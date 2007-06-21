From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Introduce git version --list-features for porcelain use
Date: Wed, 20 Jun 2007 22:47:14 -0700
Message-ID: <7v1wg55065.fsf@assigned-by-dhcp.pobox.com>
References: <20070621045903.GA14047@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jun 21 07:47:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1FVl-0001RF-0O
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 07:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170AbXFUFrQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 01:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752024AbXFUFrP
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 01:47:15 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:55670 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752033AbXFUFrP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 01:47:15 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070621054714.STZB1594.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Thu, 21 Jun 2007 01:47:14 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id E5nE1X00C1kojtg0000000; Thu, 21 Jun 2007 01:47:14 -0400
In-Reply-To: <20070621045903.GA14047@spearce.org> (Shawn O. Pearce's message
	of "Thu, 21 Jun 2007 00:59:03 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50595>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> As a porcelain author I'm finding it difficult to keep track of
> what features I can use in git-gui.  Newer versions of Git have
> newer capabilities but they don't always immediately get newer
> version numbers that I can easily test for.

Two and half comments, and a discussion.

> +static const char *supported_features[] = {
> +	"blame-ignore-whitespace",
> +	"list-features",
> +};
> +
>  /* most GUI terminals set COLUMNS (although some don't export it) */
>  static int term_columns(void)
>  {
> @@ -190,10 +195,78 @@ void help_unknown_cmd(const char *cmd)
>  	exit(1);
>  }
>  
> +static int is_feature_name_sane(const char *a)
> +{
> +	if (!*a || *a == '-')
> +		return 0;
> +	for (; *a; a++) {
> +		if (! ((*a >= 'a' && *a <= 'z')
> +		    || (*a >= '0' && *a <= '9')
> +		    || *a == '-'))
> +			return 0;
> +	}
> +	return 1;
> +}
> +

> +static int cmp_feature(const void *a_, const void *b_)
> +{
> +	const char *a = *((const char **)a_);
> +	const char *b = *((const char **)b_);
> +	return strcmp(a, b);
> +}
> +
> +static void list_features()
> +{
> +	unsigned cnt = ARRAY_SIZE(supported_features);
> +	unsigned i;
> +
> +	qsort(supported_features, cnt,
> +		sizeof(supported_features[0]), cmp_feature);
> ...
> +}

Unless we are talking about dynamically extensible feature list
(eh, dll, anybody?), it might be easier to keep (1) the list
sorted, and (2) free of insane feature name in
supported_features[] array at the source level.  Then you can
lose that is_feature_name_sane() function.

> +static int supports_feature(const char *the_feature)
> +{
> +	unsigned cnt = ARRAY_SIZE(supported_features);
> +	unsigned i;
> +
> +	for (i = 0; i < cnt; i++) {
> +		if (!strcmp(supported_features[i], the_feature))
> +			return 0;
> +	}
> +	return 1;
> +}

And you can  perform a bsearch here. instead of linear.

> +test_expect_failure \
> +	'feature "THISNEVERWILLBEAGITFEATURE" is not supported' \
> +	'git version --supports-feature=THISNEVERWILLBEAGITFEATURE'

I would expect that THISNEW... will get complaint saying "That
is not a valid feature name, as it has uppercase", from a
version that has is_feature_name_sane() function.

I suspect that this patch is meant for my 'maint' (and
1.5.2.3).  Or is it for my 'master'?  What's your plan to handle
transition?

For example, if this appears on 1.5.2.3, then
supported_features[] should not have blame-ignore-whitespace,
unless we are talking about cherry-picking, and I honestly do
not think "blame -w" deserves to go to the maintenance only
series.  On the other hand, --list-features could go to 'maint'
under 'future prooofing' category, I guess.

If this is meant to be only for 1.5.3 and later, then you know
that "blame -w" is available as well, so the fact you can do
"git version --list-features" alone tells you that you can use
"blame -w", among other many things, such as "diff -C -C"
instead of --find-copies-harder.

Where does the above discussion lead us?  It essentially means,
in either case, "blame-ignore-whitespace" should not be in that
supported_features[] array.

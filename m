From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] log: add log.follow config option
Date: Tue, 07 Jul 2015 23:42:52 +0200
Message-ID: <vpqlherlk4j.fsf@anie.imag.fr>
References: <1436294440-20273-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 23:43:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCadw-0003Me-9A
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 23:43:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933034AbbGGVnE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 17:43:04 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33091 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932879AbbGGVnB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 17:43:01 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t67LgoPo027332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 7 Jul 2015 23:42:50 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t67LgrEX012778;
	Tue, 7 Jul 2015 23:42:53 +0200
In-Reply-To: <1436294440-20273-1-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Tue, 7 Jul 2015 14:40:40 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 07 Jul 2015 23:42:50 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t67LgoPo027332
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1436910170.94506@nhjuzEN/FuKohNiWdXSwHA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273605>

Hi,

Thanks for your patch. Below are some comments. Some of them are just me
thinking out loudly (don't take it badly if I'm being negative), some
are more serious, but all are fixable.

David Turner <dturner@twopensource.com> writes:

> From: David Turner <dturner@twitter.com>

If you configure your commiter id and your From field to the same value,
you can avoid this distracting "From:" header.

You're lacking a Signed-off-by trailer.

> +log.follow::
> +	If a single file argument is given to git log, it will act as
> +	if the `--follow` option was also used.  This adds no new
> +	functionality over what --follow already provides (in other words,
> +	it cannot be used to follow multiple files).  It's just a
> +	convenience.

Missing `...` around the second --follow.

I would write this as:

	This has the same limitations as --follow, i.e. it cannot be
	used to follow multiple files and does not work well on
	non-linear history.

and drop the "it's just a convenience" part.

> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -31,6 +31,7 @@ static const char *default_date_mode = NULL;
>  
>  static int default_abbrev_commit;
>  static int default_show_root = 1;
> +static int default_follow = 0;

I tend to disagree with this rule, but in Git we usually omit the "= 0"
for static variables, which are already initialized to 0 by default.

> +		/* Can't prune commits with rename following: the paths change.. */
> +		if (!DIFF_OPT_TST(&revs->diffopt, FOLLOW_RENAMES)) {
> +			revs->prune = 1;
> +		} else {
> +			revs->diff = 1;
> +		}

Useless braces.

> +     git log --name-status --pretty="format:%s"  path1 > current'

Whitespace: here an elsewhere, you have two spaces before path1, and we
usually stick the > to the filename like >current.

> --- a/t/t4206-log-follow-harder-copies.sh
> +++ b/t/t4206-log-follow-harder-copies.sh
> @@ -53,4 +53,39 @@ test_expect_success \
>      'validate the output.' \
>      'compare_diff_patch current expected'
>  
> +test_expect_success \
> +    'git config log.follow works like --follow' \
> +    'test_config log.follow true &&
> +     git log --name-status --pretty="format:%s"  path1 > current'
> +
> +test_expect_success \
> +    'validate the output.' \
> +    'compare_diff_patch current expected'

I would squash these two tests. As-is, the first one doesn't really test
anything (well, just that git log doesn't crash with log.follow).

I think you meant test_cmp, not compare_diff_patch, as you don't need
the "similarity index" and "index ..." filtering that compare_diff_patch
does before test_cmp.

That said, I see that you are mimicking surrounding code, which is a
good thing for consistancy. I think the best would be to write tests in
t4202-log.sh, which already tests the --follow option, and uses a more
modern coding style which you can mimick.
t4206-log-follow-harder-copies.sh is really about finding copies in
--follow. Another option is to start your series with a patch like
"t4206: modernize style".

Or you can just accept that the current style in this file is subpar and
continue with it.

> +test_expect_success \
> +    'git config log.follow does not die with multiple paths' \
> +    'test_config log.follow true &&
> +     git log path0 path1 > current &&

You are creating 'current' but not using it.

> +     wc -l current'

What is the intent of this "wc -l current"? You're not checking its
output ...

> +test_expect_success \
> +    'git config log.follow does not die with no paths' \
> +    'test_config log.follow true &&
> +     git log -- > current &&

One more creation of current which isn't used ...

> +     wc -l current'
> +
> +test_expect_success \
> +    'git config log.follow is overridden by --no-follow' \
> +    'test_config log.follow true &&
> +     git log --no-follow --name-status --pretty="format:%s"  path1 > current'

... because you're overwriting it here.

> +cat >expected <<\EOF
> +Copy path1 from path0
> +A	path1
> +EOF

Put everything in test_expect_..., including creation of expected file.
For more info, read t/README and its Do's, don'ts & things to keep in
mind section.

> +test_expect_success \
> +    'validate the output.' \
> +    'compare_diff_patch current expected'
> +
>  test_done

Cheers,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

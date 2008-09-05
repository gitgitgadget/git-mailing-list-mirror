From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] for-each-ref: `:short` format for `refname`
Date: Fri, 05 Sep 2008 15:20:11 -0700
Message-ID: <7vej3yutes.fsf@gitster.siamese.dyndns.org>
References: <7vtzcxaxgr.fsf@gitster.siamese.dyndns.org>
 <1220649383-17916-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, szeder@ira.uka.de,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Sep 06 00:21:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbjgH-0007f9-3Z
	for gcvg-git-2@gmane.org; Sat, 06 Sep 2008 00:21:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135AbYIEWUW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2008 18:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752118AbYIEWUW
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 18:20:22 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40280 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972AbYIEWUW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2008 18:20:22 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 695815E46D;
	Fri,  5 Sep 2008 18:20:20 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 30FB45E468; Fri,  5 Sep 2008 18:20:15 -0400 (EDT)
In-Reply-To: <1220649383-17916-1-git-send-email-bert.wesarg@googlemail.com>
 (Bert Wesarg's message of "Fri, 5 Sep 2008 23:16:23 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D3794C28-7B98-11DD-8496-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95046>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> ...
> To integrate this new format into the bash completion to get
> only non-ambiguous refs is beyond the scope of this patch.
>
> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>
> ---
> Cc: git@vger.kernel.org
> Cc: szeder@ira.uka.de
> Cc: Shawn O. Pearce <spearce@spearce.org>

Nice writeup of the history of this patch, if on tad-too-verbose side.

> diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
> index 21e92bb..9b44092 100644
> --- a/builtin-for-each-ref.c
> +++ b/builtin-for-each-ref.c
> @@ -546,6 +546,107 @@ static void grab_values(struct atom_value *val, int deref, struct object *obj, v
> +/*
> + * Shorten the refname to an non-ambiguous form
> + */
> +static char *get_short_ref(struct refinfo *ref)
> +{
> ...
> +	/* skip first rule, it will always match */
> +	for (i = nr_rules - 1; i > 0 ; --i) {
> +		int j;
> +		int short_name_len;
> +
> +		if (1 != sscanf(ref->refname, scanf_fmts[i], short_name))
> +			continue;
> +
> +		short_name_len = strlen(short_name);
> +
> +		/*
> +		 * check if the short name resolves to a valid ref,
> +		 * but use only rules prior to the matched one
> +		 */
> +		for (j = 0; j < i; j++) {
> ...
> +		}
> +		/*
> +		 * short name is non-ambiguous if all previous rules
> +		 * haven't resolved to a valid ref
> +		 */
> +		if (j == i)
> +			return short_name;

Is this inner loop essentially the same as calling dwim_ref(), while
temporarily turning warn_ambiguous_refs on, and checking for return value
of one?

> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index 8ced593..4f247dd 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -262,6 +262,50 @@ for i in "--perl --shell" "-s --python" "--python --tcl" "--tcl --perl"; do
>  	"
>  done
>  
> +cat >expected <<\EOF
> +master
> +testtag
> +EOF
> +
> +test_expect_success 'Check short refname format' '
> +	(git for-each-ref --format="%(refname:short)" refs/heads &&
> +	git for-each-ref --format="%(refname:short)" refs/tags) >actual &&
> +	test_cmp expected actual
> +'

Not a complaint nor objection but mere curiosity.  Why does this run two
for-each-ref, not just one with two patterns?

> +test_expect_success 'Check for invalid refname format' '
> +	test_must_fail git for-each-ref --format="%(refname:INVALID)"
> +'

Good.

> +cat >expected <<\EOF
> +heads/master
> +master
> +EOF
> +
> +test_expect_success 'Check ambiguous head and tag refs' '
> +	git checkout -b newtag &&
> +	echo "Using $datestamp" > one &&
> +	git add one &&
> +	git commit -m "Branch" &&
> +	setdate_and_increment &&
> +	git tag -m "Tagging at $datestamp" master &&
> +	git for-each-ref --format "%(refname:short)" refs/heads/master refs/tags/master >actual &&
> +	test_cmp expected actual
> +'
> +
> +cat >expected <<\EOF
> +heads/ambiguous
> +ambiguous
> +EOF
> +
> +test_expect_success 'Check ambiguous head and tag refs II' '
> +	git checkout master &&
> +	git tag ambiguous testtag^0 &&
> +	git branch ambiguous testtag^0 &&
> +	git for-each-ref --format "%(refname:short)" refs/heads/ambiguous refs/tags/ambiguous >actual &&
> +	test_cmp expected actual
> +'
> +

Can we also try first creating a clone of some repo and run:

	for-each-ref --format="%(refname:short)" refs/remotes

I am unsure how "remotes/origin" when "refs/remotes/origin/HEAD" points at
their 'master' branch behaves with your code, and/or how it should behave.

Other than that, nicely done.

From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/9] ref-filter: add support for %(path) atom
Date: Sat, 03 Oct 2015 12:02:00 +0200
Message-ID: <vpqwpv49so7.fsf@grenoble-inp.fr>
References: <1443807546-5985-1-git-send-email-Karthik.188@gmail.com>
	<1443807546-5985-4-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 03 12:02:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZiJdx-0001z9-8T
	for gcvg-git-2@plane.gmane.org; Sat, 03 Oct 2015 12:02:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751729AbbJCKCL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Oct 2015 06:02:11 -0400
Received: from mx1.imag.fr ([129.88.30.5]:59561 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751576AbbJCKCJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2015 06:02:09 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t93A20Z3028526
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sat, 3 Oct 2015 12:02:00 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t93A203N001871;
	Sat, 3 Oct 2015 12:02:00 +0200
In-Reply-To: <1443807546-5985-4-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Fri, 2 Oct 2015 23:09:00 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sat, 03 Oct 2015 12:02:00 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t93A20Z3028526
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1444471324.27843@vzK1qy+Xb7JHL4RNepcJfw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278966>

Karthik Nayak <karthik.188@gmail.com> writes:

> This adds %(path) and %(path:short) atoms. The %(path) atom will print
> the path of the given ref, while %(path:short) will only print the
> subdirectory of the given ref.

What does "path" mean in this context? How is it different from
%(refname)?

I found the answer below, but I could not guess from the doc and commit
message. Actually, I'm not sure %(path) is the right name. If you want
the "file/directory" analogy, then %(dirname) would be better.

> +		} else if (match_atom_name(name, "path", &valp)) {
> +			const char *sp, *ep;
> +
> +			if (ref->kind & FILTER_REFS_DETACHED_HEAD)
> +				continue;
> +
> +			sp = strchr(ref->refname, '/');
> +			ep = strchr(++sp, '/');

This assumes you have two / in the fullrefname. It is normally the case,
but one can also create eg. refs/foo references. AFAIK, in this case sp
will be NULL, and you're then calling strchr(++NULL) which may segfault.

> diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
> index d7f7a18..5557657 100755
> --- a/t/t6302-for-each-ref-filter.sh
> +++ b/t/t6302-for-each-ref-filter.sh
> @@ -312,6 +312,7 @@ test_expect_success 'check %(if:equals=<string>)' '
>  	test_cmp expect actual
>  '
>  
> +
>  test_expect_success 'check %(if:notequals=<string>)' '

Useless new blank line.

> +test_expect_success 'check %(path)' '
> +	git for-each-ref --format="%(path)" >actual &&
> +	cat >expect <<-\EOF &&
> +	refs/heads

You should add eg.

git update-ref refs/foo HEAD
git update-ref refs/foodir/bar/boz HEAD

before the test to check and document the behavior for such refnames.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v16 00/14] port tag.c to use ref-filter APIs
Date: Sun, 06 Sep 2015 20:49:30 +0200
Message-ID: <vpqa8sz9ydh.fsf@anie.imag.fr>
References: <1441479135-5285-1-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 06 20:50:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYf0r-0002Ox-6i
	for gcvg-git-2@plane.gmane.org; Sun, 06 Sep 2015 20:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752332AbbIFStj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2015 14:49:39 -0400
Received: from mx2.imag.fr ([129.88.30.17]:59878 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751768AbbIFSti (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2015 14:49:38 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t86InSDf020176
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sun, 6 Sep 2015 20:49:28 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t86InUoc001641;
	Sun, 6 Sep 2015 20:49:30 +0200
In-Reply-To: <1441479135-5285-1-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Sun, 6 Sep 2015 00:22:01 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 06 Sep 2015 20:49:28 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t86InSDf020176
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1442170170.60118@XAuUriT156KfHF7DxJmH/w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277435>

Karthik Nayak <karthik.188@gmail.com> writes:

> @@ -705,9 +719,12 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
>  			v->s = xstrdup(subpos);
>  		else if (skip_prefix(name, "contents:lines=", &valp)) {
>  			struct strbuf s = STRBUF_INIT;
> +			const char *contents_end = bodylen + bodypos - siglen;
> +
>  			if (strtoul_ui(valp, 10, &v->u.contents.lines))
> -				die(_("positive width expected contents:lines=%s"), valp);
> -			append_lines(&s, subpos, sublen + bodylen - siglen, v->u.contents.lines);
> +				die(_("positive value expected contents:lines=%s"), valp);
> +			/*  Size is the length of the message after removing the signature */

Nit: double-space after /*.

> -test_expect_success 'alignment with format quote' '
> -	cat >expect <<-EOF &&
> -	refname is ${sq}           ${sq}\\${sq}${sq}master${sq}\\${sq}${sq}           ${sq}|
> -	refname is ${sq}            ${sq}\\${sq}${sq}side${sq}\\${sq}${sq}            ${sq}|
> -	refname is ${sq}          ${sq}\\${sq}${sq}odd/spot${sq}\\${sq}${sq}          ${sq}|
> -	refname is ${sq}         ${sq}\\${sq}${sq}double-tag${sq}\\${sq}${sq}         ${sq}|
> -	refname is ${sq}            ${sq}\\${sq}${sq}four${sq}\\${sq}${sq}            ${sq}|
> -	refname is ${sq}            ${sq}\\${sq}${sq}one${sq}\\${sq}${sq}             ${sq}|
> -	refname is ${sq}         ${sq}\\${sq}${sq}signed-tag${sq}\\${sq}${sq}         ${sq}|
> -	refname is ${sq}           ${sq}\\${sq}${sq}three${sq}\\${sq}${sq}            ${sq}|
> -	refname is ${sq}            ${sq}\\${sq}${sq}two${sq}\\${sq}${sq}             ${sq}|
> +test_expect_success 'alignment with format quote' "
> +	cat >expect <<-\EOF &&
> +	|'       master| A U Thor       '|
> +	|'        side| A U Thor        '|
> +	|'      odd/spot| A U Thor      '|
> +	|'         double-tag|          '|
> +	|'        four| A U Thor        '|
> +	|'        one| A U Thor         '|
> +	|'         signed-tag|          '|
> +	|'       three| A U Thor        '|
> +	|'        two| A U Thor         '|
>  	EOF
> -	git for-each-ref --shell --format="refname is %(align:30,middle)${sq}%(refname:short)${sq}%(end)|" >actual &&
> +	git for-each-ref --shell --format='|%(align:30,middle)%(refname:short)| %(authorname)%(end)|' >actual &&
>  	test_cmp expect actual
> -'
> +"

The new test is indeed easier to read, but you're not testing anymore
the consequence of a single-quote within the aligned string.

An implementation that just adds single-quotes around the string without
turning ' into '\'' would be broken but still pass the test.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

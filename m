From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 04/10] ref-filter: modify "%(objectname:short)" to take length
Date: Thu, 08 Oct 2015 20:58:12 +0200
Message-ID: <vpqh9m1mbln.fsf@grenoble-inp.fr>
References: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
	<1444295885-1657-5-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 08 20:58:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkGOU-0007mk-Ml
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 20:58:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755493AbbJHS6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 14:58:18 -0400
Received: from mx1.imag.fr ([129.88.30.5]:44179 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753714AbbJHS6S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 14:58:18 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t98IwBJB012840
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 8 Oct 2015 20:58:11 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t98IwCbr009599;
	Thu, 8 Oct 2015 20:58:12 +0200
In-Reply-To: <1444295885-1657-5-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Thu, 8 Oct 2015 14:47:59 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 08 Oct 2015 20:58:11 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t98IwBJB012840
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1444935493.0775@jZJEzhO6JRQTrVxfG0YoYg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279260>

Karthik Nayak <karthik.188@gmail.com> writes:

> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -464,14 +464,28 @@ static void *get_obj(const unsigned char *sha1, struct object **obj, unsigned lo
>  static int grab_objectname(const char *name, const unsigned char *sha1,
>  			    struct atom_value *v)
>  {
> -	if (!strcmp(name, "objectname")) {
> -		char *s = xmalloc(41);
> -		strcpy(s, sha1_to_hex(sha1));
> -		v->s = s;
> -		return 1;
> -	}
> -	if (!strcmp(name, "objectname:short")) {
> -		v->s = xstrdup(find_unique_abbrev(sha1, DEFAULT_ABBREV));
> +	const char *p;
> +
> +	if (match_atom_name(name, "objectname", &p)) {
> +		/*  No arguments given, copy the entire objectname */
> +		if (!p) {
> +			char *s = xmalloc(41);

While you're there, you may want to get rid of this hardcoded 41 and
write GIT_SHA1_HEXSZ + 1 instead.

> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index 7c9bec7..6fc569e 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -385,6 +385,28 @@ test_expect_success 'Check short objectname format' '
>  	test_cmp expected actual
>  '
>  
> +cat >expected <<EOF
> +$(git rev-parse --short=1 HEAD)
> +EOF

Please write all code within test_expect_success including this
(t/README:

 - Put all code inside test_expect_success and other assertions.

   Even code that isn't a test per se, but merely some setup code
   should be inside a test assertion.
).

> +test_expect_success 'Check objectname:short format when size is less than MINIMUM_ABBREV' '
> +	git for-each-ref --format="%(objectname:short=1)" refs/heads >actual &&
> +	test_cmp expected actual
> +'
> +
> +cat >expected <<EOF
> +$(git rev-parse --short=10 HEAD)
> +EOF

Likewise.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

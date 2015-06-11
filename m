From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 2/7] bisect: replace hardcoded "bad|good" by variables
Date: Thu, 11 Jun 2015 17:27:21 +0200
Message-ID: <vpq1thi465i.fsf@anie.imag.fr>
References: <1433953472-32572-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<1433953472-32572-2-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, remi.lespinet@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	remi.galan-alfonso@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr, chriscool@tuxfamily.org,
	thomasxnguy@gmail.com, valentinduperray@gmail.com
To: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jun 11 17:27:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z34OF-0005Tw-3n
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 17:27:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752436AbbFKP1a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 11:27:30 -0400
Received: from mx1.imag.fr ([129.88.30.5]:48018 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751634AbbFKP13 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 11:27:29 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5BFRJBE008654
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 11 Jun 2015 17:27:19 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5BFRL0k014706;
	Thu, 11 Jun 2015 17:27:21 +0200
In-Reply-To: <1433953472-32572-2-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	(Antoine Delaite's message of "Wed, 10 Jun 2015 18:24:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 11 Jun 2015 17:27:20 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5BFRJBE008654
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434641242.58366@evWt45sH9x2XJG/i3n2TtQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271417>

Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr> writes:

> -	if (!strcmp(refname, "bad")) {
> +	char good_prefix[256];
> +	strcpy(good_prefix, name_good);
> +	strcat(good_prefix, "-");

You are silently adding a restriction here: name_good must be small
enough to fit in a 256-bytes array. It's not a terrible restriction, but
what may happen if you break it is a real issue.

Either you have to enforce this restriction somewhere, or you should not
have the restriction at all. I'd vote for the second. strbuf is your
friend here.

> @@ -259,21 +264,21 @@ bisect_state() {
>  
>  bisect_next_check() {
>  	missing_good= missing_bad=
> -	git show-ref -q --verify refs/bisect/bad || missing_bad=t
> -	test -n "$(git for-each-ref "refs/bisect/good-*")" || missing_good=t
> +	git show-ref -q --verify refs/bisect/$NAME_BAD || missing_bad=t
> +	test -n "$(git for-each-ref "refs/bisect/$NAME_GOOD-*")" || missing_good=t

There are other restrictions here: $NAME_BAD must be an acceptable ref
name, and you're not quoting $NAME_BAD hence it must not contain shell
meta-characters (The requirements for ref names almost imply that, but
'foo/bar{a,b}' is accepted and will trigger some expansion if your
/bin/sh is bash for example).

Being an acceptable ref name is a constraint you have to check (Junio
already mentionned check-ref-format). I think quoting variables makes
sense too.

> @@ -421,7 +426,7 @@ bisect_replay () {
>  		start)
>  			cmd="bisect_start $rev"
>  			eval "$cmd" ;;
> -		good|bad|skip)
> +		$NAME_GOOD|$NAME_BAD|skip)

$NAME_GOOD and $NAME_BAD need quoting if you're not sure they don't
contain shell metacharacters.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

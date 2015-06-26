From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v10 7/7] bisect: allow any terms set by user
Date: Fri, 26 Jun 2015 22:59:48 +0200
Message-ID: <vpq7fqqqj7f.fsf@anie.imag.fr>
References: <1435337896-20709-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435337896-20709-8-git-send-email-Matthieu.Moy@imag.fr>
	<CAP8UFD1Donr4v3Z8bpawv0_heDUQ+-EkepZF6UvuXOed7TQBXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	louis--alexandre stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Nguy <thomasxnguy@gmail.com>,
	Valentin Duperray <valentinduperray@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 23:03:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8al3-0001qD-1s
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 23:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754073AbbFZVAP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 17:00:15 -0400
Received: from mx1.imag.fr ([129.88.30.5]:45904 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754096AbbFZVAB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 17:00:01 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5QKxjkF008078
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 26 Jun 2015 22:59:45 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5QKxmuV016153;
	Fri, 26 Jun 2015 22:59:48 +0200
In-Reply-To: <CAP8UFD1Donr4v3Z8bpawv0_heDUQ+-EkepZF6UvuXOed7TQBXA@mail.gmail.com>
	(Christian Couder's message of "Fri, 26 Jun 2015 22:29:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 26 Jun 2015 22:59:45 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5QKxjkF008078
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1435957188.9597@dXvzh7Lbg9fBYZKyIvxyJQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272826>

Christian Couder <christian.couder@gmail.com> writes:

> On Fri, Jun 26, 2015 at 6:58 PM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
>> From: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
>>
>> Introduction of the git bisect terms command. The user can set his own
>> terms. It will work exactly like before. The terms must be set before the
>> start.
>
> After looking a bit at the code, I think that for now existing
> predefined terms ("bad", "good", "new" and "old") as well as some
> other terms that look like bisect subcommands like "skip", "start" and
> "terms" should be disallowed as arguments to "git bisect terms",

More importantly, subcommands should be disallowed, or the user may
completely break bisect (e.g. running 'git bisect terms reset bar'
prevents you from running 'git bisect reset' later).

And they should be different, or some more funny situation will occur.

I've just squashed this into my last patch:

diff --git a/git-bisect.sh b/git-bisect.sh
index cf07a91..f6be218 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -607,9 +607,21 @@ bisect_terms () {
 			gettextln "Your current terms are $NAME_GOOD for the old state
 and $NAME_BAD for the new state."
 		else
-			die "$(gettext "No terms defined.")"
+			die "$(gettext "no terms defined")"
 		fi ;;
 	2)
+		for term in "$@"
+		do
+			case "$term" in
+				help|start|bad|good|new|old|terms|skip|next|reset|visualize|replay|log|run)
+				die "$(eval_gettext "can't use the builtin command '\$term' as a term")"
+				;;
+			esac
+		done
+		if test "$1" = "$2"
+		then
+			die "$(gettext "please use two different terms")"
+		fi
 		if ! test -s "$GIT_DIR/BISECT_START"
 		then
 			write_terms "$1" "$2"
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index eb8cc80..5a7243b 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -852,7 +852,7 @@ test_expect_success 'bisect terms needs 0 or 2 arguments' '
 	test_must_fail git bisect terms only-one &&
 	test_must_fail git bisect terms 1 2 3 &&
 	test_must_fail git bisect terms 2>actual &&
-	echo "No terms defined." >expected &&
+	echo "no terms defined" >expected &&
 	test_cmp expected actual
 '
 
Updated my GitHub branch, but I'll stop spamming the list with git
send-email for a while ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

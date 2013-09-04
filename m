From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Bug in git rebase --continue in v1.8.4
Date: Wed, 04 Sep 2013 13:56:18 +0200
Message-ID: <vpq61ug6brx.fsf@anie.imag.fr>
References: <5221E661.1070200@gmx.de> <5226E8FC.8070208@FreeBSD.org>
	<vpqsixl9ezo.fsf@anie.imag.fr> <5226F4F8.7090304@FreeBSD.org>
	<5226FA92.5060709@FreeBSD.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Andriy Gapon <avg@FreeBSD.org>
X-From: git-owner@vger.kernel.org Wed Sep 04 13:56:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHBhF-00010m-Qt
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 13:56:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762449Ab3IDL40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 07:56:26 -0400
Received: from mx1.imag.fr ([129.88.30.5]:45269 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759380Ab3IDL4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 07:56:25 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r84BuHiR005127
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 4 Sep 2013 13:56:17 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VHBh5-0005dI-5X; Wed, 04 Sep 2013 13:56:19 +0200
In-Reply-To: <5226FA92.5060709@FreeBSD.org> (Andriy Gapon's message of "Wed,
	04 Sep 2013 12:17:06 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 04 Sep 2013 13:56:18 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r84BuHiR005127
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1378900578.57588@/jWzxjoeg3fupWqwvmZmrg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233832>

Andriy Gapon <avg@FreeBSD.org> writes:

> This looks like bug in FreeBSD shell indeed.

Yes: the testsuite would have caught it otherwise.

> If a script is sourced within a function scope, then 'return' in the script
> causes the function to return.  But it should cause the sourced script to return.

OK, so this is FreeBSD's fault. But that should not prevent us from
fixing Git to make it work with FreeBSD.

Does the patch below fix the testsuite for you?

--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -167,13 +167,22 @@ You can run "git stash pop" or "git stash drop" at any time.
        rm -rf "$state_dir"
 }
 
-run_specific_rebase () {
+run_specific_rebase_internal () {
        if [ "$interactive_rebase" = implied ]; then
                GIT_EDITOR=:
                export GIT_EDITOR
                autosquash=
        fi
+       # On FreeBSD, the shell's "return" returns from the current
+       # function, not from the current file inclusion.
+       # run_specific_rebase_internal has the file inclusion as a
+       # last statement, so POSIX and FreeBSD's return will do the
+       # same thing.
        . git-rebase--$type
+}
+
+run_specific_rebase () {
+       run_specific_rebase_internal
        ret=$?
        if test $ret -eq 0
        then


-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

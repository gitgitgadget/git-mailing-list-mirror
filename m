From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git rebase -i error message interprets \t in commit message
Date: Tue, 06 Aug 2013 18:05:53 +0200
Message-ID: <vpqli4ekdni.fsf@anie.imag.fr>
References: <87k3jy6cyc.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Aug 06 18:06:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6jm5-0002kA-DZ
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 18:06:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756078Ab3HFQGJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 12:06:09 -0400
Received: from mx2.imag.fr ([129.88.30.17]:47781 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755893Ab3HFQF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 12:05:59 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r76G5pYi022468
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 6 Aug 2013 18:05:51 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1V6jlh-00084J-B5; Tue, 06 Aug 2013 18:05:53 +0200
In-Reply-To: <87k3jy6cyc.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Tue, 06 Aug 2013 17:44:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 06 Aug 2013 18:05:51 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r76G5pYi022468
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1376409954.06936@zTp8zoqVnrV3bA4WLDiJ8g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231758>

David Kastrup <dak@gnu.org> writes:

> Could not apply 16de9d2... Make tempo range 	empo 20~30 be input as 	empo 20-30 instead

Indeed. The source of the problem is that our "die" shell function
interprets \t (because it uses "echo").

A simple fix would be this:

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 7a964ad..97258d5 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -53,7 +53,7 @@ die () {
 die_with_status () {
        status=$1
        shift
-       echo >&2 "$*"
+       printf >&2 "%s\n" "$*"
        exit "$status"
 }
 
It does not sound crazy as the shell function "say" right below uses the
same printf "%s\n" "$*", but I'm wondering whether this could have other
bad implications (e.g. if there are escape sequences in the commit
message, aren't we going to screw up the terminal?).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

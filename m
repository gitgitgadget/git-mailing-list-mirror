From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH] git-am: fix detection of absolute paths for windows
Date: Thu, 30 Sep 2010 14:24:07 +0100
Message-ID: <87tyl6hnu2.fsf_-_@fox.patthoyts.tk>
References: <87ocbitd33.fsf@fox.patthoyts.tk>
	<201009282252.25688.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: msysgit@googlegroups.com, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Oct 01 00:24:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1RYL-0004XR-Cv
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 00:24:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756891Ab0I3WYc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 18:24:32 -0400
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:55209 "EHLO
	smtp-out5.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755613Ab0I3WYc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Sep 2010 18:24:32 -0400
Received: from [172.23.170.140] (helo=anti-virus02-07)
	by smtp-out5.blueyonder.co.uk with smtp (Exim 4.52)
	id 1P1RYC-0005AJ-S4; Thu, 30 Sep 2010 23:24:28 +0100
Received: from [77.99.239.132] (helo=fox.patthoyts.tk)
	by asmtp-out6.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1P1RY5-00067X-Lu; Thu, 30 Sep 2010 23:24:21 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 2A77321903; Thu, 30 Sep 2010 23:24:21 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
X-Url: http://www.patthoyts.tk/
In-Reply-To: <201009282252.25688.j6t@kdbg.org> (Johannes Sixt's message of
	"Tue, 28 Sep 2010 22:52:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157717>

Add an is_absolute_path function to abstract out platform differences
in checking for an absolute or relative path.
Specifically fixes t4150-am on Windows.

Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---

In response to the following comment...

>Johannes Sixt <j6t@kdbg.org> writes:
>>>       git-am: fix absolute path logic on Windows 
>>
>>This mistakes a file that has a colon in the second position as absolute, even 
>>on non-Windows. IIUC, this patch is not intended for upstream git.
>>

This patch is an alternative solution that only tries the Windows paths
on msysGit. This is_absolute_path might find use elsewhere in the future
so I elected to place it in the sh-setup script. Also added support for
identifying a UNC path as absolute.


 git-am.sh       |   12 ++++++------
 git-sh-setup.sh |   15 +++++++++++++++
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index e7f008c..9317b38 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -444,12 +444,12 @@ else
 				set x
 				first=
 			}
-			case "$arg" in
-			/*)
-				set "$@" "$arg" ;;
-			*)
-				set "$@" "$prefix$arg" ;;
-			esac
+			if is_absolute_path "$arg"
+			then
+				set "$@" "$arg"
+			else
+				set "$@" "$prefix$arg"
+			fi
 		done
 		shift
 	fi
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 6131670..b9eb0bf 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -209,5 +209,20 @@ case $(uname -s) in
 	find () {
 		/usr/bin/find "$@"
 	}
+	is_absolute_path () {
+		case "$1" in
+		/* | ?:* | \\\\*)
+			return 0 ;;
+		esac
+		return 1
+	}
 	;;
+*)
+	is_absolute_path () {
+		case "$1" in
+		/*)
+			return 0 ;;
+		esac
+		return 1
+	}
 esac
-- 
1.7.3

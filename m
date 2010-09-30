From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH] git-am: fix detection of absolute paths for windows
Date: Thu, 30 Sep 2010 14:24:07 +0100
Message-ID: <87iq1ly81q.fsf@fox.patthoyts.tk>
References: <87ocbitd33.fsf@fox.patthoyts.tk>
	<201009282252.25688.j6t@kdbg.org> <87tyl6hnu2.fsf_-_@fox.patthoyts.tk>
	<201010011946.12481.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: msysgit@googlegroups.com, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Oct 01 22:26:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1mB1-0000yh-MN
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 22:25:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752886Ab0JAUZv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Oct 2010 16:25:51 -0400
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:40221 "EHLO
	smtp-out4.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752340Ab0JAUZu (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Oct 2010 16:25:50 -0400
Received: from [172.23.170.144] (helo=anti-virus03-07)
	by smtp-out4.blueyonder.co.uk with smtp (Exim 4.52)
	id 1P1mAq-0002qS-Uw; Fri, 01 Oct 2010 21:25:45 +0100
Received: from [77.99.239.132] (helo=fox.patthoyts.tk)
	by asmtp-out1.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1P1mAk-00041B-B0; Fri, 01 Oct 2010 21:25:38 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 902F521B9C; Fri,  1 Oct 2010 21:25:37 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
X-Url: http://www.patthoyts.tk/
In-Reply-To: <201010011946.12481.j6t@kdbg.org> (Johannes Sixt's message of
	"Fri, 1 Oct 2010 19:46:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157780>

Add an is_absolute_path function to abstract out platform differences
in checking for an absolute or relative path.
Specifically fixes t4150-am on Windows.

[PT: updated following suggestion from j6t to support \* and //*]

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---

Johannes Sixt <j6t@kdbg.org> writes:
>On Donnerstag, 30. September 2010, Pat Thoyts wrote:
>> Add an is_absolute_path function to abstract out platform differences
>> in checking for an absolute or relative path.
>> Specifically fixes t4150-am on Windows.
>
>Thanks for tackling this!
>
>> @@ -209,5 +209,20 @@ case $(uname -s) in
>>  	find () {
>>  		/usr/bin/find "$@"
>>  	}
>> +	is_absolute_path () {
>> +		case "$1" in
>> +		/* | ?:* | \\\\*)
>
>Absolute paths can also start with a backslash, and UNC paths can start with 
>double-slash. Therefore, this should be:
>
>		[/\\]* | [A-Za-z]:*)
>
>> +			return 0 ;;
>> +		esac
>> +		return 1
>> +	}
>
>-- Hannes

I've modified the patch and added your signoff - hopefully that is ok?

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
index 6131670..58d30c9 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -209,5 +209,20 @@ case $(uname -s) in
 	find () {
 		/usr/bin/find "$@"
 	}
+	is_absolute_path () {
+		case "$1" in
+		[/\\]* | [A-Za-z]:*)
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

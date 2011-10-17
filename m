From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH 1/4] git-gui: handle config booleans without value
Date: Tue, 18 Oct 2011 00:13:59 +0100
Message-ID: <87mxczgqiw.fsf@fox.patthoyts.tk>
References: <94b050c4cf7ae8df8d79112e13613244ebff4037.1318579823.git.bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Oct 18 01:14:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFwNl-0005l7-71
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 01:14:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756208Ab1JQXOD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 19:14:03 -0400
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:20482 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752453Ab1JQXOC (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Oct 2011 19:14:02 -0400
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.1])
          by mtaout01-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20111017231400.BWJD13501.mtaout01-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Tue, 18 Oct 2011 00:14:00 +0100
Received: from [94.171.235.235] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1RFwNc-0006V4-0a; Tue, 18 Oct 2011 00:14:00 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 4A182201AC; Tue, 18 Oct 2011 00:13:59 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <94b050c4cf7ae8df8d79112e13613244ebff4037.1318579823.git.bert.wesarg@googlemail.com>
	(Bert Wesarg's message of "Fri, 14 Oct 2011 10:14:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
X-Cloudmark-Analysis: v=1.1 cv=JvdXmxIgLJv2/GthKqHpGJEEHukvLcvELVXUanXFreg= c=1 sm=0 a=O9HYxzjLEG8A:10 a=F7pDX9lBjJ0A:10 a=kj9zAlcOel0A:10 a=mK_AVkanAAAA:8 a=Rf460ibiAAAA:8 a=shVeskzBdJgyAGMCh80A:9 a=nzrbkkectRT378UVyZYA:7 a=CjuIK1q_8ugA:10 a=9xyTavCNlvEA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183840>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

>When git interprets a config variable without a value as bool it is considered
>as true. But git-gui doesn't so until yet.
>
>The value for boolean configs are also case-insensitive.
>
>Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>---
> git-gui.sh |   16 ++++++++++++++--
> 1 files changed, 14 insertions(+), 2 deletions(-)
>
>diff --git a/git-gui.sh b/git-gui.sh
>index f897160..d687871 100755
>--- a/git-gui.sh
>+++ b/git-gui.sh
>@@ -299,7 +299,9 @@ proc is_config_true {name} {
> 	global repo_config
> 	if {[catch {set v $repo_config($name)}]} {
> 		return 0
>-	} elseif {$v eq {true} || $v eq {1} || $v eq {yes}} {
>+	}
>+	set v [string tolower $v]
>+	if {$v eq {} || $v eq {true} || $v eq {1} || $v eq {yes} || $v eq {on}} {
> 		return 1
> 	} else {
> 		return 0

This looks ok - we actually have a [string is boolean $v] test we could
use eg:
  if {[string is boolean $v]} {
    return [expr {$v eq {} ? 1 : !!$v}]
  }
although I'm not sure it gains us much. This would match everything Tcl
believes to be a boolean - yes/no, on/off, true/false and 1/0. Without
-strict the [string is] test will consider {} to be a boolean.


>@@ -310,7 +312,9 @@ proc is_config_false {name} {
> 	global repo_config
> 	if {[catch {set v $repo_config($name)}]} {
> 		return 0
>-	} elseif {$v eq {false} || $v eq {0} || $v eq {no}} {
>+	}
>+	set v [string tolower $v]
>+	if {$v eq {false} || $v eq {0} || $v eq {no} || $v eq {off}} {
> 		return 1
> 	} else {
> 		return 0
>@@ -1060,6 +1064,10 @@ git-version proc _parse_config {arr_name args} {
> 				} else {
> 					set arr($name) $value
> 				}
>+			} elseif {[regexp {^([^\n]+)$} $line line name]} {
>+				# no value given, but interpreting them as
>+				# boolean will be handled as true
>+				set arr($name) {}
> 			}
> 		}
> 	}
>@@ -1075,6 +1083,10 @@ git-version proc _parse_config {arr_name args} {
> 					} else {
> 						set arr($name) $value
> 					}
>+				} elseif {[regexp {^([^=]+)$} $line line name]} {
>+					# no value given, but interpreting them as
>+					# boolean will be handled as true
>+					set arr($name) {}
> 				}
> 			}
> 			close $fd_rc

Is this really how git treats boolean config values? I can't seem to
demonstrate that to myself:
pat@frog:/opt/src/git-gui$ git config --unset core.xyzzy
pat@frog:/opt/src/git-gui$ git config --bool --get core.xyzzy
pat@frog:/opt/src/git-gui$ git config --bool core.xyzzy 1
pat@frog:/opt/src/git-gui$ git config --bool --get core.xyzzy
true

I assume I'm using the wrong test for this.

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD

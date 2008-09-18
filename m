From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH v2 3/4] diff.*.xfuncname which uses "extended" regex's for
 hunk header selection
Date: Thu, 18 Sep 2008 17:44:33 -0500
Message-ID: <fjsVcwP3ERAtOSloTT6E_M76x0-uAuN_SFta0ReZcFZ1h58s6M4jTQ@cipher.nrlssc.navy.mil>
References: <7vskry1485.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Arjen Laarhoven <arjen@yaph.org>,
	Mike Ralphson <mike.ralphson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	Boyd Lynn Gerber <gerberb@zenez.com>,
	Git Mailing List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Johan Herland <johan@herland.net>,
	Andreas Ericsson <ae@op5.se>, Kirill Smelkov <kirr@mns.spb.ru>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Gustaf Hendeby <hendeby@isy.liu.se>,
	Jonathan del Strother <maillist@steelskies.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 19 00:46:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgSGp-0006y4-94
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 00:46:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755421AbYIRWpe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 18:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755401AbYIRWpd
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 18:45:33 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:33127 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755161AbYIRWpd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 18:45:33 -0400
Received: by mail.nrlssc.navy.mil id m8IMiXBd001836; Thu, 18 Sep 2008 17:44:33 -0500
In-Reply-To: <7vskry1485.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 18 Sep 2008 22:44:33.0843 (UTC) FILETIME=[1EE48030:01C919E0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96249>

Currently, the hunk headers produced by 'diff -p' are customizable by
setting the diff.*.funcname option in the config file. The 'funcname' option
takes a basic regular expression. This functionality was designed using the
GNU regex library which, by default, allows using backslashed versions of
some extended regular expression operators, even in Basic Regular Expression
mode. For example, the following characters, when backslashed, are
interpreted according to the extended regular expression rules: ?, +, and |.
As such, the builtin funcname patterns were created using some extended
regular expression operators.

Other platforms which adhere more strictly to the POSIX spec do not
interpret the backslashed extended RE operators in Basic Regular Expression
mode. This causes the pattern matching for the builtin funcname patterns to
fail on those platforms.

Introduce a new option 'xfuncname' which uses extended regular expressions,
and advertise it _instead_ of funcname. Since most users are on GNU
platforms, the majority of funcname patterns are created and tested there.
Advertising only xfuncname should help to avoid the creation of non-portable
patterns which work with GNU regex but not elsewhere.

Additionally, the extended regular expressions may be less ugly and
complicated compared to the basic RE since many common special operators do
not need to be backslashed.

For example, the GNU Basic RE:

    ^[ 	]*\\(\\(public\\|static\\).*\\)$

becomes the following Extended RE:

    ^[ 	]*((public|static).*)$

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 Documentation/gitattributes.txt |    4 ++--
 diff.c                          |    5 +++++
 t/t4018-diff-funcname.sh        |    2 +-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 6f3551d..9a75257 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -288,13 +288,13 @@ for paths.
 *.tex	diff=tex
 ------------------------
 
-Then, you would define "diff.tex.funcname" configuration to
+Then, you would define "diff.tex.xfuncname" configuration to
 specify a regular expression that matches a line that you would
 want to appear as the hunk header, like this:
 
 ------------------------
 [diff "tex"]
-	funcname = "^\\(\\\\\\(sub\\)*section{.*\\)$"
+	xfuncname = "^(\\\\(sub)*section\\{.*)$"
 ------------------------
 
 Note.  A single level of backslashes are eaten by the
diff --git a/diff.c b/diff.c
index 08cdd8f..9d8fd2b 100644
--- a/diff.c
+++ b/diff.c
@@ -196,6 +196,11 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
 					return config_error_nonbool(var);
 				return parse_funcname_pattern(var, ep, value,
 					0);
+			} else if (!strcmp(ep, ".xfuncname")) {
+				if (!value)
+					return config_error_nonbool(var);
+				return parse_funcname_pattern(var, ep, value,
+					REG_EXTENDED);
 			}
 		}
 	}
diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 18bcd97..602d68f 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -58,7 +58,7 @@ test_expect_success 'last regexp must not be negated' '
 '
 
 test_expect_success 'alternation in pattern' '
-	git config diff.java.funcname "^[ 	]*\\(\\(public\\|static\\).*\\)$"
+	git config diff.java.xfuncname "^[ 	]*((public|static).*)$" &&
 	git diff --no-index Beer.java Beer-correct.java |
 	grep "^@@.*@@ public static void main("
 '
-- 
1.6.0.1.244.gdc19

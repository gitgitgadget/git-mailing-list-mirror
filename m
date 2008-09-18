From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 3/4] diff.*.xfuncname which uses "extended" regex's for hunk
 header selection
Date: Wed, 17 Sep 2008 19:10:50 -0500
Message-ID: <wgfIh_UVzwhXaVTN46Io8UDAq72MVwOkk7CobrAvp0330VRzwT2fuA@cipher.nrlssc.navy.mil>
References: <7v3ak06jzj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>,
	Arjen Laarhoven <arjen@yaph.org>,
	Mike Ralphson <mike.ralphson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	Boyd
X-From: git-owner@vger.kernel.org Thu Sep 18 02:12:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kg786-0006dO-48
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 02:12:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752380AbYIRALK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 20:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752498AbYIRALJ
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 20:11:09 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:58098 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752125AbYIRALI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 20:11:08 -0400
Received: by mail.nrlssc.navy.mil id m8I0AoFL008964; Wed, 17 Sep 2008 19:10:51 -0500
In-Reply-To: <7v3ak06jzj.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 18 Sep 2008 00:10:51.0303 (UTC) FILETIME=[027C7370:01C91923]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96154>

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
index 6f3551d..fa04eca 100644
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
+	xfuncname = "^(\\\\(sub)*section{.*)$"
 ------------------------
 
 Note.  A single level of backslashes are eaten by the
diff --git a/diff.c b/diff.c
index 4363d0d..ad5e551 100644
--- a/diff.c
+++ b/diff.c
@@ -195,6 +195,11 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
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

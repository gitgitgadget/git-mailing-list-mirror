From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/3] apply: squelch excessive errors and --whitespace=error-all
Date: Mon, 27 Feb 2006 17:13:30 -0800
Message-ID: <7vfym4uvyd.fsf@assigned-by-dhcp.cox.net>
References: <20060225174047.0e9a6d29.akpm@osdl.org>
	<7v1wxq7psj.fsf@assigned-by-dhcp.cox.net>
	<20060225210712.29b30f59.akpm@osdl.org>
	<Pine.LNX.4.64.0602260925170.22647@g5.osdl.org>
	<20060226103604.2d97696c.akpm@osdl.org>
	<Pine.LNX.4.64.0602261213340.22647@g5.osdl.org>
	<20060226202617.GH7851@redhat.com> <1141008633.7593.13.camel@homer>
	<Pine.LNX.4.63.0602271004130.5937@wbgn013.biozentrum.uni-wuerzburg.de>
	<20060227011832.78359f0a.akpm@osdl.org>
	<7vhd6kxuea.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Morton <akpm@osdl.org>
X-From: git-owner@vger.kernel.org Tue Feb 28 02:13:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDtQo-0006k0-HA
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 02:13:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751869AbWB1BNf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 20:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751876AbWB1BNf
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 20:13:35 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:49831 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751869AbWB1BNe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 20:13:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060228011049.LUBT17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 27 Feb 2006 20:10:49 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16902>

This by default makes --whitespace=warn, error, and strip to
warn only the first 5 additions of trailing whitespaces.  A new
option --whitespace=error-all can be used to view all of them
before applying.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * This is already in "next".

 apply.c |   53 +++++++++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 45 insertions(+), 8 deletions(-)

fc96b7c9ba5034a408d508c663a96a15b8f8729c
diff --git a/apply.c b/apply.c
index 7dbbeb4..8139d83 100644
--- a/apply.c
+++ b/apply.c
@@ -41,6 +41,8 @@ static enum whitespace_eol {
 	strip_and_apply,
 } new_whitespace = nowarn;
 static int whitespace_error = 0;
+static int squelch_whitespace_errors = 5;
+static int applied_after_stripping = 0;
 static const char *patch_input_file = NULL;
 
 /*
@@ -832,11 +834,16 @@ static int parse_fragment(char *line, un
 			 */
 			if ((new_whitespace != nowarn) &&
 			    isspace(line[len-2])) {
-				fprintf(stderr, "Added whitespace\n");
-				fprintf(stderr, "%s:%d:%.*s\n",
-					patch_input_file,
-					linenr, len-2, line+1);
-				whitespace_error = 1;
+				whitespace_error++;
+				if (squelch_whitespace_errors &&
+				    squelch_whitespace_errors <
+				    whitespace_error)
+					;
+				else {
+					fprintf(stderr, "Adds trailing whitespace.\n%s:%d:%.*s\n",
+						patch_input_file,
+						linenr, len-2, line+1);
+				}
 			}
 			added++;
 			newlines--;
@@ -1129,6 +1136,7 @@ static int apply_line(char *output, cons
 		plen--;
 		while (0 < plen && isspace(patch[plen]))
 			plen--;
+		applied_after_stripping++;
 	}
 	memcpy(output, patch + 1, plen);
 	if (add_nl_to_tail)
@@ -1895,11 +1903,16 @@ int main(int argc, char **argv)
 				new_whitespace = error_on_whitespace;
 				continue;
 			}
+			if (!strcmp(arg+13, "error-all")) {
+				new_whitespace = error_on_whitespace;
+				squelch_whitespace_errors = 0;
+				continue;
+			}
 			if (!strcmp(arg+13, "strip")) {
 				new_whitespace = strip_and_apply;
 				continue;
 			}
-			die("unrecognixed whitespace option '%s'", arg+13);
+			die("unrecognized whitespace option '%s'", arg+13);
 		}
 
 		if (check_index && prefix_length < 0) {
@@ -1919,7 +1932,31 @@ int main(int argc, char **argv)
 	}
 	if (read_stdin)
 		apply_patch(0, "<stdin>");
-	if (whitespace_error && new_whitespace == error_on_whitespace)
-		return 1;
+	if (whitespace_error) {
+		if (squelch_whitespace_errors &&
+		    squelch_whitespace_errors < whitespace_error) {
+			int squelched =
+				whitespace_error - squelch_whitespace_errors;
+			fprintf(stderr, "warning: squelched %d whitespace error%s\n",
+				squelched,
+				squelched == 1 ? "" : "s");
+		}
+		if (new_whitespace == error_on_whitespace)
+			die("%d line%s add%s trailing whitespaces.",
+			    whitespace_error,
+			    whitespace_error == 1 ? "" : "s",
+			    whitespace_error == 1 ? "s" : "");
+		if (applied_after_stripping)
+			fprintf(stderr, "warning: %d line%s applied after"
+				" stripping trailing whitespaces.\n",
+				applied_after_stripping,
+				applied_after_stripping == 1 ? "" : "s");
+		else if (whitespace_error)
+			fprintf(stderr, "warning: %d line%s add%s trailing"
+				" whitespaces.\n",
+				whitespace_error,
+				whitespace_error == 1 ? "" : "s",
+				whitespace_error == 1 ? "s" : "");
+	}
 	return 0;
 }
-- 
1.2.3.gbfea

From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [RFC/PATCH] status: Add a new NUL separated output format
Date: Sat, 10 Apr 2010 20:25:28 +0100
Message-ID: <20100410192529.23731.79803.julian@quantumfyre.co.uk>
References: <20100409184608.C7C61475FEF@snark.thyrsus.com>
	<20100410040959.GA11977@coredump.intra.peff.net>
	<9c7e1f33b7ec0dab68a92aa8f067989e@212.159.54.234>
Cc: Eric Raymond <esr@snark.thyrsus.com>,
	Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Sat Apr 10 21:31:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0gOb-0005z1-H1
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 21:31:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595Ab0DJTbD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 15:31:03 -0400
Received: from positron.quantumfyre.co.uk ([213.165.84.138]:35385 "EHLO
	positron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750974Ab0DJTbB (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Apr 2010 15:31:01 -0400
Received: from reaper.quantumfyre.co.uk (reaper.quantumfyre.co.uk [212.159.54.234])
	by positron.quantumfyre.co.uk (Postfix) with ESMTP id 50E21819C4B5;
	Sat, 10 Apr 2010 20:30:53 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id B1BE420C8F3;
	Sat, 10 Apr 2010 20:30:58 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id GVeOfAUbpQZR; Sat, 10 Apr 2010 20:30:58 +0100 (BST)
Received: from rayne.quantumfyre.co.uk (rayne.quantumfyre.co.uk [192.168.0.18])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 2A6F3C8153;
	Sat, 10 Apr 2010 20:30:58 +0100 (BST)
X-git-sha1: ad64ddda809eb1d58ea2d7325153a4fc384c91d6 
X-Mailer: git-mail-commits v0.5.3
In-Reply-To: <9c7e1f33b7ec0dab68a92aa8f067989e@212.159.54.234>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144582>

Add a new output format option to git-status that is a more extreme
form of the -z output that places a NUL between all parts of the
record, and always has three entries per record, even when only two
are relevant.  This make the parsing of --porcelain output much
simpler for the consumer.

Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
---

On Sat, 10 Apr 2010, Julian Phillips wrote:

> Not true.  If the second form was used, then you _can_ split on \0.  It
> will tokenise the data for you, and then you consume ether two or three
> tokens depending on the status flags.  So it would make the parsing
> simpler.  But to make it even easier, how about adding a -Z that makes the
> output format "XY\0file1\0[file2]\0" (i.e. always three tokens per record,
> with the third token being empty if there is no second filename)?  Though
> if future expandability was wanted you could end each record with \0\0 and
> then parsing would be a two stages of split on \0\0 for records and then
> split on \0 for entries?  The is already precedence for the -z option to
> change the output format, so a second similar switch should be ok?  Then
> the updated documentation could recommend --porcelain -Z for new users
> without affecting old ones.

Something like this for the first variant (fixed three entries per record)
perhaps ... (though a proper patch would probably want some tests too)

 builtin/commit.c |    6 ++++--
 wt-status.c      |   19 ++++++++++++++-----
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index c5ab683..acbcefc 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1025,8 +1025,10 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT(0, "porcelain", &status_format,
 			    "show porcelain output format",
 			    STATUS_FORMAT_PORCELAIN),
-		OPT_BOOLEAN('z', "null", &null_termination,
-			    "terminate entries with NUL"),
+		OPT_SET_INT('z', "null", &null_termination,
+			    "terminate entries with NUL", 1),
+		OPT_SET_INT('Z', "intense-null", &null_termination,
+			    "use NUL for all seperators, including absent values", 2),
 		{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg,
 		  "mode",
 		  "show untracked files, optional modes: all, normal, no. (Default: all)",
diff --git a/wt-status.c b/wt-status.c
index 8ca59a2..9f23ec6 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -663,7 +663,9 @@ static void wt_shortstatus_unmerged(int null_termination, struct string_list_ite
 	case 7: how = "UU"; break; /* both modified */
 	}
 	color_fprintf(s->fp, color(WT_STATUS_UNMERGED, s), "%s", how);
-	if (null_termination) {
+	if (null_termination == 2) {
+		fprintf(stdout, "%c%s%c%c", 0, it->string, 0, 0);
+	} else if (null_termination) {
 		fprintf(stdout, " %s%c", it->string, 0);
 	} else {
 		struct strbuf onebuf = STRBUF_INIT;
@@ -687,14 +689,19 @@ static void wt_shortstatus_status(int null_termination, struct string_list_item
 		color_fprintf(s->fp, color(WT_STATUS_CHANGED, s), "%c", d->worktree_status);
 	else
 		putchar(' ');
-	putchar(' ');
-	if (null_termination) {
-		fprintf(stdout, "%s%c", it->string, 0);
+	if (null_termination == 2) {
+		char *file2 = "";
+		if (d->head_path)
+			file2 = d->head_path;
+		fprintf(stdout, "%c%s%c%s%c", 0, it->string, 0, file2, 0);
+	} else if (null_termination) {
+		fprintf(stdout, " %s%c", it->string, 0);
 		if (d->head_path)
 			fprintf(stdout, "%s%c", d->head_path, 0);
 	} else {
 		struct strbuf onebuf = STRBUF_INIT;
 		const char *one;
+		putchar(' ');
 		if (d->head_path) {
 			one = quote_path(d->head_path, -1, &onebuf, s->prefix);
 			printf("%s -> ", one);
@@ -709,7 +716,9 @@ static void wt_shortstatus_status(int null_termination, struct string_list_item
 static void wt_shortstatus_untracked(int null_termination, struct string_list_item *it,
 			    struct wt_status *s)
 {
-	if (null_termination) {
+	if (null_termination == 2) {
+		fprintf(stdout, "??%c%s%c%c", 0, it->string, 0, 0);
+	} else if (null_termination) {
 		fprintf(stdout, "?? %s%c", it->string, 0);
 	} else {
 		struct strbuf onebuf = STRBUF_INIT;
-- 
1.7.0.4

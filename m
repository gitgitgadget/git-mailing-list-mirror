From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Please make git-am handle \r\n-damaged patches
Date: Tue, 04 Aug 2009 15:22:26 -0700
Message-ID: <7vmy6fdxst.fsf@alter.siamese.dyndns.org>
References: <4A7735B0.2040703@zytor.com>
 <81b0412b0908032335s3363849aj32a0e93efa15c012@mail.gmail.com>
 <7v7hxk5b4y.fsf@alter.siamese.dyndns.org>
 <20090805061514.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 00:22:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYSP8-0000D4-VW
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 00:22:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933482AbZHDWWh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 18:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933480AbZHDWWg
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 18:22:36 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44461 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933466AbZHDWWf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 18:22:35 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 05D151DD64;
	Tue,  4 Aug 2009 18:22:36 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 08AF21DD5E; Tue,  4 Aug 2009
 18:22:27 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4FD70B36-8145-11DE-A7B3-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124827>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Junio C Hamano <gitster@pobox.com>
>
>> Alex Riesen <raa.lkml@gmail.com> writes:
>>
>>> Maybe it is as simple as that (not tested yet,
>>> and sent through gmail, so please be careful):
>>
>> I thought about this approach, but it made me worried about a case where
>> an otherwise sane piece of e-mail has \r at the end of one line as the
>> real payload.  But as long as we are talking about a text e-mail (and we
>> are talking about mailsplit here and a binary payload with a CTE applied
>> counts as text), I think we can safely use an approach like this.
>
> Is it safe to rebase a commit that introduces a carriage-return at the end of the line using the updated program?

Hmmm, good point.  The approach does break rebase.

At least we could patch it up like this.

 builtin-mailinfo.c  |    2 +-
 builtin-mailsplit.c |   11 +++++++++--
 builtin.h           |    2 +-
 git-am.sh           |    8 +++++++-
 t/t3400-rebase.sh   |   26 ++++++++++++++++++++++++--
 5 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 92637ac..6e44d2c 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -835,7 +835,7 @@ static void handle_body(void)
 		strbuf_reset(&line);
 		if (strbuf_avail(&line) < 100)
 			strbuf_grow(&line, 100);
-	} while ((len = read_line_with_nul(line.buf, strbuf_avail(&line), fin)));
+	} while ((len = read_line_with_nul(line.buf, strbuf_avail(&line), fin, 0)));
 
 handle_body_out:
 	strbuf_release(&prev);
diff --git a/builtin-mailsplit.c b/builtin-mailsplit.c
index ad5f6b5..f774b04 100644
--- a/builtin-mailsplit.c
+++ b/builtin-mailsplit.c
@@ -45,8 +45,10 @@ static int is_from_line(const char *line, int len)
 /* Could be as small as 64, enough to hold a Unix "From " line. */
 static char buf[4096];
 
+static int keep_cr;
+
 /* We cannot use fgets() because our lines can contain NULs */
-int read_line_with_nul(char *buf, int size, FILE *in)
+int read_line_with_nul(char *buf, int size, FILE *in, int nuke_cr_at_eol)
 {
 	int len = 0, c;
 
@@ -58,6 +60,9 @@ int read_line_with_nul(char *buf, int size, FILE *in)
 		if (c == '\n' || len + 1 >= size)
 			break;
 	}
+	if (nuke_cr_at_eol &&
+	    (1 < len && buf[len - 2] == '\r' && buf[len - 1] == '\n'))
+		buf[len-- - 2] = '\n';
 	buf[len] = '\0';
 
 	return len;
@@ -93,7 +98,7 @@ static int split_one(FILE *mbox, const char *name, int allow_bare)
 		if (fwrite(buf, 1, len, output) != len)
 			die_errno("cannot write output");
 
-		len = read_line_with_nul(buf, sizeof(buf), mbox);
+		len = read_line_with_nul(buf, sizeof(buf), mbox, !keep_cr);
 		if (len == 0) {
 			if (feof(mbox)) {
 				status = 1;
@@ -248,6 +253,8 @@ int cmd_mailsplit(int argc, const char **argv, const char *prefix)
 			nr = strtol(arg+2, NULL, 10);
 		} else if ( arg[1] == 'b' && !arg[2] ) {
 			allow_bare = 1;
+		} else if (!strcmp(arg, "--keep-cr")) {
+			keep_cr = 1;
 		} else if ( arg[1] == 'o' && arg[2] ) {
 			dir = arg+2;
 		} else if ( arg[1] == '-' && !arg[2] ) {
diff --git a/builtin.h b/builtin.h
index 825a96f..59dddee 100644
--- a/builtin.h
+++ b/builtin.h
@@ -13,7 +13,7 @@ extern const char git_more_info_string[];
 extern void list_common_cmds_help(void);
 extern const char *help_unknown_cmd(const char *cmd);
 extern void prune_packed_objects(int);
-extern int read_line_with_nul(char *buf, int size, FILE *file);
+extern int read_line_with_nul(char *buf, int size, FILE *file, int nuke_cr_at_eol);
 extern int fmt_merge_msg(int merge_summary, struct strbuf *in,
 	struct strbuf *out);
 extern int commit_tree(const char *msg, unsigned char *tree,
diff --git a/git-am.sh b/git-am.sh
index d64d997..985226b 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -197,7 +197,13 @@ check_patch_format () {
 split_patches () {
 	case "$patch_format" in
 	mbox)
-		git mailsplit -d"$prec" -o"$dotest" -b -- "$@" > "$dotest/last" ||
+		case "$rebasing" in
+		'')
+			keep_cr= ;;
+		?*)
+			keep_cr=--keep-cr ;;
+		esac
+		git mailsplit -d"$prec" -o"$dotest" -b $keep_cr -- "$@" > "$dotest/last" ||
 		clean_abort
 		;;
 	stgit-series)
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index c5c29cc..4e6a44b 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -3,9 +3,10 @@
 # Copyright (c) 2005 Amos Waterland
 #
 
-test_description='git rebase should not destroy author information
+test_description='git rebase assorted tests
 
-This test runs git rebase and checks that the author information is not lost.
+This test runs git rebase and checks that the author information is not lost
+among other things.
 '
 . ./test-lib.sh
 
@@ -133,4 +134,25 @@ test_expect_success 'rebase -q is quiet' '
      test ! -s output.out
 '
 
+q_to_cr () {
+	tr Q '\015'
+}
+
+test_expect_success 'Rebase a commit that sprinkles CRs in' '
+	(
+		echo "One"
+		echo "TwoQ"
+		echo "Three"
+		echo "FQur"
+		echo "Five"
+	) | q_to_cr >CR &&
+	git add CR &&
+	test_tick &&
+	git commit -a -m "A file with a line with CR" &&
+	git tag file-with-cr &&
+	git checkout HEAD^0 &&
+	git rebase --onto HEAD^^ HEAD^ &&
+	git diff --exit-code file-with-cr:CR HEAD:CR
+'
+
 test_done

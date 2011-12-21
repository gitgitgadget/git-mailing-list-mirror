From: Bill Zaumen <bill.zaumen+git@gmail.com>
Subject: [PATCH 5/6] Add MD support for fetch, pull, and push.
Date: Tue, 20 Dec 2011 23:12:48 -0800
Message-ID: <1324451568.1684.23.camel@yos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Dec 21 08:12:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdGM6-0000QC-It
	for gcvg-git-2@lo.gmane.org; Wed, 21 Dec 2011 08:12:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362Ab1LUHMq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Dec 2011 02:12:46 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34580 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214Ab1LUHMp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2011 02:12:45 -0500
Received: by iaeh11 with SMTP id h11so11462959iae.19
        for <git@vger.kernel.org>; Tue, 20 Dec 2011 23:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:subject:from:to:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=2W58iqvwlhMKFtRN0LQGqNFBcTiVwi1OcxY6RusP2J4=;
        b=YMGHmkRd7ILCcmhU6/+pnRbQpoKLoip+7b6JtkQFqLxle/ROWr0JCcPdHKBe9ueztB
         zzLWppet8ulNcNfLBPCE4m+kEopikFdueleXPgaXSQEWdBlDioa79pU/ZRTeM+0y4fIE
         P2QWXyFSqnbnwVclkFPXBmMc4LLWIiFff3ajk=
Received: by 10.50.88.135 with SMTP id bg7mr1583432igb.7.1324451564779;
        Tue, 20 Dec 2011 23:12:44 -0800 (PST)
Received: from [192.168.1.20] (adsl-209-233-20-69.dsl.snfc21.pacbell.net. [209.233.20.69])
        by mx.google.com with ESMTPS id d19sm13745294ibh.8.2011.12.20.23.12.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 20 Dec 2011 23:12:43 -0800 (PST)
X-Mailer: Evolution 2.30.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187555>

A new capability, "mds-check" is defined. When present, a client will
(when possible and useful) send the server a SHA-1 value and a message
digest, separated by a '-'.  This is used to detect hash collisions,
with a goal of finding problems early if a malicious attempt is made
to forge commits with different commits with the same SHA-1 value in
different repositories.  It is a simple, fast test - a look-up and a
comparison.

Signed-off-by: Bill Zaumen <bill.zaumen+git@gmail.com>
---
 builtin/fetch-pack.c   |   29 +++++++++++-
 builtin/receive-pack.c |  117 +++++++++++++++++++++++++++++++++++++++++++-----
 builtin/send-pack.c    |   26 ++++++++++-
 http.c                 |   19 ++++++--
 t/t5500-fetch-pack.sh  |   10 +++--
 t/t5510-fetch.sh       |   12 ++++-
 upload-pack.c          |   11 ++++-
 7 files changed, 196 insertions(+), 28 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 6207ecd..2f5b7ef 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -18,6 +18,8 @@ static int prefer_ofs_delta = 1;
 static int no_done;
 static int fetch_fsck_objects = -1;
 static int transfer_fsck_objects = -1;
+static int mds_check = 0;
+
 static struct fetch_pack_args args = {
 	/* .uploadpack = */ "git-upload-pack",
 };
@@ -390,9 +392,25 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 	flushes = 0;
 	retval = -1;
 	while ((sha1 = get_rev())) {
-		packet_buf_write(&req_buf, "have %s\n", sha1_to_hex(sha1));
-		if (args.verbose)
-			fprintf(stderr, "have %s\n", sha1_to_hex(sha1));
+		if (mds_check) {
+			mdigest_t digest;
+			if (has_sha1_file_digest(sha1, &digest)) {
+				packet_buf_write(&req_buf, "have %s\n",
+						 sha1_to_hex_digest(sha1,
+								    &digest));
+
+			} else {
+				packet_buf_write(&req_buf, "have %s\n",
+						 sha1_to_hex(sha1));
+			}
+			if (args.verbose)
+				fprintf(stderr, "have %s\n", sha1_to_hex(sha1));
+		} else {
+			packet_buf_write(&req_buf, "have %s\n",
+					 sha1_to_hex(sha1));
+			if (args.verbose)
+				fprintf(stderr, "have %s\n", sha1_to_hex(sha1));
+		}
 		in_vain++;
 		if (flush_at <= ++count) {
 			int ack;
@@ -807,6 +825,11 @@ static struct ref *do_fetch_pack(int fd[2],
 			fprintf(stderr, "Server supports ofs-delta\n");
 	} else
 		prefer_ofs_delta = 0;
+	if (server_supports("mds-check")) {
+		if (args.verbose)
+			fprintf(stderr, "Server supports mds-check\n");
+		mds_check = 1;
+	}
 	if (everything_local(&ref, nr_match, match)) {
 		packet_flush(fd[1]);
 		goto all_done;
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index d2dcb7e..b9d1c1f 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -122,7 +122,8 @@ static int show_ref(const char *path, const unsigned char *sha1, int flag, void
 	else
 		packet_write(1, "%s %s%c%s%s\n",
 			     sha1_to_hex(sha1), path, 0,
-			     " report-status delete-refs side-band-64k",
+			     " report-status delete-refs side-band-64k"
+			     " mds-check",
 			     prefer_ofs_delta ? " ofs-delta" : "");
 	sent_capabilities = 1;
 	return 0;
@@ -709,37 +710,131 @@ static struct command *read_head_info(void)
 	struct command *commands = NULL;
 	struct command **p = &commands;
 	for (;;) {
-		static char line[1000];
+		static char line[1500];
 		unsigned char old_sha1[20], new_sha1[20];
 		struct command *cmd;
 		char *refname;
 		int len, reflen;
+		int has_old_sha1_digest = 0;
+		int has_new_sha1_digest = 0;
+		mdigest_t old_sha1_digest;
+		mdigest_t new_sha1_digest;
+		mdigest_t digest;
+		int old_hashlen = 40;
+		int new_hashlen = 40;
+		int hashlen = 81; /* includes blank between two hashes */
+		int digest_field_len = 0;
+
+		mdigest_clear(&old_sha1_digest);
+		mdigest_clear(&new_sha1_digest);
 
 		len = packet_read_line(0, line, sizeof(line));
 		if (!len)
 			break;
 		if (line[len-1] == '\n')
 			line[--len] = 0;
-		if (len < 83 ||
-		    line[40] != ' ' ||
-		    line[81] != ' ' ||
-		    get_sha1_hex(line, old_sha1) ||
-		    get_sha1_hex(line + 41, new_sha1))
+		if (len > (old_hashlen + 1) && line[old_hashlen] == '-') {
+			digest_field_len = 1
+				+ get_hex_field_size(line+old_hashlen+1);
+		}
+		if (len > (old_hashlen + digest_field_len) &&
+		    line[old_hashlen] == '-') {
+			old_hashlen += digest_field_len;
+			hashlen += digest_field_len;
+			digest_field_len = 0;
+			if (len > (old_hashlen + 1)
+			    && line[old_hashlen] == '-') {
+				digest_field_len = 1 +
+					get_hex_field_size(line+old_hashlen+1);
+			}
+			if (len > (old_hashlen + digest_field_len + 1) &&
+			    line[old_hashlen] == '-') {
+				old_hashlen += digest_field_len;
+				hashlen += digest_field_len;
+			}
+		}
+		if (line[old_hashlen] != ' ') {
+			die("protocol error: expected old/new/ref, got '%s'",
+			    line);
+		}
+		digest_field_len = 0;
+		if (len > hashlen + 1 && line[hashlen] == '-') {
+			digest_field_len = 1 +
+			  get_hex_field_size(line+hashlen+1);
+		}
+		if (len > (hashlen + digest_field_len + 1) &&
+		    line[hashlen] == '-') {
+			new_hashlen += digest_field_len;
+			hashlen += digest_field_len;
+			digest_field_len = 0;
+			if (len > (hashlen + 1)
+			    && line[hashlen] == '-') {
+				digest_field_len = 1 +
+					get_hex_field_size(line+hashlen+1);
+			}
+			if (len > (hashlen + digest_field_len + 1) &&
+			    line[hashlen] == '-') {
+				new_hashlen += digest_field_len;
+				hashlen += digest_field_len;
+			}
+		}
+		if (line[hashlen] != ' ') {
 			die("protocol error: expected old/new/ref, got '%s'",
 			    line);
+		}
+
+		if (len < hashlen + 1 ||
+		    line[old_hashlen] != ' ' ||
+		    line[hashlen] != ' ' ||
+		    get_sha1_hex_digest(line, old_sha1,
+				     &has_old_sha1_digest, &old_sha1_digest) ||
+		    get_sha1_hex_digest(line + old_hashlen + 1, new_sha1,
+					&has_new_sha1_digest,
+					&new_sha1_digest)) {
+			die("protocol error: expected old/new/ref, got '%s'",
+			    line);
+		}
+
+		if (has_old_sha1_digest &&
+		    has_sha1_file_digest(old_sha1, &digest)) {
+			if (mdigest_tst(&old_sha1_digest, &digest)) {
+				die("hash collision for %s",
+				    sha1_to_hex(old_sha1));
+			}
+		}
+
+
+		if (has_new_sha1_digest &&
+		    has_sha1_file_digest(new_sha1, &digest)) {
+			if (mdigest_tst(&new_sha1_digest, &digest)) {
+				die("hash collision for %s",
+				    sha1_to_hex(new_sha1));
+			}
+		}
 
-		refname = line + 82;
+		refname = line + hashlen + 1;
 		reflen = strlen(refname);
-		if (reflen + 82 < len) {
+		if (reflen + hashlen + 1 < len) {
 			if (strstr(refname + reflen + 1, "report-status"))
 				report_status = 1;
 			if (strstr(refname + reflen + 1, "side-band-64k"))
 				use_sideband = LARGE_PACKET_MAX;
 		}
-		cmd = xcalloc(1, sizeof(struct command) + len - 80);
+		/*
+		 * Without the additional digests,
+		 *   old_hashlen + new_hashlen = 80
+		 *   hashlen = 81,
+		 *   hashlen + 1 = 82
+		 * which puts the same numeric values into the last argument
+		 * of xcalloc, and the second & third argument of memcpy
+		 * that were used in commit
+		 * fc14b89a7e6899b8ac3b5751ec2d8c98203ea4c2.
+		 */
+		cmd = xcalloc(1, sizeof(struct command) + len
+			      - (old_hashlen + new_hashlen));
 		hashcpy(cmd->old_sha1, old_sha1);
 		hashcpy(cmd->new_sha1, new_sha1);
-		memcpy(cmd->ref_name, line + 82, len - 81);
+		memcpy(cmd->ref_name, line + hashlen + 1, len - (hashlen));
 		*p = cmd;
 		p = &cmd->next;
 	}
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index cd1115f..1eb9704 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -250,6 +250,7 @@ int send_pack(struct send_pack_args *args,
 	int allow_deleting_refs = 0;
 	int status_report = 0;
 	int use_sideband = 0;
+	int mds_check = 0;
 	unsigned cmds_sent = 0;
 	int ret;
 	struct async demux;
@@ -263,6 +264,8 @@ int send_pack(struct send_pack_args *args,
 		args->use_ofs_delta = 1;
 	if (server_supports("side-band-64k"))
 		use_sideband = 1;
+	if (server_supports("mds-check"))
+		mds_check = 1;
 
 	if (!remote_refs) {
 		fprintf(stderr, "No refs in common and none specified; doing nothing.\n"
@@ -298,8 +301,27 @@ int send_pack(struct send_pack_args *args,
 		if (args->dry_run) {
 			ref->status = REF_STATUS_OK;
 		} else {
-			char *old_hex = sha1_to_hex(ref->old_sha1);
-			char *new_hex = sha1_to_hex(ref->new_sha1);
+			char *old_hex, *new_hex;
+			if (mds_check) {
+				mdigest_t digest;
+				if (has_sha1_file_digest(ref->old_sha1,
+						      &digest)) {
+					old_hex = sha1_to_hex_digest
+						(ref->old_sha1, &digest);
+				} else {
+					old_hex = sha1_to_hex(ref->old_sha1);
+				}
+				if (has_sha1_file_digest(ref->new_sha1,
+						      &digest)) {
+					new_hex = sha1_to_hex_digest
+						(ref->new_sha1, &digest);
+				} else {
+					new_hex = sha1_to_hex(ref->new_sha1);
+				}
+			} else {
+				old_hex = sha1_to_hex(ref->old_sha1);
+				new_hex = sha1_to_hex(ref->new_sha1);
+			}
 
 			if (!cmds_sent && (status_report || use_sideband)) {
 				packet_buf_write(&req_buf, "%s %s %s%c%s%s",
diff --git a/http.c b/http.c
index 0ffd79c..e4e3ec7 100644
--- a/http.c
+++ b/http.c
@@ -1014,8 +1014,9 @@ int finish_http_pack_request(struct http_pack_request *preq)
 	struct packed_git **lst;
 	struct packed_git *p = preq->target;
 	char *tmp_idx;
+	char *tmp_mds;
 	struct child_process ip;
-	const char *ip_argv[8];
+	const char *ip_argv[10];
 
 	close_pack_index(p);
 
@@ -1028,14 +1029,20 @@ int finish_http_pack_request(struct http_pack_request *preq)
 	*lst = (*lst)->next;
 
 	tmp_idx = xstrdup(preq->tmpfile);
+	tmp_mds = xstrdup(preq->tmpfile);
 	strcpy(tmp_idx + strlen(tmp_idx) - strlen(".pack.temp"),
 	       ".idx.temp");
+	strcpy(tmp_mds + strlen(tmp_mds) - strlen(".pack.temp"),
+	       ".mds.temp");
+
 
 	ip_argv[0] = "index-pack";
 	ip_argv[1] = "-o";
 	ip_argv[2] = tmp_idx;
-	ip_argv[3] = preq->tmpfile;
-	ip_argv[4] = NULL;
+	ip_argv[3] = "-m";
+	ip_argv[4] = tmp_mds;
+	ip_argv[5] = preq->tmpfile;
+	ip_argv[6] = NULL;
 
 	memset(&ip, 0, sizeof(ip));
 	ip.argv = ip_argv;
@@ -1046,20 +1053,24 @@ int finish_http_pack_request(struct http_pack_request *preq)
 	if (run_command(&ip)) {
 		unlink(preq->tmpfile);
 		unlink(tmp_idx);
+		unlink(tmp_mds);
 		free(tmp_idx);
+		free(tmp_mds);
 		return -1;
 	}
 
 	unlink(sha1_pack_index_name(p->sha1));
 
 	if (move_temp_to_file(preq->tmpfile, sha1_pack_name(p->sha1))
-	 || move_temp_to_file(tmp_idx, sha1_pack_index_name(p->sha1))) {
+	 || move_temp_to_file(tmp_idx, sha1_pack_index_name(p->sha1))
+	 || move_temp_to_file(tmp_mds, sha1_pack_mds_name(p->sha1))) {
 		free(tmp_idx);
 		return -1;
 	}
 
 	install_packed_git(p);
 	free(tmp_idx);
+	free(tmp_mds);
 	return 0;
 }
 
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 9bf69e9..b6632d2 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -53,8 +53,8 @@ pull_to_client () {
 			git symbolic-ref HEAD refs/heads/`echo $heads \
 				| sed -e "s/^\(.\).*$/\1/"` &&
 
-			git fsck --full &&
-
+			git fsck --full  &&
+			test -z "`git count-objects -v -M | grep MD`" &&
 			mv .git/objects/pack/pack-* . &&
 			p=`ls -1 pack-*.pack` &&
 			git unpack-objects <$p &&
@@ -142,7 +142,8 @@ test_expect_success 'fsck in shallow repo' '
 test_expect_success 'simple fetch in shallow repo' '
 	(
 		cd shallow &&
-		git fetch
+		git fetch &&
+		test -z "`git count-objects -v -M | grep MD`"
 	)
 '
 
@@ -245,7 +246,8 @@ test_expect_success 'clone shallow object count' '
 		cd shallow &&
 		git count-objects -v
 	) > count.shallow &&
-	grep "^count: 52" count.shallow
+	grep "^count: 52" count.shallow  &&
+	test -z "`git count-objects -v -M | grep MD`"
 '
 
 test_done
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index e88dbd5..5e3b8c6 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -14,6 +14,12 @@ test_bundle_object_count () {
 	test "$2" = $(grep '^[0-9a-f]\{40\} ' verify.out | wc -l)
 }
 
+test_bundle_mds_count () {
+	git verify-pack -v -M "$1" >verify.out &&
+	test "$2" = $(grep '^[0-9a-f]\{40\} ' verify.out | grep -v "<no md>" | wc -l)
+}
+
+
 test_expect_success setup '
 	echo >file original &&
 	git add file &&
@@ -214,7 +220,8 @@ test_expect_success 'bundle 1 has only 3 files ' '
 		cat
 	) <bundle1 >bundle.pack &&
 	git index-pack bundle.pack &&
-	test_bundle_object_count bundle.pack 3
+	test_bundle_object_count bundle.pack 3 &&
+	test_bundle_mds_count bundle.pack 3
 '
 
 test_expect_success 'unbundle 2' '
@@ -237,7 +244,8 @@ test_expect_success 'bundle does not prerequisite objects' '
 		cat
 	) <bundle3 >bundle.pack &&
 	git index-pack bundle.pack &&
-	test_bundle_object_count bundle.pack 3
+	test_bundle_object_count bundle.pack 3 &&
+	test_bundle_mds_count bundle.pack 3
 '
 
 test_expect_success 'bundle should be able to create a full history' '
diff --git a/upload-pack.c b/upload-pack.c
index 6f36f62..1e77826 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -320,11 +320,18 @@ static int got_sha1(char *hex, unsigned char *sha1)
 {
 	struct object *o;
 	int we_knew_they_have = 0;
+	int has_sha1_digest, has_digest;
+	mdigest_t sha1_digest, digest;
 
-	if (get_sha1_hex(hex, sha1))
+	if (get_sha1_hex_digest(hex, sha1, &has_sha1_digest, &sha1_digest))
 		die("git upload-pack: expected SHA1 object, got '%s'", hex);
 	if (!has_sha1_file(sha1))
 		return -1;
+	has_digest = has_sha1_file_digest(sha1, &digest);
+	if (has_sha1_digest && has_digest
+	    && mdigest_tst(&digest, &sha1_digest)) {
+		die("git upload-pack: SHA1 collision on MD for %s", hex);
+	}
 
 	o = lookup_object(sha1);
 	if (!(o && o->parsed))
@@ -719,7 +726,7 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
 {
 	static const char *capabilities = "multi_ack thin-pack side-band"
 		" side-band-64k ofs-delta shallow no-progress"
-		" include-tag multi_ack_detailed";
+		" include-tag multi_ack_detailed" " mds-check";
 	struct object *o = parse_object(sha1);
 	const char *refname_nons = strip_namespace(refname);
 
-- 
1.7.1

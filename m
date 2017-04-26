Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF7E7207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 22:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031349AbdDZWOG (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 18:14:06 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36028 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031323AbdDZWN4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 18:13:56 -0400
Received: by mail-pf0-f180.google.com with SMTP id 194so7049033pfv.3
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 15:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XXzm8AxV9HTQRqU9jtTHkoBIx08ua93wNl2gZlPOynw=;
        b=gt5CzbXK3PzxvuPMNCyuSGXiSmss33PDgnLsFv6/ZM7swvgfZvsrQi/98PIhfTiyZo
         zyYuGOiUXoYvtnTIkFpTzWGiJu4rxD5OUBDcb5PX6ZjvfvNFwHcPjLccSkrMyXyQRcsB
         8ImxZGWLDmHVTD1TGwgYaK07zOkHBNdxpiU6tHDdpyvKa1UsLrDe77FCK1EnFjpZ6SRF
         HBfz3FDkDEKjiJYYedYDe6TnDtqM/W5idgVOrxKBpEk4EjNo/TkzuUHIlIxc1WGtB88m
         1ftphi236FqkPcvwG37uNvnEqHMA+KvBT1/uPgHJey8ryV48E493QhMSBT3Iu4KxmKLG
         oseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XXzm8AxV9HTQRqU9jtTHkoBIx08ua93wNl2gZlPOynw=;
        b=XuNw1Tz/0ZA/6GTfUR66ExnP91a4daHvOkUR2KZ17hM7iUQhkvMq9PKgkksegKK3HI
         ewdECY+/HbJosLtRJQRaIEt38M/3o/ToLwom1ZVDxq5Gvf2YSHcwxN+ts5KlsI276XSM
         JMsCxDCa1AXFMielv5mQNUUUA6EVjBvmoBtSSkzmuvSsIEM/G7phTeG6kPIz7Mdg8OsQ
         ezW1HWkQvy+52RtAdUm1Y7DnatJbrxP1pR1xPO/mQC2u+VNmsB04Sw2BvsR8Y/Xa1DhS
         4WBwoQI77j/+tAbDRnOHAJN3QsPyWReRF8G1lW1fsHZoAPm7v6a3N8DeWlvmsFVVNtf0
         uHwQ==
X-Gm-Message-State: AN3rC/4+snmoyMdbkNZXJfFFLB0xXXaY/wN74hHwUy1CEkSSIHG0d7r3
        aXS2aLESFL4mOGsV
X-Received: by 10.98.5.5 with SMTP id 5mr2272848pff.36.1493244835316;
        Wed, 26 Apr 2017 15:13:55 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id s89sm460123pfi.79.2017.04.26.15.13.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Apr 2017 15:13:54 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, markbt@efaref.net,
        git@jeffhostetler.com, kevin.david@microsoft.com
Subject: Proposal for missing blob support in Git repos
Date:   Wed, 26 Apr 2017 15:13:46 -0700
Message-Id: <20170426221346.25337-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.0.rc0.306.g87b477812d-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a proposal for missing blob support in Git repos. There have
been several other proposals [1] [2]; this is similar to those except
that I have provided a more comprehensive analysis of the changes that
need to be done, and have made those changes (see commit below the
scissors line).

This proposal is limited to local handling using a user-specified hook.
I have another proposal out [3] for what a potential default hook should
be - how Git on the server can serve blobs to repos that have missing
blobs.

[1] <20170304191901.9622-1-markbt@efaref.net>
[2] <1488999039-37631-1-git-send-email-git@jeffhostetler.com>
[3] <ffd92ad9-39fe-c76b-178d-6e3d6a425037@google.com>

-- 8< --
sha1_file, fsck: add missing blob hook support

Currently, Git does not support repos with very large numbers of blobs
or repos that wish to minimize manipulation of certain blobs (for
example, because they are very large) very well, even if the user
operates mostly on part of the repo, because Git is designed on the
assumption that every blob referenced by a tree object is available
somewhere in the repo storage.

As a first step to reducing this problem, add rudimentary support for
missing blobs by teaching sha1_file to invoke a hook whenever a blob is
requested but missing, and by updating fsck to tolerate missing blobs.
The hook is a shell command that can be configured through "git config";
this hook takes in a list of hashes and writes (if successful) the
corresponding objects to the repo's local storage.

This commit does not include support for generating such a repo; neither
has any command (other than fsck) been modified to either tolerate
missing blobs (without invoking the hook) or be more efficient in
invoking the missing blob hook. Only a fallback is provided in the form
of sha1_file invoking the missing blob hook when necessary.

In order to determine the code changes in sha1_file.c necessary, I
investigated the following:
 (1) functions in sha1_file that take in a hash, without the user
     regarding how the object is stored (loose or packed)
 (2) functions in sha1_file that operate on packed objects (because I
     need to check callers that know about the loose/packed distinction
     and operate on both differently, and ensure that they can handle
     the concept of objects that are neither loose nor packed)

For (1), I looked through all non-static functions in sha1_file.c that
take in an unsigned char * parameter. The ones that are relevant, and my
modifications to them to resolve this problem, are:
 - sha1_object_info_extended (fixed in this commit)
 - sha1_object_info (auto-fixed by sha1_object_info_extended)
 - read_sha1_file_extended (fixed by fixing read_object)
 - read_object_with_reference (auto-fixed by read_sha1_file_extended)
 - force_object_loose (only called from builtin/pack-objects.c, which
   already knows that at least one pack contains this object)
 - has_sha1_file_with_flags (fixed in this commit)
 - assert_sha1_type (auto-fixed by sha1_object_info)

As described in the list above, several changes have been included in
this commit to fix the necessary functions.

For (2), I looked through the same functions as in (1) and also
for_each_packed_object. The ones that are relevant are:
 - parse_pack_index
   - http - indirectly from http_get_info_packs
 - find_pack_entry_one
   - this searches a single pack that is provided as an argument; the
     caller already knows (through other means) that the sought object
     is in a specific pack
 - find_sha1_pack
   - fast-import - appears to be an optimization to not store a
     file if it is already in a pack
   - http-walker - to search through a struct alt_base
   - http-push - to search through remote packs
 - has_sha1_pack
   - builtin/fsck - fixed in this commit
   - builtin/count-objects - informational purposes only (check if loose
     object is also packed)
   - builtin/prune-packed - check if object to be pruned is packed (if
     not, don't prune it)
   - revision - used to exclude packed objects if requested by user
   - diff - just for optimization
 - for_each_packed_object
   - reachable - only to find recent objects
   - builtin/fsck - fixed in this commit
   - builtin/cat-file - see below

As described in the list above, builtin/fsck has been updated. I have
left builtin/cat-file alone; this means that cat-file
--batch-all-objects will only operate on objects physically in the repo.

Some alternative designs that I considered but rejected:

 - Storing a list of hashes of missing blobs, possibly with metadata
   (much like the shallow list). Having such a list would allow for
   things like better error messages, attaching metadata (for example,
   file size or binary/text nature) to each blob, and configuring
   different hooks for each blob, but it is difficult to scale to large
   repos.
 - Adding a hook whenever a packed blob is requested, not on any blob.
   That is, whenever we attempt to search the packfiles for a blob, if
   it is missing (from the packfiles and from the loose object storage),
   to invoke the hook (which must then store it as a packfile), open the
   packfile the hook generated, and report that the blob is found in
   that new packfile. This reduces the amount of analysis needed (in
   that we only need to look at how packed blobs are handled), but
   requires that the hook generate packfiles (or for sha1_file to pack
   whatever loose objects are generated), creating one packfile for each
   missing blob and potentially very many packfiles that must be
   linearly searched. This may be tolerable now for repos that only have
   a few missing blobs (for example, repos that only want to exclude
   large blobs), and might be tolerable in the future if we have
   batching support for the most commonly used commands, but is not
   tolerable now for repos that exclude a large amount of blobs.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/config.txt | 10 +++++++
 builtin/fsck.c           |  6 +++++
 sha1_file.c              | 69 +++++++++++++++++++++++++++++++++++++++++++++---
 t/t3907-missing-blob.sh  | 50 +++++++++++++++++++++++++++++++++++
 4 files changed, 131 insertions(+), 4 deletions(-)
 create mode 100644 t/t3907-missing-blob.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 475e874d5..04db83fe8 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -369,6 +369,16 @@ The default is false, except linkgit:git-clone[1] or linkgit:git-init[1]
 will probe and set core.ignoreCase true if appropriate when the repository
 is created.
 
+core.missingBlobCommand::
+	If set, whenever a blob in the local repo is attempted to be
+	read but is missing, invoke this shell command to generate or
+	obtain that blob before reporting an error. This shell command
+	should take one or more hashes, each terminated by a newline, as
+	standard input, and (if successful) should write the
+	corresponding objects to the local repo (packed or loose).
++
+If set, fsck will not treat a missing blob as an error condition.
+
 core.precomposeUnicode::
 	This option is only used by Mac OS implementation of Git.
 	When core.precomposeUnicode=true, Git reverts the unicode decomposition
diff --git a/builtin/fsck.c b/builtin/fsck.c
index f76e4163a..5c60c0916 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -37,6 +37,7 @@ static int verbose;
 static int show_progress = -1;
 static int show_dangling = 1;
 static int name_objects;
+static int missing_blob_ok;
 #define ERROR_OBJECT 01
 #define ERROR_REACHABLE 02
 #define ERROR_PACK 04
@@ -93,6 +94,9 @@ static int fsck_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.missingblobcommand"))
+		missing_blob_ok = 1;
+
 	return git_default_config(var, value, cb);
 }
 
@@ -222,6 +226,8 @@ static void check_reachable_object(struct object *obj)
 	if (!(obj->flags & HAS_OBJ)) {
 		if (has_sha1_pack(obj->oid.hash))
 			return; /* it is in pack - forget about it */
+		if (missing_blob_ok && obj->type == OBJ_BLOB)
+			return;
 		printf("missing %s %s\n", printable_type(obj),
 			describe_object(obj));
 		errors_found |= ERROR_REACHABLE;
diff --git a/sha1_file.c b/sha1_file.c
index 1577e2d7d..de8f137a9 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2955,6 +2955,49 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 	return (status < 0) ? status : 0;
 }
 
+static char *missing_blob_command;
+static int sha1_file_config(const char *conf_key, const char *value, void *cb)
+{
+	if (!strcmp(conf_key, "core.missingblobcommand")) {
+		missing_blob_command = xstrdup(value);
+	}
+	return 0;
+}
+
+static int configured;
+static void ensure_configured(void)
+{
+	if (configured)
+		return;
+
+	git_config(sha1_file_config, NULL);
+	configured = 1;
+}
+
+static void handle_missing_blob(const unsigned char *sha1)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	const char *argv[] = {missing_blob_command, NULL};
+	char input[GIT_MAX_HEXSZ + 1];
+
+	memcpy(input, sha1_to_hex(sha1), 40);
+	input[40] = '\n';
+
+	cp.argv = argv;
+	cp.env = local_repo_env;
+	cp.use_shell = 1;
+
+	if (pipe_command(&cp, input, sizeof(input), NULL, 0, NULL, 0)) {
+		die("failed to load blob %s", sha1_to_hex(sha1));
+	}
+
+	/*
+	 * The command above may have updated packfiles, so update our record
+	 * of them.
+	 */
+	reprepare_packed_git();
+}
+
 int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi, unsigned flags)
 {
 	struct cached_object *co;
@@ -2979,6 +3022,8 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 		return 0;
 	}
 
+	if (!has_sha1_file_with_flags(sha1, 0))
+		return -1;
 	if (!find_pack_entry(real, &e)) {
 		/* Most likely it's a loose object. */
 		if (!sha1_loose_object_info(real, oi, flags)) {
@@ -3091,6 +3136,8 @@ static void *read_object(const unsigned char *sha1, enum object_type *type,
 		return xmemdupz(co->buf, co->size);
 	}
 
+	if (!has_sha1_file_with_flags(sha1, 0))
+		return NULL;
 	buf = read_packed_sha1(sha1, type, size);
 	if (buf)
 		return buf;
@@ -3480,17 +3527,31 @@ int has_sha1_pack(const unsigned char *sha1)
 int has_sha1_file_with_flags(const unsigned char *sha1, int flags)
 {
 	struct pack_entry e;
+	int already_retried = 0;
 
 	if (!startup_info->have_repository)
 		return 0;
+retry:
 	if (find_pack_entry(sha1, &e))
 		return 1;
 	if (has_loose_object(sha1))
 		return 1;
-	if (flags & HAS_SHA1_QUICK)
-		return 0;
-	reprepare_packed_git();
-	return find_pack_entry(sha1, &e);
+	if (!(flags & HAS_SHA1_QUICK)) {
+		reprepare_packed_git();
+		if (find_pack_entry(sha1, &e))
+			return 1;
+	}
+
+	if (!already_retried) {
+		ensure_configured();
+		if (missing_blob_command) {
+			already_retried = 1;
+			handle_missing_blob(sha1);
+			goto retry;
+		}
+	}
+
+	return 0;
 }
 
 int has_object_file(const struct object_id *oid)
diff --git a/t/t3907-missing-blob.sh b/t/t3907-missing-blob.sh
new file mode 100644
index 000000000..f03e53c23
--- /dev/null
+++ b/t/t3907-missing-blob.sh
@@ -0,0 +1,50 @@
+#!/bin/sh
+
+test_description='core.missingblobcommand option'
+
+. ./test-lib.sh
+
+test_expect_success 'sha1_object_info_extended and read_sha1_file (through git cat-file -p)' '
+	rm -rf server client &&
+
+	git init server &&
+	test_commit -C server 1 &&
+	test_config -C server uploadpack.allowanysha1inwant 1 &&
+	HASH=$(git hash-object server/1.t) &&
+
+	git init client &&
+	test_config -C client core.missingblobcommand \
+		"git -C \"$(pwd)/server\" pack-objects --stdout | git unpack-objects" &&
+	git -C client cat-file -p "$HASH"
+'
+
+test_expect_success 'has_sha1_file (through git cat-file -e)' '
+	rm -rf server client &&
+
+	git init server &&
+	test_commit -C server 1 &&
+	test_config -C server uploadpack.allowanysha1inwant 1 &&
+	HASH=$(git hash-object server/1.t) &&
+
+	git init client &&
+	test_config -C client core.missingblobcommand \
+		"git -C \"$(pwd)/server\" pack-objects --stdout | git unpack-objects" &&
+	git -C client cat-file -e "$HASH"
+'
+
+test_expect_success 'fsck' '
+	rm -rf server client &&
+
+	git init server &&
+	test_commit -C server 1 &&
+	test_config -C server uploadpack.allowanysha1inwant 1 &&
+	HASH=$(git hash-object server/1.t) &&
+	echo hash is $HASH &&
+
+	cp -r server client &&
+	test_config -C client core.missingblobcommand "this-command-is-not-actually-run" &&
+	rm client/.git/objects/$(echo $HASH | cut -c1-2)/$(echo $HASH | cut -c3-40) &&
+	git -C client fsck
+'
+
+test_done
-- 
2.13.0.rc0.306.g87b477812d-goog


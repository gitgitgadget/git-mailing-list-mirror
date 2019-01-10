Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 689EB1F803
	for <e@80x24.org>; Thu, 10 Jan 2019 19:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbfAJTgy (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 14:36:54 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:46540 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbfAJTgy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 14:36:54 -0500
Received: by mail-pl1-f201.google.com with SMTP id t10so6770140plo.13
        for <git@vger.kernel.org>; Thu, 10 Jan 2019 11:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=lyy5hI0I9HHgV/S80J+cvjQTCz56W0AGStf8JQ4hPFE=;
        b=VdUXg9IL5AJW5s9zICdGoaXmzJuqTMSlOSdITP6BgclZoAb8YMPD/6DO4IZyz2EAVD
         ToDXytPluxXlwZKneWbJt9pyoG/9BSZSGX3vEXE2aX4puIK17E/sxITsKw9s+LiDV1UI
         3q+Sz8FNVNiZOQ+zhTDW3dWlJy838Lp0jMgNJk/Ecq4DeaqBOuAZg4oLaTzUFWQrxeOF
         HBnPWJFvsRC8b2QgI56oTkjxbWylt8Fyy/9phsOsniyHQa0z0yR6gDLa1BkYuEgMDNLp
         bbjXBaP34b4mtWBUMoHuD24mhhnizwF5KnPkiw8xQ5vS7X9ZPB1xSx5vDNQHKmdQ+OlN
         gwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=lyy5hI0I9HHgV/S80J+cvjQTCz56W0AGStf8JQ4hPFE=;
        b=jesj1qcooUYn3DgSxc9scfy1u+CxNjkHfQGB4yutelSqaXZsgVdrNT5CXiDbc5eyiG
         X2/HL3mhuWi6C5f73EaCMSAYn2YyW/uJ2+rsMEfct5GUzLiNRUxaSnZ0zTNlmUBmOnp8
         ISj+k9S2qXf8ceTJFp/BCutAPNeXgT5D4YwmDyUIimQKQob2oK0GUSyHS+7t+2/xxUnc
         pScU1NjdH0JH5bgMUVjY6T6MTEyKoLi2TYuPEVjnt/KMORBkiJQRbpVni0LFg68qazNb
         bjLQtdOUt5/5WfYDRdkHO+V2gl3hWJafVgLSvSxZ+Vcp5qhsIOp6r87VDhuNFhJp6neE
         cH8w==
X-Gm-Message-State: AJcUukeJi2gTKWUqa7vURgXGdY7oCdk+/Or+rPhLCSGEEzGEVRZof1gE
        xJGOVhtIxdR1IEGBFqy/skBbW0whRy4NsPCIbz8Xjf020afWKXy7sV9INR5KthOwPtTiEcLXMO2
        f8lHBkIK40L4ZjvoQ4IgGwp1SxHAqyzJLmmcYDO+Isd9IxsCqNjlh0DXzoEuNhPAIc44KC70K+R
        UT
X-Google-Smtp-Source: ALg8bN7yxtsILotz5mayZA0zAA/akgv+Sz5/BORJ+cuvAO4WE70s5ohXfhQO3pH7BDlid8DH15TY6hIB7S2RpY+s7GtK
X-Received: by 2002:a17:902:43e4:: with SMTP id j91mr2500928pld.1.1547149013241;
 Thu, 10 Jan 2019 11:36:53 -0800 (PST)
Date:   Thu, 10 Jan 2019 11:36:45 -0800
Message-Id: <20190110193645.34080-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH] fetch-pack: do not take shallow lock unnecessarily
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When fetching using protocol v2, the remote may send a "shallow-info"
section if the client is shallow. If so, Git as the client currently
takes the shallow file lock, even if the "shallow-info" section is
empty.

This is not a problem except that Git does not support taking the
shallow file lock after modifying the shallow file, because
is_repository_shallow() stores information that is never cleared. And
this take-after-modify occurs when Git does a tag-following fetch from a
shallow repository on a transport that does not support tag following
(since in this case, 2 fetches are performed).

To solve this issue, take the shallow file lock (and perform all other
shallow processing) only if the "shallow-info" section is non-empty;
otherwise, behave as if it were empty.

A full solution (probably, ensuring that any action of committing
shallow file locks also includes clearing the information stored by
is_repository_shallow()) would solve the issue without need for this
patch, but this patch is independently useful (as an optimization to
prevent writing a file in an unnecessary case), hence why I wrote it. I
have included a NEEDSWORK outlining the full solution.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
Sorry for sending out multiple solutions to this issue, but I think I
have found the simplest way to do this. Even if we end up needing one of
the more complicated ways, I think that this is independently useful (as
stated above), so I am sending out this patch for your consideration.

For reference, the other solutions I sent out are:

(1) https://public-inbox.org/git/20181218010811.143608-1-jonathantanmy@google.com/
This is the full solution described in the commit message above. Locking
and committing the shallow file is now abstracted behind an interface
that ensures that anything done by is_repository_shallow() is cleared
when the shallow file is committed.

(2) https://public-inbox.org/git/20181220195349.92214-1-jonathantanmy@google.com/
A partial solution - if the client did not make any depth requests (as
is the case above - the client is shallow but made a normal fetch
request), any "shallow" lines are first filtered before determining if
the lock needs to be taken. This solves the issue in practice because
there are no "shallow"s, so no lock is taken (and the filter is a
no-op).

The two prior versions do not have the annotated tag in the test. I
noticed that the second fetch occurs regardless of whether the annotated
tag is present, but I included it anyway - the second fetch is possibly
a bug if the annotated tag is not present, but that issue is outside the
scope of this patch.
---
 fetch-pack.c           | 11 +++++++++--
 shallow.c              |  7 +++++++
 t/t5702-protocol-v2.sh | 18 ++++++++++++++++++
 3 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index dd6700bda9..5885623ece 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1232,6 +1232,8 @@ static int process_acks(struct fetch_negotiator *negotiator,
 static void receive_shallow_info(struct fetch_pack_args *args,
 				 struct packet_reader *reader)
 {
+	int line_received = 0;
+
 	process_section_header(reader, "shallow-info", 0);
 	while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
 		const char *arg;
@@ -1241,6 +1243,7 @@ static void receive_shallow_info(struct fetch_pack_args *args,
 			if (get_oid_hex(arg, &oid))
 				die(_("invalid shallow line: %s"), reader->line);
 			register_shallow(the_repository, &oid);
+			line_received = 1;
 			continue;
 		}
 		if (skip_prefix(reader->line, "unshallow ", &arg)) {
@@ -1253,6 +1256,7 @@ static void receive_shallow_info(struct fetch_pack_args *args,
 				die(_("error in object: %s"), reader->line);
 			if (unregister_shallow(&oid))
 				die(_("no shallow found: %s"), reader->line);
+			line_received = 1;
 			continue;
 		}
 		die(_("expected shallow/unshallow, got %s"), reader->line);
@@ -1262,8 +1266,11 @@ static void receive_shallow_info(struct fetch_pack_args *args,
 	    reader->status != PACKET_READ_DELIM)
 		die(_("error processing shallow info: %d"), reader->status);
 
-	setup_alternate_shallow(&shallow_lock, &alternate_shallow_file, NULL);
-	args->deepen = 1;
+	if (line_received) {
+		setup_alternate_shallow(&shallow_lock, &alternate_shallow_file,
+					NULL);
+		args->deepen = 1;
+	}
 }
 
 static void receive_wanted_refs(struct packet_reader *reader,
diff --git a/shallow.c b/shallow.c
index 02fdbfc554..ce45297940 100644
--- a/shallow.c
+++ b/shallow.c
@@ -43,6 +43,13 @@ int register_shallow(struct repository *r, const struct object_id *oid)
 
 int is_repository_shallow(struct repository *r)
 {
+	/*
+	 * NEEDSWORK: This function updates
+	 * r->parsed_objects->{is_shallow,shallow_stat} as a side effect but
+	 * there is no corresponding function to clear them when the shallow
+	 * file is updated.
+	 */
+
 	FILE *fp;
 	char buf[1024];
 	const char *path = r->parsed_objects->alternate_shallow_file;
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 0f2b09ebb8..fd164d414d 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -471,6 +471,24 @@ test_expect_success 'upload-pack respects client shallows' '
 	grep "fetch< version 2" trace
 '
 
+test_expect_success 'ensure that multiple fetches in same process from a shallow repo works' '
+	rm -rf server client trace &&
+
+	test_create_repo server &&
+	test_commit -C server one &&
+	test_commit -C server two &&
+	test_commit -C server three &&
+	git clone --shallow-exclude two "file://$(pwd)/server" client &&
+
+	git -C server tag -a -m "an annotated tag" twotag two &&
+
+	# Triggers tag following (thus, 2 fetches in one process)
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client -c protocol.version=2 \
+		fetch --shallow-exclude one origin &&
+	# Ensure that protocol v2 is used
+	grep "fetch< version 2" trace
+'
+
 # Test protocol v2 with 'http://' transport
 #
 . "$TEST_DIRECTORY"/lib-httpd.sh
-- 
2.19.0.271.gfe8321ec05.dirty


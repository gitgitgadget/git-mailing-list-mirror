Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7126AC433DF
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47D5620776
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="BHge1FlQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391903AbgFSR4Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:56:16 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39396 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387512AbgFSR4P (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 13:56:15 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id AB06260478;
        Fri, 19 Jun 2020 17:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592589373;
        bh=Uv/wKn6UgkCUjzt4vWEUTSHZ0g/oJpwNf2V21MdhPfw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=BHge1FlQCt5C9EadB4sY/vwDbS9mj1rwxqn7si7gc1EffZNWr8poGNiWq8w+qBXOg
         Q934E4c2FC9bDAMfJhoOfLqcqXYz4G7QDcevC2pPcZ54K5PhBlFEhRMlyyYNuOYzUn
         Rk8j/CVt2ei1O7MLRLxt5drfWgu+q5ooA25W+jfF8VoL9llwzl2q5QUtb1gDcNoEq2
         tLMjuWxiabCZ8z9wgv0ZD8P2sECJTTD5SXsDnVLRs/cVmDiTeAhLgHQoJZPmWKG9Dl
         HqvChZf8WVsFun4YsenqgnZGnt3YoCRR/7f8SXyGRwFITEpyVqgzkd75aZIGniU7k8
         QEHVekZIr+PB/lJecSR69/abGSDm0LfwflQIibKwxtUCWthkLZtxwmNCgX/jxwUKe3
         o0mjhgbuGwgL3atvFCtLgbB2VjsCVV7fQFqRZ37/Q1MyGbGDns570N6eOPTLtjHR4A
         PlES4Y4BHH04nm7eHSkXC5MgJzLYZ7QuMdtsrLFknxSE6BF9k9W
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 00/44] SHA-256 part 2/3: protocol functionality
Date:   Fri, 19 Jun 2020 17:55:17 +0000
Message-Id: <20200619175601.569856-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9
In-Reply-To: <20200513005424.81369-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is part 2 of 3 of the SHA-256 work.  This series adds all of the
protocol logic to work with SHA-256 repositories.

v3 fixes a bug in patch 34 which prevented cloning an empty repository
with the dumb HTTP protocol.  We look up the hash algorithm by length of
the data in the info/refs file and if we have no refs, we have no
entries.

Previously, we just failed and complained, which isn't really helpful,
nor is it backward compatible.  So now we use whatever the default is
for the current repository.  That means we honor GIT_DEFAULT_HASH or git
clone -c, and default to SHA-1 otherwise.  Users are encouraged to
switch to the smart protocol if they need to distinguish the remote
side's hash algorithm when the repository is empty.

There are tests for the default hash behavior, but not for git clone -c,
because the extensions.objectformat option doesn't exist yet.  I have
tested that it does indeed work, though.

Otherwise, this series is the same as v2 except for a rebase (for my
convenience and Junio's).

Changes from v2:
* Rebase onto master.
* Fix cloning an empty repository with the dumb HTTP protocol.

Changes from v1:
* Fix spurious line additions and deletions.
* Rename len to linelen for easier understanding.
* Move the documentation comment for xstrncmpz to the header.
* Drop a useless variable (found).
* Update several commit messages to better explain things as suggested
  by Junio and Martin.
* Name the parameters for parse_feature_value for better documentation.
* Reduce the scope of variables when possible.
* Add explicit handling for missing object-format capabilities.
* Rename all new options to --object-format.
* Use oidcpy where possible.
* Test more failure cases.
* Have index-pack fail if --stdin and --object-format are both
  specified.
* Move and simplify t5704.
* Other miscellaneous cleanups to respond to review feedback.

Range-diff below.

brian m. carlson (44):
  t1050: match object ID paths in a hash-insensitive way
  Documentation: document v1 protocol object-format capability
  connect: have ref processing code take struct packet_reader
  wrapper: add function to compare strings with different NUL
    termination
  remote: advertise the object-format capability on the server side
  connect: add function to parse multiple v1 capability values
  connect: add function to fetch value of a v2 server capability
  pkt-line: add a member for hash algorithm
  transport: add a hash algorithm member
  connect: add function to detect supported v1 hash functions
  send-pack: detect when the server doesn't support our hash
  connect: make parse_feature_value extern
  fetch-pack: detect when the server doesn't support our hash
  connect: detect algorithm when fetching refs
  builtin/receive-pack: detect when the server doesn't support our hash
  docs: update remote helper docs for object-format extensions
  transport-helper: implement object-format extensions
  remote-curl: implement object-format extensions
  builtin/clone: initialize hash algorithm properly
  t5562: pass object-format in synthesized test data
  fetch-pack: parse and advertise the object-format capability
  setup: set the_repository's hash algo when checking format
  t3200: mark assertion with SHA1 prerequisite
  packfile: compute and use the index CRC offset
  t5302: modernize test formatting
  builtin/show-index: provide options to determine hash algo
  t1302: expect repo format version 1 for SHA-256
  Documentation/technical: document object-format for protocol v2
  connect: pass full packet reader when parsing v2 refs
  connect: parse v2 refs with correct hash algorithm
  serve: advertise object-format capability for protocol v2
  t5500: make hash independent
  builtin/ls-remote: initialize repository based on fetch
  remote-curl: detect algorithm for dumb HTTP by size
  builtin/index-pack: add option to specify hash algorithm
  t1050: pass algorithm to index-pack when outside repo
  remote-curl: avoid truncating refs with ls-remote
  t/helper: initialize the repository for test-sha1-array
  t5702: offer an object-format capability in the test
  t5703: use object-format serve option
  t5704: send object-format capability with SHA-256
  t5300: pass --object-format to git index-pack
  bundle: detect hash algorithm when reading refs
  remote-testgit: adapt for object-format

 Documentation/git-index-pack.txt              |   8 +
 Documentation/git-show-index.txt              |  11 +-
 Documentation/gitremote-helpers.txt           |  33 +-
 .../technical/protocol-capabilities.txt       |  15 +
 Documentation/technical/protocol-v2.txt       |   9 +
 builtin/clone.c                               |   9 +
 builtin/index-pack.c                          |  14 +-
 builtin/ls-remote.c                           |   4 +
 builtin/receive-pack.c                        |  10 +
 builtin/show-index.c                          |  29 +-
 bundle.c                                      |  22 +-
 bundle.h                                      |   1 +
 connect.c                                     | 138 +++++--
 connect.h                                     |   3 +
 fetch-pack.c                                  |  14 +
 git-compat-util.h                             |   6 +
 git.c                                         |   2 +-
 object-store.h                                |   1 +
 packfile.c                                    |   1 +
 pkt-line.c                                    |   1 +
 pkt-line.h                                    |   3 +
 remote-curl.c                                 |  46 ++-
 send-pack.c                                   |   6 +
 serve.c                                       |  27 ++
 setup.c                                       |   1 +
 t/helper/test-oid-array.c                     |   3 +
 t/t1050-large.sh                              |   6 +-
 t/t1302-repo-version.sh                       |   6 +-
 t/t3200-branch.sh                             |   2 +-
 t/t5300-pack-object.sh                        |   9 +-
 t/t5302-pack-index.sh                         | 360 +++++++++---------
 t/t5500-fetch-pack.sh                         |   5 +-
 t/t5550-http-fetch-dumb.sh                    |  18 +
 t/t5562-http-backend-content-length.sh        |   5 +-
 t/t5701-git-serve.sh                          |  25 ++
 t/t5702-protocol-v2.sh                        |   2 +
 t/t5703-upload-pack-ref-in-want.sh            |  19 +-
 t/t5704-protocol-violations.sh                |   2 +
 t/t5801/git-remote-testgit                    |   6 +
 t/test-lib.sh                                 |   1 +
 transport-helper.c                            |  24 +-
 transport.c                                   |  18 +-
 transport.h                                   |   8 +
 upload-pack.c                                 |   3 +-
 wrapper.c                                     |   8 +
 45 files changed, 696 insertions(+), 248 deletions(-)

Range-diff against v2:
 1:  5878fe6a98 =  1:  3504602e31 t1050: match object ID paths in a hash-insensitive way
 2:  402864eaa3 =  2:  150ccddb98 Documentation: document v1 protocol object-format capability
 3:  d124692e2f =  3:  b86ec9fffe connect: have ref processing code take struct packet_reader
 4:  cce29662b4 =  4:  f048e638e5 wrapper: add function to compare strings with different NUL termination
 5:  3b207e304b !  5:  99261e8221 remote: advertise the object-format capability on the server side
    @@ upload-pack.c
     @@ upload-pack.c: static int send_ref(const char *refname, const struct object_id *oid,
      		struct strbuf symref_info = STRBUF_INIT;
      
    - 		format_symref_info(&symref_info, cb_data);
    + 		format_symref_info(&symref_info, &data->symref);
     -		packet_write_fmt(1, "%s %s%c%s%s%s%s%s%s agent=%s\n",
     +		packet_write_fmt(1, "%s %s%c%s%s%s%s%s%s object-format=%s agent=%s\n",
      			     oid_to_hex(oid), refname_nons,
      			     0, capabilities,
      			     (allow_unadvertised_object_request & ALLOW_TIP_SHA1) ?
     @@ upload-pack.c: static int send_ref(const char *refname, const struct object_id *oid,
    - 			     stateless_rpc ? " no-done" : "",
    + 			     data->stateless_rpc ? " no-done" : "",
      			     symref_info.buf,
      			     allow_filter ? " filter" : "",
     +			     the_hash_algo->name,
 6:  235d7f5b8f =  6:  5504199a26 connect: add function to parse multiple v1 capability values
 7:  0324e126b1 =  7:  59d1b463bf connect: add function to fetch value of a v2 server capability
 8:  cdba3122ce =  8:  1b2789cab7 pkt-line: add a member for hash algorithm
 9:  c8233c3b42 =  9:  971d05e2c7 transport: add a hash algorithm member
10:  b9273c4021 = 10:  7b90abd41a connect: add function to detect supported v1 hash functions
11:  e2d37b75c8 = 11:  578676762d send-pack: detect when the server doesn't support our hash
12:  602734cbbb = 12:  131e98603a connect: make parse_feature_value extern
13:  d97fa2c8aa = 13:  a786478005 fetch-pack: detect when the server doesn't support our hash
14:  ba052f1da7 = 14:  3436a6db7b connect: detect algorithm when fetching refs
15:  661d94d4de = 15:  c8d0760e3f builtin/receive-pack: detect when the server doesn't support our hash
16:  fd8b85390c = 16:  944bf6ab9a docs: update remote helper docs for object-format extensions
17:  32285e611f = 17:  9f072d34dc transport-helper: implement object-format extensions
18:  a33d1ed9a0 = 18:  2bdc53a8d9 remote-curl: implement object-format extensions
19:  fffdf0780d = 19:  87c6cd32f7 builtin/clone: initialize hash algorithm properly
20:  f616f85b4b = 20:  e2cc4d34fe t5562: pass object-format in synthesized test data
21:  eca43da42e = 21:  34b712a983 fetch-pack: parse and advertise the object-format capability
22:  22c1a62e10 = 22:  3e43a7d314 setup: set the_repository's hash algo when checking format
23:  7c7f2263d5 = 23:  fcf0ef64f0 t3200: mark assertion with SHA1 prerequisite
24:  ee8a71a926 = 24:  192578b5dd packfile: compute and use the index CRC offset
25:  6afecf0b09 = 25:  a560ed3194 t5302: modernize test formatting
26:  99a847ba4e = 26:  9a079f99a0 builtin/show-index: provide options to determine hash algo
27:  9f7c7bafaf = 27:  56d97c9c94 t1302: expect repo format version 1 for SHA-256
28:  d0ea597d63 = 28:  8c25898ded Documentation/technical: document object-format for protocol v2
29:  51848df542 = 29:  39af318fb0 connect: pass full packet reader when parsing v2 refs
30:  b57361f3b8 ! 30:  5b334cb9b9 connect: parse v2 refs with correct hash algorithm
    @@ connect.c: static int process_ref_v2(struct packet_reader *reader, struct ref **
      			*list = &peeled->next;
      
     @@ connect.c: struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
    - 			     const struct string_list *server_options)
    + 			     int stateless_rpc)
      {
      	int i;
     +	const char *hash_name;
31:  a0c0f0f7a3 = 31:  955ea0b4cb serve: advertise object-format capability for protocol v2
32:  1694f3f838 = 32:  5172e56115 t5500: make hash independent
33:  902b394667 = 33:  79b576238f builtin/ls-remote: initialize repository based on fetch
34:  cc12b9b51f ! 34:  0ecf5c1a1f remote-curl: detect algorithm for dumb HTTP by size
    @@ Commit message
         provide one. Detect the hash algorithm in use by the size of the first
         object ID.
     
    +    If we have an empty repository, we don't know what the hash algorithm is
    +    on the remote side, so default to whatever the local side has
    +    configured.  Without doing this, we cannot clone an empty repository
    +    since we don't know its hash algorithm.  Test this case appropriately,
    +    since we currently have no tests for cloning an empty repository with
    +    the dumb HTTP protocol.
    +
         We anonymize the URL like elsewhere in the function in case the user has
         decided to include a secret in the URL.
     
    @@ remote-curl.c: static struct ref *parse_git_refs(struct discovery *heads, int fo
     +	const char *p = memchr(heads->buf, '\t', heads->len);
     +	int algo;
     +	if (!p)
    -+		return NULL;
    ++		return the_hash_algo;
     +
     +	algo = hash_algo_by_length((p - heads->buf) / 2);
     +	if (algo == GIT_HASH_UNKNOWN)
    @@ remote-curl.c: static struct ref *parse_info_refs(struct discovery *heads)
      			if (!refs)
      				refs = ref;
      			if (last_ref)
    +
    + ## t/t5550-http-fetch-dumb.sh ##
    +@@ t/t5550-http-fetch-dumb.sh: test_expect_success 'create password-protected repository' '
    + 	       "$HTTPD_DOCUMENT_ROOT_PATH/auth/dumb/repo.git"
    + '
    + 
    ++test_expect_success 'create empty remote repository' '
    ++	git init --bare "$HTTPD_DOCUMENT_ROOT_PATH/empty.git" &&
    ++	(cd "$HTTPD_DOCUMENT_ROOT_PATH/empty.git" &&
    ++	 mkdir -p hooks &&
    ++	 write_script "hooks/post-update" <<-\EOF &&
    ++	 exec git update-server-info
    ++	EOF
    ++	 hooks/post-update
    ++	)
    ++'
    ++
    ++test_expect_success 'empty dumb HTTP repository has default hash algorithm' '
    ++	test_when_finished "rm -fr clone-empty" &&
    ++	git clone $HTTPD_URL/dumb/empty.git clone-empty &&
    ++	git -C clone-empty rev-parse --show-object-format >empty-format &&
    ++	test "$(cat empty-format)" = "$(test_oid algo)"
    ++'
    ++
    + setup_askpass_helper
    + 
    + test_expect_success 'cloning password-protected repository can fail' '
35:  b5425c9f54 = 35:  95bc1ef6fb builtin/index-pack: add option to specify hash algorithm
36:  5c70c24d7a = 36:  89c389100e t1050: pass algorithm to index-pack when outside repo
37:  460d6008e8 = 37:  bd93aabe6b remote-curl: avoid truncating refs with ls-remote
38:  60a98d9b53 = 38:  a8e31600cc t/helper: initialize the repository for test-sha1-array
39:  b66c3ead37 = 39:  d217758a83 t5702: offer an object-format capability in the test
40:  af43274a1f = 40:  6d1964142c t5703: use object-format serve option
41:  f5085b1f3f = 41:  84cad9b3ba t5704: send object-format capability with SHA-256
42:  a1b01babda = 42:  1e96dbf3dc t5300: pass --object-format to git index-pack
43:  dbb5f7195e = 43:  14cb067334 bundle: detect hash algorithm when reading refs
44:  6c823bbe68 = 44:  816d08eb2e remote-testgit: adapt for object-format

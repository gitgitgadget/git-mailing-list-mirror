Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B6AC433E2
	for <git@archiver.kernel.org>; Mon, 25 May 2020 19:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C215E20776
	for <git@archiver.kernel.org>; Mon, 25 May 2020 19:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="mrK3nMCO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390397AbgEYT7s (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 15:59:48 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38674 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390353AbgEYT7p (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 May 2020 15:59:45 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id AAF3F60482;
        Mon, 25 May 2020 19:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1590436783;
        bh=HhYglvrvO44gU+ROsoBx1TlzprbPpAyi/FY6y+7r9BM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=mrK3nMCOZii5RzZrGSU4olJUbjbVU4E+zeb0aQzjM+F/zrAn2YMRn2uShVl2hru++
         vo1XFvsOc2zNCIItw8f5WusQl/pjH6OPtqsMSo/WCKq78so8We5WfRndktMeH7wNOw
         Lu2kjHQqYm4vwjnW2O8eoKCzqPSm9c9ThhBMLGoGMQOTDvrdxLKEaWpPpEI8zfxw5O
         /vB6RtyXGNiFPRI61aMqIda+T+hzabAmg9Y//e4DnC8dFvq1rl9dSbS8toJF22Tk3g
         EsDuKyJJag7wwUTA2bXG1O5uhS7eoxiHBp9hIdFFB1kFk+QixiolM4BthuQ+hUrzX0
         QZcUoPMaS5VL6KqfyhEpk78pN1KlXtNhYaLCgw5ouIkYZepqpyJI7+FA8QsMMKl9KG
         sIRwMd0wYMj06iXTWgmnP3vk6g/dLuZfFpf+vES1A/c/WuQSwNubieYUj0J2yG7QZH
         d8HRPg9S7A4Q0O5EesuuE2oZ0Px/ri2agcv5Y0HfDuPmv6V2vYu
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 00/44] SHA-256 part 2/3: protocol functionality
Date:   Mon, 25 May 2020 19:58:46 +0000
Message-Id: <20200525195930.309665-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652
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
 44 files changed, 678 insertions(+), 248 deletions(-)

Range-diff against v1:
 1:  82a0a5beae =  1:  5878fe6a98 t1050: match object ID paths in a hash-insensitive way
 2:  95e84f6457 !  2:  402864eaa3 Documentation: document v1 protocol object-format capability
    @@ Documentation/technical/protocol-capabilities.txt: agent strings are purely info
      symref
      ------
      
    -@@ Documentation/technical/protocol-capabilities.txt: refs being sent.
    - 
    - Clients MAY use the parameters from this capability to select the proper initial
    - branch when cloning a repository.
    --
    - shallow
    - -------
    - 
 3:  7c82e91a11 !  3:  d124692e2f connect: have ref processing code take struct packet_reader
    @@ Commit message
         code take pointers to struct reader instead of having to pass multiple
         arguments to each function.
     
    +    Rename the len variable to "linelen" to make it clearer what the
    +    variable does in light of the variable change.
    +
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
      ## connect.c ##
    @@ connect.c: static void annotate_refs_with_symref_info(struct ref *ref)
      }
      
     -static void process_capabilities(const char *line, int *len)
    -+static void process_capabilities(struct packet_reader *reader, int *len)
    ++static void process_capabilities(struct packet_reader *reader, int *linelen)
      {
     +	const char *line = reader->line;
      	int nul_location = strlen(line);
    - 	if (nul_location == *len)
    +-	if (nul_location == *len)
    ++	if (nul_location == *linelen)
      		return;
    -@@ connect.c: static void process_capabilities(const char *line, int *len)
    - 	*len = nul_location;
    + 	server_capabilities_v1 = xstrdup(line + nul_location + 1);
    +-	*len = nul_location;
    ++	*linelen = nul_location;
      }
      
     -static int process_dummy_ref(const char *line)
 4:  a78234de04 <  -:  ---------- wrapper: add function to compare strings with different NUL termination
 -:  ---------- >  4:  cce29662b4 wrapper: add function to compare strings with different NUL termination
 5:  628ecec99a =  5:  3b207e304b remote: advertise the object-format capability on the server side
 6:  9990767072 =  6:  235d7f5b8f connect: add function to parse multiple v1 capability values
 7:  5ce2b7afde =  7:  0324e126b1 connect: add function to fetch value of a v2 server capability
 8:  e5d58b48f3 =  8:  cdba3122ce pkt-line: add a member for hash algorithm
 9:  bce9ba0538 =  9:  c8233c3b42 transport: add a hash algorithm member
10:  2d016e3870 ! 10:  b9273c4021 connect: add function to detect supported v1 hash functions
    @@ connect.c: static const char *parse_feature_value(const char *feature_list, cons
     +int server_supports_hash(const char *desired, int *feature_supported)
     +{
     +	int offset = 0;
    -+	int len, found = 0;
    ++	int len;
     +	const char *hash;
     +
     +	hash = next_server_feature_value("object-format", &len, &offset);
    @@ connect.c: static const char *parse_feature_value(const char *feature_list, cons
     +	}
     +	while (hash) {
     +		if (!xstrncmpz(desired, hash, len))
    -+			found = 1;
    -+
    -+		if (found)
     +			return 1;
    ++
     +		hash = next_server_feature_value("object-format", &len, &offset);
     +	}
     +	return 0;
11:  9fdc67b825 ! 11:  e2d37b75c8 send-pack: detect when the server doesn't support our hash
    @@ Commit message
         send-pack: detect when the server doesn't support our hash
     
         Detect when the server doesn't support our hash algorithm and abort.
    +    If the server does support our hash, advertise it as part of our
    +    capabilities.
     
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
12:  91a1fb0a7d ! 12:  602734cbbb connect: make parse_feature_value extern
    @@ connect.h: struct packet_reader;
      enum protocol_version discover_version(struct packet_reader *reader);
      
      int server_supports_hash(const char *desired, int *feature_supported);
    -+const char *parse_feature_value(const char *, const char *, int *, int *);
    ++const char *parse_feature_value(const char *feature_list, const char *feature, int *lenp, int *offset);
      int server_supports_v2(const char *c, int die_on_error);
      int server_feature_v2(const char *c, const char **v);
      int server_supports_feature(const char *c, const char *feature,
13:  fd82e5f755 = 13:  d97fa2c8aa fetch-pack: detect when the server doesn't support our hash
14:  b62f751fe4 ! 14:  ba052f1da7 connect: detect algorithm when fetching refs
    @@ Commit message
         If we're fetching refs, detect the hash algorithm and parse the refs
         using that algorithm.
     
    +    As mentioned in the documentation, if multiple versions of the
    +    object-format capability are provided, we use the first.  No known
    +    implementation supports multiple algorithms now, but they may in the
    +    future.
    +
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
      ## connect.c ##
     @@ connect.c: static void annotate_refs_with_symref_info(struct ref *ref)
      
    - static void process_capabilities(struct packet_reader *reader, int *len)
    + static void process_capabilities(struct packet_reader *reader, int *linelen)
      {
     +	const char *feat_val;
     +	int feat_len;
    -+	int hash_algo;
      	const char *line = reader->line;
      	int nul_location = strlen(line);
    - 	if (nul_location == *len)
    + 	if (nul_location == *linelen)
      		return;
      	server_capabilities_v1 = xstrdup(line + nul_location + 1);
    - 	*len = nul_location;
    + 	*linelen = nul_location;
     +
     +	feat_val = server_feature_value("object-format", &feat_len);
     +	if (feat_val) {
     +		char *hash_name = xstrndup(feat_val, feat_len);
    -+		hash_algo = hash_algo_by_name(hash_name);
    ++		int hash_algo = hash_algo_by_name(hash_name);
     +		if (hash_algo != GIT_HASH_UNKNOWN)
     +			reader->hash_algo = &hash_algos[hash_algo];
     +		free(hash_name);
    ++	} else {
    ++		reader->hash_algo = &hash_algos[GIT_HASH_SHA1];
     +	}
      }
      
15:  29b4219411 ! 15:  661d94d4de builtin/receive-pack: detect when the server doesn't support our hash
    @@ builtin/receive-pack.c: static struct command *read_head_info(struct packet_read
      		linelen = strlen(reader->line);
      		if (linelen < reader->pktlen) {
      			const char *feature_list = reader->line + linelen + 1;
    -+			const char *hash;
    ++			const char *hash = NULL;
     +			int len = 0;
      			if (parse_feature_request(feature_list, "report-status"))
      				report_status = 1;
16:  f8eb8c96f8 = 16:  fd8b85390c docs: update remote helper docs for object-format extensions
17:  93bf7005a8 = 17:  32285e611f transport-helper: implement object-format extensions
18:  ed75c102a3 = 18:  a33d1ed9a0 remote-curl: implement object-format extensions
19:  bf16872e73 = 19:  fffdf0780d builtin/clone: initialize hash algorithm properly
20:  ce77713343 ! 20:  f616f85b4b t5562: pass object-format in synthesized test data
    @@ t/t5562-http-backend-content-length.sh: test_expect_success 'setup' '
      		printf 0000 &&
      		echo "$hash_next" | git pack-objects --stdout
      	} >push_body &&
    -@@ t/t5562-http-backend-content-length.sh: test_expect_success GZIP 'push plain' '
    - 	test_cmp act.head exp.head
    - '
    - 
    -+test_expect_success GZIP 'push plain with SHA-1' '
    -+	test_when_finished "git branch -D newbranch" &&
    -+	test_http_env receive push_body &&
    -+	verify_http_result "200 OK" &&
    -+	git rev-parse newbranch >act.head &&
    -+	echo "$hash_next" >exp.head &&
    -+	test_cmp act.head exp.head
    -+'
    -+
    - test_expect_success 'push plain truncated' '
    - 	test_http_env receive push_body.trunc &&
    - 	! verify_http_result "200 OK"
21:  e4dd90fa9d <  -:  ---------- t5704: send object-format capability with SHA-256
22:  626d6e9018 ! 21:  eca43da42e fetch-pack: parse and advertise the object-format capability
    @@ fetch-pack.c: static int send_fetch_request(struct fetch_negotiator *negotiator,
     +			die(_("mismatched algorithms: client %s; server %s"),
     +			    the_hash_algo->name, hash_name);
     +		packet_write_fmt(fd_out, "object-format=%s", the_hash_algo->name);
    -+	}
    -+	else if (hash_algo_by_ptr(the_hash_algo) != GIT_HASH_SHA1)
    ++	} else if (hash_algo_by_ptr(the_hash_algo) != GIT_HASH_SHA1) {
     +		die(_("the server does not support algorithm '%s'"),
     +		    the_hash_algo->name);
    ++	}
     +
      	packet_buf_delim(&req_buf);
      	if (args->use_thin_pack)
23:  8c675b5117 ! 22:  22c1a62e10 setup: set the_repository's hash algo when checking format
    @@ Commit message
         the same time.  This ensures that we perform a suitable initialization
         early enough to avoid confusing any parts of the code.  If we defer
         until later, we can end up with portions of the code which are confused
    -    about the hash algorithm, resulting in segfaults.
    +    about the hash algorithm, resulting in segfaults when working with
    +    SHA-256 repositories.
     
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
24:  b714d4accc = 23:  7c7f2263d5 t3200: mark assertion with SHA1 prerequisite
25:  eacde58fda = 24:  ee8a71a926 packfile: compute and use the index CRC offset
26:  81bb8cdb18 = 25:  6afecf0b09 t5302: modernize test formatting
27:  8623f21715 ! 26:  99a847ba4e builtin/show-index: provide options to determine hash algo
    @@ Metadata
      ## Commit message ##
         builtin/show-index: provide options to determine hash algo
     
    -    It's possible to use a variety of index formats with show-index, and we
    -    need a way to indicate the hash algorithm which is in use for a
    -    particular index we'd like to show.  Default to using the value for the
    -    repository we're in by calling setup_git_directory_gently, and allow
    -    overriding it by using a --hash argument.
    +    show-index is capable of reading any possible index file whether or not
    +    the index is inside a repository.  However, because our index files lack
    +    metadata about the hash algorithm in use, it's not possible to
    +    autodetect the algorithm that a particular index file is using.
    +
    +    In order to allow us to read index files of any algorithm, let's set up
    +    the .git directory gently so that we default to the algorithm for the
    +    current repository, and add an --object-format option to allow users to
    +    override this setting and continue to run show-index outside of a
    +    repository altogether.  Let's also document this new option so that
    +    people can find it and use it.
     
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
    + ## Documentation/git-show-index.txt ##
    +@@ Documentation/git-show-index.txt: git-show-index - Show packed archive index
    + SYNOPSIS
    + --------
    + [verse]
    +-'git show-index'
    ++'git show-index' [--object-format=<hash-algorithm>]
    + 
    + 
    + DESCRIPTION
    +@@ Documentation/git-show-index.txt: Note that you can get more information on a packfile by calling
    + linkgit:git-verify-pack[1]. However, as this command considers only the
    + index file itself, it's both faster and more flexible.
    + 
    ++OPTIONS
    ++-------
    ++
    ++--object-format=<hash-algorithm>::
    ++	Specify the given object format (hash algorithm) for the index file.  The
    ++	valid values are 'sha1' and (if enabled) 'sha256'.  The default is the
    ++	algorithm for the current repository (set by `extensions.objectFormat`), or
    ++	'sha1' if no value is set or outside a repository..
    ++
    + GIT
    + ---
    + Part of the linkgit:git[1] suite
    +
      ## builtin/show-index.c ##
     @@
      #include "builtin.h"
    @@ builtin/show-index.c
     -static const char show_index_usage[] =
     -"git show-index";
     +static const char *const show_index_usage[] = {
    -+	"git show-index [--hash=HASH]",
    ++	"git show-index [--object-format=<hash-algorithm>]",
     +	NULL
     +};
      
    @@ builtin/show-index.c: int cmd_show_index(int argc, const char **argv, const char
     +	const char *hash_name = NULL;
     +	int hash_algo;
     +	const struct option show_index_options[] = {
    -+		OPT_STRING(0, "hash", &hash_name, N_("hash"),
    ++		OPT_STRING(0, "object-format", &hash_name, N_("hash-algorithm"),
     +			   N_("specify the hash algorithm to use")),
     +		OPT_END()
     +	};
28:  bb3d2f566a = 27:  9f7c7bafaf t1302: expect repo format version 1 for SHA-256
29:  cc25069cb6 = 28:  d0ea597d63 Documentation/technical: document object-format for protocol v2
30:  efdac6383f ! 29:  51848df542 connect: pass full packet reader when parsing v2 refs
    @@ connect.c: static int process_ref_v2(const char *line, struct ref ***list)
      	/*
      	 * Ref lines have a number of fields which are space deliminated.  The
     @@ connect.c: struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
    - 	}
    - 	packet_flush(fd_out);
      
    -+
      	/* Process response from server */
      	while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
     -		if (!process_ref_v2(reader->line, &list))
31:  602405e436 ! 30:  b57361f3b8 connect: parse v2 refs with correct hash algorithm
    @@ Commit message
         set that value in the packet reader.  Parse the refs using this
         algorithm.
     
    -    Note that we use memcpy instead of oidcpy for copying values, since
    -    oidcpy is intentionally limited to the current hash algorithm length,
    -    and the copy will be too short if the server side uses SHA-256 but the
    -    client side has not had a repository set up (and therefore defaults to
    -    SHA-1).
    -
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
      ## connect.c ##
    +@@ connect.c: static int process_ref(const struct packet_reader *reader, int len,
    + 		die(_("protocol error: unexpected capabilities^{}"));
    + 	} else if (check_ref(name, flags)) {
    + 		struct ref *ref = alloc_ref(name);
    +-		memcpy(ref->old_oid.hash, old_oid.hash, reader->hash_algo->rawsz);
    ++		oidcpy(&ref->old_oid, &old_oid);
    + 		**list = ref;
    + 		*list = &ref->next;
    + 	}
     @@ connect.c: static int process_ref_v2(struct packet_reader *reader, struct ref ***list)
      		goto out;
      	}
32:  96236ac9ae ! 31:  a0c0f0f7a3 serve: advertise object-format capability for protocol v2
    @@ Commit message
     
         In the test, when we're using an algorithm other than SHA-1, we need to
         specify the algorithm in use so we don't get a failure with an "unknown
    -    format" message. Add a wrapper function that specifies this header if
    -    required.  Skip specifying this header for SHA-1 to test that it works
    -    both with and without this header.
    +    format" message.  Add a test that we handle a mismatched algorithm.
    +    Remove the test_oid_init call since it's no longer necessary.
     
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
    + ## connect.c ##
    +@@ connect.c: struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
    + 			die(_("unknown object format '%s' specified by server"), hash_name);
    + 		reader->hash_algo = &hash_algos[hash_algo];
    + 		packet_write_fmt(fd_out, "object-format=%s", reader->hash_algo->name);
    ++	} else {
    ++		reader->hash_algo = &hash_algos[GIT_HASH_SHA1];
    + 	}
    + 
    + 	if (server_options && server_options->nr &&
    +
      ## serve.c ##
     @@ serve.c: static int agent_advertise(struct repository *r,
      	return 1;
    @@ serve.c: static int process_request(void)
     
      ## t/t5701-git-serve.sh ##
     @@ t/t5701-git-serve.sh: test_description='test protocol v2 server commands'
    - 
      . ./test-lib.sh
      
    -+write_command () {
    -+	echo "command=$1"
    -+
    -+	if test "$(test_oid algo)" != sha1
    -+	then
    -+		echo "object-format=$(test_oid algo)"
    -+	fi
    -+}
    -+
      test_expect_success 'test capability advertisement' '
    -+	test_oid_init &&
    ++	test_oid_cache <<-EOF &&
    ++	wrong_algo sha1:sha256
    ++	wrong_algo sha256:sha1
    ++	EOF
      	cat >expect <<-EOF &&
      	version 2
      	agent=git/$(git version | cut -d" " -f3)
    @@ t/t5701-git-serve.sh: test_expect_success 'request invalid capability' '
      	EOF
      	test_must_fail test-tool serve-v2 --stateless-rpc 2>err <in &&
     @@ t/t5701-git-serve.sh: test_expect_success 'request with no command' '
    - 
      test_expect_success 'request invalid command' '
      	test-tool pkt-line pack >in <<-EOF &&
    --	command=foo
    -+	$(write_command foo)
    + 	command=foo
    ++	object-format=$(test_oid algo)
      	agent=git/test
      	0000
      	EOF
    -@@ t/t5701-git-serve.sh: test_expect_success 'setup some refs and tags' '
    +@@ t/t5701-git-serve.sh: test_expect_success 'request invalid command' '
    + 	test_i18ngrep "invalid command" err
    + '
      
    ++test_expect_success 'wrong object-format' '
    ++	test-tool pkt-line pack >in <<-EOF &&
    ++	command=fetch
    ++	agent=git/test
    ++	object-format=$(test_oid wrong_algo)
    ++	0000
    ++	EOF
    ++	test_must_fail test-tool serve-v2 --stateless-rpc 2>err <in &&
    ++	test_i18ngrep "mismatched object format" err
    ++'
    ++
    + # Test the basics of ls-refs
    + #
    + test_expect_success 'setup some refs and tags' '
    +@@ t/t5701-git-serve.sh: test_expect_success 'setup some refs and tags' '
      test_expect_success 'basics of ls-refs' '
      	test-tool pkt-line pack >in <<-EOF &&
    --	command=ls-refs
    -+	$(write_command ls-refs)
    + 	command=ls-refs
    ++	object-format=$(test_oid algo)
      	0000
      	EOF
      
     @@ t/t5701-git-serve.sh: test_expect_success 'basics of ls-refs' '
    - 
      test_expect_success 'basic ref-prefixes' '
      	test-tool pkt-line pack >in <<-EOF &&
    --	command=ls-refs
    -+	$(write_command ls-refs)
    + 	command=ls-refs
    ++	object-format=$(test_oid algo)
      	0001
      	ref-prefix refs/heads/master
      	ref-prefix refs/tags/one
     @@ t/t5701-git-serve.sh: test_expect_success 'basic ref-prefixes' '
    - 
      test_expect_success 'refs/heads prefix' '
      	test-tool pkt-line pack >in <<-EOF &&
    --	command=ls-refs
    -+	$(write_command ls-refs)
    + 	command=ls-refs
    ++	object-format=$(test_oid algo)
      	0001
      	ref-prefix refs/heads/
      	0000
     @@ t/t5701-git-serve.sh: test_expect_success 'refs/heads prefix' '
    - 
      test_expect_success 'peel parameter' '
      	test-tool pkt-line pack >in <<-EOF &&
    --	command=ls-refs
    -+	$(write_command ls-refs)
    + 	command=ls-refs
    ++	object-format=$(test_oid algo)
      	0001
      	peel
      	ref-prefix refs/tags/
     @@ t/t5701-git-serve.sh: test_expect_success 'peel parameter' '
    - 
      test_expect_success 'symrefs parameter' '
      	test-tool pkt-line pack >in <<-EOF &&
    --	command=ls-refs
    -+	$(write_command ls-refs)
    + 	command=ls-refs
    ++	object-format=$(test_oid algo)
      	0001
      	symrefs
      	ref-prefix refs/heads/
     @@ t/t5701-git-serve.sh: test_expect_success 'symrefs parameter' '
    - 
      test_expect_success 'sending server-options' '
      	test-tool pkt-line pack >in <<-EOF &&
    --	command=ls-refs
    -+	$(write_command ls-refs)
    + 	command=ls-refs
    ++	object-format=$(test_oid algo)
      	server-option=hello
      	server-option=world
      	0001
     @@ t/t5701-git-serve.sh: test_expect_success 'unexpected lines are not allowed in fetch request' '
    - 	git init server &&
      
      	test-tool pkt-line pack >in <<-EOF &&
    --	command=fetch
    -+	$(write_command fetch)
    + 	command=fetch
    ++	object-format=$(test_oid algo)
      	0001
      	this-is-not-a-command
      	0000
33:  57f3bbb709 = 32:  1694f3f838 t5500: make hash independent
34:  8242e65747 ! 33:  902b394667 builtin/ls-remote: initialize repository based on fetch
    @@ Commit message
         the refs to 40 hex characters, since that's the length of the default
         hash algorithm (SHA-1).
     
    +    Note that technically this is not a correct setting of the repository
    +    hash algorithm since, if we are in a repository, it might be one of a
    +    different hash algorithm from the remote side.  However, our current
    +    code paths don't handle multiple algorithms and won't for some time, so
    +    this is the best we can do.  We rely on the fact that ls-remote never
    +    modifies the current repository, which is a reasonable assumption to
    +    make.
    +
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
      ## builtin/ls-remote.c ##
35:  c5664b646f ! 34:  cc12b9b51f remote-curl: detect algorithm for dumb HTTP by size
    @@ Commit message
         provide one. Detect the hash algorithm in use by the size of the first
         object ID.
     
    +    We anonymize the URL like elsewhere in the function in case the user has
    +    decided to include a secret in the URL.
    +
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
      ## remote-curl.c ##
    @@ remote-curl.c: static struct ref *parse_info_refs(struct discovery *heads)
     +	if (!options.hash_algo)
     +		die("%sinfo/refs not valid: could not determine hash algorithm; "
     +		    "is this a git repository?",
    -+		    url.buf);
    ++		    transport_anonymize_url(url.buf));
     +
      	data = heads->buf;
      	start = NULL;
36:  31cd59a221 <  -:  ---------- builtin/index-pack: add option to specify hash algorithm
 -:  ---------- > 35:  b5425c9f54 builtin/index-pack: add option to specify hash algorithm
37:  658b787e8c = 36:  5c70c24d7a t1050: pass algorithm to index-pack when outside repo
38:  64429337ba = 37:  460d6008e8 remote-curl: avoid truncating refs with ls-remote
39:  cde2128520 = 38:  60a98d9b53 t/helper: initialize the repository for test-sha1-array
40:  0af00a7681 = 39:  b66c3ead37 t5702: offer an object-format capability in the test
41:  74278d4c1c = 40:  af43274a1f t5703: use object-format serve option
 -:  ---------- > 41:  f5085b1f3f t5704: send object-format capability with SHA-256
42:  4f735c8bb5 = 42:  a1b01babda t5300: pass --object-format to git index-pack
43:  3854f70427 = 43:  dbb5f7195e bundle: detect hash algorithm when reading refs
44:  103be1f4d6 = 44:  6c823bbe68 remote-testgit: adapt for object-format

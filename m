Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE3C156871
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 14:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832636; cv=none; b=s0F4a23imvyJO7GpwtWoKRDizFYjxdiqVdgqS0Mt0te3PctS6teLU2B2e5v/rrNebp38PtlaIAzV7ktzoJRwjCVFYns3n3Ivckb3zzsSrCuRewWb60dVP2Wid2Lgi3GDhgrHBmnGUT38V2nMu14yVI0XExaLvpoGFJAwkW+/VTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832636; c=relaxed/simple;
	bh=XE5bT+aBXC9MMu7fPWe+DAOZRykPKZI+BCHL9ScUXs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VPz2VuLuV62jyD2JggxwmjfgsPEG5s+1lZvdnn46qC77xkoRrmH3ApD4uvgrdnvzQzx7XYn8wCHSIHegtRuRuEQkbJ3kUKf+n1tA5t/dmcd/GSq++IhgTvNEqiugaAbO0rXnkpfowyeV3eWYAmaGKCK29HBwljJ93miwbRxNiHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=FOQ8glfn; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="FOQ8glfn"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1721832628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2+2DdrrP4FUWOf12CzIXTAFh6reh9NCF7g49+JiLAe0=;
	b=FOQ8glfnY8IsWdMgXPRlV03y4NmrWEetWt/5zFDOXyqezkYxzECyg8zde0yAV0qOLN5tHo
	PNQIzbVpaOKRiIM82z/r/8rI1gPQU3Q4urSXbe7gkM1keWn3zbtrYajHuGd260jS3c8OYk
	5+F5FOLB2f+qQSy0hZNEmh3DySvcByg=
From: Toon Claes <toon@iotcl.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Toon Claes <toon@iotcl.com>
Subject: [PATCH v2 0/3] fetch: use bundle URIs when having creationToken heuristic
Date: Wed, 24 Jul 2024 16:49:54 +0200
Message-ID: <20240724144957.3033840-1-toon@iotcl.com>
In-Reply-To: <20240722080705.2614195-1-toon@iotcl.com>
References: <20240722080705.2614195-1-toon@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This is version 2 of teaching git-fetch(1) to use bundle URIs. For this second
revision I've split up the changes in multliple commits as Junio suggested.

 - The first patch cleans up some unneccessary code.

 - The second patch refactor the code to make it possible to reuse.

 - The third patch makes git-fetch(1) use bundle URIs when creationToken
   heuristic is used. This time I've added some more information about how
   bundle URIs are handled when they have a creationToken heuristic.

Toon Claes (3):
  clone: remove double bundle list clear code
  transport: introduce transport_has_remote_bundle_uri()
  fetch: use bundle URIs when having creationToken heuristic

 builtin/clone.c             | 26 ++++++--------------
 builtin/fetch.c             | 13 ++++++++++
 t/helper/test-bundle-uri.c  |  2 +-
 t/t5558-clone-bundle-uri.sh | 28 ++++++++++++++++++++-
 t/t5584-fetch-bundle-uri.sh | 49 +++++++++++++++++++++++++++++++++++++
 transport.c                 | 14 ++++++++++-
 transport.h                 |  7 +++---
 7 files changed, 114 insertions(+), 25 deletions(-)
 create mode 100755 t/t5584-fetch-bundle-uri.sh

Range-diff against v1:
-:  ---------- > 1:  fb556a76d3 clone: remove double bundle list clear code
1:  00f6017ab0 ! 2:  0f7c53bbe1 fetch: use bundle URIs when having creationToken heuristic
    @@ Metadata
     Author: Toon Claes <toon@iotcl.com>

      ## Commit message ##
    -    fetch: use bundle URIs when having creationToken heuristic
    +    transport: introduce transport_has_remote_bundle_uri()

    -    At the moment, bundle URIs are only used on git-clone(1). For a clone
    -    the use of bundle URI is trivial, because repository is empty so
    -    downloading bundles will never result in downloading objects that are in
    -    the repository already.
    +    The public function transport_get_remote_bundle_uri() exists to fetch
    +    the bundle URI(s) from the remote. This function is only called from
    +    builtin/clone.c (not taking test-tool into account). There it ignores
    +    the return value, because it doesn't matter whether the server didn't
    +    return any bundles or if it failed trying to fetch them, clone can
    +    continue without bundle URIs. After calling it, it checks if anything
    +    is collected in the bundle list and starts fetching them.

    -    For git-fetch(1), this more complicated to use bundle URI. We want to
    -    avoid downloading bundles that only contains objects that are in the
    -    local repository already.
    -
    -    One way to achieve this is possible when the "creationToken" heuristic
    -    is used for bundle URIs. With this heuristic, the server sends along a
    -    creationToken for each bundle. When a client downloads bundles with such
    -    creationToken, the highest known value is written to
    -    `fetch.bundleCreationToken` in the git-config. The next time bundles are
    -    advertised by the server, bundles with a lower creationToken value are
    -    ignored. This was already implemented by 7903efb717 (bundle-uri:
    -    download in creationToken order, 2023-01-31) in
    -    fetch_bundles_by_token().
    -
    -    Using the creationToken heuristic is optional, but without it the
    -    client has no idea which bundles are new and which only have objects the
    -    client already has.
    -
    -    With this knowledge, make git-fetch(1) get bundle URI information from
    -    the server, but only use bundle URIs if the creationToken heuristic is
    -    used.
    -
    -    The code added in builtin/fetch.c is very similar to the code in
    -    builtin/clone.c, so while at it make sure we always clean up the bundles
    -    list advertised by the server.
    +    Add public function transport_has_remote_bundle_uri() instead. This
    +    calls the (now made private) transport_get_remote_bundle_uri() function
    +    and returns whether any bundle URI is received. This makes reuse of the
    +    code easier and avoids code duplication when we add bundle URI support
    +    to git-fetch(1).

         Signed-off-by: Toon Claes <toon@iotcl.com>

      ## builtin/clone.c ##
     @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
    + 				bundle_uri);
    + 		else if (has_heuristic)
      			git_config_set_gently("fetch.bundleuri", bundle_uri);
    - 	} else {
    - 		/*
    +-	} else {
    +-		/*
     -		* Populate transport->got_remote_bundle_uri and
     -		* transport->bundle_uri. We might get nothing.
     -		*/
    -+		 * Populate transport->bundles. We might get nothing or fail
    -+		 * trying, but clone can continue without bundles as well.
    -+		 */
    - 		transport_get_remote_bundle_uri(transport);
    -
    - 		if (transport->bundles &&
    -@@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
    - 			else if (fetch_bundle_list(the_repository,
    - 						   transport->bundles))
    - 				warning(_("failed to fetch advertised bundles"));
    --		} else {
    --			clear_bundle_list(transport->bundles);
    --			FREE_AND_NULL(transport->bundles);
    - 		}
    -+
    -+		clear_bundle_list(transport->bundles);
    -+		if (transport->bundles)
    -+			FREE_AND_NULL(transport->bundles);
    +-		transport_get_remote_bundle_uri(transport);
    +-
    +-		if (transport->bundles &&
    +-		    hashmap_get_size(&transport->bundles->bundles)) {
    +-			/* At this point, we need the_repository to match the cloned repo. */
    +-			if (repo_init(the_repository, git_dir, work_tree))
    +-				warning(_("failed to initialize the repo, skipping bundle URI"));
    +-			else if (fetch_bundle_list(the_repository,
    +-						   transport->bundles))
    +-				warning(_("failed to fetch advertised bundles"));
    +-		}
    ++	} else if (transport_has_remote_bundle_uri(transport)) {
    ++		/* At this point, we need the_repository to match the cloned repo. */
    ++		if (repo_init(the_repository, git_dir, work_tree))
    ++			warning(_("failed to initialize the repo, skipping bundle URI"));
    ++		else if (fetch_bundle_list(the_repository,
    ++					   transport->bundles))
    ++			warning(_("failed to fetch advertised bundles"));
      	}

      	if (refs)

    - ## builtin/fetch.c ##
    -@@ builtin/fetch.c: static int do_fetch(struct transport *transport,
    - 			retcode = 1;
    + ## t/helper/test-bundle-uri.c ##
    +@@ t/helper/test-bundle-uri.c: static int cmd_ls_remote(int argc, const char **argv)
      	}

    -+	/*
    -+	 * Populate transport->bundles. We might get nothing or fail
    -+	 * trying, but fetch can continue without bundles as well.
    -+	 */
    -+	transport_get_remote_bundle_uri(transport);
    -+
    -+	if (transport->bundles &&
    -+	    hashmap_get_size(&transport->bundles->bundles) &&
    -+	    (transport->bundles->heuristic == BUNDLE_HEURISTIC_CREATIONTOKEN)) {
    -+		if (fetch_bundle_list(the_repository, transport->bundles))
    -+			warning(_("failed to fetch advertised bundles"));
    -+	}
    -+
    -+	clear_bundle_list(transport->bundles);
    -+	if (transport->bundles)
    -+		FREE_AND_NULL(transport->bundles);
    -+
    - 	if (fetch_and_consume_refs(&display_state, transport, transaction, ref_map,
    - 				   &fetch_head, config)) {
    - 		retcode = 1;
    + 	transport = transport_get(remote, NULL);
    +-	if (transport_get_remote_bundle_uri(transport) < 0) {
    ++	if (!transport_has_remote_bundle_uri(transport)) {
    + 		error(_("could not get the bundle-uri list"));
    + 		status = 1;
    + 		goto cleanup;

    - ## t/t5584-fetch-bundle-uri.sh (new) ##
    -@@
    -+#!/bin/sh
    -+
    -+test_description='test use of bundle URI in "git fetch"'
    -+
    -+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    -+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    -+
    -+. ./test-lib.sh
    -+
    -+test_expect_success 'set up repos and bundles' '
    -+	git init source &&
    -+	test_commit -C source A &&
    -+	git clone --no-local source go-A-to-C &&
    -+	test_commit -C source B &&
    -+	git clone --no-local source go-B-to-C &&
    -+	git clone --no-local source go-B-to-D &&
    -+	git -C source bundle create B.bundle main &&
    -+	test_commit -C source C &&
    -+	git -C source bundle create B-to-C.bundle B..main &&
    -+	git -C source config uploadpack.advertiseBundleURIs true &&
    -+	git -C source config bundle.version 1 &&
    -+	git -C source config bundle.mode all &&
    -+	git -C source config bundle.heuristic creationToken &&
    -+	git -C source config bundle.bundle-B.uri "file://$(pwd)/source/B.bundle" &&
    -+	git -C source config bundle.bundle-B.creationToken 1 &&
    -+	git -C source config bundle.bundle-B-to-C.uri "file://$(pwd)/source/B-to-C.bundle" &&
    -+	git -C source config bundle.bundle-B-to-C.creationToken 2
    -+'
    + ## transport.c ##
    +@@ transport.c: int transport_fetch_refs(struct transport *transport, struct ref *refs)
    + 	return rc;
    + }
    +
    +-int transport_get_remote_bundle_uri(struct transport *transport)
    ++static int transport_get_remote_bundle_uri(struct transport *transport)
    + {
    + 	int value = 0;
    + 	const struct transport_vtable *vtable = transport->vtable;
    +@@ transport.c: int transport_get_remote_bundle_uri(struct transport *transport)
    +
    + 	if (vtable->get_bundle_uri(transport) < 0)
    + 		return error(_("could not retrieve server-advertised bundle-uri list"));
     +
    -+test_expect_success 'fetches one bundle URI to get up-to-date' '
    -+	git -C go-B-to-C -c transfer.bundleURI=true fetch origin &&
    -+	test 1 = $(ls go-B-to-C/.git/objects/bundles | wc -l) &&
    -+	test 2 = $(git -C go-B-to-C config fetch.bundleCreationToken)
    -+'
    ++	return 0;
    ++}
     +
    -+test_expect_success 'fetches two bundle URIs to get up-to-date' '
    -+	git -C go-A-to-C -c transfer.bundleURI=true fetch origin &&
    -+	test 2 = $(ls go-A-to-C/.git/objects/bundles | wc -l) &&
    -+	test 2 = $(git -C go-A-to-C config fetch.bundleCreationToken)
    -+'
    ++int transport_has_remote_bundle_uri(struct transport *transport)
    ++{
    ++	transport_get_remote_bundle_uri(transport);
     +
    -+test_expect_success 'fetches one bundle URI and objects from remote' '
    -+	test_commit -C source D &&
    -+	git -C go-B-to-D -c transfer.bundleURI=true fetch origin &&
    -+	test 1 = $(ls go-B-to-D/.git/objects/bundles | wc -l) &&
    -+	test 2 = $(git -C go-B-to-D config fetch.bundleCreationToken)
    -+'
    ++	if (transport->bundles &&
    ++	    hashmap_get_size(&transport->bundles->bundles))
    ++		return 1;
     +
    -+test_done
    + 	return 0;
    + }
    +
    +
    + ## transport.h ##
    +@@ transport.h: const struct ref *transport_get_remote_refs(struct transport *transport,
    + 					    struct transport_ls_refs_options *transport_options);
    +
    + /**
    +- * Retrieve bundle URI(s) from a remote. Populates "struct
    +- * transport"'s "bundle_uri" and "got_remote_bundle_uri".
    ++ * Try fetch bundle URI(s) from a remote and returns 1 if one or more
    ++ * bundle URI(s) are received from the server.
    ++ * Populates "struct transport"'s "bundles" and "got_remote_bundle_uri".
    +  */
    +-int transport_get_remote_bundle_uri(struct transport *transport);
    ++int transport_has_remote_bundle_uri(struct transport *transport);
    +
    + /*
    +  * Fetch the hash algorithm used by a remote.
-:  ---------- > 3:  db8f303dde fetch: use bundle URIs when having creationToken heuristic
--
2.45.2

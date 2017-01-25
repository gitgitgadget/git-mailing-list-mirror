Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BA881F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 22:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752128AbdAYWDX (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 17:03:23 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:34850 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750930AbdAYWDV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 17:03:21 -0500
Received: by mail-pg0-f44.google.com with SMTP id 194so67614202pgd.2
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 14:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=xv3BDzGUFcviTtAYExKJLJ0i5810vovPGjq2VHAGnGw=;
        b=hQiFrJvE4woa48F9czurweffGwko4teHPjIwND0CFp64C1hSGCmJdz05uzrz1DFgtb
         9r3ADrmfsCS3MTNzmtnd7jJtxJNDnzxEJduDfzz1K26WlUgBi1xRZ6mxlm6IrXdxInoK
         934ZJmmnhQkpaTU3eFOj2bNM7MRuYCNHd2DJr0+Cu2wdkzJxFY5fIUhMncrLhcvceWAq
         SlQvkYA0qt7QfiZDoJzgELbbkf9b0dC2EAU1eEvLsWZUZysAwq329zj0+YDmHHw++j6U
         ojMaAhxIzcQ3MsDS6ifgSK6Mg/dUjj7/f8drP6hsxlUZeHWDxd0JnNB8iDuAS5CII9Q6
         8CPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=xv3BDzGUFcviTtAYExKJLJ0i5810vovPGjq2VHAGnGw=;
        b=ULU5TTRRIVKmZ1zs0dJiKqbU1WzvQc03W31bZNdGUGI1gpgDVwdGQfAuVA6tIf6UBU
         rz5dyE5yWrQgQl2rkZ/aXNcuk3PJ0aWoNAS6EGod97jM8NCRl72ksFHgSVY4rPEGWBMB
         bsTBdUuh2qCGZ+d+Ym5EfQw8AcsPk9L227rjCpWs/rOajRrePDvk+oeHIFtWiikW4Q2K
         onWnE37Ruk1Z5S5xrF6BXXxZcPZzncx4GOJlp1NOZiqsEC3Ag3MCwrClfc0z6m0L8tYh
         6xo+rBI5VSchYyer3n7woAexIY7wQ/ZlKa2N0kodRfMeQTL+UM8/+MZuTwHBW2O+k8Si
         sYBA==
X-Gm-Message-State: AIkVDXJCY0iwmEpiTp74U8uEg9PB2e7Q3s0/6xCHXwwRbBnLVVnES3raspYs9oXJs0Fx6SJr
X-Received: by 10.99.185.74 with SMTP id v10mr1717597pgo.98.1485381799935;
        Wed, 25 Jan 2017 14:03:19 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([100.96.238.13])
        by smtp.gmail.com with ESMTPSA id o24sm3357308pfj.78.2017.01.25.14.03.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Jan 2017 14:03:19 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [RFC 02/14] upload-pack: allow ref name and glob requests
Date:   Wed, 25 Jan 2017 14:02:55 -0800
Message-Id: <d0d42b3bb4cf755f122591e191354c53848f197d.1485381677.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <cover.1485381677.git.jonathantanmy@google.com>
References: <cover.1485381677.git.jonathantanmy@google.com>
In-Reply-To: <cover.1485381677.git.jonathantanmy@google.com>
References: <cover.1485381677.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, while performing packfile negotiation [1], upload-pack allows
clients to specify their desired objects only as SHA-1s. This causes:
(a) vulnerability to failure when an object turns non-existent during
    negotiation, which may happen if, for example, upload-pack is
    provided by multiple Git servers in a load-balancing arrangement,
    and
(b) dependence on the server first publishing a list of refs with
    associated objects.

To eliminate (a) and take a step towards eliminating (b), teach
upload-pack to support requests in the form of ref names and globs (in
addition to the existing support for SHA-1s) through a new line of the
form "want-ref <ref>" where ref is the full name of a ref, a glob
pattern, or a SHA-1. At the conclusion of negotiation, the server will
write "wanted-ref <SHA-1> <name>" for all requests that have been
specified this way.

The server indicates that it supports this feature by advertising the
capability "ref-in-want". Advertisement of this capability is by default
disabled, but can be enabled through a configuration option.

To be flexible with respect to client needs, the server does not
indicate an error if a "want-ref" line corresponds to no refs, but
instead relies on the client to ensure that what the user needs has been
fetched. For example, a client could reasonably expand an abbreviated
name "foo" to "want-ref foo", "want-ref refs/heads/foo", "want-ref
refs/tags/foo", among others, and ensure that at least one such ref has
been fetched.

[1] pack-protocol.txt

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/technical/http-protocol.txt         |  20 +-
 Documentation/technical/pack-protocol.txt         |  24 +-
 Documentation/technical/protocol-capabilities.txt |   6 +
 t/t5552-upload-pack-ref-in-want.sh                | 295 ++++++++++++++++++++++
 upload-pack.c                                     |  89 ++++++-
 5 files changed, 411 insertions(+), 23 deletions(-)
 create mode 100755 t/t5552-upload-pack-ref-in-want.sh

diff --git a/Documentation/technical/http-protocol.txt b/Documentation/technical/http-protocol.txt
index 1c561bdd9..162d6bc07 100644
--- a/Documentation/technical/http-protocol.txt
+++ b/Documentation/technical/http-protocol.txt
@@ -316,7 +316,8 @@ to prevent caching of the response.
 
 Servers SHOULD support all capabilities defined here.
 
-Clients MUST send at least one "want" command in the request body.
+Clients MUST send at least one "want" or "want-ref" command in the
+request body.
 Clients MUST NOT reference an id in a "want" command which did not
 appear in the response obtained through ref discovery unless the
 server advertises capability `allow-tip-sha1-in-want` or
@@ -330,7 +331,7 @@ server advertises capability `allow-tip-sha1-in-want` or
   want_list         =  PKT-LINE(want NUL cap_list LF)
 		       *(want_pkt)
   want_pkt          =  PKT-LINE(want LF)
-  want              =  "want" SP id
+  want              =  "want" SP id / "want-ref" SP name
   cap_list          =  *(SP capability) SP
 
   have_list         =  *PKT-LINE("have" SP id LF)
@@ -352,7 +353,8 @@ C: Build an empty set, `common`, to hold the objects that are later
    determined to be on both ends.
 
 C: Build a set, `want`, of the objects from `advertised` the client
-   wants to fetch, based on what it saw during ref discovery.
+   wants to fetch, based on what it saw during ref discovery. This is to
+   be used if the server does not support the ref-in-want capability.
 
 C: Start a queue, `c_pending`, ordered by commit time (popping newest
    first).  Add all client refs.  When a commit is popped from
@@ -363,8 +365,8 @@ C: Start a queue, `c_pending`, ordered by commit time (popping newest
 
 C: Send one `$GIT_URL/git-upload-pack` request:
 
-   C: 0032want <want #1>...............................
-   C: 0032want <want #2>...............................
+   C: <size>want-ref <want #1>...............................
+   C: <size>want-ref <want #2>...............................
    ....
    C: 0032have <common #1>.............................
    C: 0032have <common #2>.............................
@@ -384,7 +386,7 @@ the pkt-line value.
 Commands MUST appear in the following order, if they appear
 at all in the request stream:
 
-* "want"
+* "want" or "want-ref"
 * "have"
 
 The stream is terminated by a pkt-line flush (`0000`).
@@ -393,6 +395,9 @@ A single "want" or "have" command MUST have one hex formatted
 SHA-1 as its value.  Multiple SHA-1s MUST be sent by sending
 multiple commands.
 
+A "want-ref" command MUST be followed by a ref name (which may include
+shell glob characters) or a hex formatted SHA-1.
+
 The `have` list is created by popping the first 32 commits
 from `c_pending`.  Less can be supplied if `c_pending` empties.
 
@@ -410,6 +415,9 @@ Verify all objects in `want` are directly reachable from refs.
 The server MAY walk backwards through history or through
 the reflog to permit slightly stale requests.
 
+Treat "want-ref" requests as if the equivalent 0 or more "want" commands
+(according to the server's refs) were given instead.
+
 If no "want" objects are received, send an error:
 TODO: Define error if no "want" lines are requested.
 
diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index c59ac9936..b8b2ffdf9 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -223,15 +223,20 @@ out of what the server said it could do with the first 'want' line.
 		       PKT-LINE("deepen-since" SP timestamp) /
 		       PKT-LINE("deepen-not" SP ref)
 
-  first-want        =  PKT-LINE("want" SP obj-id SP capability-list)
-  additional-want   =  PKT-LINE("want" SP obj-id)
+  first-want        =  PKT-LINE(want SP capability-list)
+  additional-want   =  PKT-LINE(want)
+
+  want              = "want" SP obj-id / "want-ref" SP name
 
   depth             =  1*DIGIT
 ----
 
-Clients MUST send all the obj-ids it wants from the reference
-discovery phase as 'want' lines. Clients MUST send at least one
-'want' command in the request body. Clients MUST NOT mention an
+Clients may specify the objects it wants by selecting obj-ids from the
+refs that have been advertised (using "want") or by specifying ref names
+and ref patterns directly (using "want-ref"). If the latter, the server
+will return the list of effective refs used using "wanted-ref" lines.
+Either way, clients MUST send at least one
+'want' or 'want-ref' command in the request body. Clients MUST NOT mention an
 obj-id in a 'want' command which did not appear in the response
 obtained through ref discovery.
 
@@ -249,7 +254,7 @@ complete those commits. Commits whose parents are not received as a
 result are defined as shallow and marked as such in the server. This
 information is sent back to the client in the next step.
 
-Once all the 'want's and 'shallow's (and optional 'deepen') are
+Once all the wants and 'shallow's (and optional 'deepen') are
 transferred, clients MUST send a flush-pkt, to tell the server side
 that it is done sending the list.
 
@@ -344,7 +349,9 @@ implementation if we have received at least one "ACK %s continue"
 during a prior round.  This helps to ensure that at least one common
 ancestor is found before we give up entirely.
 
-Once the 'done' line is read from the client, the server will either
+Once the 'done' line is read from the client, the server will send all the
+refs corresponding to "want-ref" lines from the client (prefixed by
+"wanted-ref"), and then either
 send a final 'ACK obj-id' or it will send a 'NAK'. 'obj-id' is the object
 name of the last commit determined to be common. The server only sends
 ACK after 'done' if there is at least one common base and multi_ack or
@@ -354,9 +361,10 @@ if there is no common base found.
 Then the server will start sending its packfile data.
 
 ----
-  server-response = *ack_multi ack / nak
+  server-response = *ack_multi *wanted_ref ack / nak
   ack_multi       = PKT-LINE("ACK" SP obj-id ack_status)
   ack_status      = "continue" / "common" / "ready"
+  wanted_ref      = PKT-LINE("wanted-ref" SP obj-id SP name)
   ack             = PKT-LINE("ACK" SP obj-id)
   nak             = PKT-LINE("NAK")
 ----
diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
index 26dcc6f50..72a2ff907 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -309,3 +309,9 @@ to accept a signed push certificate, and asks the <nonce> to be
 included in the push certificate.  A send-pack client MUST NOT
 send a push-cert packet unless the receive-pack server advertises
 this capability.
+
+ref-in-want
+-----------
+
+If the upload-pack server advertises this capability, fetch-pack may
+send "want-ref" lines.
diff --git a/t/t5552-upload-pack-ref-in-want.sh b/t/t5552-upload-pack-ref-in-want.sh
new file mode 100755
index 000000000..3496af641
--- /dev/null
+++ b/t/t5552-upload-pack-ref-in-want.sh
@@ -0,0 +1,295 @@
+#!/bin/sh
+
+test_description='upload-pack ref-in-want'
+
+. ./test-lib.sh
+
+line() {
+	len=$(printf '%s' "$1" | wc -c) &&
+	len=$((len + 5)) &&
+	printf '%04x%s\n' $len "$1" >>input
+}
+
+flush() {
+	printf '0000'
+}
+
+get_actual_refs() {
+	grep -a wanted-ref output | sed "s/^.*wanted-ref //" >actual_refs
+}
+
+get_actual_commits() {
+	perl -0777 -p -e "s/^.*PACK/PACK/s" <output >o.pack &&
+	git index-pack o.pack &&
+	git verify-pack -v o.idx | grep commit | cut -c-40 | sort >actual_commits
+}
+
+check_output() {
+	get_actual_refs &&
+	test_cmp expected_refs actual_refs &&
+	get_actual_commits &&
+	test_cmp expected_commits actual_commits
+}
+
+# c(o/foo) d(o/bar)
+#        \ /
+#         b   e(baz)  f(master)
+#          \__  |  __/
+#             \ | /
+#               a
+test_expect_success 'setup repository' '
+	test_commit a &&
+	git checkout -b o/foo &&
+	test_commit b &&
+	test_commit c &&
+	git checkout -b o/bar b &&
+	test_commit d &&
+	git checkout -b baz a &&
+	test_commit e &&
+	git checkout master &&
+	test_commit f
+'
+
+test_expect_success 'config controls ref-in-want advertisement' '
+	test_config uploadpack.advertiseRefInWant false &&
+	printf "0000" | git upload-pack . >output &&
+	! grep -a ref-in-want output &&
+	test_config uploadpack.advertiseRefInWant true &&
+	printf "0000" | git upload-pack . >output &&
+	grep -a ref-in-want output
+'
+
+test_expect_success 'mix want and want-ref' '
+	cat >expected_refs <<-EOF &&
+	$(git rev-parse f) refs/heads/master
+	EOF
+	git rev-parse e f | sort >expected_commits &&
+
+	line "want-ref refs/heads/master" >input &&
+	line "want $(git rev-parse e)" >>input &&
+	flush >>input &&
+	line "have $(git rev-parse a)" >>input &&
+	flush >>input &&
+	line "done" >>input &&
+	git upload-pack . <input >output &&
+	check_output
+'
+
+test_expect_success 'want-ref with glob and non-glob' '
+	cat >expected_refs <<-EOF &&
+	$(git rev-parse f) refs/heads/master
+	$(git rev-parse d) refs/heads/o/bar
+	$(git rev-parse c) refs/heads/o/foo
+	EOF
+	git rev-parse b c d f | sort >expected_commits &&
+
+	line "want-ref refs/head*/[op]/*" >input &&
+	line "want-ref refs/heads/master" >>input &&
+	line "want-ref refs/heads/non-existent/*" >>input &&
+	line "want-ref refs/heads/also-non-existent" >>input &&
+	flush >>input &&
+	line "have $(git rev-parse a)" >>input &&
+	flush >>input &&
+	line "done" >>input &&
+	git upload-pack . <input >output &&
+	check_output
+'
+
+test_expect_success 'want-ref with SHA-1' '
+	cat >expected_refs <<-EOF &&
+	$(git rev-parse f) $(git rev-parse f)
+	EOF
+	git rev-parse f | sort >expected_commits &&
+
+	line "want-ref $(git rev-parse f)" >input &&
+	flush >>input &&
+	line "have $(git rev-parse a)" >>input &&
+	flush >>input &&
+	line "done" >>input &&
+	git upload-pack . <input >output &&
+	check_output
+'
+
+test_expect_success 'want-ref with overlapping glob and non-glob' '
+	cat >expected_refs <<-EOF &&
+	$(git rev-parse d) refs/heads/o/bar
+	$(git rev-parse c) refs/heads/o/foo
+	EOF
+	git rev-parse b c d | sort >expected_commits &&
+
+	line "want-ref refs/heads/o/*" >input &&
+	line "want-ref refs/heads/o/foo" >>input &&
+	flush >>input &&
+	line "have $(git rev-parse a)" >>input &&
+	flush >>input &&
+	line "done" >>input &&
+	git upload-pack . <input >output &&
+	check_output
+'
+
+test_expect_success 'want-ref with overlapping non-glob and SHA-1' '
+	cat >expected_refs <<-EOF &&
+	$(git rev-parse f) $(git rev-parse f)
+	$(git rev-parse f) refs/heads/master
+	EOF
+	git rev-parse f | sort >expected_commits &&
+
+	line "want-ref $(git rev-parse f)" >input &&
+	line "want-ref refs/heads/master" >>input &&
+	flush >>input &&
+	line "have $(git rev-parse a)" >>input &&
+	flush >>input &&
+	line "done" >>input &&
+	git upload-pack . <input >output &&
+	check_output
+'
+
+test_expect_success 'want-ref with overlapping glob and SHA-1' '
+	cat >expected_refs <<-EOF &&
+	$(git rev-parse f) $(git rev-parse f)
+	$(git rev-parse f) refs/heads/master
+	EOF
+	git rev-parse f | sort >expected_commits &&
+
+	line "want-ref $(git rev-parse f)" >input &&
+	line "want-ref refs/heads/mas*" >>input &&
+	flush >>input &&
+	line "have $(git rev-parse a)" >>input &&
+	flush >>input &&
+	line "done" >>input &&
+	git upload-pack . <input >output &&
+	check_output
+'
+
+test_expect_success 'want-ref with overlapping globs' '
+	cat >expected_refs <<-EOF &&
+	$(git rev-parse d) refs/heads/o/bar
+	$(git rev-parse c) refs/heads/o/foo
+	EOF
+	git rev-parse b c d | sort >expected_commits &&
+
+	line "want-ref refs/heads/o/*" >input &&
+	line "want-ref refs/heads/o/f*" >>input &&
+	flush >>input &&
+	line "have $(git rev-parse a)" >>input &&
+	flush >>input &&
+	line "done" >>input &&
+	git upload-pack . <input >output &&
+	check_output
+'
+
+test_expect_success 'want-ref with ref we already have commit for' '
+	cat >expected_refs <<-EOF &&
+	$(git rev-parse c) refs/heads/o/foo
+	EOF
+	>expected_commits &&
+
+	line "want-ref refs/heads/o/foo" >input &&
+	flush >>input &&
+	line "have $(git rev-parse c)" >>input &&
+	flush >>input &&
+	line "done" >>input &&
+	git upload-pack . <input >output &&
+	check_output
+'
+
+test_expect_success 'send wanted-ref only at the end of negotiation' '
+	# Incomplete input; acknowledge "have" with NAK, but no wanted-ref
+	line "want-ref refs/heads/o/foo" >input &&
+	flush >>input &&
+	line "have 1234567890123456789012345678901234567890" >>input &&
+	flush >>input &&
+	test_must_fail git upload-pack . <input >output &&
+	grep -a "0008NAK" output &&
+	test_must_fail grep -a "wanted-ref" output &&
+
+	# Complete the input, and try again
+	line "have $(git rev-parse c)" >>input &&
+	flush >>input &&
+	line "done" >>input &&
+	flush >>input &&
+	git upload-pack . <input >output &&
+	grep -a "wanted-ref" output
+'
+
+test_expect_success 'want-ref with capability declaration' '
+	cat >expected_refs <<-EOF &&
+	$(git rev-parse c) refs/heads/o/foo
+	EOF
+	git rev-parse b c | sort >expected_commits &&
+
+	line "want-ref refs/heads/o/foo no_progress" >input &&
+	flush >>input &&
+	line "have $(git rev-parse a)" >>input &&
+	flush >>input &&
+	line "done" >>input &&
+	git upload-pack . <input >output &&
+	check_output
+'
+
+test_expect_success 'hideRefs' '
+	test_config transfer.hideRefs refs/heads/o/foo &&
+
+	cat >expected_refs <<-EOF &&
+	$(git rev-parse d) refs/heads/o/bar
+	EOF
+	git rev-parse b d | sort >expected_commits &&
+
+	line "want-ref refs/heads/o/*" >input &&
+	flush >>input &&
+	line "have $(git rev-parse a)" >>input &&
+	flush >>input &&
+	line "done" >>input &&
+	git upload-pack . <input >output &&
+	check_output
+'
+
+test_expect_success 'setup namespaced repo' '
+	git init n &&
+	(
+		cd n &&
+		test_commit a &&
+		test_commit b &&
+		git checkout a &&
+		test_commit c &&
+		git checkout a &&
+		test_commit d &&
+		git update-ref refs/heads/ns-no b
+		git update-ref refs/namespaces/ns/refs/heads/ns-yes c
+		git update-ref refs/namespaces/ns/refs/heads/another d
+	)
+'
+
+test_expect_success 'want-ref with namespaces' '
+	cat >expected_refs <<-EOF &&
+	$(git -C n rev-parse c) refs/heads/ns-yes
+	EOF
+	git -C n rev-parse c | sort >expected_commits &&
+
+	line "want-ref refs/heads/ns-*" >input &&
+	flush >>input &&
+	line "have $(git -C n rev-parse a)" >>input &&
+	flush >>input &&
+	line "done" >>input &&
+	git --namespace=ns -C n upload-pack . <input >output &&
+	check_output
+'
+
+test_expect_success 'hideRefs with namespaces' '
+	test_config transfer.hideRefs refs/heads/another &&
+
+	cat >expected_refs <<-EOF &&
+	$(git -C n rev-parse c) refs/heads/ns-yes
+	EOF
+	git -C n rev-parse c | sort >expected_commits &&
+
+	line "want-ref refs/heads/ns-*" >input &&
+	flush >>input &&
+	line "have $(git -C n rev-parse a)" >>input &&
+	flush >>input &&
+	line "done" >>input &&
+	git --namespace=ns -C n upload-pack . <input >output &&
+	check_output
+'
+
+test_done
diff --git a/upload-pack.c b/upload-pack.c
index 15c60a204..b88ed8e26 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -62,6 +62,7 @@ static int use_sideband;
 static int advertise_refs;
 static int stateless_rpc;
 static const char *pack_objects_hook;
+static int advertise_ref_in_want;
 
 static void reset_timeout(void)
 {
@@ -380,7 +381,25 @@ static int ok_to_give_up(void)
 	return 1;
 }
 
-static int get_common_commits(void)
+static void write_wanted_ns_refs(const struct string_list *wanted_ns_refs)
+{
+	const struct string_list_item *item;
+	for_each_string_list_item(item, wanted_ns_refs) {
+		unsigned char sha1[GIT_SHA1_RAWSZ];
+		if (!get_sha1_hex(item->string, sha1)) {
+			packet_write_fmt(1, "wanted-ref %s %s\n", item->string,
+					 item->string);
+		} else {
+			if (read_ref(item->string, sha1))
+				die("unable to read ref %s", item->string);
+			packet_write_fmt(1, "wanted-ref %s %s\n",
+					 sha1_to_hex(sha1),
+					 strip_namespace(item->string));
+		}
+	}
+}
+
+static int get_common_commits(const struct string_list *wanted_ns_refs)
 {
 	unsigned char sha1[20];
 	char last_hex[41];
@@ -442,6 +461,7 @@ static int get_common_commits(void)
 			continue;
 		}
 		if (!strcmp(line, "done")) {
+			write_wanted_ns_refs(wanted_ns_refs);
 			if (have_obj.nr > 0) {
 				if (multi_ack)
 					packet_write_fmt(1, "ACK %s\n", last_hex);
@@ -729,7 +749,26 @@ static void deepen_by_rev_list(int ac, const char **av,
 	packet_flush(1);
 }
 
-static void receive_needs(void)
+static int mark_ref_wanted(const char *ns_ref,
+			   const struct object_id *oid, int flags,
+			   void *wanted_ns_refs_)
+{
+	struct string_list *wanted_ns_refs = wanted_ns_refs_;
+	struct object *o;
+
+	if (ref_is_hidden(strip_namespace(ns_ref), ns_ref))
+		return 0;
+
+	o = parse_object_or_die(oid->hash, ns_ref);
+	if (!(o->flags & WANTED)) {
+		o->flags |= WANTED;
+		add_object_array(o, NULL, &want_obj);
+	}
+	string_list_insert(wanted_ns_refs, ns_ref);
+	return 0;
+}
+
+static void receive_needs(struct string_list *wanted_ns_refs)
 {
 	struct object_array shallows = OBJECT_ARRAY_INIT;
 	struct string_list deepen_not = STRING_LIST_INIT_DUP;
@@ -793,8 +832,35 @@ static void receive_needs(void)
 			deepen_rev_list = 1;
 			continue;
 		}
-		if (skip_prefix(line, "want ", &arg) &&
-		    !get_sha1_hex(arg, sha1_buf)) {
+		if (skip_prefix(line, "want-ref ", &arg)) {
+			struct object_id oid;
+
+			char *space = strchrnul(arg, ' ');
+			char *ns_ref = xstrfmt("%s%.*s",
+					       get_git_namespace(),
+					       (int)(space - arg),
+					       arg);
+			if (has_glob_specials(ns_ref))
+				for_each_glob_ref(mark_ref_wanted, ns_ref,
+						  wanted_ns_refs);
+			else if (!get_oid_hex(arg, &oid)) {
+				o = parse_object(oid.hash);
+				if (o && !(o->flags & WANTED)) {
+					o->flags |= WANTED;
+					if (!((allow_unadvertised_object_request & ALLOW_ANY_SHA1) == ALLOW_ANY_SHA1
+					      || is_our_ref(o)))
+						has_non_tip = 1;
+					add_object_array(o, NULL, &want_obj);
+				}
+				mark_ref_wanted(ns_ref, &oid, 0,
+						wanted_ns_refs);
+			} else if (!read_ref(ns_ref, oid.hash))
+				mark_ref_wanted(ns_ref, &oid, 0,
+						wanted_ns_refs);
+			free(ns_ref);
+			features = space;
+		} else if (skip_prefix(line, "want ", &arg) &&
+			   !get_sha1_hex(arg, sha1_buf)) {
 			o = parse_object(sha1_buf);
 			if (!o)
 				die("git upload-pack: not our ref %s",
@@ -806,12 +872,11 @@ static void receive_needs(void)
 					has_non_tip = 1;
 				add_object_array(o, NULL, &want_obj);
 			}
+			features = arg + 40;
 		} else
 			die("git upload-pack: protocol error, "
 			    "expected to get sha, not '%s'", line);
 
-		features = arg + 40;
-
 		if (parse_feature_request(features, "deepen-relative"))
 			deepen_relative = 1;
 		if (parse_feature_request(features, "multi_ack_detailed"))
@@ -935,7 +1000,7 @@ static int send_ref(const char *refname, const struct object_id *oid,
 		struct strbuf symref_info = STRBUF_INIT;
 
 		format_symref_info(&symref_info, cb_data);
-		packet_write_fmt(1, "%s %s%c%s%s%s%s%s agent=%s\n",
+		packet_write_fmt(1, "%s %s%c%s%s%s%s%s%s agent=%s\n",
 			     oid_to_hex(oid), refname_nons,
 			     0, capabilities,
 			     (allow_unadvertised_object_request & ALLOW_TIP_SHA1) ?
@@ -943,6 +1008,8 @@ static int send_ref(const char *refname, const struct object_id *oid,
 			     (allow_unadvertised_object_request & ALLOW_REACHABLE_SHA1) ?
 				     " allow-reachable-sha1-in-want" : "",
 			     stateless_rpc ? " no-done" : "",
+			     advertise_ref_in_want ?
+				     " ref-in-want" : "",
 			     symref_info.buf,
 			     git_user_agent_sanitized());
 		strbuf_release(&symref_info);
@@ -975,6 +1042,7 @@ static int find_symref(const char *refname, const struct object_id *oid,
 static void upload_pack(void)
 {
 	struct string_list symref = STRING_LIST_INIT_DUP;
+	struct string_list wanted_ns_refs = STRING_LIST_INIT_DUP;
 
 	head_ref_namespaced(find_symref, &symref);
 
@@ -992,11 +1060,12 @@ static void upload_pack(void)
 	if (advertise_refs)
 		return;
 
-	receive_needs();
+	receive_needs(&wanted_ns_refs);
 	if (want_obj.nr) {
-		get_common_commits();
+		get_common_commits(&wanted_ns_refs);
 		create_pack_file();
 	}
+	string_list_clear(&wanted_ns_refs, 0);
 }
 
 static int upload_pack_config(const char *var, const char *value, void *unused)
@@ -1020,6 +1089,8 @@ static int upload_pack_config(const char *var, const char *value, void *unused)
 		keepalive = git_config_int(var, value);
 		if (!keepalive)
 			keepalive = -1;
+	} else if (!strcmp("uploadpack.advertiserefinwant", var)) {
+		advertise_ref_in_want = git_config_bool(var, value);
 	} else if (current_config_scope() != CONFIG_SCOPE_REPO) {
 		if (!strcmp("uploadpack.packobjectshook", var))
 			return git_config_string(&pack_objects_hook, var, value);
-- 
2.11.0.483.g087da7b7c-goog


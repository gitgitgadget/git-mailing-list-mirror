From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv9 5/9] receive-pack.c: negotiate atomic push support
Date: Tue, 30 Dec 2014 15:41:34 -0800
Message-ID: <1419982898-23108-6-git-send-email-sbeller@google.com>
References: <1419982898-23108-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, sunshine@sunshineco.com, mhagger@alum.mit.edu,
	jrnieder@gmail.com, ronniesahlberg@gmail.com,
	Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Dec 31 00:42:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y66QN-0007uT-WD
	for gcvg-git-2@plane.gmane.org; Wed, 31 Dec 2014 00:42:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035AbaL3Xl4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2014 18:41:56 -0500
Received: from mail-ig0-f170.google.com ([209.85.213.170]:54787 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751957AbaL3Xlw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2014 18:41:52 -0500
Received: by mail-ig0-f170.google.com with SMTP id r2so14241035igi.1
        for <git@vger.kernel.org>; Tue, 30 Dec 2014 15:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7UO+kxVSzB2qdVNu5TvF7ooeCTdJWp5r7UWGsoBWUxU=;
        b=WyYTskTs5M0d8obuaACgyMceLVcq0KHzaDwYV3a/5CxoqQOzrJe9uvKrzmC2qSMO9h
         F/CzAlsyouSHOVsbB+eR0Zuw4Y73IeYpOQu/wrUNYtr/ZnC/OCdtPgQlLQw1yc/bJDud
         H9FE8VuGWYHCr4/AMkEbz1ng5YPOYypNJUXlQdZHWFujMgkM4BvY9xnbGu5S36ezNEIM
         /hN/LImeO3TZSZp5cu+rQ+DhyUxB94LJxVaOQm1bf4yoTD1987oCU3ninJfawkDWE/Rh
         L9ierHyT2mD/YB7ebmy3j3LzG6TuZggoaC3gu5NGOBut3+LnIFnBOMl5g+MkluW+RfgA
         Iyxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7UO+kxVSzB2qdVNu5TvF7ooeCTdJWp5r7UWGsoBWUxU=;
        b=g2IBR/2yVwCAtE7UBpkhJGJxcrzMKr8MwCGAUzMzL4IWWSw+kLtfMCqLPs6+jYWuxt
         p/lxgEuLCoGz+jl1Gbw0gBs/3hZEGEu1YQ0oWYX4i0oYp7euLrWgPuWCe0Ev5RvCV98J
         sC1bF+ORZOkl6vLyO+GhpHLWN6XKE0p0J2IyDMSVegCmL1wSpKS2UoU+fmDB4ouFbBsg
         X0Rlo5yCSEjh8WhzJ29Pk4D9Cz7CCtxquUcsRKsI0NKLup8Z0fWj2p4/wfMBqaYo8P7c
         4fEfX4HE6xImdWvaghuyA/rt8htFs5AjaAFFhlN19c0UmEsSDpF24IRjdSaLgVM+BVB0
         zc/w==
X-Gm-Message-State: ALoCoQnOAhpXopTaLZrbSJemWP8q4trzkxK9krSPqTUogV+pTlDAnifv60QM+hioi2pJuxLlfRny
X-Received: by 10.107.6.34 with SMTP id 34mr55795215iog.88.1419982911223;
        Tue, 30 Dec 2014 15:41:51 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:e545:220a:6cf6:2fed])
        by mx.google.com with ESMTPSA id h19sm18412851ioe.27.2014.12.30.15.41.50
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Dec 2014 15:41:50 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1419982898-23108-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261958>

From: Ronnie Sahlberg <sahlberg@google.com>

This adds the atomic protocol option to allow
receive-pack to inform the client that it has
atomic push capability.

This commit makes the functionality introduced
in the previous commits go live for the serving
side. The changes in documentation reflect the
protocol capabilities of the server.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    v9:
     This was once part of "[PATCH 1/7] receive-pack.c:
     add protocol support to negotiate atomic-push"
     but now it only touches the receive-pack.c part
     and doesn't bother with the send-pack part any more.
     That is done in a later patch, when send-pack actually
     learns all the things it needs to know about the
     atomic push option.
    
     We can configure the remote if it wants to advertise
     atomicity!
    
    All previous notes were lost due to my glorious
    capability to operate git rebase.

 Documentation/technical/protocol-capabilities.txt | 13 +++++++++++--
 builtin/receive-pack.c                            | 11 +++++++++++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
index 6d5424c..4f8a7bf 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -18,8 +18,9 @@ was sent.  Server MUST NOT ignore capabilities that client requested
 and server advertised.  As a consequence of these rules, server MUST
 NOT advertise capabilities it does not understand.
 
-The 'report-status', 'delete-refs', 'quiet', and 'push-cert' capabilities
-are sent and recognized by the receive-pack (push to server) process.
+The 'atomic', 'report-status', 'delete-refs', 'quiet', and 'push-cert'
+capabilities are sent and recognized by the receive-pack (push to server)
+process.
 
 The 'ofs-delta' and 'side-band-64k' capabilities are sent and recognized
 by both upload-pack and receive-pack protocols.  The 'agent' capability
@@ -244,6 +245,14 @@ respond with the 'quiet' capability to suppress server-side progress
 reporting if the local progress reporting is also being suppressed
 (e.g., via `push -q`, or if stderr does not go to a tty).
 
+atomic
+------
+
+If the server sends the 'atomic' capability it is capable of accepting
+atomic pushes. If the pushing client requests this capability, the server
+will update the refs in one atomic transaction. Either all refs are
+updated or none.
+
 allow-tip-sha1-in-want
 ----------------------
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index d431e97..8fd58ff 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -37,6 +37,7 @@ static int receive_fsck_objects = -1;
 static int transfer_fsck_objects = -1;
 static int receive_unpack_limit = -1;
 static int transfer_unpack_limit = -1;
+static int advertise_atomic_push = 1;
 static int unpack_limit = 100;
 static int report_status;
 static int use_sideband;
@@ -159,6 +160,11 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (strcmp(var, "receive.advertiseatomic") == 0) {
+		advertise_atomic_push = git_config_bool(var, value);
+		return 0;
+	}
+
 	return git_default_config(var, value, cb);
 }
 
@@ -174,6 +180,8 @@ static void show_ref(const char *path, const unsigned char *sha1)
 
 		strbuf_addstr(&cap,
 			      "report-status delete-refs side-band-64k quiet");
+		if (advertise_atomic_push)
+			strbuf_addstr(&cap, " atomic");
 		if (prefer_ofs_delta)
 			strbuf_addstr(&cap, " ofs-delta");
 		if (push_cert_nonce)
@@ -1264,6 +1272,9 @@ static struct command *read_head_info(struct sha1_array *shallow)
 				use_sideband = LARGE_PACKET_MAX;
 			if (parse_feature_request(feature_list, "quiet"))
 				quiet = 1;
+			if (advertise_atomic_push
+			    && parse_feature_request(feature_list, "atomic"))
+				use_atomic = 1;
 		}
 
 		if (!strcmp(line, "push-cert")) {
-- 
2.2.1.62.g3f15098

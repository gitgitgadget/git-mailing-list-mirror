From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv12 06/10] receive-pack.c: negotiate atomic push support
Date: Wed,  7 Jan 2015 19:23:20 -0800
Message-ID: <1420687404-13997-7-git-send-email-sbeller@google.com>
References: <1420687404-13997-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, pclouds@gmail.com, sunshine@sunshineco.com,
	mhagger@alum.mit.edu, ronniesahlberg@gmail.com, jrnieder@gmail.com,
	Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jan 08 04:24:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y93ha-0007Gy-If
	for gcvg-git-2@plane.gmane.org; Thu, 08 Jan 2015 04:24:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755861AbbAHDXy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2015 22:23:54 -0500
Received: from mail-ie0-f169.google.com ([209.85.223.169]:44704 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755787AbbAHDXw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2015 22:23:52 -0500
Received: by mail-ie0-f169.google.com with SMTP id y20so7508816ier.0
        for <git@vger.kernel.org>; Wed, 07 Jan 2015 19:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VTHCCMcZB3mFhfC7K0kJdZxvMjDO2K2iOYGD2Y3+cdU=;
        b=Wm7EQ9LR2nnYtnH6pJ01eCt2t2VlGpnueSHc9N9X1mt60uxJYJiLm8Lq0DmZgyfFVe
         JgNUE/aoYKYG21q0bqSVslRaprjfes3vuYCjP1V8ITx7+aW72jjXeEPZ8QclRBgqxDl4
         YtcePSmcGYhLiCUppnDAv/QdS5mKfgloHFRTVaonleICsNf/xB2jn0XjKrzcoNrBnEdh
         KVwriHHk0xlyq46TBfgMMKeYF/tz3jR4MCFmLM4w1kfdTNVoUYaMElwPkNr6Beb+K9Ou
         jGYhLS1Vys3EBwNqvqJgK/QMVkTV7a+UTEaAjAce4fbhV1UM393Ehz2M2T8mlnz87J9B
         r7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VTHCCMcZB3mFhfC7K0kJdZxvMjDO2K2iOYGD2Y3+cdU=;
        b=dErNQKHAMegD8WL8ZA48/njokhLYhrS49fHUYhG416lYXdNS1DIT6mNQ4ztq2IFzU1
         ByGtSp0wZ30ekDq9iV5AP3ZkQ6oagbU/FNO0DZhLlBW8OMGirhnqwMYo/hl2s7YKHAlR
         mcX6Yzc1fPUNZU0iOqcZUWUPvt0Qjh9prTDwWHnwMbNxezgdUhzSExf9gRkHu1sYA9sR
         lxDi5YDavAOsjuG9GYX26ntWAvfQ2smYqkOCzdkcpSZGgFE0ScSGGsV4DjoTtb1IcAlc
         oJ/LvM6EzzFmtNCui0snPVuC+b/hrR0QtxpGRprwXa1kKsZpfEN00foRtYHrgdsQ3r1Z
         ZcNA==
X-Gm-Message-State: ALoCoQm77wAhIMsFOP7B4o4uhAhftP/lsGNWZbosgx+u9SaOhH2uk4J9syPL4Rr/sty/bnteGsUC
X-Received: by 10.42.62.71 with SMTP id x7mr6055936ich.61.1420687431574;
        Wed, 07 Jan 2015 19:23:51 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:948f:12c6:eb26:9b9c])
        by mx.google.com with ESMTPSA id m127sm1738453ioe.32.2015.01.07.19.23.50
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 07 Jan 2015 19:23:51 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1420687404-13997-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262176>

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
    v10, v11, v12:
    * no changes
    
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
index 362d33f..4c069c5 100644
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
@@ -1263,6 +1271,9 @@ static struct command *read_head_info(struct sha1_array *shallow)
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

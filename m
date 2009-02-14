From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH] use a hash of the lock token as the suffix for PUT/MOVE
Date: Sat, 14 Feb 2009 15:30:41 +0800
Message-ID: <49967321.10800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 14 08:32:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYF0c-0006Yj-Gd
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 08:32:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbZBNHau (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 02:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbZBNHat
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 02:30:49 -0500
Received: from ti-out-0910.google.com ([209.85.142.188]:10133 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141AbZBNHas (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 02:30:48 -0500
Received: by ti-out-0910.google.com with SMTP id d10so1154229tib.23
        for <git@vger.kernel.org>; Fri, 13 Feb 2009 23:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=MmpBuYtasIFVen1X/xzOs/uKbx/O9TvgT0zzqb29TCc=;
        b=br584CYGJ/reBTGuYZzFI6I7/lvJvguVXDK+PhVLjSB1IpF+Nxn8hgdLsr0qTT+REw
         JsIps5lWfYTPyU57xfjFkUIpXvN6L6711I22/3IVcFoD+ZmaO1wZJBZJpm0u+ZVs5+Kg
         bpUS0qd5Hbkvtb2URQMLz4oUQuVol1NT51GDk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=wOFY7gDAZ3Q1kjveW7XEYkXN5MSnxxI6hLlw9J2CWYzj+8Px00tGAhck0faNVk2prs
         RE5Sdt+TM4XDlQ+dxZ+diY5lo36lPj1tpCR030ADF3Zt9FsuQsQgmUGfvVtPrQlJVP1c
         t1wKjbTZCQB5qF+En1zhghpdn/ZsrnZcHj3MA=
Received: by 10.110.14.3 with SMTP id 3mr4957080tin.57.1234596646157;
        Fri, 13 Feb 2009 23:30:46 -0800 (PST)
Received: from ?116.87.149.13? ([116.87.149.13])
        by mx.google.com with ESMTPS id d4sm643081tib.8.2009.02.13.23.30.44
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 13 Feb 2009 23:30:45 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109839>

After 753bc91 ("Remove the requirement opaquelocktoken uri scheme"),
lock tokens are in the URI forms in which they are received from the
server, eg. 'opaquelocktoken:', 'urn:uuid:'.

However, "start_put" (and consequently "start_move"), which attempts to
create a unique temporary file using the UUID of the lock token,
inadvertently uses the lock token in its URI form. These file
operations on the server may not be successful (specifically, in
Windows), due to the colon ':' character from the URI form of the lock
token in the file path.

This patch uses a hash of the lock token instead, guaranteeing only
"safe" characters (a-f, 0-9) are used in the file path.

The token's hash is generated when the lock token is received from the
server in handle_new_lock_ctx, minimizing the number of times of
hashing.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

This patch is a result of the discussion on "[PATCH] use lock token in
non-URI form in start_put"; you can read it at
http://kerneltrap.org/mailarchive/git/2009/2/7/4922094.

The decision to use a hash of the token is so that one can avoid
handling the URI scheme of the lock token, which may be a deeply
nested URI, or (the more likely scenario) contain "unsafe" characters
for a file name, such as colons, slashes and spaces.

 http-push.c          |   11 ++++++++++-
 t/t5540-http-push.sh |    7 +++++++
 2 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/http-push.c b/http-push.c
index eefd64c..0a252dd 100644
--- a/http-push.c
+++ b/http-push.c
@@ -153,6 +153,7 @@ struct remote_lock
 	char *url;
 	char *owner;
 	char *token;
+	char *token_sha1_hex;
 	time_t start_time;
 	long timeout;
 	int refreshing;
@@ -558,7 +559,7 @@ static void start_put(struct transfer_request *request)

 	append_remote_object_url(&buf, remote->url, hex, 0);
 	strbuf_addstr(&buf, "_");
-	strbuf_addstr(&buf, request->lock->token);
+	strbuf_addstr(&buf, request->lock->token_sha1_hex);
 	request->url = strbuf_detach(&buf, NULL);

 	slot = get_active_slot();
@@ -1130,6 +1131,8 @@ static void handle_lockprop_ctx(struct xml_ctx *ctx, int tag_closed)
 static void handle_new_lock_ctx(struct xml_ctx *ctx, int tag_closed)
 {
 	struct remote_lock *lock = (struct remote_lock *)ctx->userData;
+	git_SHA_CTX sha_ctx;
+	unsigned char lock_token_sha1[20];

 	if (tag_closed && ctx->cdata) {
 		if (!strcmp(ctx->name, DAV_ACTIVELOCK_OWNER)) {
@@ -1142,6 +1145,12 @@ static void handle_new_lock_ctx(struct xml_ctx *ctx, int tag_closed)
 		} else if (!strcmp(ctx->name, DAV_ACTIVELOCK_TOKEN)) {
 			lock->token = xmalloc(strlen(ctx->cdata) + 1);
 			strcpy(lock->token, ctx->cdata);
+
+			git_SHA1_Init(&sha_ctx);
+			git_SHA1_Update(&sha_ctx, lock->token, strlen(lock->token));
+			git_SHA1_Final(lock_token_sha1, &sha_ctx);
+
+			lock->token_sha1_hex = sha1_to_hex(lock_token_sha1);
 		}
 	}
 }
diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index c236b5e..11b3432 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -94,6 +94,13 @@ test_expect_success 'MKCOL sends directory names with trailing slashes' '

 '

+test_expect_success 'PUT and MOVE sends object to URLs with SHA-1 hash suffix' '
+
+	grep -P "\"(?:PUT|MOVE) .+objects/[\da-z]{2}/[\da-z]{38}_[\da-z\-]{40} HTTP/[0-9.]+\" 20\d" \
+		< "$HTTPD_ROOT_PATH"/access.log
+
+'
+
 stop_httpd

 test_done
-- 
1.6.1.2.278.g9a9e.dirty

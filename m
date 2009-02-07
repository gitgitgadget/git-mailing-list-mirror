From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH] don't append 'opaquelocktoken:' in PUT and MOVE
Date: Sat, 07 Feb 2009 23:12:57 +0800
Message-ID: <498DA4F9.20104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 07 16:14:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVotS-0005lx-Oe
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 16:14:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752458AbZBGPN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 10:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752285AbZBGPN2
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 10:13:28 -0500
Received: from ti-out-0910.google.com ([209.85.142.187]:7520 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023AbZBGPN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 10:13:27 -0500
Received: by ti-out-0910.google.com with SMTP id d10so1317246tib.23
        for <git@vger.kernel.org>; Sat, 07 Feb 2009 07:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=2CmgWH2Gz7LQy9fLtW2vqPJ58GlfZY3PcTJT5g+Rzzg=;
        b=rK1yq4MpghXuL/f19xzZlCO9Ixk6C4mw+LZ9zkGgekW+t63wgx3237y+pPn0/J16tD
         b209TgZiwJkHjxfTvex8FO4Du2F+og48NLrCLExpfMuS1xtXsKw5nLKfTczZv/Ey8a0C
         JiHKmIw4sAdto64uI1o9dkgG6TeufobOVVjuk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=CFA1GaMh2LGXfOoUmHh3WY3uIKipYzSFXCBvzPH59lNhGzuekLaj7jB349hHdy7MR1
         UHvZv/d1VpD1+dOwvA3+0R1V97HryHzFN4WqHx0EeNB0MAQ540W6HBZZ9FGvifAHtsF/
         w+knA7AaI1tPKQRPeUDXiuJ3bUhQCItQcgcok=
Received: by 10.110.40.8 with SMTP id n8mr4874632tin.28.1234019604292;
        Sat, 07 Feb 2009 07:13:24 -0800 (PST)
Received: from ?116.87.149.30? ([116.87.149.30])
        by mx.google.com with ESMTPS id b7sm4867295tic.35.2009.02.07.07.13.22
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 07 Feb 2009 07:13:23 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108855>

In 753bc91 ("Remove the requirement opaquelocktoken uri scheme"), the
lock token is guaranteed to be prefixed with the string
'opaquelocktoken:', which propagated down to file path creation
operations in the remote repository, namely, in start_put (and
consequently start_move).

These file operations may not be successful, due to the colon ':'
character in the file path (specifically, in Windows).

This patch ensures that the lock token sans 'opaquelocktoken:' is used
instead in start_put.

Note on tests: In the second grep, we check that Apache returns status
20* (ie. the request was successful), but in the first we do not do
so, since file creation by PUSH/MOVE is not guaranteed to succeed (see
above).

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

 http-push.c          |    2 +-
 t/t5540-http-push.sh |    9 +++++++++
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/http-push.c b/http-push.c
index eefd64c..10df94a 100644
--- a/http-push.c
+++ b/http-push.c
@@ -558,7 +558,7 @@ static void start_put(struct transfer_request *request)

 	append_remote_object_url(&buf, remote->url, hex, 0);
 	strbuf_addstr(&buf, "_");
-	strbuf_addstr(&buf, request->lock->token);
+	strbuf_addstr(&buf, request->lock->token + 16);
 	request->url = strbuf_detach(&buf, NULL);

 	slot = get_active_slot();
diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index c236b5e..544dea8 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -94,6 +94,15 @@ test_expect_success 'MKCOL sends directory names with trailing slashes' '

 '

+test_expect_success 'PUT and MOVE sends object to URLs without "opaquelocktoken:"' '
+
+	!(grep -P "\"(?:PUT|MOVE) .+objects/[\da-z]{2}/[\da-z]{38}_opaquelocktoken:[\da-z\-]{36} HTTP/[0-9.]+\"" \
+	< "$HTTPD_ROOT_PATH"/access.log) &&
+	grep -P "\"(?:PUT|MOVE) .+objects/[\da-z]{2}/[\da-z]{38}_[\da-z\-]{36} HTTP/[0-9.]+\" 20\d" \
+	< "$HTTPD_ROOT_PATH"/access.log
+
+'
+
 stop_httpd

 test_done
-- 
1.6.1.2.278.g9a9e.dirty

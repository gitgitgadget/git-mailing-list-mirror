From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH] use lock token in non-URI form in start_put
Date: Sun, 08 Feb 2009 03:27:53 +0800
Message-ID: <498DE0B9.6080603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 07 20:29:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVssC-000319-J8
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 20:29:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752457AbZBGT2Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 14:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752223AbZBGT2Z
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 14:28:25 -0500
Received: from ti-out-0910.google.com ([209.85.142.185]:18402 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864AbZBGT2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 14:28:24 -0500
Received: by ti-out-0910.google.com with SMTP id d10so1355510tib.23
        for <git@vger.kernel.org>; Sat, 07 Feb 2009 11:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=9+NZZ/WqozkbkRerlrhfibhyee1VXXAnjZn1YilVMoY=;
        b=n9IUItJT3ldwFDD5J/xcI/mbq0KC5VNuvBBEOEWDo15OELbCnIofv4hAt1zzo3DPrF
         ea5wMcSRfY0aftCrT+znuDSpYsFH79LHy64aBX+a41YltDrnGDv/p5ALVeq+0vpDOHBv
         MmnjdrayTT7OI2Es6ZXFxu4vteAOqHc1h/sMc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=BqXkpAYoQMhyX5Mc9Cns5FIIfI0BWrqW9I6aZJISi3cPtit3k86FreGssQ0RviE3g0
         bSS5janyJwqdyL+koId2JsN+g3VA0vrDe1li+cy7RULFv5GDIkMhzDNARUlo0bczqy4q
         LBOLi0sm5zrRfbEJ8hAgrewDZx4KoacJw2VMU=
Received: by 10.110.3.15 with SMTP id 15mr5189645tic.0.1234034900854;
        Sat, 07 Feb 2009 11:28:20 -0800 (PST)
Received: from ?116.87.149.30? ([116.87.149.30])
        by mx.google.com with ESMTPS id b7sm2611584tic.15.2009.02.07.11.28.19
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 07 Feb 2009 11:28:20 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108876>

After 753bc91 ("Remove the requirement opaquelocktoken uri scheme"),
lock tokens are in the URI forms in which they are received from the
server, eg. 'opaquelocktoken:', 'uuid:'

However, "start_put" (and consequently "start_move"), which attempts to
create a unique temporary file using the UUID of the lock token,
inadvertently uses the lock token in its URI form. These file
operations on the server may not be successful (specifically, in
Windows), due to the colon ':' character from the URI form of the lock
token in the file path.

This patch ensures that the lock token sans the URI scheme is used
instead in "start_put".

To do this, the "start_put" gets the position of ':', which is used to
separate the URI scheme from the part, eg. "<scheme>:". In addition,
start_put uses the last position of ':', since URIs with component
URIs are possible, eg. "urn:uuid:" One can be sure that the lock token
will always contain the UUID and be in URI form, due to RFC 2518, or
its successor RFC 4918 (see
http://www.webdav.org/specs/rfc4918.html#ELEMENT_locktoken).

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http-push.c          |    2 +-
 t/t5540-http-push.sh |    7 +++++++
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/http-push.c b/http-push.c
index eefd64c..bd8f372 100644
--- a/http-push.c
+++ b/http-push.c
@@ -558,7 +558,7 @@ static void start_put(struct transfer_request *request)

 	append_remote_object_url(&buf, remote->url, hex, 0);
 	strbuf_addstr(&buf, "_");
-	strbuf_addstr(&buf, request->lock->token);
+	strbuf_addstr(&buf, strrchr(request->lock->token, ':') + 1);
 	request->url = strbuf_detach(&buf, NULL);

 	slot = get_active_slot();
diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index c236b5e..268b2d4 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -94,6 +94,13 @@ test_expect_success 'MKCOL sends directory names with trailing slashes' '

 '

+test_expect_success 'PUT and MOVE sends object to URLs in non-URI form' '
+
+	grep -P "\"(?:PUT|MOVE) .+objects/[\da-z]{2}/[\da-z]{38}_[\da-z\-]{36} HTTP/[0-9.]+\" 20\d" \
+	< "$HTTPD_ROOT_PATH"/access.log
+
+'
+
 stop_httpd

 test_done
-- 
1.6.1.2.278.g9a9e.dirty

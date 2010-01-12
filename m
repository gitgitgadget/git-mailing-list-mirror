From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] remote-curl: Fix Accept header for smart HTTP connections
Date: Tue, 12 Jan 2010 09:54:04 -0800
Message-ID: <20100112175404.GE1173@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 18:54:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUkwc-0005N6-RT
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 18:54:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754173Ab0ALRyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 12:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753786Ab0ALRyJ
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 12:54:09 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:42743 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753490Ab0ALRyI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 12:54:08 -0500
Received: by yxe17 with SMTP id 17so21604182yxe.33
        for <git@vger.kernel.org>; Tue, 12 Jan 2010 09:54:07 -0800 (PST)
Received: by 10.91.121.2 with SMTP id y2mr734458agm.105.1263318846960;
        Tue, 12 Jan 2010 09:54:06 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 21sm11068678yxe.19.2010.01.12.09.54.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 12 Jan 2010 09:54:06 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136742>

We actually expect to see an application/x-git-upload-pack-result
but we lied and said we Accept *-response.  This was a typo on my
part when I was writing the code.

Fortunately the wrong Accept header had no real impact, as the
deployed git-http-backend servers were not testing the Accept
header before they returned their content.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 This should go in maint.

 remote-curl.c         |    2 +-
 t/t5551-http-fetch.sh |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index a331bae..8f169dd 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -480,7 +480,7 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads)
 	strbuf_addf(&buf, "Content-Type: application/x-%s-request", svc);
 	rpc->hdr_content_type = strbuf_detach(&buf, NULL);
 
-	strbuf_addf(&buf, "Accept: application/x-%s-response", svc);
+	strbuf_addf(&buf, "Accept: application/x-%s-result", svc);
 	rpc->hdr_accept = strbuf_detach(&buf, NULL);
 
 	while (!err) {
diff --git a/t/t5551-http-fetch.sh b/t/t5551-http-fetch.sh
index c0505ec..7faa31a 100755
--- a/t/t5551-http-fetch.sh
+++ b/t/t5551-http-fetch.sh
@@ -38,7 +38,7 @@ cat >exp <<EOF
 > POST /smart/repo.git/git-upload-pack HTTP/1.1
 > Accept-Encoding: deflate, gzip
 > Content-Type: application/x-git-upload-pack-request
-> Accept: application/x-git-upload-pack-response
+> Accept: application/x-git-upload-pack-result
 > Content-Length: xxx
 < HTTP/1.1 200 OK
 < Pragma: no-cache
-- 
1.6.6.280.ge295b

-- 
Shawn.

From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 2/2] remote-curl.c: fix rpc_out()
Date: Mon, 23 Nov 2009 11:03:38 +0800
Message-ID: <20091123110338.2b230359.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 23 04:10:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCPK7-0001SM-MW
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 04:10:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756149AbZKWDK3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Nov 2009 22:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756126AbZKWDK3
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 22:10:29 -0500
Received: from mail-gx0-f226.google.com ([209.85.217.226]:47024 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756122AbZKWDK2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2009 22:10:28 -0500
Received: by gxk26 with SMTP id 26so4471649gxk.1
        for <git@vger.kernel.org>; Sun, 22 Nov 2009 19:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=L9EKXsxPWenBg880XKwHCQSVIK1MyH5kHXaNBOPVing=;
        b=q7djBXCTnM3zph9JpCsPa5fKUP4AyQrlatZOAS9cxrHEpQma/oy3vimKjXvThyhoZ0
         EZDx63mcJl1odjASv7g7r2CrM53+v4WiTigy+IHVfvyehV1XsC0quVdjtfo77ID/toI7
         DTZKKwXigGug4kVoFzVi7eYLijh2VUmu8B7mk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=sf+JtBgUjszesZ1Y7mzzFDpJFppfUHW5U/1N2O4drA9xlIum7QvgoVMwlUNuI6NW+y
         qNkcYha0SRSfBdk/TfWS7BPdzv2PfnHMSG19XOyHeuSHtWvZkuDMcDlzhN2Acz6+gWSW
         NH5WCfrl2q9CdVSaEXhqFt6H3M++phJYGWLNg=
Received: by 10.150.87.2 with SMTP id k2mr7426500ybb.267.1258945425809;
        Sun, 22 Nov 2009 19:03:45 -0800 (PST)
Received: from your-cukc5e3z5n (cm164.zeta152.maxonline.com.sg [116.87.152.164])
        by mx.google.com with ESMTPS id 6sm1336986ywc.24.2009.11.22.19.03.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Nov 2009 19:03:45 -0800 (PST)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133477>

Use comparisons between rpc->len and rpc->pos, rather than computing
their difference. This avoids potential errors when this value is
negative and we access it.

Use an int to store the return value from packet_read_line(), instead
of a size_t.

Handle the errorneous condition where rpc->pos exceeds rpc->len by
printing a message and aborting the transfer (return 0).

Remove extraneous semicolon (';') at the end of the if statement, that
prevented code in its block from executing.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

  Users might experience issues when pushing with chunked encoding when
  size_t avail is negative.

 remote-curl.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 69eaf58..a2b8bbf 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -297,17 +297,22 @@ static size_t rpc_out(void *ptr, size_t eltsize,
 {
 	size_t max = eltsize * nmemb;
 	struct rpc_state *rpc = buffer_;
-	size_t avail = rpc->len - rpc->pos;
+	size_t avail = (size_t) 0;

-	if (!avail) {
-		avail = packet_read_line(rpc->out, rpc->buf, rpc->alloc);
-		if (!avail)
+	if (rpc->pos == rpc->len) {
+		int n = packet_read_line(rpc->out, rpc->buf, rpc->alloc);
+		if (!n)
 			return 0;
 		rpc->pos = 0;
-		rpc->len = avail;
+		avail = rpc->len = (size_t) n;
+	} else if (rpc->pos > rpc->len) {
+		error("bad condition!");
+		return 0;
+	} else {
+		avail = rpc->len - rpc->pos;
 	}

-	if (max < avail);
+	if (max < avail)
 		avail = max;
 	memcpy(ptr, rpc->buf + rpc->pos, avail);
 	rpc->pos += avail;
--
1.6.5.3.301.gb2eb

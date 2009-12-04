From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH resend 3/3] transport.c::transport_push(): make ref status
 affect return value
Date: Fri, 4 Dec 2009 14:58:42 +0800
Message-ID: <20091204145842.57c3c51c.rctay89@gmail.com>
References: <20091204145755.4d793b0b.rctay89@gmail.com>,
 <20091204145643.296ec414.rctay89@gmail.com>,
 <20091204145437.1a9910db.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Sverre Rabbelier" <srabbelier@gmail.com>,
	"Clemens Buchacher" <drizzd@aon.at>, "Jeff King" <peff@peff.net>,
	"Junio C Hamano" <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 04 07:58:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGS7y-0001x8-Jo
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 07:58:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752814AbZLDG6o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 01:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752790AbZLDG6n
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 01:58:43 -0500
Received: from mail-yw0-f182.google.com ([209.85.211.182]:61816 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752779AbZLDG6m (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 01:58:42 -0500
Received: by ywh12 with SMTP id 12so2307212ywh.21
        for <git@vger.kernel.org>; Thu, 03 Dec 2009 22:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=2HpjEyxFBzYM3t91js07QNax6S/+9PL2qNtc9wAag2k=;
        b=Rk47ZS4dm7MpndTihaeJZ3RjoRMvs8uMMnhn6uUfxb6ajJTCN/Ei7KF9kkgyS44BgP
         Pni4kjJYDl7HcjRD7A5RD1BFMKT2TzViVNsxJPt6BwlXmhlrnLZlpHisF8gSGiH7JR1e
         xKpm6xNAjeV+D+wBElSCgD7VTDnw9h3i7Pd/c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=YEkpMwYS8MnnBQ3fvzcIFzSQ9iZa9uqR4tWqpPAAtGckwjM26+hspGYm/8SMjwlVOO
         2HN6tbQn41vuLAh6B7C6xGMvnvU/6NWz6P9CiJSh+88QLVBZlXtTkjHvGzlE4JT3ihqe
         hte/69acuX34A54kqmGTTXgrIHSfNw7NelhRs=
Received: by 10.91.50.3 with SMTP id c3mr4297610agk.38.1259909929079;
        Thu, 03 Dec 2009 22:58:49 -0800 (PST)
Received: from your-cukc5e3z5n (cm81.zeta152.maxonline.com.sg [116.87.152.81])
        by mx.google.com with ESMTPS id 34sm1434190yxf.47.2009.12.03.22.58.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 03 Dec 2009 22:58:48 -0800 (PST)
In-Reply-To: <20091204145437.1a9910db.rctay89@gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134497>

When determining whether to print the ref status table,
push_had_errors() is called. Piggy-back this and modify the return
value accordingly.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 transport.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/transport.c b/transport.c
index 3eea836..32c122b 100644
--- a/transport.c
+++ b/transport.c
@@ -889,10 +889,13 @@ int transport_push(struct transport *transport,

 		ret = transport->push_refs(transport, remote_refs, flags);

-		if (!quiet || push_had_errors(remote_refs))
-			print_push_status(transport->url, remote_refs,
-					verbose | porcelain, porcelain,
-					nonfastforward);
+		if (!quiet)
+			if (push_had_errors(remote_refs)) {
+				ret = -1;
+				print_push_status(transport->url, remote_refs,
+						verbose | porcelain, porcelain,
+						nonfastforward);
+			}

 		if (!(flags & TRANSPORT_PUSH_DRY_RUN)) {
 			struct ref *ref;
--
1.6.6.rc1.286.gbc15a

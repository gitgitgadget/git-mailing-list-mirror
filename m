From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] server-info: clean up after writing info/packs
Date: Sat, 13 Sep 2014 16:19:38 -0400
Message-ID: <20140913201938.GC27082@peff.net>
References: <20140913201538.GA24854@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <stefanbeller@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Sat Sep 13 22:19:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XStnM-0003Ql-RY
	for gcvg-git-2@plane.gmane.org; Sat, 13 Sep 2014 22:19:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752294AbaIMUTl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Sep 2014 16:19:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:47809 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752280AbaIMUTk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Sep 2014 16:19:40 -0400
Received: (qmail 8846 invoked by uid 102); 13 Sep 2014 20:19:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 Sep 2014 15:19:40 -0500
Received: (qmail 10303 invoked by uid 107); 13 Sep 2014 20:20:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 Sep 2014 16:20:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Sep 2014 16:19:38 -0400
Content-Disposition: inline
In-Reply-To: <20140913201538.GA24854@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256975>

We allocate pack information in a static global list but
never clean it up. This leaks memory, and means that calling
update_server_info twice will generate a buggy file (it will
have duplicate entries).

Signed-off-by: Jeff King <peff@peff.net>
---
 server-info.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/server-info.c b/server-info.c
index d54a3d6..31f4a74 100644
--- a/server-info.c
+++ b/server-info.c
@@ -233,6 +233,14 @@ static void init_pack_info(const char *infofile, int force)
 		info[i]->new_num = i;
 }
 
+static void free_pack_info(void)
+{
+	int i;
+	for (i = 0; i < num_pack; i++)
+		free(info[i]);
+	free(info);
+}
+
 static int write_pack_info_file(FILE *fp)
 {
 	int i;
@@ -252,6 +260,7 @@ static int update_info_packs(int force)
 
 	init_pack_info(infofile, force);
 	ret = update_info_file(infofile, write_pack_info_file);
+	free_pack_info();
 	free(infofile);
 	return ret;
 }
-- 
2.1.0.373.g91ca799

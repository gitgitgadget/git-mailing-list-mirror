From: Jeff King <peff@peff.net>
Subject: [PATCH 1/8] transport-helper: fix minor leak in push_refs_with_export
Date: Tue, 7 Jun 2011 13:19:29 -0400
Message-ID: <20110607171929.GA22087@sigill.intra.peff.net>
References: <20110607171838.GA21685@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 19:19:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTzwL-0000Nf-CS
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 19:19:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754931Ab1FGRTg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 13:19:36 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50718
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753534Ab1FGRTg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 13:19:36 -0400
Received: (qmail 16901 invoked by uid 107); 7 Jun 2011 17:19:43 -0000
Received: from c-76-21-13-32.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (76.21.13.32)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Jun 2011 13:19:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jun 2011 13:19:29 -0400
Content-Disposition: inline
In-Reply-To: <20110607171838.GA21685@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175218>


Signed-off-by: Jeff King <peff@peff.net>
---
 transport-helper.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 660147f..b560b64 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -721,20 +721,21 @@ static int push_refs_with_export(struct transport *transport,
 		char *private;
 		unsigned char sha1[20];
 
 		if (!data->refspecs)
 			continue;
 		private = apply_refspecs(data->refspecs, data->refspec_nr, ref->name);
 		if (private && !get_sha1(private, sha1)) {
 			strbuf_addf(&buf, "^%s", private);
 			string_list_append(&revlist_args, strbuf_detach(&buf, NULL));
 		}
+		free(private);
 
 		string_list_append(&revlist_args, ref->name);
 
 	}
 
 	if (get_exporter(transport, &exporter,
 			 export_marks, import_marks, &revlist_args))
 		die("Couldn't run fast-export");
 
 	data->no_disconnect_req = 1;
-- 
1.7.6.rc0.35.gc40cb

From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH] builtin-push: don't access freed transport->url
Date: Fri, 4 Dec 2009 07:31:44 +0800
Message-ID: <20091204073144.f98115f9.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Daniel Barkalow" <barkalow@iabervon.org>,
	"Sverre Rabbelier" <srabbelier@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 04 00:33:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGLBC-000579-3F
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 00:33:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753824AbZLCXde (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2009 18:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753619AbZLCXdd
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Dec 2009 18:33:33 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:59806 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbZLCXdd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2009 18:33:33 -0500
Received: by yxe17 with SMTP id 17so1627135yxe.33
        for <git@vger.kernel.org>; Thu, 03 Dec 2009 15:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=Bmu+TScHnAbYWURY8/RhlxTKGW+ILXoEqzaG9sCYio0=;
        b=ixDQmHxl6/edMrECPkiF6jQ3nWx1S3yxbmtrh5OAQtw8uw9kRTUV7vqjmu1SOZlkjR
         Q3ZMstIAYJ/DwecEAZDFPcOG5QpDqN/tVpAgJu30UQyxTHj2qIkKpx/SSg+hfDXOKea0
         zRd6Y+h2gBsya54SGk9yPcTmPhI6SHMetmOVo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=vjLi/WVsz6x/SOILLSgSf7G/e/wTqLp+h38fNxTSoNfUWUcQ/6OyJBwZoPjQTEyiE+
         +aIerM2XteJQFPkUKiXmwbmGcVz0HbuTJJRicDXKIx6smv16bx+QPVGRhY6CyhJYpORc
         O68JzbYy9LxUVLtogVGo7lHjA6xEZ2aDzpenY=
Received: by 10.101.4.22 with SMTP id g22mr3113178ani.40.1259883219532;
        Thu, 03 Dec 2009 15:33:39 -0800 (PST)
Received: from your-cukc5e3z5n (cm81.zeta152.maxonline.com.sg [116.87.152.81])
        by mx.google.com with ESMTPS id 6sm1283362yxg.48.2009.12.03.15.33.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 03 Dec 2009 15:33:38 -0800 (PST)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134482>

Move the failed push message to before transport_disconnect() so that
it doesn't access transport->url after transport has been free()'d (in
transport_disconnect()).

Additionally, make the failed push message more accurate by moving it
before transport_disconnect(), so that it doesn't report errors due
to a failed disconnect.

Cc: "Daniel Barkalow" <barkalow@iabervon.org>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 builtin-push.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index a21e46c..dcfb53f 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -101,13 +101,14 @@ static int push_with_options(struct transport *transport, int flags)
 		fprintf(stderr, "Pushing to %s\n", transport->url);
 	err = transport_push(transport, refspec_nr, refspec, flags,
 			     &nonfastforward);
+	if (err != 0)
+		error("failed to push some refs to '%s'", transport->url);
+
 	err |= transport_disconnect(transport);

 	if (!err)
 		return 0;

-	error("failed to push some refs to '%s'", transport->url);
-
 	if (nonfastforward && advice_push_nonfastforward) {
 		printf("To prevent you from losing history, non-fast-forward updates were rejected\n"
 		       "Merge the remote changes before pushing again.  See the 'non-fast-forward'\n"
--
1.6.6.rc1.249.g048b3

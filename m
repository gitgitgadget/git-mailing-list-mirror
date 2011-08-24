From: Brian Harring <ferringb@gmail.com>
Subject: [PATCH] get_indexed_object can return NULL if nothing is in that
 slot; check for it
Date: Tue, 23 Aug 2011 22:47:17 -0700
Message-ID: <20110824054717.GA16512@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 24 07:47:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qw6Il-00015c-NV
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 07:47:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168Ab1HXFqz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 01:46:55 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:55038 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354Ab1HXFqy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 01:46:54 -0400
Received: by ywf7 with SMTP id 7so632067ywf.19
        for <git@vger.kernel.org>; Tue, 23 Aug 2011 22:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=N+8URJ4ZeYHj8XWGNYjcRVOl+e74h17YWbx4uuLzN4w=;
        b=XmpYgCuQzDicXJmHSVwoD/2abzDQC4QY8mcagR02mocgcBWpgUc3Ra4GMfxR+xy8hO
         QXVcEDPH8x1B09GhjreybjUHds48eXYD37FZ7Yb7Pr/et2LLJd8WlO5AtOKA0KZWRiwG
         5tm9xtOYUCMpm9zMCoA3sRxPz1s4/TxpKFKPk=
Received: by 10.150.93.5 with SMTP id q5mr5108058ybb.325.1314164813658;
        Tue, 23 Aug 2011 22:46:53 -0700 (PDT)
Received: from smtp.gmail.com:587 (74-95-192-101-SFBA.hfc.comcastbusiness.net [74.95.192.101])
        by mx.google.com with ESMTPS id z29sm1100955yhn.2.2011.08.23.22.46.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 23 Aug 2011 22:46:53 -0700 (PDT)
Received: by smtp.gmail.com:587 (sSMTP sendmail emulation); Tue, 23 Aug 2011 22:47:17 -0700
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179986>

This fixes a segfault introduced by 051e400; via it, no longer able to 
trigger the http/smartserv race.

Signed-off-by: Brian Harring <ferringb@gmail.com>
---
 upload-pack.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 6420918..8739bfa 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -533,6 +533,8 @@ static void check_non_tip(void)
 	namebuf[41] = '\n';
 	for (i = get_max_object_index(); 0 < i; ) {
 		o = get_indexed_object(--i);
+		if (!o)
+			continue;
 		if (!(o->flags & OUR_REF))
 			continue;
 		memcpy(namebuf + 1, sha1_to_hex(o->sha1), 40);
-- 
1.7.6

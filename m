From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 6/7] When updating refs after a fetch, resolve the symref if set
Date: Wed, 28 Oct 2009 23:40:25 -0700
Message-ID: <1256798426-21816-7-git-send-email-srabbelier@gmail.com>
References: <1256798426-21816-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: "Git List" <git@vger.kernel.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Johan Herland" <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Oct 29 07:48:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3OoN-0005KC-RM
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 07:48:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756495AbZJ2Gsd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 02:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756493AbZJ2Gsc
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 02:48:32 -0400
Received: from mail-pw0-f42.google.com ([209.85.160.42]:63668 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756481AbZJ2Gsc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 02:48:32 -0400
Received: by pwj9 with SMTP id 9so1254429pwj.21
        for <git@vger.kernel.org>; Wed, 28 Oct 2009 23:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ZsN5iq1nJDeJvkMhGcX18WIparJqN550KhJItwU8TxM=;
        b=VreKoB1hXKBRFx3UBMUa7H82jm9OqGy/UXDAsCx2nfs5cKkgRyU+qymTgEGnVBFdWT
         y+OoNd34LnlDnxN1Oaznx7IwdryiVhKBwuJBdYZusY10lOM4NuUHUpt348chSqgz0i6z
         7NqpucUouXCmAg3ekMpqpYQVgQNmCZq/Fz7do=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tjxOdJsjsHC94MtKEDqvoW3ViLk3O9SKu2aPndN/zP69e9aq1xzH901Myn7BGGwRLI
         dJG7RDv+iPwbYeq9uCVF/iVXfgvVoePnwVcv+xmXNI0OVVxG5SlKpzdmx0ekTS4N/Vyx
         Iwuoh6KzQLGy+1obfeaFzxqqHWoqEjlJAo5io=
Received: by 10.114.51.12 with SMTP id y12mr5697916way.33.1256798496689;
        Wed, 28 Oct 2009 23:41:36 -0700 (PDT)
Received: from localhost.localdomain (ip67-152-86-163.z86-152-67.customer.algx.net [67.152.86.163])
        by mx.google.com with ESMTPS id 23sm401242pxi.1.2009.10.28.23.41.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Oct 2009 23:41:35 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.2.291.gf76a3
In-Reply-To: <1256798426-21816-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131562>

This makes it possible to return in response to 'list':
	@refs/hg/origin/tip refs/heads/tip
And have HEAD resolve properly after the import completes.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

	Without this it is very hard to support 'git clone' on a
	non-git repository, which I think is a very important thing
	to have.

 transport-helper.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 639f08c..a361366 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -159,7 +159,7 @@ static int fetch_with_import(struct transport *transport,
 		posn = to_fetch[i];
 		if (posn->status & REF_STATUS_UPTODATE)
 			continue;
-		read_ref(posn->name, posn->old_sha1);
+		read_ref(posn->symref ? posn->symref : posn->name, posn->old_sha1);
 	}
 	return 0;
 }
-- 
1.6.5.2.291.gf76a3

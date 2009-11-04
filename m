From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v2 09/13] Honour the refspec when updating refs after import
Date: Wed,  4 Nov 2009 20:48:14 +0100
Message-ID: <1257364098-1685-10-git-send-email-srabbelier@gmail.com>
References: <1257364098-1685-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Nov 04 20:50:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5lrh-0000NL-FR
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 20:49:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758095AbZKDTtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 14:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758090AbZKDTtP
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 14:49:15 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:55343 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758089AbZKDTtN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 14:49:13 -0500
Received: by mail-ew0-f207.google.com with SMTP id 3so3490482ewy.37
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 11:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=yJzh6OEdhIMWDyAmpBuwCvXwI31lJD3dZasKahY7Jvc=;
        b=ukbEgkkFNYuXDePWPeZAsisKw6bp5TVtq5m/uBfyemC5HP5QVb2fNM7EkI0IyXMRIq
         jSVqXG4Dyuq42dkJtMFrh52Q2YfpAp1wvEt7vPbv9Eo/OvD3rCBlklHH+LO5TuYBFe5r
         /wy5Nm+TEdohY87clgGzWhxNGB/nPLOmwZKeY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=b1dW43IfAsfutDA3sr4k7DWxTQI28RsGU3SFbjHz6OeVnB/C6pBqRkRuY1bfLzlsLB
         xjrtbntWGAJigTD73I3xyvCXVvBjgaoPM9djLGgsJ7S0vMUQHb+JVWUmkPojUK+c5Fdw
         L0JehqH8QZvl0BsOeDteqM9souwx1Z7aKtExU=
Received: by 10.213.23.206 with SMTP id s14mr2228637ebb.73.1257364158329;
        Wed, 04 Nov 2009 11:49:18 -0800 (PST)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id 5sm4314489eyh.2.2009.11.04.11.49.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Nov 2009 11:49:18 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2.295.g0d105
In-Reply-To: <1257364098-1685-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132126>

This way the helper can write to 'refs/remotes/origin/*' instead of
writing to 'refs/heads/*'.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Daniel, does this look good to you?

  Let's assume the following:
  * list: only HEAD is a symref (to refs/heads/<branch>), all other
          refs are '? refs/heads/<branch>'.
  * import: the helper creates branches under refs/remotes/<alias>/*
            (since the refspec code is not yet in that would allow
             it to create them under refs/<vcs>/<alias>/*)

  Now when updating the refs we do the following:
  transport-helper.c:145 "read_ref(posn->name, posn->old_sha1);"

  The value of posn->name looks like "refs/heads/<branch>". So what
  does this lookup do? It tries to lookup the new value of the ref
  _where it will be created_, this fails of course, since the ref
  currently only exists as "refs/remotes/origin/<branch>". So, we
  should instead be doing a lookup using posn->peer_ref->name, and
  not do a lookup at all if it posn->peer_ref is not set (which
  should not occur as we are passed only wanted peer refs).

  Please let me know if this makes sense and both this and 0008 can
  be squashed with 0007.

 transport-helper.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 148496c..72ed95b 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -142,7 +142,10 @@ static int fetch_with_import(struct transport *transport,
 		posn = to_fetch[i];
 		if (posn->status & REF_STATUS_UPTODATE)
 			continue;
-		read_ref(posn->name, posn->old_sha1);
+		if(posn->peer_ref) {
+			read_ref(posn->peer_ref->name, posn->peer_ref->old_sha1);
+			hashcpy(posn->old_sha1, posn->peer_ref->old_sha1);
+		}
 	}
 	return 0;
 }
-- 
1.6.5.2.295.g0d105

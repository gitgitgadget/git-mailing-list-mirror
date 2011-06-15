From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [PATCH] Use correct value when hinting strbuf_read()
Date: Wed, 15 Jun 2011 20:08:38 +0200
Message-ID: <1308161318-25637-1-git-send-email-iveqy@iveqy.com>
Cc: iveqy@iveqy.com, jens.lehmann@web.de, hvoigt@hvoigt.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 15 20:08:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWuW1-00038p-Hx
	for gcvg-git-2@lo.gmane.org; Wed, 15 Jun 2011 20:08:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752494Ab1FOSI2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 14:08:28 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:59199 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619Ab1FOSI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 14:08:27 -0400
Received: by eyx24 with SMTP id 24so262556eyx.19
        for <git@vger.kernel.org>; Wed, 15 Jun 2011 11:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:to:cc:subject:date:message-id
         :x-mailer;
        bh=Uxk1482GuqwaQCC5CIebiNQ5pFGROMWpY+oBtqoZg8I=;
        b=InGTDi1EwcYhmrDgeuNn92pjS//0vGr/pSE7y6aleCkKUGAVX7AAWWn55VOI0UNf8D
         Klxv6Vz0GGSrxtScZ6mP3o+nfZgP8LsL0pD9qSl+VaP2xF1sH5h35FjpAWEQ7gKVyQWe
         8uKIatHR1M9/hC/95A6Jzb3txcYDq0cmAlup0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=fUZi7lEJZFfZJQS+D8SK+VuH13EyjEk9LmBJ1S/dpSIp4mTqSSL9h9Y1GXW9hXM7sk
         4Yq+PgLLLe+nded1ZdCujlNrQlUeiIU0pQZQN+VCjGShrIuB3orotmVoEpyoo6Eznb5p
         emHBd2DWNzBkzVGzlLU4DvcPIu6JAZFr5J6oM=
Received: by 10.213.27.148 with SMTP id i20mr1292753ebc.145.1308161305993;
        Wed, 15 Jun 2011 11:08:25 -0700 (PDT)
Received: from kolya (h8n2fls303o1100.telia.com [195.67.191.8])
        by mx.google.com with ESMTPS id g48sm617094eea.26.2011.06.15.11.08.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 15 Jun 2011 11:08:25 -0700 (PDT)
Received: from iveqy by kolya with local (Exim 4.72)
	(envelope-from <iveqy@kolya>)
	id 1QWuW8-0006g3-OC; Wed, 15 Jun 2011 20:08:43 +0200
X-Mailer: git-send-email 1.7.5.1.230.ga2029.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175844>

The git strbuf allows for each read to hint about the size of the
string. In this case the the string can never be longer than 41
characters, as it cannot contain more than a single hex-sha1 and a
newline.

So let's use 41 instead of 1024 to reduce the memory footprint.

Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
Mentored-by: Jens Lehmann <Jens.Lehmann@web.de>
Mentored-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 submodule.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/submodule.c b/submodule.c
index b6dec70..86baf42 100644
--- a/submodule.c
+++ b/submodule.c
@@ -326,7 +326,7 @@ static int is_submodule_commit_present(const char *path, unsigned char sha1[20])
 		cp.no_stdin = 1;
 		cp.out = -1;
 		cp.dir = path;
-		if (!run_command(&cp) && !strbuf_read(&buf, cp.out, 1024))
+		if (!run_command(&cp) && !strbuf_read(&buf, cp.out, 41))
 			is_present = 1;
 
 		close(cp.out);
-- 
1.7.5.1.229.g455f

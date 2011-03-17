From: Andrey Borzenkov <arvidjaar@gmail.com>
Subject: [PATCH TopGit] tg-export.sh: support tag objects as parent
Date: Thu, 17 Mar 2011 21:30:23 +0300
Message-ID: <1300386623-31666-1-git-send-email-arvidjaar@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 17 19:31:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0HyR-0007tU-OC
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 19:31:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755187Ab1CQSa5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 14:30:57 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43519 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755023Ab1CQSa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 14:30:56 -0400
Received: by bwz15 with SMTP id 15so2708874bwz.19
        for <git@vger.kernel.org>; Thu, 17 Mar 2011 11:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:message-id:x-mailer;
        bh=5KcNoezaw0MqbXTOx5oDBd+m/O/g73cv1A2JSVIJgSM=;
        b=dw+RN9wtTPim8x4JsD3mJFUlJm6NBQemLvujwXpE7ARf4iNikQS85mp1QNM7ixSkHF
         puYf9MnjJ6y+yLQCkludC7ksV1YNcdfjGPvQkvfMWPPhGlONm1NbQM0s5Razh7qZv8uA
         Txj7Vzw+TRrU5RQkyDV8eAxHXXw3dx4YOY5nE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=ErFii3W90rIvdp2qU1FupU7rA4iJ3K8pqeCgh0js1TIdnHaN60lKeFLZSiezy20GeL
         8KSfdpCgsQMwfkw2Pkfwqs4FLRu1AFTkQ1QvF9feZYqxjQ4gVOWZlPJbqj2+4XphohNs
         bpZWhvZNuc25lq3EBOaK0HhYYAqDVh2xM7JuM=
Received: by 10.204.19.14 with SMTP id y14mr65719bka.187.1300386655128;
        Thu, 17 Mar 2011 11:30:55 -0700 (PDT)
Received: from localhost.localdomain (ppp85-140-14-15.pppoe.mtu-net.ru [85.140.14.15])
        by mx.google.com with ESMTPS id k5sm1564839bku.16.2011.03.17.11.30.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Mar 2011 11:30:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169254>

Currently tg-export fails with

Collapsing u/quota-pull
fatal: 2770ca86dec8b9cc36bf50127e5aff7f29557e3c is not a valid 'commit' object

Check for and resolve tag objects for parent.

Signed-off-by: Andrey Borzenkov <arvidjaar@gmail.com>

---
 tg-export.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/tg-export.sh b/tg-export.sh
index 486ec94..4574882 100644
--- a/tg-export.sh
+++ b/tg-export.sh
@@ -95,7 +95,8 @@ collapsed_commit()
 	>"$playground/^body"
 
 	# Determine parent
-	parent="$(cut -f 1 "$playground/$name^parents")"
+	parent="$(cut -f 1 "$playground/$name^parents" | \
+		while read p; do [ $(git cat-file -t $p 2> /dev/null) = tag ] && git cat-file tag $p | head -1 | cut -d' ' -f2 || echo $p; done)"
 	if [ "$(cat "$playground/$name^parents" | wc -l)" -gt 1 ]; then
 		# Produce a merge commit first
 		parent="$({
-- 
tg: (9aa66bc..) u/parent-tag (depends on: u/signed-off-by)

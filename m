From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] git-submodule - Fix errors regarding resolve_relative_url
Date: Sat, 14 Jun 2008 15:36:29 -0400
Message-ID: <1213472189-252-1-git-send-email-mlevedahl@gmail.com>
References: <7vd4mjhnwk.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org, Mark Levedahl <mlevedahl@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jun 14 21:38:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7bZf-0005WQ-BB
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 21:38:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754311AbYFNTgg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 15:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754226AbYFNTgg
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 15:36:36 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:17466 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754130AbYFNTgf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 15:36:35 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2781657ywe.1
        for <git@vger.kernel.org>; Sat, 14 Jun 2008 12:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=NkG5NvzeTkEL0xN063ar/02tc70KryoRc5iywq6N3Ec=;
        b=ST4bxOG33V5vh5OD7zHqhNhq7Hj7MjwC0/cgzbJcMI/CE/uNZc6b0JcEXK2DO+SOYn
         h51DwqmLuHqDMzlKKq6Pw8zC2CYenSYWg7kY1bbk1jzlI5mnfLCnEGtQIYB5vrfZQjo3
         V1sPZ9jjMGsj4ll+Ut5C7GogG44Vp+XVCmBmk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ZhxBT2yiBKRoZVantdK8CRvB73pmvYG5NZDTqznrb2oPOerxlPx73AmccPIST89QbW
         sq/wt4+j8kGsfhUmtYfwUmi96I31VGPkBI4VFEN6hODs8btidJfficDH2eSP8YI60Oax
         gOhQyZfHWEBAZRn3ttljE8Tu4TxiQ8cWdw1ss=
Received: by 10.151.100.17 with SMTP id c17mr7163531ybm.98.1213472193937;
        Sat, 14 Jun 2008 12:36:33 -0700 (PDT)
Received: from localhost.localdomain ( [71.191.242.223])
        by mx.google.com with ESMTPS id 5sm5215039ywd.2.2008.06.14.12.36.32
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 14 Jun 2008 12:36:33 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.rc2.65.gcb6b9
In-Reply-To: <7vd4mjhnwk.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85039>

git-submodule was invoking "die" from within resolve-relative-url, but
the error return was ignored by the callers. Fix this.

While we're at it, clean up the quoting on invocation of
resolve_relative_url as it was wrong.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-submodule.sh |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 4bd2b8e..9c890d3 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -178,7 +178,8 @@ cmd_add()
 		case "$repo" in
 		./*|../*)
 			# dereference source url relative to parent's url
-			realrepo="$(resolve_relative_url $repo)" ;;
+			realrepo=$(resolve_relative_url "$repo") || exit
+			;;
 		*)
 			# Turn the source into an absolute path if
 			# it is local
@@ -246,7 +247,7 @@ cmd_init()
 		# Possibly a url relative to parent
 		case "$url" in
 		./*|../*)
-			url="$(resolve_relative_url "$url")"
+			url=$(resolve_relative_url "$url") || exit
 			;;
 		esac
 
-- 
1.5.6.rc2.65.gcb6b9

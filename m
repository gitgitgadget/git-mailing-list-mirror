From: "Torgil Svensson" <torgil.svensson@gmail.com>
Subject: [PATCH] submodule update - don't run git-fetch if sha1 available
Date: Sat, 11 Aug 2007 19:48:37 +0200
Message-ID: <e7bda7770708111048s77fbf416k9d0352486aee6b4a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 11 19:48:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJv54-0003jf-7y
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 19:48:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754335AbXHKRsj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 13:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754252AbXHKRsj
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 13:48:39 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:11908 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753729AbXHKRsi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 13:48:38 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1276772wah
        for <git@vger.kernel.org>; Sat, 11 Aug 2007 10:48:37 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=g9ocApLmFte63BbBwFjmM5yuZaxzE/qUjIwiLCa8g+xBaYmJQ+6UpY3ADCHCxW/OhFjC2y+m3aXzWvA47Mb4I5HmEePFTWLYHPXsjshs245LbRGwejthTQ8B0kkIx98bax83MtWt9AMtFVH3/GCWBlaXy4G3y+IMU+zMZXKUM7I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=tW6zY2+AFr0y9GxWziegzdGyEKEsKrTWqhkFEOZK/So7o0FK5NlkGoF/6V0dOk2mU/u8CZ2R27AdHGKJ+IzHPvyf/BIld3EIbglm4BJ5ItCbzUGwQcPOZr7JERlN76Lbf4D/7lJIRA8gtID9RbR13uGtd3ODy9heojyqx93Dx/8=
Received: by 10.115.59.4 with SMTP id m4mr1733043wak.1186854517552;
        Sat, 11 Aug 2007 10:48:37 -0700 (PDT)
Received: by 10.114.47.7 with HTTP; Sat, 11 Aug 2007 10:48:37 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55617>

It's un-necessary (both time-consuming and annoying if you are
disconnected) for git submodule update to always running git-fetch
prior to the detached head checkout of the submodule if the commit
already exists.

Signed-off-by: Torgil Svensson <torgil.svensson@gmail.com>
---
 git-submodule.sh |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 2cfeadd..dc2ed4b 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -39,6 +39,11 @@ get_repo_base() {
        ) 2>/dev/null
 }

+has_sha1()
+{
+       git rev-list 2>/dev/null --max-count=0 $1
+}
+
 #
 # Map submodule path to submodule name
 #
@@ -193,9 +198,9 @@ modules_update()

                if test "$subsha1" != "$sha1"
                then
-                       (unset GIT_DIR && cd "$path" && git-fetch &&
+                       (unset GIT_DIR && cd "$path" && (has_sha1
"$sha1" || git-fetch) &&
                                git-checkout -q "$sha1") ||
-                       die "Unable to checkout '$sha1' in submodule
path '$path'"
+                       die "Unable to checkout '$sha1' in submodule
path '$path'"

                        say "Submodule path '$path': checked out '$sha1'"
                fi
--
1.5.3.rc4.730.ga8c3-dirty

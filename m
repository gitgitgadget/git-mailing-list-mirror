From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] git-submodule.sh - Remove trailing / from URL if found
Date: Thu, 21 Aug 2008 19:54:01 -0400
Message-ID: <1219362841-4048-1-git-send-email-mlevedahl@gmail.com>
References: <7vej4ii6y8.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org, Mark Levedahl <mlevedahl@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 22 01:55:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWJzo-0000F1-TD
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 01:55:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752325AbYHUXyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 19:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752333AbYHUXyJ
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 19:54:09 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:35833 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752253AbYHUXyH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 19:54:07 -0400
Received: by an-out-0708.google.com with SMTP id d40so33498and.103
        for <git@vger.kernel.org>; Thu, 21 Aug 2008 16:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Enf5hOn0uP8PUdpFY9gS8/tBQyrtpUdkiojKP81GaJI=;
        b=vstePWBdfw5RVO6K51q/lGq53oAt1I62BYN+hVYwpWYhQ+lb209X20rjB4gTbcASw/
         JkKG1QaPgs7eiWEJvOo/BC4JjwpxaWXJxWLOnTilt15yY5qGBuNetC89gFWwUA6bzEpS
         UIdVzCNn8aGXRl3fGv4i6s88zmnoAPDHp/VyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=h736nIqQhUcTRWV89l+2DzvH8zrGIDy9HqLQIubi44WXZn6GGDzyTfuxIwsWN+OZyr
         F1QPHdIACZ5qEsWwthP/AR/kpEDnKwOMzbufnYxZ+LufcLgcMPdBcXFT0/9msE9dE2+I
         VEb6HttJTYZgVlnL258slxLa8/3O7ttbE4dJY=
Received: by 10.100.109.13 with SMTP id h13mr577792anc.158.1219362846864;
        Thu, 21 Aug 2008 16:54:06 -0700 (PDT)
Received: from localhost.localdomain ( [71.163.41.46])
        by mx.google.com with ESMTPS id b12sm1001165ana.14.2008.08.21.16.54.04
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 21 Aug 2008 16:54:05 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.29.g747a
In-Reply-To: <7vej4ii6y8.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93232>

git clone does not complain if a trailing '/' is included in the origin
URL, but doing so causes resolution of a submodule's URL relative to the
superproject to fail. Trailing /'s are likely when cloning locally using
tab-completion, so the slash may appear in either superproject or
submodule URL. So, ignore the trailing slash if it already exists in
the superproject's URL, and don't record one for the submodule (which
could itself have submodules...).

The problem I'm trying to fix is that a number of folks have
superprojects checked out where the recorded origin URL has a trailing
/, and a submodule has its origin in a directory sitting right next to
the superproject on the server. Thus, we have:

	superproject url = server:/public/super
	submodoule url = server:/public/sub1

However, in the checked out superproject's .git/config

[remote "origin"]
	url = server:/public/super/

and for similar reasons, the submodule has its URL recorded in .gitmodules as
[submodule "sub"]

	path = submodule1
	url = ../sub1/

resolve_relative_url gets the submodule's recorded url as $1, which
the caller retrieved from .gitmodules, and retrieves the superprojects
origin from .git/config. So in this case resolve_relative_url has
that:

	url = ../sub1/
	remoteurl = server:/public/super/

So, without any patch, resolve_relative_url computes the submodule's URL as:

	server:/public/super/sub1/

rather than

	server:/public/sub1

In summary, it is essential that resolve_relative_url strip the
trailing / from the superproject's url before starting, and
beneficial if it assures that the result does not contain
a trailing / as the submodule may itself also be a superproject.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-submodule.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 2d57d60..0bc1085 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -36,6 +36,7 @@ resolve_relative_url ()
 	remoteurl=$(git config "remote.$remote.url") ||
 		die "remote ($remote) does not have a url defined in .git/config"
 	url="$1"
+	remoteurl=${remoteurl%/}
 	while test -n "$url"
 	do
 		case "$url" in
@@ -50,7 +51,7 @@ resolve_relative_url ()
 			break;;
 		esac
 	done
-	echo "$remoteurl/$url"
+	echo "$remoteurl"/"${url%/}"
 }
 
 #
-- 
1.6.0.29.g747a

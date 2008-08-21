From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] git-submodule.sh - Remove trailing / from URL if found
Date: Wed, 20 Aug 2008 21:07:27 -0400
Message-ID: <1219280847-872-1-git-send-email-mlevedahl@gmail.com>
References: <7vpro4tjkw.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org, Mark Levedahl <mlevedahl@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 21 03:08:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVyfF-0002gG-TY
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 03:08:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557AbYHUBHf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 21:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751777AbYHUBHe
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 21:07:34 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:42040 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbYHUBHe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 21:07:34 -0400
Received: by an-out-0708.google.com with SMTP id d40so116047and.103
        for <git@vger.kernel.org>; Wed, 20 Aug 2008 18:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=8Uf28MteY9ryU0b+8NsSGfjJmL6KkHy7QIy1cxHvuEs=;
        b=spd483B/enK3XndF1EERHwA5C4fDysmXBlhl8acg+glD9+U8B/6RON5bBj3iCEQRaM
         jr+DFcPZCX23aWvVT/WYjOzkIZhgYTVrw7vEQJFkZ/rpgW/9yZS7rGPBuqScAD++CpTs
         Wc97xmqopHFXS4SIjbZaFoSSafH/PAwMXMgP4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=gKJufKOHoEdzh5Ahq51/NqtPPRVB3aS1l8FSSgfZ8XDHApnyNguXqnnYM9mmXDOtnF
         +AKgrs5Fo9c8WbG7mRfG8y0nwgqtaP4lVCUDUlzeiyxkaXp9nJiXfAXaWkr/6tuP5rrp
         JpH5Jhpzzb5lu1w0haMXx75rh7Ss98B0BX6Cs=
Received: by 10.100.112.9 with SMTP id k9mr1124144anc.72.1219280853293;
        Wed, 20 Aug 2008 18:07:33 -0700 (PDT)
Received: from localhost.localdomain ( [71.163.41.46])
        by mx.google.com with ESMTPS id d29sm83501and.12.2008.08.20.18.07.30
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 20 Aug 2008 18:07:31 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.22.g2957
In-Reply-To: <7vpro4tjkw.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93081>

git clone does not complain if a trailing '/' is included in the origin
URL, but doing so causes resolution of a submodule's URL relative to the
superproject to fail. Trailing /'s are likely when cloning locally using
tab-completion, so the slash may appear in either superproject or
submodule URL. So, ignore the trailing slash if it already exists in
the superproject's URL, and don't record one for the submodule (which
could itself have submodules...).

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-submodule.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index b40f876..e576cd2 100755
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
1.6.0.22.g2957

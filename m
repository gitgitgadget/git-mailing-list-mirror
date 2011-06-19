From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v2 06/20] transport-helper: don't feed bogus refs to export push
Date: Sun, 19 Jun 2011 17:18:31 +0200
Message-ID: <1308496725-22329-7-git-send-email-srabbelier@gmail.com>
References: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar
X-From: git-owner@vger.kernel.org Sun Jun 19 17:19:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYJn3-0003jn-3F
	for gcvg-git-2@lo.gmane.org; Sun, 19 Jun 2011 17:19:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754365Ab1FSPTp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jun 2011 11:19:45 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:44389 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754336Ab1FSPTl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2011 11:19:41 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so981213ewy.19
        for <git@vger.kernel.org>; Sun, 19 Jun 2011 08:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=T0eET7HzH0pS0tr2V/NcNahwYiMEqIeu+fPCgNBoHJE=;
        b=DXC7pPpzraiIN3rEzWbJhtSRBw34Za5wO81EH96peZl0HBEOCaprUPUgnX/s72EB8z
         OtK0hle29TJtc3NblvY6K11FT+uNfL9tNULL+6Iexbud2y4n2Hk4U7B9IX19EAjenIpv
         RuitP1OS22QmDi7Z40Uhw4AQh+Qc8/mc3EFbI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tlCb9l/Fo+b9LGrgCzbUNDabMFaNx32iSPc+ODdeL/3lENiLiBT7zF4M7Bwa2PVRY7
         3kLHZb/E1cNKqRS2zqHV/5DTwhq/2xyO2JWfF09bOs0m7DqAlLHQ0/HbX9wwn5rANIC0
         9bi7PciqBUuDtXjuJg9Y7DCH5jjSLN6wd0KWg=
Received: by 10.213.9.72 with SMTP id k8mr1624651ebk.1.1308496780700;
        Sun, 19 Jun 2011 08:19:40 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id y6sm3824429eem.18.2011.06.19.08.19.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 19 Jun 2011 08:19:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176009>

From: Jeff King <peff@peff.net>

When we want to push to a remote helper that has the
"export" capability, we collect all of the refs we want to
push and then feed them to fast-export.

However, the list of refs is actually a list of remote refs,
not local refs. The mapped local refs are included via the
peer_ref pointer. So when we add an argument to our
fast-export command line, we must be sure to use the local
peer_ref name (and if there is no local name, it is because
we are not actually sending that ref, or we may not even
have the ref at all).

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Unchanged.

 t/t5800-remote-helpers.sh |    2 +-
 transport-helper.c        |    3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t5800-remote-helpers.sh b/t/t5800-remote-helpers.sh
index ca115cc..ceb0010 100755
--- a/t/t5800-remote-helpers.sh
+++ b/t/t5800-remote-helpers.sh
@@ -106,7 +106,7 @@ test_expect_failure 'fetch multiple branches' '
 	compare_refs server new localclone refs/remotes/origin/new
 '
 
-test_expect_failure 'push when remote has extra refs' '
+test_expect_success 'push when remote has extra refs' '
 	(cd clone &&
 	 echo content >>file &&
 	 git commit -a -m six &&
diff --git a/transport-helper.c b/transport-helper.c
index b560b64..34d18aa 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -730,7 +730,8 @@ static int push_refs_with_export(struct transport *transport,
 		}
 		free(private);
 
-		string_list_append(&revlist_args, ref->name);
+		if (ref->peer_ref)
+			string_list_append(&revlist_args, ref->peer_ref->name);
 
 	}
 
-- 
1.7.5.1.292.g728120

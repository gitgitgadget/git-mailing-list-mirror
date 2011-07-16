From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v3 06/23] transport-helper: don't feed bogus refs to export push
Date: Sat, 16 Jul 2011 15:03:26 +0200
Message-ID: <1310821424-4750-7-git-send-email-srabbelier@gmail.com>
References: <1310821424-4750-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar
X-From: git-owner@vger.kernel.org Sat Jul 16 15:11:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qi4er-0008HP-FN
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jul 2011 15:11:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755191Ab1GPNLq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jul 2011 09:11:46 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:37892 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755012Ab1GPNLp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2011 09:11:45 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so997240ewy.19
        for <git@vger.kernel.org>; Sat, 16 Jul 2011 06:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=RBPvEf6VLprth9mh0M2MHiYpt0gM+R+/N1ATLOpMB5U=;
        b=nKc9NlVDU3Xk4l4vQFd3oCu30MDTQR2HcdfpDEy45E3sxfFzYZv7JizKY5DO8xvSxh
         jZU67JEnoMX0PPW/TX1xrfwdjWI559ZQXvRmYvG1imYd2GHMxGfZudT8nQi+Qqm1yBG4
         V1X/Rc1MK+Opm3c8jsRsrvLqrCr40oeVU4kIM=
Received: by 10.213.20.200 with SMTP id g8mr1605933ebb.140.1310821474680;
        Sat, 16 Jul 2011 06:04:34 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id q16sm1212533eef.7.2011.07.16.06.04.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Jul 2011 06:04:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1310821424-4750-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177276>

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

  Unchanged

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

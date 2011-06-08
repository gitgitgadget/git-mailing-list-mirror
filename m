From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 05/19] transport-helper: don't feed bogus refs to export push
Date: Wed,  8 Jun 2011 20:48:36 +0200
Message-ID: <1307558930-16074-6-git-send-email-srabbelier@gmail.com>
References: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>, "Jeff King" <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 20:50:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUNpI-00087c-Mm
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 20:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509Ab1FHStk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 14:49:40 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:46131 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614Ab1FHStf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 14:49:35 -0400
Received: by ewy4 with SMTP id 4so282597ewy.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 11:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=BdR5hPBfJGwBbX6IZwEkW0cw8UouWbCF2fJNiLZdBD0=;
        b=xh3QWiPBllAhZqYYRyeI/5oBiC2rTEvu+kk9ehb6rk5mLuAdXDyjd0bNrxGkrsfqvX
         7l6SkRbHWtixoUcIPA5Q2qEklFuksJFe9KwnEKBGPSNKZ5JVqxbZ4JXlEPARFKG84V62
         L5cQuqk60rqlsRkmItl0FE6V4dXBuTzJZ3yoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=W8z/HTfFmJzcYEkKHMfBFKaI3FyPnuUPCQBA0jsjxchWGS2tRBxH3Fax53loJLU4io
         k/tZtXxr5bsv2BrDASvFHIf8Zy7aFiVoSYHrq7atMKETQ2PGkoSMPbezMvXc2KNdt8dE
         De6Yn4j9wzhARlK9ibk8QfSbAbcxwL4y0oi4o=
Received: by 10.14.96.133 with SMTP id r5mr2986574eef.139.1307558974226;
        Wed, 08 Jun 2011 11:49:34 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id b1sm729674eeg.19.2011.06.08.11.49.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 11:49:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175433>

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

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Unchanged from Peff's series.

 t/t5800-remote-helpers.sh |    2 +-
 transport-helper.c        |    3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t5800-remote-helpers.sh b/t/t5800-remote-helpers.sh
index 562edf4..1abfa5c 100755
--- a/t/t5800-remote-helpers.sh
+++ b/t/t5800-remote-helpers.sh
@@ -102,7 +102,7 @@ test_expect_failure PYTHON_24 'fetch multiple branches' '
 	compare_refs server new localclone refs/remotes/origin/new
 '
 
-test_expect_failure PYTHON_24 'push when remote has extra refs' '
+test_expect_success PYTHON_24 'push when remote has extra refs' '
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

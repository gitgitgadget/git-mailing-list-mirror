From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH 8/8] fetch.c: Remove call to parse_object() from process()
Date: Wed, 21 Sep 2005 20:19:09 +0400 (MSD)
Message-ID: <20050921161909.C39C5E2FFC7@center4.mivlgu.local>
References: <20050921161829.GA20944@master.mivlgu.local>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 21 18:23:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EI7Jd-0006Ia-Ec
	for gcvg-git@gmane.org; Wed, 21 Sep 2005 18:19:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbVIUQTM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 12:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbVIUQTL
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 12:19:11 -0400
Received: from mivlgu.ru ([81.18.140.87]:4230 "EHLO center4.mivlgu.local")
	by vger.kernel.org with ESMTP id S1751125AbVIUQTK (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2005 12:19:10 -0400
Received: by center4.mivlgu.local (Postfix, from userid 500)
	id C39C5E2FFC7; Wed, 21 Sep 2005 20:19:09 +0400 (MSD)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20050921161829.GA20944@master.mivlgu.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9061>

The call to parse_object() in process() is not actually needed - if
the object type is unknown, parse_object() will be called by loop();
if the type is known, the object will be parsed by the appropriate
process_*() function.

After this change blobs which exist locally are no longer parsed,
which gives about 2x CPU usage improvement; the downside is that there
will be no warnings for existing corrupted blobs, but detecting such
corruption is the job of git-fsck-objects, not the fetch programs.
Newly fetched objects are still checked for corruption in http-fetch.c
and ssh-fetch.c (local-fetch.c does not seem to do it, but the removed
parse_object() call would not be reached for new objects anyway).

---

 fetch.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

b8a4d51743787be17f9572dce2eb2f4040ac241b
diff --git a/fetch.c b/fetch.c
--- a/fetch.c
+++ b/fetch.c
@@ -134,7 +134,6 @@ static int process(struct object *obj)
 	obj->flags |= SEEN;
 
 	if (has_sha1_file(obj->sha1)) {
-		parse_object(obj->sha1);
 		/* We already have it, so we should scan it now. */
 		obj->flags |= TO_SCAN;
 	} else {

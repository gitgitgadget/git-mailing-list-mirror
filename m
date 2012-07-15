From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH] Fix overwritten remote ref on with fast-import.
Date: Sun, 15 Jul 2012 16:26:23 +0200
Message-ID: <1342362383-31167-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1342013933-14381-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: florian.achleitner.2.6.31@gmail.com, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org, David Michael Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Sun Jul 15 16:27:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqPnf-0002N4-N3
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jul 2012 16:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967Ab2GOO1O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jul 2012 10:27:14 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:63444 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751535Ab2GOO1N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2012 10:27:13 -0400
Received: by bkwj10 with SMTP id j10so4135368bkw.19
        for <git@vger.kernel.org>; Sun, 15 Jul 2012 07:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=lDHNBCPKsCu3xl92kVALb5A3gDfPPa3a9U9BrTBpBVw=;
        b=FTypmWsaI7ILyhbjk3kK45xuVi8EZCxqiA6UtV0R7p2z47mq+BCr7dZTRezevg/+UG
         NddVWadOI7bl9+9zm1Hmk+aiZ4zmwNDJQ+je1J2s4VFUZGpaF3+1shApq7wtH+9Y0Qrs
         RBVKN/WafLeN8TUwQFlG2Jgyyhan4v8uoss4g+ZKFHFhj9ppa0PQNR47nA7syv80By4v
         99zt9SxdO7TycFuUth3wkrNmMzm4XKx2DmpnXyyVS8E9X98QbY8oZCxDvWY7Rgv6xkNl
         vE+IAlF/BSWwI947wkRmX0nPatGtZZKeRjrNTTWFv7HfZrrYtOgFBbufS/nvEoWVj/ka
         Syug==
Received: by 10.204.41.206 with SMTP id p14mr3476457bke.54.1342362431555;
        Sun, 15 Jul 2012 07:27:11 -0700 (PDT)
Received: from flobuntu.lan (93-82-157-117.adsl.highway.telekom.at. [93.82.157.117])
        by mx.google.com with ESMTPS id g6sm6675660bkg.2.2012.07.15.07.27.06
        (version=SSLv3 cipher=OTHER);
        Sun, 15 Jul 2012 07:27:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1342013933-14381-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201480>

After importing new commits on top of refs/remotes/* the
ref was overwritten with the local refs/heads/master, because the name
of the remote reference to fetch, i.e. refs/heads/master, was used to
retrieve old_sha1 for it's local counterpart. Therefore, old_sha1 pointed
to the local head which was not contained in the remote branch and couldn't
be updated (printing a warning ..).

There are some points that are still not completely clear to me:
- I found, that the remote ref I need is stored in ref->peer_ref. There
  is one little comment on peer_ref saying /* when renaming */. That doesn't say much
  to me. Is peer_ref the correct solution?
- fast-import's commit command does already add a commit to a branch. The
  remote ref was already correct, but got overwritten by store_updated_refs
  after fast import terminated. (I figured that out using strace).
  So the update is somewhat redundant. But probably only in this special case.(?)

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
---
 transport-helper.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/transport-helper.c b/transport-helper.c
index d6daad5..a0f05ce 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -485,8 +485,10 @@ static int fetch_with_import(struct transport *transport,
 			continue;
 		if (data->refspecs)
 			private = apply_refspecs(data->refspecs, data->refspec_nr, posn->name);
+		else if (posn->peer_ref)
+			private = xstrdup(posn->peer_ref->name);
 		else
-			private = xstrdup(posn->name);
+			private = NULL;
 		if (private) {
 			read_ref(private, posn->old_sha1);
 			free(private);
-- 
1.7.9.5

From: Jeff King <peff@peff.net>
Subject: [PATCH] show-branch: use strbuf instead of static buffer
Date: Fri, 5 Apr 2013 17:15:50 -0400
Message-ID: <20130405211550.GA4880@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Roman <eroman@chromium.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 06 19:26:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWPA-0001b9-CK
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:55:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162673Ab3DEVQF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 17:16:05 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58187 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1162478Ab3DEVQE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 17:16:04 -0400
Received: (qmail 17800 invoked by uid 107); 5 Apr 2013 21:17:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 05 Apr 2013 17:17:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Apr 2013 17:15:50 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220208>

When we generate relative names (e.g., "master~20^2"), we
format the name into a static buffer, then xstrdup the
result to attach it to the commit. Since the first thing we
add into the static buffer is the already-computed name of
the child commit, the names may get longer and longer as
the traversal gets deeper, and we may eventually overflow
the fixed-size buffer.

Fix this by converting the fixed-size buffer into a dynamic
strbuf.  The performance implications should be minimal, as
we end up allocating a heap copy of the name anyway (and now
we can just detach the heap copy from the strbuf).

Reported-by: Eric Roman <eroman@chromium.org>
Signed-off-by: Jeff King <peff@peff.net>
---
This is a fix for a bug report that came to me off-list.  A real-world
example can be seen by running "git show-branch --all" on a fresh clone
of:

  https://chromium.googlesource.com/chromium/src.git

(but that repo is 1.7G, so I don't recommend cloning it unless you're
really interested). Its master branch consists of a strange sequence of
merges that results in naming commits like master^2^2^2^2... and so on
(it's unclear to me why, but it looks like maybe syncing up separate svn
and git repositories?).  Which is odd, but looking at graph, I think the
names show-branch is generating are correct; they're just really long.
And of course odd history is no excuse to overflow a buffer.

Though this is a stack overflow, I don't know that it's exploitable for
anything interesting; an attacker does not get to write arbitrary data,
but rather only a sequence of "^%d" and "~%d" relative history markers.
Perhaps in theory one could devise a history such that the sequence
markers spelled out some malicious code, but it would be quite a
challenge (and given that you have only ascii [^~0-9] to work with,
probably impossible).

I prepared this on "master", but it should be suitable for "maint"; the
code dates all the way back to git v0.99.

 builtin/show-branch.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index d208fd6..90fc6b1 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -162,29 +162,28 @@ static void name_commits(struct commit_list *list,
 			nth = 0;
 			while (parents) {
 				struct commit *p = parents->item;
-				char newname[1000], *en;
+				struct strbuf newname = STRBUF_INIT;
 				parents = parents->next;
 				nth++;
 				if (p->util)
 					continue;
-				en = newname;
 				switch (n->generation) {
 				case 0:
-					en += sprintf(en, "%s", n->head_name);
+					strbuf_addstr(&newname, n->head_name);
 					break;
 				case 1:
-					en += sprintf(en, "%s^", n->head_name);
+					strbuf_addf(&newname, "%s^", n->head_name);
 					break;
 				default:
-					en += sprintf(en, "%s~%d",
-						n->head_name, n->generation);
+					strbuf_addf(&newname, "%s~%d",
+						    n->head_name, n->generation);
 					break;
 				}
 				if (nth == 1)
-					en += sprintf(en, "^");
+					strbuf_addch(&newname, '^');
 				else
-					en += sprintf(en, "^%d", nth);
-				name_commit(p, xstrdup(newname), 0);
+					strbuf_addf(&newname, "^%d", nth);
+				name_commit(p, strbuf_detach(&newname, NULL), 0);
 				i++;
 				name_first_parent_chain(p);
 			}
-- 
1.8.2.rc0.33.gd915649

From: Jeff King <peff@peff.net>
Subject: [PATCH/RFC] improve no-op push output
Date: Wed, 30 May 2012 08:08:04 -0400
Message-ID: <20120530120804.GA3501@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 30 14:08:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZhhe-0001xG-3m
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 14:08:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753202Ab2E3MIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 08:08:09 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:36294
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752993Ab2E3MIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 08:08:09 -0400
Received: (qmail 4492 invoked by uid 107); 30 May 2012 12:08:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 May 2012 08:08:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 May 2012 08:08:04 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198806>

I noticed the mention of the "Everything up-to-date" message in a nearby
thread. This patch doesn't help with the case there, but it made me
think about how vague that message is.

-- >8 --
When a push is a no-op because all refs are up-to-date, we print
"Everything up-to-date". That is reasonable when push.default is
"matching" (or when a wildcard refspec is given), because "Everything"
pretty obviously means "everything you asked git to push".

But when one of the single-ref push.default modes is used, the
"Everything" is slightly misleading; we only tried to push one thing,
and we should not give the user the impression that the remote is
completely in sync with what is in their local repo.

Instead, let's detect the case that we attempted to push a single ref,
and if so, just show the verbose status table (which includes the
up-to-date ref). We don't want to show it if we tried to push many refs,
because it could be quite long (e.g., in the case of "matching").

---
So before, running:

  git init -q --bare parent &&
  git clone -q parent child 2>/dev/null &&
  cd child &&
  echo one >one && git add one && git commit -q -m one &&
  git branch other &&
  git -c push.default=simple push

would just print:

  Everything up-to-date

and now you get:

  To /tmp/push-message/parent
   = [up to date]      master -> master

which is much more informative. And this could naturally extend to
printing the whole table when n < 5, or something similar. I don't think
it would help the case that David reported, though, since it sounds like
his problem was being on a detached HEAD without realizing it (and even
if we did print a status table, he would be similarly confused).

diff --git a/transport.c b/transport.c
index 1811b50..4dc09da 100644
--- a/transport.c
+++ b/transport.c
@@ -1033,6 +1033,15 @@ static void die_with_unpushed_submodules(struct string_list *needs_pushing)
 	die("Aborting.");
 }
 
+static int num_uptodate(struct ref *ref)
+{
+	int n = 0;
+	for (; ref; ref = ref->next)
+		if (ref->status == REF_STATUS_UPTODATE)
+			n++;
+	return n;
+}
+
 int transport_push(struct transport *transport,
 		   int refspec_nr, const char **refspec, int flags,
 		   int *nonfastforward)
@@ -1116,8 +1125,15 @@ int transport_push(struct transport *transport,
 
 		if (porcelain && !push_ret)
 			puts("Done");
-		else if (!quiet && !ret && !transport_refs_pushed(remote_refs))
-			fprintf(stderr, "Everything up-to-date\n");
+		else if (!quiet && !ret && !transport_refs_pushed(remote_refs)) {
+			if (verbose)
+				; /* already showed the up-to-date entries */
+			else if (num_uptodate(remote_refs) == 1)
+				transport_print_push_status(transport->url,
+				    remote_refs, 1, 0, nonfastforward);
+			else
+				fprintf(stderr, "Everything up-to-date\n");
+		}
 
 		return ret;
 	}

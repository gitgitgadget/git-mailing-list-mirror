From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH v2] push: point to 'git pull' and 'git push --force' in case of non-fast forward
Date: Tue, 11 Aug 2009 12:03:13 +0900
Message-ID: <20090811120313.6117@nanako3.lavabit.com>
References: <1249579933-1782-1-git-send-email-Matthieu.Moy@imag.fr>
	<1249717868-10946-1-git-send-email-Matthieu.Moy@imag.fr>
	<87prb6r9d1.fsf@iki.fi> <vpqab2aqqia.fsf@bauges.imag.fr>
	<7vy6pujmsc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 14:46:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaqkN-0004ns-Tj
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 14:46:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753912AbZHKMqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 08:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753931AbZHKMqK
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 08:46:10 -0400
Received: from karen.lavabit.com ([72.249.41.33]:46553 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753741AbZHKMqI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 08:46:08 -0400
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 7112311B8B4;
	Mon, 10 Aug 2009 22:03:57 -0500 (CDT)
Received: from 9170.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id AGZI3J98DOWA; Mon, 10 Aug 2009 22:03:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=4B+PCVVsHCK/8QdSji7KoBAaYfzLLIMSgOPiMKGXlLpN0cMfaapWwwEfXgMFYX+km9/RSqJ7L4WulXqDJGI2VxtPoGU0NSzg8ll/vR8OkdljUBkMU379MqacyOmzBa3HAptgjXmucjiNFhmqpkWVFJOsYlfWsxNKrrN6FxePBF8=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7vy6pujmsc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125543>

From: Matthieu Moy <Matthieu.Moy@imag.fr>
Date: Sat,  8 Aug 2009 09:51:08 +0200
Subject: [PATCH] push: point to 'git pull' and 'git push --force' in case of non-fast forward

'git push' failing because of non-fast forward is a very common situation,
and a beginner does not necessarily understand "fast forward" immediately.

Add a new section to the git-push documentation and refer them to it.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---

  Quoting Junio C Hamano <gitster@pobox.com> writes:

  > So how about phrasing it like this?
  >
  >     Non-fast forward pushes were rejected because you would discard remote
  >     changes you have not seen.  Integrate them with your changes and then
  >     push again. See 'non-fast forward' section of 'git push --help'.
  >
  > I think you can throw in a discussion on --force to the manual page, too.

  Here is my attempt to coagulate the improvements discussed on the thread so far. I added a paragraph that mentions --force in the new section of the manual, reworded the explanatory message on the UI, and forged two signatures.

 Documentation/git-push.txt |   86 ++++++++++++++++++++++++++++++++++++++++++++
 builtin-push.c             |    9 ++++-
 transport.c                |   10 ++++--
 transport.h                |    3 +-
 4 files changed, 103 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 2653388..58d2bd5 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -195,6 +195,92 @@ reason::
 	refs, no explanation is needed. For a failed ref, the reason for
 	failure is described.
 
+Note about fast-forwards
+------------------------
+
+When an update changes a branch (or more in general, a ref) that used to
+point at commit A to point at another commit B, it is called a
+fast-forward update if and only if B is a descendant of A.
+
+In a fast-forward update from A to B, the set of commits that the original
+commit A built on top of is a subset of the commits the new commit B
+builds on top of.  Hence, it does not lose any history.
+
+In contrast, a non-fast-forward update will lose history.  For example,
+suppose you and somebody else started at the same commit X, and you built
+a history leading to commit B while the other person built a history
+leading to commit A.  The history looks like this:
+
+----------------
+
+      B
+     /
+ ---X---A
+
+----------------
+
+Further suppose that the other person already pushed changes leading to A
+back to the original repository you two obtained the original commit X.
+
+The push done by the other person updated the branch that used to point at
+commit X to point at commit A.  It is a fast-forward.
+
+But if you try to push, you will attempt to update the branch (that
+now points at A) with commit B.  This does _not_ fast-forward.  If you did
+so, the changes introduced by commit A will be lost, because everybody
+will now start building on top of B.
+
+The command by default does not allow an update that is not a fast-forward
+to prevent such loss of history.
+
+If you do not want to lose your work (history from X to B) nor the work by
+the other person (history from X to A), you would need to first fetch the
+history from the repository, create a history that contains changes done
+by both parties, and push the result back.
+
+You can perform "git pull", resolve potential conflicts, and "git push"
+the result.  A "git pull" will create a merge commit C between commits A
+and B.
+
+----------------
+
+      B---C
+     /   /
+ ---X---A
+
+----------------
+
+Updating A with the resulting merge commit will fast-forward and your
+push will be accepted.
+
+Alternatively, you can rebase your change between X and B on top of A,
+with "git pull --rebase", and push the result back.  The rebase will
+create a new commit D that builds the change between X and B on top of
+A.
+
+----------------
+
+      B   D
+     /   /
+ ---X---A
+
+----------------
+
+Again, updating A with this commit will fast-forward and your push will be
+accepted.
+
+There is another common situation where you may encounter non-fast-forward
+rejection when you try to push, and it is possible even when you are
+pushing into a repository nobody else pushes into. After you push commit
+A yourself (in the first picture in this section), replace it with "git
+commit --amend" to produce commit B, and you try to push it out, because
+forgot that you have pushed A out already. In such a case, and only if
+you are certain that nobody in the meantime fetched your earlier commit A
+(and started building on top of it), you can run "git push --force" to
+overwrite it. In other words, "git push --force" is a method reserved for
+a case where you do mean to lose history.
+
+
 Examples
 --------
 
diff --git a/builtin-push.c b/builtin-push.c
index 1d92e22..50328f4 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -140,6 +140,7 @@ static int do_push(const char *repo, int flags)
 		struct transport *transport =
 			transport_get(remote, url[i]);
 		int err;
+		int nonfastforward;
 		if (receivepack)
 			transport_set_option(transport,
 					     TRANS_OPT_RECEIVEPACK, receivepack);
@@ -148,13 +149,19 @@ static int do_push(const char *repo, int flags)
 
 		if (flags & TRANSPORT_PUSH_VERBOSE)
 			fprintf(stderr, "Pushing to %s\n", url[i]);
-		err = transport_push(transport, refspec_nr, refspec, flags);
+		err = transport_push(transport, refspec_nr, refspec, flags,
+				     &nonfastforward);
 		err |= transport_disconnect(transport);
 
 		if (!err)
 			continue;
 
 		error("failed to push some refs to '%s'", url[i]);
+		if (nonfastforward) {
+			printf("To prevent you from losing history, non-fast-forward updates were rejected.\n"
+			       "Merge the remote changes before pushing again.\n"
+			       "See 'non-fast forward' section of 'git push --help' for details.\n");
+		}
 		errs++;
 	}
 	return !!errs;
diff --git a/transport.c b/transport.c
index de0d587..f231b35 100644
--- a/transport.c
+++ b/transport.c
@@ -820,7 +820,7 @@ static int print_one_push_status(struct ref *ref, const char *dest, int count, i
 }
 
 static void print_push_status(const char *dest, struct ref *refs,
-							  int verbose, int porcelain)
+			      int verbose, int porcelain, int * nonfastforward)
 {
 	struct ref *ref;
 	int n = 0;
@@ -835,11 +835,14 @@ static void print_push_status(const char *dest, struct ref *refs,
 		if (ref->status == REF_STATUS_OK)
 			n += print_one_push_status(ref, dest, n, porcelain);
 
+	*nonfastforward = 0;
 	for (ref = refs; ref; ref = ref->next) {
 		if (ref->status != REF_STATUS_NONE &&
 		    ref->status != REF_STATUS_UPTODATE &&
 		    ref->status != REF_STATUS_OK)
 			n += print_one_push_status(ref, dest, n, porcelain);
+		if (ref->status == REF_STATUS_REJECT_NONFASTFORWARD)
+			*nonfastforward = 1;
 	}
 }
 
@@ -997,7 +1000,8 @@ int transport_set_option(struct transport *transport,
 }
 
 int transport_push(struct transport *transport,
-		   int refspec_nr, const char **refspec, int flags)
+		   int refspec_nr, const char **refspec, int flags,
+		   int * nonfastforward)
 {
 	verify_remote_names(refspec_nr, refspec);
 
@@ -1024,7 +1028,7 @@ int transport_push(struct transport *transport,
 
 		ret = transport->push_refs(transport, remote_refs, flags);
 
-		print_push_status(transport->url, remote_refs, verbose | porcelain, porcelain);
+		print_push_status(transport->url, remote_refs, verbose | porcelain, porcelain, nonfastforward);
 
 		if (!(flags & TRANSPORT_PUSH_DRY_RUN)) {
 			struct ref *ref;
diff --git a/transport.h b/transport.h
index 51b5397..639f13d 100644
--- a/transport.h
+++ b/transport.h
@@ -68,7 +68,8 @@ int transport_set_option(struct transport *transport, const char *name,
 			 const char *value);
 
 int transport_push(struct transport *connection,
-		   int refspec_nr, const char **refspec, int flags);
+		   int refspec_nr, const char **refspec, int flags,
+		   int * nonfastforward);
 
 const struct ref *transport_get_remote_refs(struct transport *transport);
 
-- 
1.6.2.GIT

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

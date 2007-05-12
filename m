From: Jan Hudec <bulb@ucw.cz>
Subject: [PATCH] Updated documentation of hooks in git-receive-pack.
Date: Sat, 12 May 2007 22:29:45 +0200
Message-ID: <20070512202945.GA10610@efreet.light.src>
References: <20070512201309.GB8983@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 12 22:30:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmyE6-0004jr-ON
	for gcvg-git@gmane.org; Sat, 12 May 2007 22:30:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755399AbXELU35 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 16:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755552AbXELU35
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 16:29:57 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:2376 "EHLO mail.bluetone.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755399AbXELU34 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 16:29:56 -0400
Received: from ([85.207.119.145])
	by mail.bluetone.cz with ESMTP with TLS id 5203017.198128;
	Sat, 12 May 2007 22:29:45 +0200
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1HmyDp-0002lR-Hn; Sat, 12 May 2007 22:29:45 +0200
Content-Disposition: inline
In-Reply-To: <20070512201309.GB8983@efreet.light.src>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-esp: ESP<0>=
	RBL:<0> 
	SHA:<0> 
	UHA:<0> 
	BAYES:<0> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47091>

Added documentation of pre-receive and post-receive hooks and updated
documentation of update and post-update hooks.

Signed-off-by: Jan Hudec <bulb@ucw.cz>
---

Resubmitting the patch including the changes based on review.

 Documentation/hooks.txt |   90 +++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 79 insertions(+), 11 deletions(-)

diff --git a/Documentation/hooks.txt b/Documentation/hooks.txt
index b083290..db23dc4 100644
--- a/Documentation/hooks.txt
+++ b/Documentation/hooks.txt
@@ -90,6 +90,38 @@ parameter, and is invoked after a commit is made.
 This hook is meant primarily for notification, and cannot affect
 the outcome of `git-commit`.
 
+[[pre-receive]]
+pre-receive
+-----------
+
+This hook is invoked by `git-receive-pack` on the remote repository,
+which happens when a `git push` is done on a local repository.
+Just before starting to update refs on the remote repository, the
+pre-receive hook is invoked.  Its exit status determines the success
+or failure of the update.
+
+This hook executes once for the receive operation. It takes no
+arguments, but for each ref to be updated it receives on standard
+input a line of the format:
+
+  <old-value> SP <new-value> SP <ref-name> NL
+
+where `<old-value>` is the old object name stored in the ref,
+`<new-value>` is the new object name to be stored in the ref and
+`<ref-name>` is the full name of the ref. When creating a new ref,
+the `<old-value>` is 40 `0`.
+
+If the hook exits with non-zero status, none of the refs will be
+updated. If the hook exits with zero, updating of individual refs can
+still be prevented by the <<update,'update'>> hook.
+
+Both standard output and standard error output are forwarded to
+`git-send-pack` on the other end, so you can simply `echo` messages
+for the user.
+
+There is no default 'pre-receive' hook.
+
+[[update]]
 update
 ------
 
@@ -108,7 +140,8 @@ three parameters:
 
 A zero exit from the update hook allows the ref to be updated.
 Exiting with a non-zero status prevents `git-receive-pack`
-from updating the ref.
+from updating that ref. When creating a new ref,
+<old-value> is 40 `0`.
 
 This hook can be used to prevent 'forced' update on certain refs by
 making sure that the object name is a commit object that is a
@@ -117,19 +150,51 @@ That is, to enforce a "fast forward only" policy.
 
 It could also be used to log the old..new status.  However, it
 does not know the entire set of branches, so it would end up
-firing one e-mail per ref when used naively, though.
+firing one e-mail per ref when used naively, though.  The
+<<post-receive,'post-receive'>> hook is more suited to that.
 
 Another use suggested on the mailing list is to use this hook to
 implement access control which is finer grained than the one
 based on filesystem group.
 
-The standard output of this hook is sent to `stderr`, so if you
-want to report something to the `git-send-pack` on the other end,
-you can simply `echo` your messages.
+Both standard output and standard error output are forwarded to
+`git-send-pack` on the other end, so you can simply `echo` messages
+for the user.
+
+The default 'update' hook, when enabled--and with
+`hooks.allowunannotated` config option turned on--prevents
+unannotated tags to be pushed.
+
+[[post-receive]]
+post-receive
+------------
+
+This hook is invoked by `git-receive-pack` on the remote repository,
+which happens when a `git push` is done on a local repository.
+It executes on the remote repository once after all the refs have
+been updated.
+
+This hook executes once for the receive operation.  It takes no
+arguments, but receives the same input as the
+<<pre-receive,'pre-receive'>> hook.
+
+This hook cannot affect the outcome of `git-receive-pack`, as it's
+called after the real work is done.
+
+This supersedes the <<post-update,'post-update'>> hook in that it
+get's both old and new values of all the refs in addition to their
+names.
+
+Both standard output and standard error output are forwarded to
+`git-send-pack` on the other end, so you can simply `echo` messages
+for the user.
 
-The default 'update' hook, when enabled, demonstrates how to
-send out a notification e-mail.
+The default 'post-receive' hook is empty, but there is
+a script `post-receive-email` provided in the `contrib/hooks`
+directory in git distribution, which implements sending commit
+emails.
 
+[[post-update]]
 post-update
 -----------
 
@@ -146,7 +211,10 @@ the outcome of `git-receive-pack`.
 
 The 'post-update' hook can tell what are the heads that were pushed,
 but it does not know what their original and updated values are,
-so it is a poor place to do log old..new.
+so it is a poor place to do log old..new. The
+<<post-receive,'post-receive'>> hook does get both original and
+updated values of the refs. You might consider it instead if you need
+them.
 
 When enabled, the default 'post-update' hook runs
 `git-update-server-info` to keep the information used by dumb
@@ -154,6 +222,6 @@ transports (e.g., HTTP) up-to-date.  If you are publishing
 a git repository that is accessible via HTTP, you should
 probably enable this hook.
 
-The standard output of this hook is sent to `/dev/null`; if you
-want to report something to the `git-send-pack` on the other end,
-you can redirect your output to your `stderr`.
+Both standard output and standard error output are forwarded to
+`git-send-pack` on the other end, so you can simply `echo` messages
+for the user.
-- 
1.5.1.4

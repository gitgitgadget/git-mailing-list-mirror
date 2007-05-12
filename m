From: Jan Hudec <bulb@ucw.cz>
Subject: [PATCH] Updated documentation of hooks in git-receive-pack.
Date: Sat, 12 May 2007 19:11:13 +0200
Message-ID: <20070512171113.GA8100@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 12 19:12:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hmv8Y-0001ed-CR
	for gcvg-git@gmane.org; Sat, 12 May 2007 19:12:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757012AbXELRLm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 13:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756997AbXELRLl
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 13:11:41 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:4945 "EHLO mail.bluetone.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758673AbXELRLk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 13:11:40 -0400
Received: from ([85.207.119.145])
	by mail.bluetone.cz with ESMTP with TLS id 5203017.196528;
	Sat, 12 May 2007 19:11:13 +0200
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1Hmv7h-00027U-Cd; Sat, 12 May 2007 19:11:13 +0200
Content-Disposition: inline
PGP: c
User-Agent: Mutt/1.5.13 (2006-08-11)
X-esp: ESP<0>=
	RBL:<0> 
	SHA:<0> 
	UHA:<0> 
	BAYES:<0> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47065>

Added documentation of pre-receive and post-receive hooks and updated
documentation of update and post-update hooks.

Signed-off-by: Jan Hudec <bulb@ucw.cz>
---

Recent question on the mailing-list made me to look at the post-receive hook
in the Documentation/hooks.txt, only to find it is not mentioned there at
all.

I looked up all the hooks and how they are called in receive-pack.c and
updated the documentation for them. Please review and apply.

Feel free to suggest syntactic or semantic fixes; I am not a native English
speaker, so there may well be some.

Regards,

Jan

 Documentation/hooks.txt |   84 ++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 76 insertions(+), 8 deletions(-)

diff --git a/Documentation/hooks.txt b/Documentation/hooks.txt
index b083290..e36cf44 100644
--- a/Documentation/hooks.txt
+++ b/Documentation/hooks.txt
@@ -90,6 +90,37 @@ parameter, and is invoked after a commit is made.
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
+`<ref-name>` is the full name of the ref.
+
+If the hook exits with non-zero status, none of the refs will be
+updated. If the hook returs zero, updating of individual refs can
+still be prevented by the <<update,'update'>> hook.
+
+The standard output of this hook is sent to `stderr`, so if you
+want to report something to the `git-send-pack` on the other end,
+you can simply `echo` your messages.
+
+There is no default 'pre-receive' hook.
+
+[[update]]
 update
 ------
 
@@ -108,7 +139,7 @@ three parameters:
 
 A zero exit from the update hook allows the ref to be updated.
 Exiting with a non-zero status prevents `git-receive-pack`
-from updating the ref.
+from updating that ref.
 
 This hook can be used to prevent 'forced' update on certain refs by
 making sure that the object name is a commit object that is a
@@ -117,7 +148,8 @@ That is, to enforce a "fast forward only" policy.
 
 It could also be used to log the old..new status.  However, it
 does not know the entire set of branches, so it would end up
-firing one e-mail per ref when used naively, though.
+firing one e-mail per ref when used naively, though.  The
+<<post-receive,'post-receive'>> hook is more suited to that.
 
 Another use suggested on the mailing list is to use this hook to
 implement access control which is finer grained than the one
@@ -127,9 +159,45 @@ The standard output of this hook is sent to `stderr`, so if you
 want to report something to the `git-send-pack` on the other end,
 you can simply `echo` your messages.
 
-The default 'update' hook, when enabled, demonstrates how to
-send out a notification e-mail.
+The default 'update' hook, when enabled--and with
+`hooks.allowunannotated` config option turned on--prevents
+unannotated tags to be pushed.
 
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
+arguments, but for each ref that was updated it receives on standard
+input a line of the format:
+
+  <old-value> SP <new-value> SP <ref-name> NL
+
+on stdin, where `<old-value>` is the old object name stored in the
+ref, `<new-value>` is the new object name to be stored in the ref and
+`<ref-name>` is the full name of the ref.
+
+This hook cannot affect the outcome of `git-receive-pack`, as it's
+called after the real work is done.
+
+This superceedes the [[post-update]] hook in that it actually get's
+both old and new values of all the refs.
+
+The standard output of this hook is sent to `stderr`, so if you
+want to report something to the `git-send-pack` on the other end,
+you can simply `echo` your messages.
+
+The default 'post-receive' hook is empty, but there is
+a script `post-receive-email` provided in the `contrib/hooks`
+directory in git distribution, which implements sending commit
+emails.
+
+[[post-update]]
 post-update
 -----------
 
@@ -146,7 +214,8 @@ the outcome of `git-receive-pack`.
 
 The 'post-update' hook can tell what are the heads that were pushed,
 but it does not know what their original and updated values are,
-so it is a poor place to do log old..new.
+so it is a poor place to do log old..new. See
+<<post-receive,'post-receive'>> hook above for a better one.
 
 When enabled, the default 'post-update' hook runs
 `git-update-server-info` to keep the information used by dumb
@@ -154,6 +223,5 @@ transports (e.g., HTTP) up-to-date.  If you are publishing
 a git repository that is accessible via HTTP, you should
 probably enable this hook.
 
-The standard output of this hook is sent to `/dev/null`; if you
-want to report something to the `git-send-pack` on the other end,
-you can redirect your output to your `stderr`.
+Both standard output and standard error output are forwarded to
+`git-send-pack` on the other end.
-- 
1.5.1.4

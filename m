From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFH] send-pack: fix pipeline.
Date: Fri, 29 Dec 2006 12:13:52 -0800
Message-ID: <7vzm96latb.fsf@assigned-by-dhcp.cox.net>
References: <7v1wmjoumq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Whitcroft <apw@shadowen.org>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri Dec 29 21:13:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1H0O73-00069e-HH
	for gcvg-git@gmane.org; Fri, 29 Dec 2006 21:13:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965129AbWL2UNy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Dec 2006 15:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965140AbWL2UNy
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Dec 2006 15:13:54 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:48214 "EHLO
	fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965129AbWL2UNx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Dec 2006 15:13:53 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061229201353.OVBP9173.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Fri, 29 Dec 2006 15:13:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 4kD71W00V1kojtg0000000; Fri, 29 Dec 2006 15:13:08 -0500
To: git@vger.kernel.org
In-Reply-To: <7v1wmjoumq.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 29 Dec 2006 02:37:33 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35607>

I really need a sanity checking on this one.  I think I got the
botched pipeline fixed with the patch I am replying to, but I do
not understand the waitpid() business.  Care to enlighten me?

-- >8 --

 Documentation/technical/send-pack-pipeline.txt |  112 ++++++++++++++++++++++++
 1 files changed, 112 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/technical/send-pack-pipeline.txt

diff --git a/Documentation/technical/send-pack-pipeline.txt b/Documentation/technical/send-pack-pipeline.txt
new file mode 100644
index 0000000..bd32aff
--- /dev/null
+++ b/Documentation/technical/send-pack-pipeline.txt
@@ -0,0 +1,112 @@
+git-send-pack
+=============
+
+Overall operation
+-----------------
+
+. Connects to the remote side and invokes git-receive-pack.
+
+. Learns what refs the remote has and what commit they point at.
+  Matches them to the refspecs we are pushing.
+
+. Checks if there are non-fast-forwards.  Unlike fetch-pack,
+  the repository send-pack runs in is supposed to be a superset
+  of the recipient in fast-forward cases, so there is no need
+  for want/have exchanges, and fast-forward check can be done
+  locally.  Tell the result to the other end.
+
+. Calls pack_objects() which generates a packfile and sends it
+  over to the other end.
+
+. If the remote side is new enough (v1.1.0 or later), wait for
+  the unpack and hook status from the other end.
+
+. Exit with appropriate error codes.
+
+
+Pack_objects pipeline
+---------------------
+
+This function gets one file descriptor (`out`) which is either a
+socket (over the network) or a pipe (local).  What's written to
+this fd goes to git-receive-pack to be unpacked.
+
+    send-pack ---> fd ---> receive-pack
+
+It somehow forks once, but does not wait for it.  I am not sure
+why.
+
+The forked child calls rev_list_generate() with that file
+descriptor (while the parent closes `out` -- the child will be
+the one that writes the packfile to the other end).
+
+    send-pack
+       |
+       rev-list-generate ---> fd ---> receive-pack
+
+
+Then rev-list-generate forks after creates a pipe; the child
+will become a pipeline "rev-list --stdin | pack-objects", which
+is the rev_list() function, while the parent feeds that pipeline
+the list of refs.
+
+    send-pack
+       |
+       rev-list-generate ---> fd ---> receive-pack
+          | ^ (pipe)
+	  v |
+         rev-list
+
+The child process, before calling rev-list, rearranges the file
+descriptors:
+
+. what it reads from rev-list-generate via pipe becomes the
+  stdin; this is to feed the upstream of the pipeline which will
+  be git-rev-list process.
+
+. what it writes to its stdout goes to the fd connected to
+  receive-pack.
+
+On the other hand, the parent process, before starting to feed
+the child pipeline, closes the reading side of the pipe and fd
+to receive-pack.
+
+    send-pack
+       |
+       rev-list-generate
+          |
+	  v [0]
+         rev-list [1] ---> receive-pack
+
+The parent then writes to the pipe and later closes it.  There
+is a commented out waitpid to wait for the rev-list side before
+it exits, I again do not understand why.
+
+The rev-list function further sets up a pipe and forks to run
+git-rev-list piped to git-pack-objects.  The child side, before
+exec'ing git-pack-objects, rearranges the file descriptors:
+
+. what it reads from the pipe becomes the stdin; this gets the
+  list of objects from the git-rev-list process.
+
+. its stdout is already connected to receive-pack, so what it
+  generates goes there.
+
+The parent process arranges its file descriptors before exec'ing
+git-rev-list:
+
+. its stdout is sent to the pipe to feed git-pack-objects.
+
+. its stdin is already connected to rev-list-generate and will
+  read the set of refs from it.
+
+
+    send-pack
+       |
+       rev-list-generate
+          |
+	  v [0]
+	  git-rev-list [1] ---> [0] git-pack-objects [1] ---> receive-pack
+
+
+

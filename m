From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH, nitpickingly final version] git-branch, git-checkout: autosetup for remote branch tracking
Date: Thu, 08 Mar 2007 13:59:24 -0800
Message-ID: <7vr6rz8khv.fsf@assigned-by-dhcp.cox.net>
References: <45EFB205.4000604@lu.unisi.ch>
	<7vzm6o9ie1.fsf@assigned-by-dhcp.cox.net>
	<45EFDE4B.3010408@lu.unisi.ch>
	<7vabyo9gr6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: bonzini@gnu.org
X-From: git-owner@vger.kernel.org Thu Mar 08 22:59:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPQe7-0000pC-UO
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 22:59:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030714AbXCHV71 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 16:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030719AbXCHV71
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 16:59:27 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:51316 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030714AbXCHV70 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 16:59:26 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070308215925.XYUT1226.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Thu, 8 Mar 2007 16:59:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id YMzQ1W00W1kojtg0000000; Thu, 08 Mar 2007 16:59:25 -0500
In-Reply-To: <7vabyo9gr6.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 08 Mar 2007 02:22:37 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41773>

Junio C Hamano <junkio@cox.net> writes:

> Paolo Bonzini <paolo.bonzini@lu.unisi.ch> writes:
>
>> 	This fixes all the nits you pointed out. :-D
>> 	Now, this was an experience to make...
>
> Thanks.
>
> Will apply after reviewing once more tomorrow, with fix-ups
> locally if needed.  No need to resend.

Gaah.

The new create_branch() is totally borked, and I did not notice
it while exchanging review e-mails.

The problem is that we have:

	if (real_ref == NULL)
        	die();

which is completely bogus.  We do "checkout -b temp v2.6.20~15"
all the time, and in that case dwim_ref(v2.6.20~15) rightfully
would say "nope, that's not a branch tip".  We have no right to
die there.

I think your new tests should have caught this kind of breakage,
but now I notice that there is no such test that makes sure that
no auto set-up is made when the original branch is not a remote
tracking branch (your new tests are only interested in testing
to see if the new feature works, and it does not test that there
is no regression to old usage).  The breakage was caught by an
unrelated test, t3900.

The appended is on top of your "final".  This is what I am
considering to apply currently.


Grumble....

---

diff --git a/builtin-branch.c b/builtin-branch.c
index 011a2fc..1d6f0cb 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -409,7 +409,6 @@ static void set_branch_defaults(const char *name, const char *real_ref)
 }
 
 static void create_branch(const char *name, const char *start_name,
-			  unsigned char *start_sha1,
 			  int force, int reflog, int track)
 {
 	struct ref_lock *lock;
@@ -430,15 +429,22 @@ static void create_branch(const char *name, const char *start_name,
 		forcing = 1;
 	}
 
-	if (start_sha1) {
-		/* detached HEAD */
-		hashcpy(sha1, start_sha1);
+	real_ref = NULL;
+	if (get_sha1(start_name, sha1))
+		die("Not a valid object name: '%s'.", start_name);
+
+	switch (dwim_ref(start_name, strlen(start_name), sha1, &real_ref)) {
+	case 0:
+		/* Not branching from any existing branch */
 		real_ref = NULL;
-	}
-	else if (dwim_ref(start_name, strlen(start_name), sha1, &real_ref) > 1)
+		break;
+	case 1:
+		/* Unique completion -- good */
+		break;
+	default:
 		die("Ambiguous object name: '%s'.", start_name);
-	else if (real_ref == NULL)
-		die("Not a valid object name: '%s'.", start_name);
+		break;
+	}
 
 	if ((commit = lookup_commit_reference(sha1)) == NULL)
 		die("Not a valid branch point: '%s'.", start_name);
@@ -619,12 +625,9 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		rename_branch(head, argv[i], force_rename);
 	else if (rename && (i == argc - 2))
 		rename_branch(argv[i], argv[i + 1], force_rename);
-	else if (i == argc - 1)
-		create_branch(argv[i], head, head_sha1, force_create, reflog,
-			      track);
-	else if (i == argc - 2)
-		create_branch(argv[i], argv[i+1], NULL, force_create, reflog,
-			      track);
+	else if (i == argc - 1 || i == argc - 2)
+		create_branch(argv[i], (i == argc - 2) ? argv[i+1] : head,
+			      force_create, reflog, track);
 	else
 		usage(builtin_branch_usage);
 

From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Replace perl code with pure shell code
Date: Mon, 29 Jan 2007 00:56:15 -0800
Message-ID: <7vtzya8b4g.fsf@assigned-by-dhcp.cox.net>
References: <45BDABB5.4070301@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
X-From: git-owner@vger.kernel.org Mon Jan 29 09:56:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBSJJ-0006Eb-J2
	for gcvg-git@gmane.org; Mon, 29 Jan 2007 09:56:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933276AbXA2I4R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Jan 2007 03:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933277AbXA2I4R
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 03:56:17 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:58481 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933276AbXA2I4Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jan 2007 03:56:16 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070129085616.FYWB29122.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Mon, 29 Jan 2007 03:56:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id GwvH1W0081kojtg0000000; Mon, 29 Jan 2007 03:55:17 -0500
In-Reply-To: <45BDABB5.4070301@fs.ei.tum.de> (Simon Schubert's message of
	"Mon, 29 Jan 2007 09:09:25 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38068>

Simon 'corecode' Schubert <corecode@fs.ei.tum.de> writes:

> Signed-off-by: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
> ...
> diff --git a/git-clone.sh b/git-clone.sh
> index ced7dfb..b3c6fa4 100755
> --- a/git-clone.sh
> +++ b/git-clone.sh
> @@ -66,48 +66,6 @@ Perhaps git-update-server-info needs to be run there?"
> ...
> -open FH, "<", "$git_dir/CLONE_HEAD";
> -while (<FH>) {
> -	my ($sha1, $name) = /^([0-9a-f]{40})\s(.*)$/;
> -	next if ($name =~ /\^\173/);
> -	if ($name eq "HEAD") {
> ...

Thanks.  I like the general direction, but not quite.

You exposed one outstanding bug, which is a hint about what is
not quite right with your patch.

-- >8 --
[PATCH] update-ref: do not accept malformatted refs.

We used to use lock_any_ref_for_update() because the command
needs to also update HEAD (which is not under refs/, so
lock_ref_sha1() cannot be used).  The function however did not
check for refs with illegal characters in them.

Use check_ref_format() to catch malformed refs.  For this check,
we specifically do not want to say having less than two levels
in the name is illegal to allow HEAD (and perhaps other special
refs in the future).

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff --git a/builtin-update-ref.c b/builtin-update-ref.c
index 1461937..5ee960b 100644
--- a/builtin-update-ref.c
+++ b/builtin-update-ref.c
@@ -61,10 +61,8 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 
 	lock = lock_any_ref_for_update(refname, oldval ? oldsha1 : NULL);
 	if (!lock)
-		return 1;
+		die("%s: cannot lock the ref", refname);
 	if (write_ref_sha1(lock, sha1, msg) < 0)
-		return 1;
-
-	/* write_ref_sha1 always unlocks the ref, no need to do it explicitly */
+		die("%s: cannot update the ref", refname);
 	return 0;
 }
diff --git a/refs.c b/refs.c
index 12e46b8..3db444c 100644
--- a/refs.c
+++ b/refs.c
@@ -710,6 +710,8 @@ struct ref_lock *lock_ref_sha1(const char *ref, const unsigned char *old_sha1)
 
 struct ref_lock *lock_any_ref_for_update(const char *ref, const unsigned char *old_sha1)
 {
+	if (check_ref_format(ref) == -1)
+		return NULL;
 	return lock_ref_sha1_basic(ref, old_sha1, NULL);
 }
 

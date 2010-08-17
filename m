From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 21/24] merge script: --ff-only to disallow true merge
Date: Tue, 17 Aug 2010 02:10:17 -0500
Message-ID: <20100817071017.GU22057@burratino>
References: <20100817065147.GA18293@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, Tay Ray Chuan <rctay89@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Clemens Buchacher <drizzd@aon.at>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 17 09:12:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlGL4-0002xP-5z
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 09:12:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752560Ab0HQHL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 03:11:57 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:54666 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995Ab0HQHL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 03:11:56 -0400
Received: by gyg10 with SMTP id 10so2252972gyg.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 00:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=EiYa7+5/be3z7XRuR8kv8rIA4DzENrxlqxRjBlcIZ4c=;
        b=vEQVF8JvoGf2LYiSKIlztzzQ3jbYp+0okfgyoPgV9aasNgiQ51DLqFJkxObf6UlmV7
         b5Yx3Fw+2fEaNZqTfjOp9Z5bTZhdlhjy+vl35woNKGYVnOMYHH58uDTyVjVchM0mj9lH
         DP3+D+ezVTXG/q4Yh1/wh+DrPgk+eatOmoWRY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=OfrFeLRsndt7lIGLkkYcU0OrhlwFgF5uDxql8ZyHtEykVKO0pbulUfuSUE3QB3D/63
         GJsKymglnMMNe5TMHYH8yNWI4uy9jqg8Fo8XWHyQypcaUFdlyDydHPOYwDSu4ShgZpiG
         x8ffMIrouLyZieOO5D8etxAH6NL3sj4AEpV7U=
Received: by 10.100.169.2 with SMTP id r2mr6989341ane.268.1282029112897;
        Tue, 17 Aug 2010 00:11:52 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id t30sm11768012ann.27.2010.08.17.00.11.51
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 00:11:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100817065147.GA18293@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153724>

Port v1.6.6-rc0~62^2 (Teach 'git merge' and 'git pull' the option
--ff-only, 2009-10-29) to the old merge script.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 contrib/examples/git-merge.sh |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/contrib/examples/git-merge.sh b/contrib/examples/git-merge.sh
index 410fa3c..dfd6e17 100755
--- a/contrib/examples/git-merge.sh
+++ b/contrib/examples/git-merge.sh
@@ -15,6 +15,7 @@ log                  add list of one-line log to merge commit message
 squash               create a single commit instead of doing a merge
 commit               perform a commit if the merge succeeds (default)
 ff                   allow fast-forward (default)
+ff-only              abort if fast-forward is not possible
 s,strategy=          merge strategy to use
 X=                   option for selected merge strategy
 m,message=           message to be used for the merge commit (if any)
@@ -45,6 +46,7 @@ use_strategies=
 xopt=
 
 allow_fast_forward=t
+fast_forward_only=
 allow_trivial_merge=t
 squash= no_commit= log_arg=
 
@@ -189,7 +191,13 @@ parse_config () {
 		--no-ff)
 			test "$squash" != t ||
 				die "You cannot combine --squash with --no-ff."
+			test "$fast_forward_only" != t ||
+				die "You cannot combine --ff-only with --no-ff."
 			allow_fast_forward=f ;;
+		--ff-only)
+			test "$allow_fast_forward" != f ||
+				die "You cannot combine --ff-only with --no-ff."
+			fast_forward_only=t ;;
 		-s|--strategy)
 			shift
 			case " $all_strategies " in
@@ -412,8 +420,8 @@ t,1,"$head",*)
 	# We are not doing octopus, not fast-forward, and have only
 	# one common.
 	git update-index --refresh 2>/dev/null
-	case "$allow_trivial_merge" in
-	t)
+	case "$allow_trivial_merge,$fast_forward_only" in
+	t,)
 		# See if it is really trivial.
 		git var GIT_COMMITTER_IDENT >/dev/null || exit
 		echo "Trying really trivial in-index merge..."
@@ -452,6 +460,11 @@ t,1,"$head",*)
 	;;
 esac
 
+if test "$fast_forward_only" = t
+then
+	die "Not possible to fast-forward, aborting."
+fi
+
 # We are going to make a new commit.
 git var GIT_COMMITTER_IDENT >/dev/null || exit
 
-- 
1.7.2.1.544.ga752d.dirty

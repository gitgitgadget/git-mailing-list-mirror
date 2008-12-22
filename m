From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] rebase -i -p: Fix --continue after a merge could
 not be redone
Date: Mon, 22 Dec 2008 22:16:51 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812222215170.30769@pacific.mpi-cbg.de>
References: <1229012461-31377-1-git-send-email-j6t@kdbg.org> <1229335531-32707-1-git-send-email-j6t@kdbg.org> <1229335531-32707-2-git-send-email-j6t@kdbg.org> <alpine.DEB.1.00.0812222139340.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Andreas Ericsson <ae@op5.se>,
	Stephen Haberman <stephen@exigencecorp.com>,
	git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Dec 22 22:12:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEs4P-000141-MW
	for gcvg-git-2@gmane.org; Mon, 22 Dec 2008 22:12:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753847AbYLVVKv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2008 16:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754412AbYLVVKv
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Dec 2008 16:10:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:43065 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751829AbYLVVKu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2008 16:10:50 -0500
Received: (qmail invoked by alias); 22 Dec 2008 21:10:48 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp061) with SMTP; 22 Dec 2008 22:10:48 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19GF3t9F3BGY+qLwAoR7QFugh/e6s+5KmWiPZBx/5
	XdxB3k4ca18v1D
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0812222139340.30769@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.76
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103771>

Hi,

On Mon, 22 Dec 2008, Johannes Schindelin wrote:

> I'll leave the commit message fixing to you, but the --cc patch probably 
> looks something like this -- feel free to squash in:
> 
> ---
> [... a patch ...]

Ooops.  Scratch that.  I tested without running the test suite, and sure 
enough, it failed.  Take that instead.

--

 git-rebase--interactive.sh |   18 +++++++++++++++---
 1 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 89c39eb..f08409c 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -115,9 +115,21 @@ mark_action_done () {
 }
 
 make_patch () {
-	parent_sha1=$(git rev-parse --verify "$1"^) ||
-		die "Cannot get patch for $1^"
-	git diff-tree -p "$parent_sha1".."$1" > "$DOTEST"/patch
+	sha1_and_parents="$(git rev-list --parents -1 $1)"
+	case "$sha1_and_parents" in
+	*' '*' '*' '*)
+		echo "Octopus merge"
+	;;
+	*' '*' '*)
+		git diff --cc $sha1_and_parents
+	;;
+	*' '*)
+		git diff-tree -p $1^!
+	;;
+	*)
+		echo "Root commit"
+	;;
+	esac > "$DOTEST"/patch
 	test -f "$DOTEST"/message ||
 		git cat-file commit "$1" | sed "1,/^$/d" > "$DOTEST"/message
 	test -f "$DOTEST"/author-script ||

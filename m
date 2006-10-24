From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] gitweb: Fix setting $/ in parse_commit()
Date: Tue, 24 Oct 2006 02:39:14 +0200
Message-ID: <20061024003913.21247.70740.stgit@rover>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 24 02:40:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcAK9-0006tt-4k
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 02:39:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbWJXAjQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 20:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbWJXAjQ
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 20:39:16 -0400
Received: from rover.dkm.cz ([62.24.64.27]:33695 "EHLO rover.dkm.cz")
	by vger.kernel.org with ESMTP id S932388AbWJXAjQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Oct 2006 20:39:16 -0400
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id 137B68BC4C;
	Tue, 24 Oct 2006 02:39:14 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29908>

If the commit couldn't have been read, $/ wasn't restored to \n properly,
causing random havoc like git_get_ref_list() returning the ref names with
trailing \n.

Aside of potential confusion in the body of git_search(), no other $/
surprises are hopefully hidden in the code.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 gitweb/gitweb.perl |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 13f04d6..9868485 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1165,12 +1165,11 @@ sub parse_commit {
 	if (defined $commit_text) {
 		@commit_lines = @$commit_text;
 	} else {
-		$/ = "\0";
+		local $/ = "\0";
 		open my $fd, "-|", git_cmd(), "rev-list", "--header", "--parents", "--max-count=1", $commit_id
 			or return;
 		@commit_lines = split '\n', <$fd>;
 		close $fd or return;
-		$/ = "\n";
 		pop @commit_lines;
 	}
 	my $header = shift @commit_lines;

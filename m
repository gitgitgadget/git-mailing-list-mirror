From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: fix memory leak when checking for empty symlinks
Date: Sun, 25 Jan 2009 17:15:51 -0800
Message-ID: <20090126011551.GA8628@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 02:17:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRG6H-0004Xj-61
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 02:17:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbZAZBPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 20:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750880AbZAZBPw
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 20:15:52 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:52891 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750868AbZAZBPw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 20:15:52 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5127D1F602;
	Mon, 26 Jan 2009 01:15:51 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107151>

By enforcing SVN::Pool usage when calling get_file once again.

This regression was introduced with the reintroduction of
SVN::Ra::get_file() usage in
dbc6c74d0858d77e61e092a48d467e725211f8e9

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index d4cb538..5d39b39 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -4021,7 +4021,8 @@ my ($ra_invalid, $can_do_switch, %ignored_err, $RA);
 BEGIN {
 	# enforce temporary pool usage for some simple functions
 	no strict 'refs';
-	for my $f (qw/rev_proplist get_latest_revnum get_uuid get_repos_root/) {
+	for my $f (qw/rev_proplist get_latest_revnum get_uuid get_repos_root
+	              get_file/) {
 		my $SUPER = "SUPER::$f";
 		*$f = sub {
 			my $self = shift;
-- 
Eric Wong

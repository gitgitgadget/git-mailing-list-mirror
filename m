From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 2/2] git svn: fix reparenting when ugly http(s) URLs are
	used
Date: Sun, 19 Jul 2009 22:58:26 -0700
Message-ID: <20090720055826.GB24393@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 20 07:58:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSltS-0006p2-J0
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 07:58:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751657AbZGTF62 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 01:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751766AbZGTF61
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 01:58:27 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:48205 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751020AbZGTF61 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 01:58:27 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 7A7171F585;
	Mon, 20 Jul 2009 05:58:27 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123571>

Mishandling of http(s) in need of escaping was causing
t9118-git-svn-funky-branch-names to fail when SVN_HTTPD_PORT
 was defined.

This bug was exposed in (but not caused by)
commit 0b2af457a49e3b00d47d556d5301934d27909db8
(Fix branch detection when repository root is inaccessible)

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index cfade63..43c86e8 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -4525,10 +4525,12 @@ sub gs_do_switch {
 
 	my $full_url = $self->{url};
 	my $old_url = $full_url;
-	$full_url .= '/' . escape_uri_only($path) if length $path;
+	$full_url .= '/' . $path if length $path;
 	my ($ra, $reparented);
 
-	if ($old_url =~ m#^svn(\+ssh)?://#) {
+	if ($old_url =~ m#^svn(\+ssh)?://# ||
+	    ($full_url =~ m#^https?://# &&
+	     escape_url($full_url) ne $full_url)) {
 		$_[0] = undef;
 		$self = undef;
 		$RA = undef;
-- 
Eric Wong

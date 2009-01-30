From: Yuval Kogman <nothingmuch@woobling.org>
Subject: [PATCH] Don't try to reclose in command_close_bidi_pipe
Date: Fri, 30 Jan 2009 06:59:30 +0200
Message-ID: <1233291570-23295-1-git-send-email-nothingmuch@woobling.org>
Cc: Yuval Kogman <nothingmuch@woobling.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 30 06:00:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSlUx-00076T-A1
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 06:00:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755252AbZA3E7g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 23:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755209AbZA3E7f
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 23:59:35 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:62049 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754928AbZA3E7e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 23:59:34 -0500
Received: by fg-out-1718.google.com with SMTP id 13so200692fge.17
        for <git@vger.kernel.org>; Thu, 29 Jan 2009 20:59:32 -0800 (PST)
Received: by 10.86.92.7 with SMTP id p7mr462632fgb.24.1233291572527;
        Thu, 29 Jan 2009 20:59:32 -0800 (PST)
Received: from syeeda.local (bzq-84-109-225-67.red.bezeqint.net [84.109.225.67])
        by mx.google.com with ESMTPS id 4sm849173fge.55.2009.01.29.20.59.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 Jan 2009 20:59:32 -0800 (PST)
Received: by syeeda.local (Postfix, from userid 501)
	id B3F113150D75; Fri, 30 Jan 2009 06:59:30 +0200 (IST)
X-Mailer: git-send-email 1.6.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107772>

Some commands require their standard input to be closed (like
git-commit-tree). This patch changes command_close_bidi_pipe so no
longer tries to close already closed handles, resulting in an error.
---
 perl/Git.pm |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 7d7f2b1..283bba8 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -422,6 +422,7 @@ sub command_close_bidi_pipe {
 	local $?;
 	my ($pid, $in, $out, $ctx) = @_;
 	foreach my $fh ($in, $out) {
+		next unless defined(fileno($fh));
 		unless (close $fh) {
 			if ($!) {
 				carp "error closing pipe: $!";
-- 
1.6.1

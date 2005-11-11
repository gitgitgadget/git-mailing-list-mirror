From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] archimport: handle pika escaping
Date: Fri, 11 Nov 2005 18:00:57 +1300
Message-ID: <11316852571842-git-send-email-martin@catalyst.net.nz>
Reply-To: Martin Langhoff <martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Fri Nov 11 05:56:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaQxB-0005A9-Oj
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 05:55:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbVKKEzz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 23:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbVKKEzz
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 23:55:55 -0500
Received: from godel.catalyst.net.nz ([202.78.240.40]:49377 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S932352AbVKKEzy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2005 23:55:54 -0500
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=mltest)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1EaQx7-0006nh-3R; Fri, 11 Nov 2005 17:55:53 +1300
Received: from mltest ([127.0.0.1])
	by mltest with smtp (Exim 3.36 #1 (Debian))
	id 1EaR21-0006me-00; Fri, 11 Nov 2005 18:00:57 +1300
In-Reply-To: 
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11556>

Arch uses pika escaping in some places (but not all!). Specifically, commits of
the type 'patch' use pika escaping in the log entries, which we parse to know
what to add/delete and what to commit.

This patch checks for hints of pika escaping and asks tla to unescape for us.

Originally implemented by Penny Leach <penny@catalyst.net.nz>

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>


---

 git-archimport.perl |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

applies-to: 6466c53ae80cddbb581c5fdb2332f9321fade867
b9d1055507ebce7f1ae1706feb79619cb03cf078
diff --git a/git-archimport.perl b/git-archimport.perl
index 980e827..e22c816 100755
--- a/git-archimport.perl
+++ b/git-archimport.perl
@@ -565,6 +565,11 @@ sub parselog {
             next if $t =~ m!\{arch\}/!;
             next if $t =~ m!\.arch-ids/!;
             next if $t =~ m!\.arch-inventory$!;
+           # tla cat-archive-log will give us filenames with spaces as file\(sp)name - why?
+           # we can assume that any filename with \ indicates some pika escaping that we want to get rid of.
+           if  ($t =~ /\\/ ){
+               $t = `tla escape --unescaped '$t'`;
+           }
             push (@tmp, shell_quote($t));
         }
         @$ref = @tmp;
---
0.99.8.GIT

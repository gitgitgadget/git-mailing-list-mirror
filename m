From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: [PATCH 3/3] gitweb: remove test when closing file descriptor
Date: Mon, 20 Dec 2010 20:01:21 +0100
Message-ID: <1292871681-4818-4-git-send-email-sylvain@abstraction.fr>
References: <1292871681-4818-1-git-send-email-sylvain@abstraction.fr>
Cc: Sylvain Rabot <sylvain@abstraction.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 20 20:01:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUkzK-0007Tv-Qx
	for gcvg-git-2@lo.gmane.org; Mon, 20 Dec 2010 20:01:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932833Ab0LTTBg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Dec 2010 14:01:36 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40065 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932694Ab0LTTBe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Dec 2010 14:01:34 -0500
Received: by mail-wy0-f174.google.com with SMTP id 28so3175777wyb.19
        for <git@vger.kernel.org>; Mon, 20 Dec 2010 11:01:34 -0800 (PST)
Received: by 10.216.20.141 with SMTP id p13mr8282289wep.102.1292871693962;
        Mon, 20 Dec 2010 11:01:33 -0800 (PST)
Received: from localhost.localdomain (85-168-197-251.rev.numericable.fr [85.168.197.251])
        by mx.google.com with ESMTPS id n1sm2038948weq.31.2010.12.20.11.01.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Dec 2010 11:01:33 -0800 (PST)
X-Mailer: git-send-email 1.7.3.4.523.g72f0d.dirty
In-Reply-To: <1292871681-4818-1-git-send-email-sylvain@abstraction.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164005>

it happens that closing file descriptor fails whereas
the blob is perfectly readable. According to perlman
the reasons could be:

   If the file handle came from a piped open, "close" will additionally
   return false if one of the other system calls involved fails, or if the
   program exits with non-zero status.  (If the only problem was that the
   program exited non-zero, $! will be set to 0.)  Closing a pipe also waits
   for the process executing on the pipe to complete, in case you want to
   look at the output of the pipe afterwards, and implicitly puts the exit
   status value of that command into $?.

   Prematurely closing the read end of a pipe (i.e. before the process writ-
   ing to it at the other end has closed it) will result in a SIGPIPE being
   delivered to the writer.  If the other end can't handle that, be sure to
   read all the data before closing the pipe.

In this case we don't mind that close fails.

Signed-off-by: Sylvain Rabot <sylvain@abstraction.fr>
---
 gitweb/gitweb.perl |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c460f27..8f0d00e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3450,8 +3450,7 @@ sub run_highlighter {
 	my ($fd, $highlight, $syntax) = @_;
 	return $fd unless ($highlight && defined $syntax);
 
-	close $fd
-		or die_error(404, "Reading blob failed");
+	close $fd;
 	open $fd, quote_command(git_cmd(), "cat-file", "blob", $hash)." | ".
 	          quote_command($highlight_bin).
 	          " --xhtml --fragment --syntax $syntax |"
-- 
1.7.3.4.523.g72f0d.dirty

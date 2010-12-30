From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: [PATCH 2/4] gitweb: remove unnecessary test when closing file descriptor
Date: Thu, 30 Dec 2010 22:20:29 +0100
Message-ID: <1293744031-17790-3-git-send-email-sylvain@abstraction.fr>
References: <1293744031-17790-1-git-send-email-sylvain@abstraction.fr>
Cc: Sylvain Rabot <sylvain@abstraction.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 30 22:20:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PYPvS-0007rf-EC
	for gcvg-git-2@lo.gmane.org; Thu, 30 Dec 2010 22:20:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755353Ab0L3VUo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Dec 2010 16:20:44 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45988 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131Ab0L3VUm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Dec 2010 16:20:42 -0500
Received: by wyb28 with SMTP id 28so11326108wyb.19
        for <git@vger.kernel.org>; Thu, 30 Dec 2010 13:20:41 -0800 (PST)
Received: by 10.227.32.137 with SMTP id c9mr9927049wbd.208.1293744040964;
        Thu, 30 Dec 2010 13:20:40 -0800 (PST)
Received: from localhost.localdomain (85-168-197-251.rev.numericable.fr [85.168.197.251])
        by mx.google.com with ESMTPS id m10sm11283348wbc.16.2010.12.30.13.20.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 30 Dec 2010 13:20:40 -0800 (PST)
X-Mailer: git-send-email 1.7.3.4.523.g72f0d.dirty
In-Reply-To: <1293744031-17790-1-git-send-email-sylvain@abstraction.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164366>

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
index ea984b9..eae75ac 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3465,8 +3465,7 @@ sub run_highlighter {
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

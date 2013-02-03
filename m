From: Alexandre Courbot <gnurou@gmail.com>
Subject: [PATCH] send-email: ignore files ending with ~
Date: Sun,  3 Feb 2013 23:55:40 +0900
Message-ID: <1359903340-14508-1-git-send-email-gnurou@gmail.com>
Cc: git@vger.kernel.org, Alexandre Courbot <gnurou@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 15:54:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U20xN-00009d-O9
	for gcvg-git-2@plane.gmane.org; Sun, 03 Feb 2013 15:54:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752876Ab3BCOxr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2013 09:53:47 -0500
Received: from mail-da0-f44.google.com ([209.85.210.44]:33266 "EHLO
	mail-da0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944Ab3BCOxq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2013 09:53:46 -0500
Received: by mail-da0-f44.google.com with SMTP id z20so2331029dae.17
        for <git@vger.kernel.org>; Sun, 03 Feb 2013 06:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=ELGWruhqco8lWwA/IggI0hx5a+5S9wJfps7qQ8HLCRI=;
        b=xPGEDLJcwYW972/YnIYuihXPXWRITfOQlo/baKAfd+3FjsnASDZkMCmdCBGlLWvqPR
         c6c13jmdOhigU76kX6as97/OPnrULPtplZ+6N6sT2QZgAj12sEnxn3P65aiYVnDdtA3J
         PqNujjsCZ+2Rb9j6OOoEFBXei6ZGdb3eZiU/WqD5p+6UnidO0mzC5eB2FqPuaoPg0rNG
         YSlMMaZCLx9LhJHvolKlF390W8O5EVrKlPWSojZ4Vi2MF7xqkTGojf+B8h7D7LCefbYu
         hoYWwerfxl7rqVuayKEhYskMJ2Ln9LfjUoGdoq6i/lJRvnRmfqPIlWyUvLwbvZqu+7Yx
         UiRw==
X-Received: by 10.68.193.199 with SMTP id hq7mr47334329pbc.3.1359903225387;
        Sun, 03 Feb 2013 06:53:45 -0800 (PST)
Received: from localhost.localdomain (softbank126010191003.bbtec.net. [126.10.191.3])
        by mx.google.com with ESMTPS id wh4sm14907937pbc.18.2013.02.03.06.53.42
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 03 Feb 2013 06:53:43 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215314>

It certainly happened to a lot of people already: you carefully prepare
your set of patches, export them using format-patch --cover-letter,
write your cover letter, and send the set like this:

$ git send-email --to=somerenowneddeveloper --to=myfutureemployer
  --cc=thismailinglistiwanttoimpress 00*

And of course since you think you know what you are doing, you just
answer 'a' at the first prompt to send all emails at once.

The next day, all these people are laughing at you because the editor
you used to write your cover letter saved a backup of the previous
version and they received two versions of it, including one containing
the familiar *** BLURB HERE *** (or potentially more humiliating stuff
if you used the buffer as a temporary scratch).

Let's save people's reputations by ignoring files ending with '~' in
send-email. There should be no reason to send such a file anyways.

Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
---
 git-send-email.perl | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index be809e5..4cc5855 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -548,7 +548,10 @@ while (defined(my $f = shift @ARGV)) {
 				sort readdir $dh;
 		closedir $dh;
 	} elsif ((-f $f or -p $f) and !check_file_rev_conflict($f)) {
-		push @files, $f;
+		# Ignore backup files
+		if ($f !~ "~\$") {
+			push @files, $f;
+		}
 	} else {
 		push @rev_list_opts, $f;
 	}
-- 
1.8.1.1

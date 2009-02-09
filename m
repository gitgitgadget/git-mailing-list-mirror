From: Deskin Miller <deskinm@umich.edu>
Subject: [PATCH v2] git-svn: Print revision while searching for earliest use of path
Date: Sun,  8 Feb 2009 19:33:18 -0500
Message-ID: <1234139598-13703-1-git-send-email-deskinm@umich.edu>
References: <86d4c5e00902050542n74b10bfdw5e9249ac23fdc9e7@mail.gmail.com>
Cc: gitster@pobox.com, git@vger.kernel.org,
	Deskin Miller <deskinm@umich.edu>
To: normalperson@yhbt.net
X-From: git-owner@vger.kernel.org Mon Feb 09 01:35:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWK6v-0003CE-I3
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 01:34:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753556AbZBIAd1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 19:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753508AbZBIAd1
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 19:33:27 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:24715 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753502AbZBIAd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 19:33:26 -0500
Received: by yx-out-2324.google.com with SMTP id 8so635029yxm.1
        for <git@vger.kernel.org>; Sun, 08 Feb 2009 16:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=IplrJavCODGBdGfKdKuN0Z7d/pXtRMKSUz6/JKakSr4=;
        b=BPuiF6U5yMkbf5rpE/rcAUy4BbTAsY3dD58s7Q4aaZb7UqbAJjLBVNEUNs16M2BMX2
         Lb9LSCwPy6gykygKQ0uB7cdHWcHMGARGH02wWi7kBjv5OFppC2CJQLuYQj8l3yLbit8E
         4siZGuZfdtS11ae7363m9gXLi6WwdH63sC3kA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=RFaIDN6up9bb46At2QGqz9YsAWZzU1HqLSULrIP4lupRnvV+wBirJRmDBEpbKTq/j8
         m0jUK/FpfcG763fbcDOKywsMLDsby/P15TolmO2Z1dcxcQIG3htOsFjsBDGJHNmrjjSE
         J1ErCvgINzPQ+qG64SL2t0XjUUeXQHtkrgUp4=
Received: by 10.64.180.5 with SMTP id c5mr1323592qbf.39.1234139604739;
        Sun, 08 Feb 2009 16:33:24 -0800 (PST)
Received: from localhost.localdomain ([68.40.49.130])
        by mx.google.com with ESMTPS id 27sm6493045qbw.19.2009.02.08.16.33.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 08 Feb 2009 16:33:23 -0800 (PST)
X-Mailer: git-send-email 1.6.1.399.g0d272
In-Reply-To: <86d4c5e00902050542n74b10bfdw5e9249ac23fdc9e7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109028>

When initializing a git-svn repository from a Subversion repoository,
it is common to be interested in a path which did not exist in the
initial commit to Subversion.  In a large repository, the initial fetch
may take some looking for the earliest existence of the path time while
the user receives no additional feedback.  Print the highest revision
number scanned thus far to let the user know something is still
happening.

Signed-off-by: Deskin Miller <deskinm@umich.edu>
---
I'd never looked closely enough at gs_fetch_loop_common to grok what was
going on, and my previous experience with svn's get_log led me to think
that git-svn would slurp up log info for all commits at once.  Silly of
me.

Eric, things are much cleaner doing as you suggest.  I added a
carriage-return at the end of the message because I like it that way,
and the line will be overwritten once it actually starts fetching data
from svn.  I don't feel strongly about it though, so if it's better to
make it a newline, please feel free to change it and apply.

Deskin Miller

 git-svn.perl |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 79888a0..601e2a3 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -4348,6 +4348,9 @@ sub gs_fetch_loop_common {
 		}
 		$self->get_log([$longest_path], $min, $max, 0, 1, 1,
 		               sub { $revs{$_[1]} = _cb(@_) });
+		if ($err) {
+			print "Checked through r$max\r";
+		}
 		if ($err && $max >= $head) {
 			print STDERR "Path '$longest_path' ",
 				     "was probably deleted:\n",
-- 
1.6.1.399.g0d272

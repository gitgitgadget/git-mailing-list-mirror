From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH 1/2 v2] Add a basic idea section for git-blame.
Date: Sat, 10 Apr 2010 18:15:29 +0800
Message-ID: <1270894530-6486-2-git-send-email-struggleyb.nku@gmail.com>
References: <1270894530-6486-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 10 12:16:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0XjN-0001PU-9M
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 12:16:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733Ab0DJKP5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 06:15:57 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:48933 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248Ab0DJKPo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 06:15:44 -0400
Received: by mail-vw0-f46.google.com with SMTP id 18so416067vws.19
        for <git@vger.kernel.org>; Sat, 10 Apr 2010 03:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=4g3GbMwjXHHt1/wFhP3nmP29KWnc8OCBmW5BoYWTWzI=;
        b=raVJQBVmmesl2mx4FF9UyGWjiItJAuKzDnd5jNTJ/S7x0YMmKg5ozoMKUysWj9I9wv
         0gxKv59hJWTPRaOKZvYsoe7H0IybRZW82tT6BlZKrjvkbNCuSOd3yJeXzsFAjEEU0BYf
         3PPUJ0JKiLdjwGJO2X7yZzl5ShHo74vnnH6hc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HqIjpDSGtuGMjx4pTXMu7kz1VPtnnrOtyY6sPeCvsfGvKzhy2Y/4SyOVPRICskV9vo
         XLw2xH4Srinoz4aqwWWqccs+yS+hwB5fExtUN/A9ZZ/LeXbibJ/eYlcNHfabOXPmlNRP
         hprX54PoAlAtZe0qkdAfQjwUbY1TylKXCa/PU=
Received: by 10.220.108.34 with SMTP id d34mr666420vcp.130.1270894543998;
        Sat, 10 Apr 2010 03:15:43 -0700 (PDT)
Received: from localhost.localdomain ([117.15.72.219])
        by mx.google.com with ESMTPS id 25sm46893343vws.1.2010.04.10.03.15.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Apr 2010 03:15:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.2.273.gc2413.dirty
In-Reply-To: <1270894530-6486-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144538>

Explain the basic idea about blame shifting with
'-M' or '-C' given.

Thanks-to: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 Documentation/git-blame.txt |   35 ++++++++++++++++++++++++++++++++++-
 1 files changed, 34 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index a27f439..3378665 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git blame' [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-p] [-w] [--incremental] [-L n,m]
-	    [-S <revs-file>] [-M] [-C] [-C] [-C] [--since=<date>]
+	    [-S <revs-file>] [-M|<num>|] [-C|<num>|] [-C|<num>|] [-C|<num>|] [--since=<date>]
 	    [<rev> | --contents <file> | --reverse <rev>] [--] <file>
 
 DESCRIPTION
@@ -36,6 +36,39 @@ $ git log --pretty=oneline -S'blame_usage'
 ea4c7f9bf69e781dd0cd88d2bccb2bf5cc15c9a7 git-blame: Make the output
 -----------------------------------------------------------------------------
 
+
+BASIC IDEA
+----------
+
+This section briefly explains the basic idea behind 'git-blame'.  You
+do not have to understand it to use git-blame, but it helps in
+understanding the `-M` and `-C` options.  For the sake of simplicity,
+we assume that history is linear.
+
+A call to `git-blame <rev> -- <file>` works as follows:
+
+- Assume all the lines' blame to <rev> initially.
+
+- Run git diff <rev>^ <rev> and ignore all +/- lines. The unchanged
+  lines are definitely from our parent, so pass the blame of the
+  unchanged lines to parent.
+
+- For the +/- lines, take the blame if there are no `-M` or `-C`
+  options given. 
+
+- Repeat step 2~3 for all the remain lines which does not find
+  a blame until all lines find its blame.
+
+If there are `-M` or `-C` given, the command will try to search for
+same code of current lines and pass blame to it.
+
+With `-M`, this command detects same lines of the current blaming code
+inside the current file. And it will shift the blame to the author of
+the original lines instead of author of current blaming code. It does
+the same for `-C` except that it will search across file boundary and
+multiple commits.
+
+
 OPTIONS
 -------
 include::blame-options.txt[]
-- 
1.7.0.2.273.gc2413.dirty

From: Luke Lee <luke.yx.lee@gmail.com>
Subject: Fix a critical bug in git-cvsexportcommit.perl
Date: Wed, 24 Sep 2014 16:32:16 +0800
Message-ID: <wq8tquzz.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 24 10:32:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWhzv-0000WG-C1
	for gcvg-git-2@plane.gmane.org; Wed, 24 Sep 2014 10:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753698AbaIXIcX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2014 04:32:23 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:64906 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434AbaIXIcU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2014 04:32:20 -0400
Received: by mail-pd0-f174.google.com with SMTP id g10so7637850pdj.19
        for <git@vger.kernel.org>; Wed, 24 Sep 2014 01:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:user-agent:mime-version
         :content-type;
        bh=8f3s988tJpv+44d7wWoTP3i6vJqvd4fcgVvXXaCI9Uo=;
        b=mrsYdVYf/E7mST6NlKUkjIVrYUJRY22M+8pWjGeX+Nuh3R7ivXPvSMTGF+fey+Qma5
         Izb9lYm/+ipQ4DJrI6VLEnxIl2BRTRZgKWf9kfnQsOeAYIzkt7UkYLmuL8pX1tKBVjtH
         ayEsdoHDAjrTGtfPbXaIGPKG+bhMdmyOomF3NGX8rjJxewzg0WKm1S6llwYCuiwagQ16
         zHTWxE56A7DBboyfUadWmvY7HTsFk/jKxhKeXo83ThP9DlLEE9M9PlsWryQXRMttkOxb
         cZvMi2Yjdp8vLD7wrCjFk+1AY5vAieS7Qdsm5OWMsvDIizfPVUKGOL/9wM+fAp5xd0Mi
         a5Cw==
X-Received: by 10.70.10.100 with SMTP id h4mr9271407pdb.162.1411547540075;
        Wed, 24 Sep 2014 01:32:20 -0700 (PDT)
Received: from tw-fw-dt-1 (59-120-45-147.HINET-IP.hinet.net. [59.120.45.147])
        by mx.google.com with ESMTPSA id f2sm14119907pdo.29.2014.09.24.01.32.19
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 24 Sep 2014 01:32:19 -0700 (PDT)
User-Agent: Gnus/5.130012 (Ma Gnus v0.12) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257453>

I fixed a long standing bug in git-cvsexportcommit.perl script which
corrupt my Perl code several times. This time I figure it out. It's
about keyword expansion. Take a simple example, a Perl code like this:

    printf "Perl/Tk $Tk::Version ($Tk::platform)\n";

will be incorrectly unexpand by git-cvsexportcommit.perl to:

    printf "Perl/Tk $Tk$Tk::platform)\n";

This happens when I try to export a git commit to a CVS working
directory *with keyword expansion turned off*. git-cvsexportcommit will
try to simulate what CVS does on unexpanding keywords. However, it *DOES
NOT* realize only valid keywords should be unexpanded. Please help apply
this patch.

Thanks.
Luke Lee

>From a33096156e376924d3a7ac2b5a42877f9aedee58 Mon Sep 17 00:00:00 2001
From: Luke Lee <luke.yx.lee@gmail.com>
Date: Wed, 24 Sep 2014 14:38:17 +0800
Subject: [PATCH] Fix a critical bug in git-cvsexportcommit.perl about
 unexpanding keywords which incorrectly delete codes that are not expanded
 keywords.

---
 git-cvsexportcommit.perl | 2 +-
 1 file changed, 1 insertions(+), 1 deletion(-)

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index d13f02d..bf41a72 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -309,7 +309,8 @@ foreach my $f (@files) {
 	while (<FILTER_IN>)
 	{
 	    my $line = $_;
-	    $line =~ s/\$([A-Z][a-z]+):[^\$]+\$/\$$1\$/g;
+	    $line =~ s/\$(Author|Date|Header|Id|Locker|Log|RCSfile|Revision|Source|State):[^:\$][^\$]+\$/\$$1\$/g;
 	    print FILTER_OUT $line;
 	}
 	close FILTER_IN;
--
2.1.1.303.ga330961.dirty

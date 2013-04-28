From: Ilya Basin <basinilya@gmail.com>
Subject: [PATCH 2/2] git-svn: fix svn fetch erroneously recreating empty dir placeholder deleted earlier
Date: Sun, 28 Apr 2013 12:35:41 +0400
Message-ID: <1611408441.20130428123541@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 8bit
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 28 10:37:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWN75-0007j7-Rp
	for gcvg-git-2@plane.gmane.org; Sun, 28 Apr 2013 10:37:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751888Ab3D1Ihb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Apr 2013 04:37:31 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:44607 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779Ab3D1IhU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Apr 2013 04:37:20 -0400
Received: by mail-lb0-f169.google.com with SMTP id z5so165448lbh.14
        for <git@vger.kernel.org>; Sun, 28 Apr 2013 01:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:x-mailer:x-priority:message-id:to:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=DY4m2lDHyrqJCwCBd0zJ/rckpcMNmwXtRrInl7stGRg=;
        b=rFfJg6wJQx0iz1X0IsUXzCNln89265fCrT1X1MdimTCs0yRX6BXYb9fqY2b4DPJ3BE
         rD9rFAr4otOaLELLp4dtnyVtycIayn8P1UgwwiGOvskSXglVdr9KInIskD8i6Snmcmvx
         J+t5JxXvsNoeg5z/Fk4vpcJjBwPzJT+6+DN0p7HWvNhEUAaj3z12xZgs7XhxRVZTG0qb
         TT+JT4hfmE3aqdK3/cLnWTdtFlBE0mU2ND7Q+ZnS9RnMi3Q62Tsxmw8g09HZ/EGMsuZ5
         1h+gV7qlNJ9FoENLJ9FeKIoQYZRTOIpZtlafE52BoF1vNCWgt+Pc4fEfG97Q2I5LoCz6
         8uPA==
X-Received: by 10.112.219.197 with SMTP id pq5mr24821739lbc.102.1367138238533;
        Sun, 28 Apr 2013 01:37:18 -0700 (PDT)
Received: from [192.168.0.78] (92-100-235-219.dynamic.avangarddsl.ru. [92.100.235.219])
        by mx.google.com with ESMTPSA id y3sm1093549lby.12.2013.04.28.01.37.17
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 28 Apr 2013 01:37:17 -0700 (PDT)
X-Mailer: Voyager (v3.99.4) Professional
X-Priority: 3 (Normal)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222731>

The Fetcher accumulates deleted paths in an array and doesn't reset the
array on next commit. This causes different results when interrupting
and resuming the fetch.
When --preserve-empty-dirs flag is used, a path in the array can be
erroneously treated as just deleted, although it was deleted in the
previous commit and cause the creation of an empty dir placeholder.

Test script:

    (
    set -e

    rm -rf testrepo.svn testrepo.gitsvn
    svnadmin create testrepo.svn
    url=file://`pwd`/testrepo.svn

    rm -rf testrepo
    svn co "$url" testrepo
    cd testrepo

    mkdir -p foo/bar
    echo aaa > foo/bar/fil.txt
    svn add foo
    svn commit -mx

    svn rm -mx "$url/foo/bar/fil.txt"
    svn rm -mx "$url/foo/bar"

    echo aaa > fil.txt
    svn add fil.txt
    svn commit -mx

    cd ..

    rm -rf testrepo.gitsvn && git svn clone --preserve-empty-dirs "$url" testrepo.gitsvn

    if [ -e testrepo.gitsvn/foo/bar/.gitignore ]; then
      echo "error: testrepo.gitsvn/foo/bar/.gitignore exists"
      false
    fi
    )
---
 perl/Git/SVN/Fetcher.pm | 1 +
 1 file changed, 1 insertion(+)

diff --git a/perl/Git/SVN/Fetcher.pm b/perl/Git/SVN/Fetcher.pm
index 4f96076..e658889 100644
--- a/perl/Git/SVN/Fetcher.pm
+++ b/perl/Git/SVN/Fetcher.pm
@@ -19,6 +19,7 @@ sub new {
 	my ($class, $git_svn, $switch_path) = @_;
 	my $self = SVN::Delta::Editor->new;
 	bless $self, $class;
+	@deleted_gpath = ();
 	if (exists $git_svn->{last_commit}) {
 		$self->{c} = $git_svn->{last_commit};
 		$self->{empty_symlinks} =
-- 
1.8.1.5

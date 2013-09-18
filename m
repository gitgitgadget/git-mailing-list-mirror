From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] contacts: fix to work in subdirectories
Date: Tue, 17 Sep 2013 22:52:05 -0400
Message-ID: <1379472725-1038-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 18 04:52:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VM7sm-0000N7-Ff
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 04:52:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388Ab3IRCwg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 22:52:36 -0400
Received: from mail-qe0-f45.google.com ([209.85.128.45]:45766 "EHLO
	mail-qe0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020Ab3IRCwf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 22:52:35 -0400
Received: by mail-qe0-f45.google.com with SMTP id 6so4394205qea.32
        for <git@vger.kernel.org>; Tue, 17 Sep 2013 19:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=ccitGYMTIpYbMpolg+GhB4GMmZ4UlZpQZKvPwx14Uqk=;
        b=N+AfXI+XS3Ret2+ZzQ8x0Gpc+LZpQxbAWfOECXdTvW7NsTVlj5+RrPaRoWPwb5v0RO
         fX5CB7urldibiN10VfFu3hAarZpzbpG1kLFxnITAKLhKZuKNfDlhqdzbzaaqn9pX6FZv
         2Z0u06i9+iVWXa9ZQpGo/ZtE5N2sXUvx7aGdUDl6UVEDv4RW9chWQhYl5iChImFHIUt2
         4PRkJKWjSs6JYDAOTo6XCBotlGpqjM0b1Kmm+HT01Dl8eamAC11CGX2Xzrz9So5sWv28
         3jM8o9iMggeUnbh96bR69ela6lMN79cKlKx8pHafaT2DdJ8bTcesOPhDs8oyBAZsqYfx
         BQGA==
X-Received: by 10.49.107.226 with SMTP id hf2mr57490584qeb.17.1379472753001;
        Tue, 17 Sep 2013 19:52:33 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dr8.cable.mindspring.com. [69.81.183.104])
        by mx.google.com with ESMTPSA id a7sm60453428qew.2.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 17 Sep 2013 19:52:32 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.535.g7b94f8e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234948>

Unlike other git commands which work correctly at the top-level or in a
subdirectory, git-contacts fails when invoked in a subdirectory. This is
because it invokes git-blame with pathnames relative to the top-level,
but git-blame interprets the pathnames as relative to the current
directory. Fix this.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

git-contacts (in Perl) was born from Felipe's git-related v9 [1]
Ruby script. That version did not handle invocation from within
subdirectories, however, an earlier version (v5) of his script [2] did,
and it was my intention all along to add such support, but I forgot
after being sidetracked adding the git-check-mailmap command and
git-blame multiple -L support (plus several bug fixes in existing -L
support).

Thanks to Thomas Gummerer for reminding me about this in the form of a
patch [3]. The current patch is intended to be a bit more efficient than
Thomas'.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/226065
[2]: http://article.gmane.org/gmane.comp.version-control.git/224783
[3]: http://thread.gmane.org/gmane.comp.version-control.git/234877

 contrib/contacts/git-contacts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/contacts/git-contacts b/contrib/contacts/git-contacts
index fb6429b..428cc1a 100755
--- a/contrib/contacts/git-contacts
+++ b/contrib/contacts/git-contacts
@@ -181,6 +181,10 @@ if (@rev_args) {
 	scan_rev_args(\%sources, \@rev_args)
 }
 
+my $toplevel = `git rev-parse --show-toplevel`;
+chomp $toplevel;
+chdir($toplevel) or die "chdir failure: $toplevel: $!\n";
+
 my %commits;
 blame_sources(\%sources, \%commits);
 import_commits(\%commits);
-- 
1.8.4.535.g7b94f8e

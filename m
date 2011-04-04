From: =?UTF-8?q?Alejandro=20R=2E=20Sede=C3=B1o?= <asedeno@mit.edu>
Subject: [PATCH 2/2] git-svn: Cache results of running the executable "git config"
Date: Mon,  4 Apr 2011 15:09:08 -0400
Message-ID: <1301944148-7950-3-git-send-email-asedeno@mit.edu>
References: <1301944148-7950-1-git-send-email-asedeno@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: James Y Knight <jknight@itasoftware.com>,
	=?UTF-8?q?Alejandro=20R=2E=20Sede=C3=B1o?= <asedeno@mit.edu>
To: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Apr 04 21:09:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6p9Z-0003Bi-SU
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 21:09:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755307Ab1DDTJ0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Apr 2011 15:09:26 -0400
Received: from mx2.itasoftware.com ([63.115.78.21]:57816 "EHLO
	mx2.itasoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755229Ab1DDTJZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 15:09:25 -0400
Received: from ita4mta2.internal.itasoftware.com (ita4mta2.internal.itasoftware.com [10.4.52.168])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.itasoftware.com (Postfix) with ESMTP id 1425B57D43;
	Mon,  4 Apr 2011 15:10:59 -0400 (EDT)
Received: from asedeno.corp.itasoftware.com (lb1.dc4nat153.dc4.internal.itasoftware.com [10.4.199.153])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ita4mta2.internal.itasoftware.com (Postfix) with ESMTPS id ECD9F19D803C;
	Mon,  4 Apr 2011 15:09:10 -0400 (EDT)
Received: from asedeno by asedeno.corp.itasoftware.com with local (Exim 4.74)
	(envelope-from <asedeno@asedeno.corp.itasoftware.com>)
	id 1Q6p9C-0004CH-TC; Mon, 04 Apr 2011 15:09:10 -0400
X-Mailer: git-send-email 1.7.4.2.1.gd6f1f
In-Reply-To: <1301944148-7950-1-git-send-email-asedeno@mit.edu>
X-ITASoftware-MailScanner: Found to be clean
X-ITASoftware-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-1, required 3, ALL_TRUSTED -1.00)
X-ITASoftware-MailScanner-From: asedeno@itasoftware.com
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170837>

=46rom: James Y Knight <jknight@itasoftware.com>

Running programs is not cheap!

Signed-off-by: James Y Knight <jknight@itasoftware.com>
Signed-off-by: Alejandro R. Sede=C3=B1o <asedeno@mit.edu>
---
 git-svn.perl |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index aa41896..e47e04c 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -59,6 +59,7 @@ use File::Find;
 use Getopt::Long qw/:config gnu_getopt no_ignore_case auto_abbrev/;
 use IPC::Open3;
 use Git;
+use Memoize;  # core since 5.8.0, Jul 2002
=20
 BEGIN {
 	# import functions from Git into our packages, en masse
@@ -72,6 +73,8 @@ BEGIN {
 			*{"${package}::$_"} =3D \&{"Git::$_"};
 		}
 	}
+	Memoize::memoize 'Git::config';
+	Memoize::memoize 'Git::config_bool';
 }
=20
 my ($SVN);
@@ -3199,6 +3202,8 @@ sub has_no_changes {
 		Memoize::unmemoize 'check_cherry_pick';
 		Memoize::unmemoize 'has_no_changes';
 	}
+
+	Memoize::memoize 'Git::SVN::repos_root';
 }
=20
 END {
--=20
1.7.4.2.1.gd6f1f

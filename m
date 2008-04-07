From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn: regression with funny chars in svn repo url
Date: Mon, 7 Apr 2008 01:11:08 -0700
Message-ID: <20080407081108.GA28853@soma>
References: <d06901f0804011111o1da8a197ob6a9aaccb3e1e9a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Panagiotis Vossos <pavossos@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 10:12:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JimSP-0001yC-Eh
	for gcvg-git-2@gmane.org; Mon, 07 Apr 2008 10:12:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753851AbYDGILR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2008 04:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752891AbYDGILQ
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Apr 2008 04:11:16 -0400
Received: from hand.yhbt.net ([66.150.188.102]:44607 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752776AbYDGILQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2008 04:11:16 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id C18CB7F41D7;
	Mon,  7 Apr 2008 01:11:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <d06901f0804011111o1da8a197ob6a9aaccb3e1e9a0@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78961>

Panagiotis Vossos <pavossos@gmail.com> wrote:
> I keep a copy of the gtk+ svn repository on my machine and I have
> noticed the following bug with git-svn:
> 
> ~/gitproj/gtk+$ which git-svn
> /usr/local/bin/git-svn
> 
> ~/gitproj/gtk+$ ls -l /usr/local/bin/git-svn
> lrwxrwxrwx 1 root staff 39 2008-03-30 07:45 /usr/local/bin/git-svn ->
> ../encap/git-1.5.4_20080328/bin/git-svn
> 
> ~/gitproj/gtk+$ git-svn --version
> git-svn version 1.5.4.5 (svn 1.4.6)
> 
> ~/gitproj/gtk+$ git-svn rebase
> Apache got a malformed URI: REPORT request failed on
> '/svn/gtk+/!svn/vcc/default': Unusable URI: it does not refer to this
> repository at /usr/local/bin/git-svn line 3821

I've known of this bug for a while but didn't track it down until
now.  Please let me know if this fixes things for you and if
there are any regressions; thanks.

>From a9ebe54adf7ae2620fba1f638dee9566f8ccca82 Mon Sep 17 00:00:00 2001
From: Eric Wong <normalperson@yhbt.net>
Date: Mon, 7 Apr 2008 00:41:44 -0700
Subject: [PATCH] git-svn: fix cloning of HTTP URLs with '+' in their path

With this, git svn clone -s http://svn.gnome.org/svn/gtk+
is successful.

Also modified the funky rename test for this, which _does_
include escaped '+' signs for HTTP URLs.  SVN seems to accept
either "+" or "%2B" in filenames and directories (just not the
main URL), so I'll leave it alone for now.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl                             |    2 +-
 t/t9115-git-svn-dcommit-funky-renames.sh |   10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 81afb5c..d91ef7a 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3666,7 +3666,7 @@ sub escape_uri_only {
 	my ($uri) = @_;
 	my @tmp;
 	foreach (split m{/}, $uri) {
-		s/([^\w.%-]|%(?![a-fA-F0-9]{2}))/sprintf("%%%02X",ord($1))/eg;
+		s/([^\w.%+-]|%(?![a-fA-F0-9]{2}))/sprintf("%%%02X",ord($1))/eg;
 		push @tmp, $_;
 	}
 	join('/', @tmp);
diff --git a/t/t9115-git-svn-dcommit-funky-renames.sh b/t/t9115-git-svn-dcommit-funky-renames.sh
index 182299c..835b1dc 100755
--- a/t/t9115-git-svn-dcommit-funky-renames.sh
+++ b/t/t9115-git-svn-dcommit-funky-renames.sh
@@ -49,6 +49,16 @@ test_expect_success 'rename pretty file into ugly one' '
 	git svn dcommit
 	'
 
+test_expect_success 'add a file with plus signs' '
+	echo .. > +_+ &&
+	git update-index --add +_+ &&
+	git commit -m plus &&
+	mkdir gtk+ &&
+	git mv +_+ gtk+/_+_ &&
+	git commit -m plus_dir &&
+	git svn dcommit
+	'
+
 stop_httpd
 
 test_done
-- 
Eric Wong

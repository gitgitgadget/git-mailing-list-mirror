From: Seth Falcon <sethfalcon@gmail.com>
Subject: [PATCH 1/1] Tried to fix git-svn's handling of filenames with embedded '@'.
Date: Sun, 28 May 2006 11:15:52 -0700
Message-ID: <m2verqkobr.fsf@ziti.fhcrc.org>
References: <m21wuem2xj.fsf@ziti.fhcrc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun May 28 20:16:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkPo0-0002vm-0n
	for gcvg-git@gmane.org; Sun, 28 May 2006 20:16:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbWE1SP5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 May 2006 14:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbWE1SP5
	(ORCPT <rfc822;git-outgoing>); Sun, 28 May 2006 14:15:57 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:43290 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750842AbWE1SP4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 May 2006 14:15:56 -0400
Received: by wr-out-0506.google.com with SMTP id i7so741301wra
        for <git@vger.kernel.org>; Sun, 28 May 2006 11:15:56 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=Z7IqGXX1Qg2IydZuRM6OG2gFEgSpKaThm00RUEs9+7SO5MQCpkRbdVGsqBiwKJ7UgiTLixuF7ZnAFcw1zOMsgJoUH56OrRDQajpbboXSBCVMVBbl9xWEA87BcqrsNU9g6PdyIK488YRIjsIRMuxoH5sz2DHvVVCTxeK+g1yVk0A=
Received: by 10.54.101.13 with SMTP id y13mr1362893wrb;
        Sun, 28 May 2006 11:15:54 -0700 (PDT)
Received: from ziti.fhcrc.org ( [67.171.24.140])
        by mx.gmail.com with ESMTP id 66sm2119108wra.2006.05.28.11.15.53;
        Sun, 28 May 2006 11:15:54 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <m21wuem2xj.fsf@ziti.fhcrc.org> (Seth Falcon's message of "Sun, 28 May 2006 11:15:04 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20886>

svn has trouble parsing files with embedded '@' characters.  For
example,

  svn propget svn:keywords foo@bar.c
  svn: Syntax error parsing revision 'bar.c'

I asked about this on #svn and the workaround suggested was to append
an explicit revision specifier:

  svn propget svn:keywords foo@bar.c@BASE

This patch appends '@BASE' to the filename in all calls to 'svn
propget'.
---
 contrib/git-svn/git-svn.perl |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index b3e0684..498ffe0 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -336,7 +336,7 @@ sub show_ignore {
 	my %ign;
 	File::Find::find({wanted=>sub{if(lstat $_ && -d _ && -d "$_/.svn"){
 		s#^\./##;
-		@{$ign{$_}} = safe_qx(qw(svn propget svn:ignore),$_);
+		@{$ign{$_}} = safe_qx(qw(svn propget svn:ignore),$_ . "\@BASE");
 		}}, no_chdir=>1},'.');
 
 	print "\n# /\n";
@@ -860,7 +860,7 @@ sub sys { system(@_) == 0 or croak $? }
 
 sub eol_cp {
 	my ($from, $to) = @_;
-	my $es = safe_qx(qw/svn propget svn:eol-style/, $to);
+	my $es = safe_qx(qw/svn propget svn:eol-style/, $to . "\@BASE");
 	open my $rfd, '<', $from or croak $!;
 	binmode $rfd or croak $!;
 	open my $wfd, '>', $to or croak $!;
@@ -898,7 +898,8 @@ sub do_update_index {
 	while (my $x = <$p>) {
 		chomp $x;
 		if (!$no_text_base && lstat $x && ! -l _ &&
-				safe_qx(qw/svn propget svn:keywords/,$x)) {
+				safe_qx(qw/svn propget svn:keywords/,
+                                        $x . "\@BASE")) {
 			my $mode = -x _ ? 0755 : 0644;
 			my ($v,$d,$f) = File::Spec->splitpath($x);
 			my $tb = File::Spec->catfile($d, '.svn', 'tmp',
-- 
1.3.3.gb931

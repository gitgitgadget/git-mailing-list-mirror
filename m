From: "Michael G. Schwern" <schwern@pobox.com>
Subject: [PATCH 6/8] Move Git::IndexInfo into its own file.
Date: Thu, 26 Jul 2012 17:26:05 -0700
Message-ID: <1343348767-86446-7-git-send-email-schwern@pobox.com>
References: <1343348767-86446-1-git-send-email-schwern@pobox.com>
Cc: robbat2@gentoo.org, bwalton@artsci.utoronto.ca,
	normalperson@yhbt.net, jrnieder@gmail.com, schwern@pobox.com
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 27 02:27:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuYOb-0004ZF-LP
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 02:27:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752860Ab2G0A0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 20:26:50 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41590 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752810Ab2G0A0q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 20:26:46 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so4044857pbb.19
        for <git@vger.kernel.org>; Thu, 26 Jul 2012 17:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=XvTn/u4pspGQPRWFbO/1xg4DMygPeCvs1PQ81HQ6JbI=;
        b=HxGl86TWohpqlJ11LUA2+RUNw+Env/Zllz38j2bsrvK1SBEJH95s4pfgiDzvh4rXCK
         74C5YB0VSNWUCI9kPTnc5TI1bbHePSZtoiQMA//ZdGKj7xKuYebaexqyfmCitjS0gkTN
         6O+DQqUQwusZXzEGSRkEmZVCCEYkWadjgB/ScFVrfeKSQ12TFCLEGkj5fTMrRwKo/BOR
         kq6nl0FclCX0Vp/vl2amNiRH1K18Atgv6eTub4Xd3/uo14N5ltk3wuX8nm29R61EI6Rg
         lEnXrjaoWl3SXNn20U+RAKyA+Otpwm+gDKRDVYRJxLGjXmlApDxceiyofDu+mh+Zm5aw
         3LIw==
Received: by 10.68.221.74 with SMTP id qc10mr9210104pbc.31.1343348806293;
        Thu, 26 Jul 2012 17:26:46 -0700 (PDT)
Received: from localhost.localdomain (c-76-105-239-160.hsd1.or.comcast.net. [76.105.239.160])
        by mx.google.com with ESMTPS id jz4sm692556pbc.17.2012.07.26.17.26.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 26 Jul 2012 17:26:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1
In-Reply-To: <1343348767-86446-1-git-send-email-schwern@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202327>

From: "Michael G. Schwern" <schwern@pobox.com>

Straight cut & paste.  Didn't require any fixing.
---
 git-svn.perl            | 32 --------------------------------
 perl/Git/IndexInfo.pm   | 33 +++++++++++++++++++++++++++++++++
 perl/Git/SVN/Fetcher.pm |  1 +
 perl/Makefile           |  1 +
 t/Git-SVN/00compile.t   |  3 ++-
 5 files changed, 37 insertions(+), 33 deletions(-)
 create mode 100644 perl/Git/IndexInfo.pm

diff --git a/git-svn.perl b/git-svn.perl
index fc49ad6..0856a77 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2041,38 +2041,6 @@ sub gc_directory {
 }
 
 
-package Git::IndexInfo;
-use strict;
-use warnings;
-use Git qw/command_input_pipe command_close_pipe/;
-
-sub new {
-	my ($class) = @_;
-	my ($gui, $ctx) = command_input_pipe(qw/update-index -z --index-info/);
-	bless { gui => $gui, ctx => $ctx, nr => 0}, $class;
-}
-
-sub remove {
-	my ($self, $path) = @_;
-	if (print { $self->{gui} } '0 ', 0 x 40, "\t", $path, "\0") {
-		return ++$self->{nr};
-	}
-	undef;
-}
-
-sub update {
-	my ($self, $mode, $hash, $path) = @_;
-	if (print { $self->{gui} } $mode, ' ', $hash, "\t", $path, "\0") {
-		return ++$self->{nr};
-	}
-	undef;
-}
-
-sub DESTROY {
-	my ($self) = @_;
-	command_close_pipe($self->{gui}, $self->{ctx});
-}
-
 package Git::SVN::GlobSpec;
 use strict;
 use warnings;
diff --git a/perl/Git/IndexInfo.pm b/perl/Git/IndexInfo.pm
new file mode 100644
index 0000000..a43108c
--- /dev/null
+++ b/perl/Git/IndexInfo.pm
@@ -0,0 +1,33 @@
+package Git::IndexInfo;
+use strict;
+use warnings;
+use Git qw/command_input_pipe command_close_pipe/;
+
+sub new {
+	my ($class) = @_;
+	my ($gui, $ctx) = command_input_pipe(qw/update-index -z --index-info/);
+	bless { gui => $gui, ctx => $ctx, nr => 0}, $class;
+}
+
+sub remove {
+	my ($self, $path) = @_;
+	if (print { $self->{gui} } '0 ', 0 x 40, "\t", $path, "\0") {
+		return ++$self->{nr};
+	}
+	undef;
+}
+
+sub update {
+	my ($self, $mode, $hash, $path) = @_;
+	if (print { $self->{gui} } $mode, ' ', $hash, "\t", $path, "\0") {
+		return ++$self->{nr};
+	}
+	undef;
+}
+
+sub DESTROY {
+	my ($self) = @_;
+	command_close_pipe($self->{gui}, $self->{ctx});
+}
+
+1;
diff --git a/perl/Git/SVN/Fetcher.pm b/perl/Git/SVN/Fetcher.pm
index ef8e9ed..76fae9b 100644
--- a/perl/Git/SVN/Fetcher.pm
+++ b/perl/Git/SVN/Fetcher.pm
@@ -57,6 +57,7 @@ sub new {
 	$self->{file_prop} = {};
 	$self->{absent_dir} = {};
 	$self->{absent_file} = {};
+	require Git::IndexInfo;
 	$self->{gii} = $git_svn->tmp_index_do(sub { Git::IndexInfo->new });
 	$self->{pathnameencoding} = Git::config('svn.pathnameencoding');
 	$self;
diff --git a/perl/Makefile b/perl/Makefile
index ff83848..2428e59 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -26,6 +26,7 @@ instdir_SQ = $(subst ','\'',$(prefix)/lib)
 
 modules += Git
 modules += Git/I18N
+modules += Git/IndexInfo
 modules += Git/SVN
 modules += Git/SVN/Memoize/YAML
 modules += Git/SVN/Fetcher
diff --git a/t/Git-SVN/00compile.t b/t/Git-SVN/00compile.t
index 1307b65..5419438 100644
--- a/t/Git-SVN/00compile.t
+++ b/t/Git-SVN/00compile.t
@@ -3,10 +3,11 @@
 use strict;
 use warnings;
 
-use Test::More tests => 5;
+use Test::More tests => 6;
 
 require_ok 'Git::SVN';
 require_ok 'Git::SVN::Utils';
 require_ok 'Git::SVN::Ra';
 require_ok 'Git::SVN::Log';
 require_ok 'Git::SVN::Migration';
+require_ok 'Git::IndexInfo';
-- 
1.7.11.1

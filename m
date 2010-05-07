From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH 2/2] gitweb: Add support for FastCGI, using CGI::Fast
Date: Fri,  7 May 2010 14:54:05 +0200
Message-ID: <1273236845-6523-3-git-send-email-jnareb@gmail.com>
References: <1273236845-6523-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Sam Vilain <sam.vilain@catalyst.net.nz>,
	Eric Wong <normalperson@yhbt.net>,
	Juan Jose Comellas <juanjo@comellas.org>,
	Peter Vereshagin <peter@vereshagin.org>,
	John Goerzen <jgoerzen@complete.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 07 14:54:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAN4Y-0003xh-Kf
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 14:54:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083Ab0EGMyY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 08:54:24 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:33443 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790Ab0EGMyW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 May 2010 08:54:22 -0400
Received: by mail-bw0-f219.google.com with SMTP id 19so556582bwz.21
        for <git@vger.kernel.org>; Fri, 07 May 2010 05:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=/VGxBRpt2qHzmhw9612FmD91wKYV1HpY/xfM+wCd74c=;
        b=clH0RYVas9L1oXkGNgIhGA9yGFwVTWqO5FL/oY8nl7s01lu/0RYnQaX4qynC+awjax
         ahG/PhWHFYEHdwZZvxaYSAD827gC5WumENOsgBlKPV+aZQOdO/AkKkPMFfQv4H1joMbz
         7KPCg/W2FofilkK02TACjiA3pRQAJwGjt5MLY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=VPGMJA6ETXyZuuHkVnt1YJ42QNHK7J7+lcR5Vo4uTgz5c5VXMmAHe5a9Lb7HYwXYGE
         A5aIngxASPZsT8YUE7YNKDQ/uc177tMJATeEA1hA0aL9GmnBakRcVZUzrg9WJcx2bXv9
         2hl9qlPvYNLzF0E+WO9+csd+77GgiM/hLZcx0=
Received: by 10.204.5.87 with SMTP id 23mr71810bku.206.1273236859914;
        Fri, 07 May 2010 05:54:19 -0700 (PDT)
Received: from localhost.localdomain (abvc175.neoplus.adsl.tpnet.pl [83.8.200.175])
        by mx.google.com with ESMTPS id 14sm710017bwz.2.2010.05.07.05.54.18
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 07 May 2010 05:54:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.1
In-Reply-To: <1273236845-6523-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146534>

From: Sam Vilain <sam.vilain@catalyst.net.nz>

Former run() subroutine got renamed to run_request().  The new run()
subroutine can run multiple requests at once if run as FastCGI script.

To run gitweb as FastCGI script you must specify '--fastcgi' / '-f'
command line option to gitweb, otherwise it runs as an ordinary CGI
script.

[jn: cherry picked from 56d7d436644ab296155a697552ea1345f2701620
 in http://utsl.gen.nz/gitweb/?p=gitweb which was originally based
 on v264 (2326acfa95ac86a53804ca8eeeb482c2f9265e34) by Kay Sievers;
 updated to reflect current gitweb code]

TODO: update 'gitweb/README' and/or 'gitweb/INSTALL' files.

Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is straighforward port of Sam Vilain patch to new gitweb code.

It is an RFC because while I have checked that it doesn't cause
problems when running without the '--fastcgi' parameter: 
* as CGI script (from mod_cgi), 
* as ModPerl::Registry script (from mod_perl), 
* as standalone script configured via gitweb_config.perl
  (from command line),
* as PSGI script via gitweb.psgi wrapper (from plackup,
  using Plack::App::WrapCGI, which in turn uses CGI::Emulate::PSGI),
I haven't actually checked that it runs correctly with *FastCGI server*
(because I don't have one installed).

 gitweb/gitweb.perl |   54 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 41bf992..a4194d7 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1012,7 +1012,7 @@ sub dispatch {
 	$actions{$action}->();
 }
 
-sub run {
+sub run_request {
 	our $t0 = [Time::HiRes::gettimeofday()]
 		if defined $t0;
 
@@ -1032,11 +1032,61 @@ sub run {
 	configure_gitweb_features();
 
 	dispatch();
+}
+
+our $is_last_request = sub { 1 };
+our ($pre_dispatch_hook, $post_dispatch_hook, $pre_listen_hook);
+our $CGI = 'CGI';
+our $cgi;
+sub evaluate_argv {
+	return unless (@ARGV);
+
+	require Getopt::Long;
+	Getopt::Long::GetOptions(
+		'fastcgi|fcgi|f' => sub {
+			require CGI::Fast;
+			our $CGI = 'CGI::Fast';
+
+			my $request_number = 0;
+			# let each child service 100 requests
+			our $is_last_request = sub { ++$request_number > 100 };
+		},
+		'nproc|n=i' => sub {
+			my ($arg, $val) = @_;
+			return unless eval { require FCGI::ProcManager; 1; };
+			my $proc_manager = FCGI::ProcManager->new({
+				n_processes => $val,
+			});
+			our $pre_listen_hook    = sub { $proc_manager->pm_manage()        };
+			our $pre_dispatch_hook  = sub { $proc_manager->pm_pre_dispatch()  };
+			our $post_dispatch_hook = sub { $proc_manager->pm_post_dispatch() };
+		},
+	);
+}
+
+sub run {
+	evaluate_argv();
+
+	$pre_listen_hook->()
+		if $pre_listen_hook;
+
+ REQUEST:
+	while ($cgi = $CGI->new()) {
+		$pre_dispatch_hook->()
+			if $pre_dispatch_hook;
+
+		run_request();
+
+		$pre_dispatch_hook->()
+			if $post_dispatch_hook;
+
+		last REQUEST if ($is_last_request->());
+	}
 
  DONE_GITWEB:
 	1;
 }
-our $cgi = CGI->new();
+
 run();
 
 ## ======================================================================
-- 
1.7.0.1

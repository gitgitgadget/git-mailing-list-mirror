From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCHv2 2/2] gitweb: Add support for FastCGI, using CGI::Fast
Date: Sat, 8 May 2010 09:59:00 +0200
Message-ID: <201005080959.01800.jnareb@gmail.com>
References: <1273236845-6523-1-git-send-email-jnareb@gmail.com> <1273236845-6523-3-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Sam Vilain <sam.vilain@catalyst.net.nz>,
	Eric Wong <normalperson@yhbt.net>,
	Juan Jose Comellas <juanjo@comellas.org>,
	Peter Vereshagin <peter@vereshagin.org>,
	John Goerzen <jgoerzen@complete.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 08 09:59:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAewR-0005Oj-H9
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 09:59:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751865Ab0EHH7O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 May 2010 03:59:14 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:50958 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751681Ab0EHH7N (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 03:59:13 -0400
Received: by bwz19 with SMTP id 19so935099bwz.21
        for <git@vger.kernel.org>; Sat, 08 May 2010 00:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=GQj2ftzvl9dAp4GJly8V2mYq2j5Tny8+yX+X9B7d5yg=;
        b=vVBlwS8e4Gb+kWPOMt3Q3bAW4T+nEa4+yym0CYv7IFDjXij1bdBhkUD4FOtFl4+jpQ
         qTCF688snlummPurexJeetpljUzcmTWwhKwS8XVLcGPwrtitsLQr6iRb3oaaasiW9da2
         aWVFZBGcrQATG6hVpFdR1us1LK8qdRjfNhltA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=fedy7xkBGgI8emCi0UYDmAHMdezJXvOMjP6gGt79/P3rfgUreB5dTYtgZgal4g+6RQ
         R71JP/7hrbU5oGqV0wCYIXvcBSMaQHruqXhw7K0Ut0vIxIpbtyV3w9w1hWUfjo8QxY8S
         njv9y2HiUo4G6WJO6KG0gZGzT4ckZN9m8hJR8=
Received: by 10.204.6.73 with SMTP id 9mr728420bky.143.1273305551449;
        Sat, 08 May 2010 00:59:11 -0700 (PDT)
Received: from [192.168.1.13] (abvu105.neoplus.adsl.tpnet.pl [83.8.218.105])
        by mx.google.com with ESMTPS id 13sm925392bwz.3.2010.05.08.00.59.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 08 May 2010 00:59:10 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1273236845-6523-3-git-send-email-jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146647>

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
Changes since v1:
* Fix $pre_dispatch_hook -> $post_dispatch_hook typo.

* Leave DONE_GITWEB label in run_request() subroutine.  This way "HTTP
  exceptions" thrown using die_error(), such as '404 Not Found', would
  correctly end current request, instead of exiting FCGI script.

  Note that in original patch by Sam Vilain "HTTP exceptions" would
  not run $post_dispatch_hook.

 gitweb/gitweb.perl |   54 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 41bf992..9a3eaf5 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1012,7 +1012,7 @@ sub dispatch {
 	$actions{$action}->();
 }
 
-sub run {
+sub run_request {
 	our $t0 = [Time::HiRes::gettimeofday()]
 		if defined $t0;
 
@@ -1036,7 +1036,57 @@ sub run {
  DONE_GITWEB:
 	1;
 }
-our $cgi = CGI->new();
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
+		$post_dispatch_hook->()
+			if $post_dispatch_hook;
+
+		last REQUEST if ($is_last_request->());
+	}
+}
+
 run();
 
 ## ======================================================================
-- 
1.7.0.1

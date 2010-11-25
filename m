From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv2] gitweb: selectable configurations that change with each request
Date: Thu, 25 Nov 2010 13:18:28 +0100
Message-ID: <201011251318.31235.jnareb@gmail.com>
References: <20101111213456.21127.36449.stgit@localhost.localdomain> <7vhbf6txi9.fsf@alter.siamese.dyndns.org> <201011242243.20545.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Julio Lajara <julio.lajara@alum.rpi.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 25 13:19:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLan9-0007YV-GE
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 13:19:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753064Ab0KYMSt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Nov 2010 07:18:49 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44659 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752918Ab0KYMSq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Nov 2010 07:18:46 -0500
Received: by bwz15 with SMTP id 15so801621bwz.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 04:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=h/mMwsJ8JxxXi+6Oib1MQ/WbdSUrc79Cm0pQ+apxIMk=;
        b=N50XO7CmVUZNgt/DDcq9xkLh8DgWbK8VX3Rv63726JDeq2qosD0A502XySpzEC1XwA
         yHDiTODmFvBzThRINakfk0KJkKEiwtqHmVVtetwga3oS1MVXqmEedF8nK3fAS/nZumgC
         PnaxrpCK0AJyCpaxD8A5zoF9bwCyivrV1LZb8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=mUMCtJjAZGOjs1xjuXHUZnVLNPgeetZJ5XlUirzFWSOMswL/mL6CVnvUVBIeEO8wWE
         v48i0/qhrJxqEXLBW9pNHxjyPofFhNtE5Jah9SUdSzNAlVIoG8TmsJ4fZZAoYQbZkzcc
         PQWJu5R5OLfRLHsQbYX+dJL3fQT3wrY8KhbtQ=
Received: by 10.204.68.81 with SMTP id u17mr566299bki.207.1290687522596;
        Thu, 25 Nov 2010 04:18:42 -0800 (PST)
Received: from [192.168.1.13] (abwg199.neoplus.adsl.tpnet.pl [83.8.230.199])
        by mx.google.com with ESMTPS id p22sm311356bkp.9.2010.11.25.04.18.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Nov 2010 04:18:40 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <201011242243.20545.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162129>

Allow selecting whether configuration file should be (re)parsed on each
request (the default, for backward compatibility with configurations that
change per session, see commit 7f425db (gitweb: allow configurations that
change with each request, 2010-07-30)), or whether should it be parsed only
once (for performance speedup for persistent environments, though currently
only FastCGI is able to make use of it, when flexibility is not important).

You can also have configuration file parsed only once, but have parts of
configuration (re)evaluated once per each request.

This is done by introducing $per_request_config variable: if set to code
reference, this code would be run once per request, while config file would
be parsed only once.  For example gitolite's contrib/gitweb/gitweb.conf
fragment mentioned in 7f425db could be rewritten as

  our $per_request_config = sub {
  	$ENV{GL_USER} = ($cgi && $cgi->remote_user) || "gitweb";
  };

to make use of this feature.

If $per_request_config is not a code reference, it is taken to be boolean
variable, to choose between running config file for each request
(flexibility), and running config file only once (performance in
persistent environments).

The default value for $per_request_config is 1 (true), which means that
old configuration that require to change per session (like gitolite's)
will keep working.


While at it, make it so evaluate_git_version() is run only once.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
On Wed, 24 Nov 2010, Jakub Narebski wrote:

> I'll send new version soon.
> 

And here it is, rebased on top of current 'master'.

 gitweb/README      |    7 +++++++
 gitweb/gitweb.perl |   23 +++++++++++++++++++++--
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/gitweb/README b/gitweb/README
index bf3664f..6646fda 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -246,6 +246,13 @@ not include variables usually directly set during build):
    http://www.andre-simon.de due to assumptions about parameters and output).
    Useful if highlight is not installed on your webserver's PATH.
    [Default: highlight]
+ * $per_request_config
+   If set to code reference, it would be run once per each request.  You can
+   set parts of configuration that change per session, e.g. by setting it to
+     sub { $ENV{GL_USER} = $cgi->remote_user || "gitweb"; }
+   Otherwise it is treated as boolean value: if true gitweb would process
+   config file once per request, if false it would process config file only
+   once.  The default is true.
 
 Projects list file format
 ~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7dbaf0c..ac38a92 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -599,6 +599,14 @@ sub filter_snapshot_fmts {
 		!$known_snapshot_formats{$_}{'disabled'}} @fmts;
 }
 
+# If it is set to code reference, it is code that it is to be run once per
+# request, allowing updating configurations that change with each request,
+# while running other code in config file only once.
+#
+# Otherwise, if it is false then gitweb would process config file only once;
+# if it is true then gitweb config would be run for each request.
+our $per_request_config = 1;
+
 our ($GITWEB_CONFIG, $GITWEB_CONFIG_SYSTEM);
 sub evaluate_gitweb_config {
 	our $GITWEB_CONFIG = $ENV{'GITWEB_CONFIG'} || "++GITWEB_CONFIG++";
@@ -1068,12 +1076,21 @@ sub reset_timer {
 	our $number_of_git_cmds = 0;
 }
 
+our $first_request = 1;
 sub run_request {
 	reset_timer();
 
 	evaluate_uri();
-	evaluate_gitweb_config();
-	evaluate_git_version();
+	if ($first_request) {
+		evaluate_gitweb_config();
+		evaluate_git_version();
+	} elsif ($per_request_config) {
+		if (ref($per_request_config) eq 'CODE') {
+			$per_request_config->();
+		} else {
+			evaluate_gitweb_config();
+		}
+	}
 	check_loadavg();
 
 	# $projectroot and $projects_list might be set in gitweb config file
@@ -1127,6 +1144,7 @@ sub evaluate_argv {
 sub run {
 	evaluate_argv();
 
+	$first_request = 1;
 	$pre_listen_hook->()
 		if $pre_listen_hook;
 
@@ -1139,6 +1157,7 @@ sub run {
 
 		$post_dispatch_hook->()
 			if $post_dispatch_hook;
+		$first_request = 0;
 
 		last REQUEST if ($is_last_request->());
 	}
-- 
1.7.3

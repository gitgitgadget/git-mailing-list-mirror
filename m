From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: Re: [RFC PATCH] gitweb: Support filtering projects by .htaccess files.
Date: Thu, 6 Nov 2008 01:36:23 +0300
Organization: HOME
Message-ID: <200811060136.23806.angavrilov@gmail.com>
References: <200811031943.30033.angavrilov@gmail.com> <200811032357.38893.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 05 23:40:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kxr2o-0002VD-Ez
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 23:40:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753646AbYKEWiZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 17:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751550AbYKEWiY
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 17:38:24 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:38043 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753395AbYKEWiX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 17:38:23 -0500
Received: by fg-out-1718.google.com with SMTP id 19so157908fgg.17
        for <git@vger.kernel.org>; Wed, 05 Nov 2008 14:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=+vvhTvEQOp/ZmfZJ0FnJzNJQReEb6qvmrTPi8aIOQjc=;
        b=Fewmwaf1Yur/wVh3FDYamg5eaJOFArzy4u1gdJMo0dNT04o85yOPi0T4ywcVfLNzg+
         Ax6wD3M66j6J53t4rOz/sZUhnhAT67HoiZvF6F0SEcVm1pC5yeShFCgSw1hN/nF77foy
         iQDdQzaArpVQLKkN+yDz1flbfTUjdALr/BH9w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=vJ6WP5Oaz514S/IyxTo/7ha5H0MrR7W38/0uRtSxr5ZUzYJzRhNqWy9VbRy8Qxd93D
         0Qr2wwOeRIiYGPDbTbX3CHf2iVsL+e52opKQ2qpllh/boh7PuVhBHP5a4n8Fpe1SNh1g
         UKhT+Du/FKohgzKVxKvsCZd+CRFnrVOauH628=
Received: by 10.181.135.5 with SMTP id m5mr435023bkn.171.1225924700985;
        Wed, 05 Nov 2008 14:38:20 -0800 (PST)
Received: from keydesk.localnet ([92.255.85.78])
        by mx.google.com with ESMTPS id d13sm759262fka.19.2008.11.05.14.38.18
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 05 Nov 2008 14:38:19 -0800 (PST)
User-Agent: KMail/1.10.1 (Linux/2.6.26.6-79.fc9.i686; KDE/4.1.2; i686; ; )
In-Reply-To: <200811032357.38893.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100194>

> > authenticated user name. Using group authentication requires specifying
> > a path to the Apache group file in the configuration.
> > 
> > Using .htaccess has an additional bonus that the same authentication
> > data can be used both for gitweb and the dumb http transport.
> 
> I'm not sure if it wouldn't be a better solution to try to ask web
> server to do authentication, for example in MOD_PERL case via $r
> object (if I remember correctly)...

You are right. I never used mod_perl before, so I didn't know that it's possible.

How about the following patch, that simply adds a hook, and provides
an example using mod_perl in the documentation?

--- >8 ---
Subject: [PATCH] gitweb: Add a per-repository authorization hook.

Add a configuration variable that can be used to specify an
arbitrary subroutine that will be called in the same situations
where $export_ok is checked, and its return value used
to decide whether the repository is to be shown.

This allows the user to implement custom authentication
schemes, for example by issuing a subrequest through mod_perl
and checking if Apache will authorize it.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 gitweb/INSTALL     |   21 +++++++++++++++++++++
 gitweb/gitweb.perl |    8 +++++++-
 2 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/gitweb/INSTALL b/gitweb/INSTALL
index 26967e2..fa5917a 100644
--- a/gitweb/INSTALL
+++ b/gitweb/INSTALL
@@ -166,6 +166,27 @@ Gitweb repositories
   shows repositories only if this file exists in its object database
   (if directory has the magic file named $export_ok).
 
+- Finally, it is possible to specify an arbitrary perl subroutine that
+  will be called for each project to determine if it can be exported.
+  The subroutine receives an absolute path to the project as its only
+  parameter.
+
+  For example, if you use mod_perl to run the script, and have dumb
+  http protocol authentication configured for your repositories, you
+  can use the following hook to allow access only if the user is
+  authorized to read the files:
+
+    $export_auth_hook = sub {
+        use Apache2::SubRequest ();
+        use Apache2::Const -compile => qw(HTTP_OK);
+        my $path = "$_[0]/HEAD";
+        my $r    = Apache2::RequestUtil->request;
+        my $sub  = $r->lookup_file($path);
+        return $sub->filename eq $path 
+            && $sub->status == Apache2::Const::HTTP_OK;
+    };
+
+
 Generating projects list using gitweb
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 172ea6b..9329880 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -95,6 +95,11 @@ our $default_projects_order = "project";
 # (only effective if this variable evaluates to true)
 our $export_ok = "++GITWEB_EXPORT_OK++";
 
+# show repository only if this subroutine returns true
+# when given the path to the project, for example:
+#    sub { return -e "$_[0]/git-daemon-export-ok"; }
+our $export_auth_hook = undef;
+
 # only allow viewing of repositories also shown on the overview page
 our $strict_export = "++GITWEB_STRICT_EXPORT++";
 
@@ -400,7 +405,8 @@ sub check_head_link {
 sub check_export_ok {
 	my ($dir) = @_;
 	return (check_head_link($dir) &&
-		(!$export_ok || -e "$dir/$export_ok"));
+		(!$export_ok || -e "$dir/$export_ok") &&
+		(!$export_auth_hook || $export_auth_hook->($dir)));
 }
 
 # process alternate names for backward compatibility
-- 
tg: (0d4f9de..) t/authenticate/hook (depends on: t/authenticate/unify-exportok)

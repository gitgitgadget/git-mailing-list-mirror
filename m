From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: Re: [RFC PATCH] gitweb: Support filtering projects by .htaccess files.
Date: Thu, 6 Nov 2008 22:43:26 +0300
Organization: HOME
Message-ID: <200811062243.27348.angavrilov@gmail.com>
References: <200811031943.30033.angavrilov@gmail.com> <200811060136.23806.angavrilov@gmail.com> <200811060026.59340.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 06 20:46:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyAoX-0008Hu-OT
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 20:46:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbYKFTpb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 14:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbYKFTpb
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 14:45:31 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:33725 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804AbYKFTpa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 14:45:30 -0500
Received: by fg-out-1718.google.com with SMTP id 19so605367fgg.17
        for <git@vger.kernel.org>; Thu, 06 Nov 2008 11:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=jTW2zjzkefLJMXcbRP8IjSdp+YWIXWXHhK1sN5nZnjQ=;
        b=m/IRcqPrnMveE/F7bQgGLQqcA98kJjc0z33p9/cDBYc4dtuJWZd3gSmTuSdF+iPJQy
         YTu+6Fw2QMYqu8QoYJFYHiYUFXxV1QpJLZzao6/ZmP25yZWkBNzU/Dtw6QzUUelDZWFV
         enK7z3cSIkIDInrP/kLYwFQhU8LIlkB6UjAKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Ds4Vr5TlhFomDnFN3kq402Mbg68GAA1pw6dIzQ3k1emaDuq93LWbu2ZbusN4neh2Fr
         Q0SHhQSV7kwo8PcpOotMF5FoqXSiHDfVRGMtOQOeEDaVqzvDvnpUetKtewVwq+U8Dwaa
         xf88j4kq0nbM/EDVhpDibv1BP+Uz6rBSJDJbY=
Received: by 10.187.203.16 with SMTP id f16mr527451faq.34.1226000728043;
        Thu, 06 Nov 2008 11:45:28 -0800 (PST)
Received: from keydesk.localnet ([92.255.85.78])
        by mx.google.com with ESMTPS id 31sm2889563fkt.3.2008.11.06.11.45.26
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 06 Nov 2008 11:45:26 -0800 (PST)
User-Agent: KMail/1.10.1 (Linux/2.6.26.6-79.fc9.i686; KDE/4.1.2; i686; ; )
In-Reply-To: <200811060026.59340.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100262>

On Thursday 06 November 2008 02:26:58 Jakub Narebski wrote:
> Alexander Gavrilov wrote:
> > +  For example, if you use mod_perl to run the script, and have dumb
> > +  http protocol authentication configured for your repositories, you
> > +  can use the following hook to allow access only if the user is
> > +  authorized to read the files:
> > +
> > +    $export_auth_hook = sub {
> > +        use Apache2::SubRequest ();
> > +        use Apache2::Const -compile => qw(HTTP_OK);
> > +        my $path = "$_[0]/HEAD";
> > +        my $r    = Apache2::RequestUtil->request;
> > +        my $sub  = $r->lookup_file($path);
> > +        return $sub->filename eq $path 
> > +            && $sub->status == Apache2::Const::HTTP_OK;
> > +    };
> 
> Can anybody check this? Or was it checked by author?

Well, it seems to do what is intended on my home server,
although it has a known limitation, so here is an updated
version that warns about it.

By the way, do you know how to deal with Apache or ModPerl's
urge to append standard error messages to the script output, other
than adding a bunch of lines like the following to the config?

  ErrorMessage 400 " "

I couldn't find any solutions so far.


--- >8 ---
Subject: [PATCH] gitweb: Add a per-repository authorization hook.

Add a configuration variable that can be used to specify an
arbitrary subroutine that will be called in the same situations
where $export_ok is checked, and its return value will be used
to decide whether the repository is to be shown.

This allows the user to implement custom authentication
schemes, for example by issuing a subrequest through mod_perl
and checking if Apache will authorize it.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 gitweb/INSTALL     |   23 +++++++++++++++++++++++
 gitweb/gitweb.perl |    8 +++++++-
 2 files changed, 30 insertions(+), 1 deletions(-)

diff --git a/gitweb/INSTALL b/gitweb/INSTALL
index 26967e2..72a1322 100644
--- a/gitweb/INSTALL
+++ b/gitweb/INSTALL
@@ -166,6 +166,29 @@ Gitweb repositories
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
+  Note that since this sample works exclusively in the filesystem
+  namespace, <Location> sections of the configuration have no effect.
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

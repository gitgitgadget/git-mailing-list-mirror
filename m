From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCH v7 2/9] gitweb: use eval + die for error (exception)
	handling
Date: Thu, 23 Dec 2010 00:55:26 +0100
Message-ID: <20101222235525.7998.99816.stgit@localhost.localdomain>
References: <20101222234843.7998.87068.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "J.H." <warthog9@eaglescrag.net>,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 23 00:56:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVYXU-00078Y-9z
	for gcvg-git-2@lo.gmane.org; Thu, 23 Dec 2010 00:56:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752709Ab0LVX4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Dec 2010 18:56:06 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:37392 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887Ab0LVX4F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Dec 2010 18:56:05 -0500
Received: by bwz15 with SMTP id 15so7007056bwz.19
        for <git@vger.kernel.org>; Wed, 22 Dec 2010 15:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:in-reply-to:references:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=Ja3wCVyHejM6WRnpxikPtqnduHpsqfo8XtSa8F61g2k=;
        b=hh/IbqV0N8dufor/pyXTj2ylYgMBYzQd0UyGl6+coPo5WkuVbk5reTnPuDEJ1RKboD
         Y3JoBDyIYEfUGEnAn0k7BWoGPoj8hiIOS2T1hJMfoj/lbjEfZ6vPbqMdCUTWoo//bCq1
         OopExZcwjCRQWBIYrS/syU7Ik6g60fyacnPuE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        b=GMWVrIh7w3m5niQkJRZwmlOwsj7dgLv5ACIA8oxw2bgmSrDNPFKMApiUTcl/T1L/oh
         UA/m0rnLW1XToezHbPbF4Dxq1TPqfSWhXJ0rcQE93sn4Yci7lece6aTqQuChlbVDEYPa
         yxRrQlkCyJj2Vzostf5PTEJBDXtWwLGM1BnW0=
Received: by 10.204.72.20 with SMTP id k20mr106348bkj.184.1293062163052;
        Wed, 22 Dec 2010 15:56:03 -0800 (PST)
Received: from localhost.localdomain (abvw91.neoplus.adsl.tpnet.pl [83.8.220.91])
        by mx.google.com with ESMTPS id b6sm4395638bkb.22.2010.12.22.15.56.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Dec 2010 15:56:02 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oBMNtQAb008105;
	Thu, 23 Dec 2010 00:55:36 +0100
In-Reply-To: <20101222234843.7998.87068.stgit@localhost.localdomain>
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164103>



In gitweb code it is assumed that calling die_error() subroutine would
end request, just like running "die" would.  Up till now it was done by
having die_error() jump to DONE_REQUEST (earlier DONE_GITWEB), or in
earlier version just 'exit' (for mod_perl via ModPerl::Registry it ends
request instead of exiting worker).

Instead of using 'goto DONE_REQUEST' for longjmp-like nonlocal jump, or
using 'exit', gitweb uses now native for Perl exception handlingin the
form of eval / die pair ("eval BLOCK" to trap exceptions, "die LIST" to
raise/throw them).

Up till now the "goto DONE_REQUEST" solution was enough, but with the
coming output caching support and it adding modular structure to gitweb,
it would be difficult to continue to keep using this solution
(e.g. interaction with capturing output).


Because gitweb now traps all exceptions occuring run_request(), the
handle_errors_html handler (set via set_message from CGI::Carp) is not
needed; gitweb can call die_error in -error_handler mode itself.  This
has the advantage that we can now set correct HTTP header (handler from
CGI::Carp::set_message was run after HTTP headers were already sent).

Gitweb assumes here that exceptions thrown by Perl would be simple
strings; die_error() throws hash reference (if not for minimal
extrenal dependencies, it would be probable object of Class::Exception
or Throwable class thrown).

Note: in newer versions of CGI::Carp there is set_die_handler(), where
handler have to set HTTP headers to the browser itself, but we cannot
rely on new enough CGI::Carp version to have been installed.  Also
set_die_handler interferes with fatalsToBrowser.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---

 gitweb/gitweb.perl |   26 ++++++++------------------
 1 files changed, 8 insertions(+), 18 deletions(-)


diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 724287b..c7a1892 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -12,7 +12,7 @@ use strict;
 use warnings;
 use CGI qw(:standard :escapeHTML -nosticky);
 use CGI::Util qw(unescape);
-use CGI::Carp qw(fatalsToBrowser set_message);
+use CGI::Carp qw(fatalsToBrowser);
 use Encode;
 use Fcntl ':mode';
 use File::Find qw();
@@ -1045,21 +1045,6 @@ sub configure_gitweb_features {
 	}
 }
 
-# custom error handler: 'die <message>' is Internal Server Error
-sub handle_errors_html {
-	my $msg = shift; # it is already HTML escaped
-
-	# to avoid infinite loop where error occurs in die_error,
-	# change handler to default handler, disabling handle_errors_html
-	set_message("Error occured when inside die_error:\n$msg");
-
-	# you cannot jump out of die_error when called as error handler;
-	# the subroutine set via CGI::Carp::set_message is called _after_
-	# HTTP headers are already written, so it cannot write them itself
-	die_error(undef, undef, $msg, -error_handler => 1, -no_http_header => 1);
-}
-set_message(\&handle_errors_html);
-
 # dispatch
 sub dispatch {
 	if (!defined $action) {
@@ -1167,7 +1152,11 @@ sub run {
 		$pre_dispatch_hook->()
 			if $pre_dispatch_hook;
 
-		run_request();
+		eval { run_request() };
+		if (defined $@ && !ref($@)) {
+			# some Perl error, but not one thrown by die_error
+			die_error(undef, undef, $@, -error_handler => 1);
+		}
 
 	DONE_REQUEST:
 		$post_dispatch_hook->()
@@ -3768,7 +3757,8 @@ EOF
 	print "</div>\n";
 
 	git_footer_html();
-	goto DONE_REQUEST
+
+	die {'status' => $status, 'error' => $error}
 		unless ($opts{'-error_handler'});
 }
 

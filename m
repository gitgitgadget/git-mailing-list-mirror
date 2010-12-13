From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCH 2/2] gitweb: use eval + die for error (exception) handling
Date: Mon, 13 Dec 2010 01:49:57 +0100
Message-ID: <20101213004916.9475.77561.stgit@localhost.localdomain>
References: <20101213004259.9475.87376.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "J.H." <warthog9@eaglescrag.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 13 01:50:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRwcZ-0007hV-1Z
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 01:50:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754044Ab0LMAuZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Dec 2010 19:50:25 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:38100 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821Ab0LMAuY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Dec 2010 19:50:24 -0500
Received: by wwa36 with SMTP id 36so5787353wwa.1
        for <git@vger.kernel.org>; Sun, 12 Dec 2010 16:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:in-reply-to:references:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=Bh121cX31oASqnXIX59DJyx7WRwS3OG7haisXJch2CA=;
        b=Z2Jt/qshoNF8MHIwJ+Ikx29wUgUVZr399+Oucs1Iyf8UrcT52/zBKRrgE6wVah3ZOD
         iniBfoCTZ5Oru/8v1sT3tWs6ZMyD+OdLtRgCYU829JqoslDnPghGgMLRoexl+45zLx+K
         reO6vikxx4mdid8u4Ps8eesdmC6u+zIYHm1DE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        b=xKgw+E1gsH5mFjd31a6h/tAAap6dVfpFJL6V2t6A8hVLq4kOYGJS7z2+dDlS8F2rvi
         Jimnw8TstZq2jp8bowqHnxZZCT7+LDlUm20EZoLsXCY/cM3/olmWDP92DH+O06UgJw4W
         MpA8CelCROoQ1HUrf4bUwHTZIgrRmTdayh5E8=
Received: by 10.216.4.82 with SMTP id 60mr2256183wei.89.1292201423264;
        Sun, 12 Dec 2010 16:50:23 -0800 (PST)
Received: from localhost.localdomain (abwq106.neoplus.adsl.tpnet.pl [83.8.240.106])
        by mx.google.com with ESMTPS id 11sm4007986wbj.1.2010.12.12.16.50.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 12 Dec 2010 16:50:22 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oBD0nwSF009614;
	Mon, 13 Dec 2010 01:50:08 +0100
In-Reply-To: <20101213004259.9475.87376.stgit@localhost.localdomain>
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163502>

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
This is main part of this series.

Comments?

 gitweb/gitweb.perl |   26 ++++++++------------------
 1 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index af45daa..ab85c53 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -20,7 +20,7 @@ use lib __DIR__ . '/lib';
 
 use CGI qw(:standard :escapeHTML -nosticky);
 use CGI::Util qw(unescape);
-use CGI::Carp qw(fatalsToBrowser set_message);
+use CGI::Carp qw(fatalsToBrowser);
 use Encode;
 use Fcntl ':mode';
 use File::Find qw();
@@ -1034,21 +1034,6 @@ sub configure_gitweb_features {
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
@@ -1145,7 +1130,11 @@ sub run {
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
@@ -3670,7 +3659,8 @@ EOF
 	print "</div>\n";
 
 	git_footer_html();
-	goto DONE_REQUEST
+
+	die {'status' => $status, 'error' => $error}
 		unless ($opts{'-error_handler'});
 }
 

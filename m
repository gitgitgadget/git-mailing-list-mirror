From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Eliminate Scalar::Util usage from private-Error.pm
Date: Wed, 26 Jul 2006 03:03:58 +0200
Message-ID: <20060726010358.20964.80443.stgit@machine>
References: <Pine.LNX.4.63.0607251809340.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 26 03:04:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5Xoh-00015l-Lr
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 03:04:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030305AbWGZBEA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Jul 2006 21:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030306AbWGZBEA
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Jul 2006 21:04:00 -0400
Received: from w241.dkm.cz ([62.24.88.241]:11184 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030305AbWGZBD7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Jul 2006 21:03:59 -0400
Received: (qmail 20974 invoked from network); 26 Jul 2006 03:03:58 +0200
Received: from localhost (HELO ?62.24.88.241?) (xpasky@127.0.0.1)
  by localhost with SMTP; 26 Jul 2006 03:03:58 +0200
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.63.0607251809340.29667@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24194>

We used just the blessed() routine so steal it from Scalar/Util.pm. ;-)
(Unfortunately, Scalar::Util is not bundled with older Perl versions.)

This is a newer much saner blessed() version by Randal L. Schwarz.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 perl/private-Error.pm |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/perl/private-Error.pm b/perl/private-Error.pm
index ebd0749..8fff866 100644
--- a/perl/private-Error.pm
+++ b/perl/private-Error.pm
@@ -43,8 +43,6 @@ sub throw_Error_Simple
 
 # Exported subs are defined in Error::subs
 
-use Scalar::Util ();
-
 sub import {
     shift;
     local $Exporter::ExportLevel = $Exporter::ExportLevel + 1;
@@ -290,6 +288,14 @@ use vars qw(@EXPORT_OK @ISA %EXPORT_TAGS
 
 @ISA = qw(Exporter);
 
+
+sub blessed {
+	my $item = shift;
+	local $@; # don't kill an outer $@
+	ref $item and eval { $item->can('can') };
+}
+
+
 sub run_clauses ($$$\@) {
     my($clauses,$err,$wantarray,$result) = @_;
     my $code = undef;
@@ -312,7 +318,7 @@ sub run_clauses ($$$\@) {
 		    $i -= 2;
 		    next CATCHLOOP;
 		}
-		elsif(Scalar::Util::blessed($err) && $err->isa($pkg)) {
+		elsif(blessed($err) && $err->isa($pkg)) {
 		    $code = $catch->[$i+1];
 		    while(1) {
 			my $more = 0;
@@ -421,7 +427,7 @@ sub try (&;$) {
 
     if (defined($err))
     {
-        if (Scalar::Util::blessed($err) && $err->can('throw'))
+        if (blessed($err) && $err->can('throw'))
         {
             throw $err;
         }

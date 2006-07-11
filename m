From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Eliminate Scalar::Util usage from private-Error.pm
Date: Tue, 11 Jul 2006 02:53:54 +0200
Message-ID: <20060711005354.5911.62525.stgit@machine.or.cz>
References: <20060710130046.GW29115@pasky.or.cz>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 11 02:54:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G06Vr-0000si-Q0
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 02:54:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbWGKAx5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 20:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWGKAx5
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 20:53:57 -0400
Received: from w241.dkm.cz ([62.24.88.241]:28107 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751398AbWGKAx4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jul 2006 20:53:56 -0400
Received: (qmail 5924 invoked from network); 11 Jul 2006 02:53:54 +0200
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 11 Jul 2006 02:53:54 +0200
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20060710130046.GW29115@pasky.or.cz>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23677>

We used just the blessed() routine so steal it from Scalar/Util.pm. ;-)
(Unfortunately, Scalar::Util is not bundled with older Perl versions.)

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 perl/private-Error.pm |   20 ++++++++++++++++----
 1 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/perl/private-Error.pm b/perl/private-Error.pm
index ebd0749..848e82b 100644
--- a/perl/private-Error.pm
+++ b/perl/private-Error.pm
@@ -43,8 +43,6 @@ sub throw_Error_Simple
 
 # Exported subs are defined in Error::subs
 
-use Scalar::Util ();
-
 sub import {
     shift;
     local $Exporter::ExportLevel = $Exporter::ExportLevel + 1;
@@ -290,6 +288,20 @@ use vars qw(@EXPORT_OK @ISA %EXPORT_TAGS
 
 @ISA = qw(Exporter);
 
+
+# Stolen from Scalar::Util:
+
+# Hope nobody defines a sub by this name
+sub UNIVERSAL::a_sub_not_likely_to_be_here { ref($_[0]) }
+
+sub blessed ($) {
+    local($@, $SIG{__DIE__}, $SIG{__WARN__});
+    length(ref($_[0]))
+        ? eval { $_[0]->a_sub_not_likely_to_be_here }
+        : undef
+}
+
+
 sub run_clauses ($$$\@) {
     my($clauses,$err,$wantarray,$result) = @_;
     my $code = undef;
@@ -312,7 +324,7 @@ sub run_clauses ($$$\@) {
 		    $i -= 2;
 		    next CATCHLOOP;
 		}
-		elsif(Scalar::Util::blessed($err) && $err->isa($pkg)) {
+		elsif(blessed($err) && $err->isa($pkg)) {
 		    $code = $catch->[$i+1];
 		    while(1) {
 			my $more = 0;
@@ -421,7 +433,7 @@ sub try (&;$) {
 
     if (defined($err))
     {
-        if (Scalar::Util::blessed($err) && $err->can('throw'))
+        if (blessed($err) && $err->can('throw'))
         {
             throw $err;
         }

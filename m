From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 2/7] gitweb: git_get_heads_list accepts an optional list of refs.
Date: Thu, 16 Sep 2010 11:31:00 +0200
Message-ID: <1284629465-14798-3-git-send-email-giuseppe.bilotta@gmail.com>
References: <1284629465-14798-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 16 11:31:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwAop-0007PY-9M
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 11:31:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753086Ab0IPJbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Sep 2010 05:31:35 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:34856 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693Ab0IPJbe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Sep 2010 05:31:34 -0400
Received: by mail-ww0-f44.google.com with SMTP id 15so130944wwe.1
        for <git@vger.kernel.org>; Thu, 16 Sep 2010 02:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=TlxtnELi439bhwPZ8kzOOmD6ezu0Q4yDGXdxkb/RlSU=;
        b=m7X76Rzy1lpaTHNIO46mV9fvYQ2Pb1M71nygA6vxHn6x1TMpMjmzqZlLFId3x7BO92
         EK79Ls5BrKl+X2kRzwsGI97vfLodsUDEC0vlNtlKZJ7QWjiB0BF4+974xL+OZmlswOzq
         KxX/Rc6RNCNiPpkubQtl4THi/cC3z2fvIMfiU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=SW8YblX1O7xB9cIXcWb4MtxpqaU9VMX+iCZTlUriXe5/3izFcPrBpC6R/uAhTIbNSS
         wsdANlg15FI64ZE3Ezv8QSeaNUmlYTLYffojN/BneWyPKE+ZIBhLVsEuuKBpx2kagL0l
         AaRoH9C2mdbdhMYlz5++v1vOVMuMZMHJzJoU4=
Received: by 10.227.136.140 with SMTP id r12mr2399303wbt.193.1284629494154;
        Thu, 16 Sep 2010 02:31:34 -0700 (PDT)
Received: from localhost ([151.60.177.109])
        by mx.google.com with ESMTPS id n40sm1666086weq.29.2010.09.16.02.31.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 16 Sep 2010 02:31:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.230.g8b572
In-Reply-To: <1284629465-14798-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156306>

git_get_heads_list(limit, class1, class2, ...) can now be used to retrieve
refs/class1, refs/class2 etc. Defaults to ('heads') or ('heads', 'remotes')
depending on the remote_heads option.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7116c26..21e83bb 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3155,15 +3155,18 @@ sub parse_from_to_diffinfo {
 ## parse to array of hashes functions
 
 sub git_get_heads_list {
-	my $limit = shift;
+	my ($limit, @class) = @_;
+	unless (defined @class) {
+		my $remote_heads = gitweb_check_feature('remote_heads');
+		@class = ('heads', $remote_heads ? 'remotes' : undef);
+	}
+	my @refs = map { "refs/$_" } @class;
 	my @headslist;
 
-	my $remote_heads = gitweb_check_feature('remote_heads');
-
 	open my $fd, '-|', git_cmd(), 'for-each-ref',
 		($limit ? '--count='.($limit+1) : ()), '--sort=-committerdate',
 		'--format=%(objectname) %(refname) %(subject)%00%(committer)',
-		'refs/heads', ( $remote_heads ? 'refs/remotes' : '')
+		@refs
 		or return;
 	while (my $line = <$fd>) {
 		my %ref_item;
-- 
1.7.3.rc1.230.g8b572

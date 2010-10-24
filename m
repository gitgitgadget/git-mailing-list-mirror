From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv6 02/10] gitweb: git_get_heads_list accepts an optional list of refs.
Date: Sun, 24 Oct 2010 12:45:28 +0200
Message-ID: <1287917136-26103-3-git-send-email-giuseppe.bilotta@gmail.com>
References: <1287917136-26103-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 24 12:46:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9y5v-0004rf-Oc
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 12:46:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461Ab0JXKp6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 06:45:58 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39237 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932370Ab0JXKp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 06:45:57 -0400
Received: by mail-ww0-f44.google.com with SMTP id 15so2499176wwe.1
        for <git@vger.kernel.org>; Sun, 24 Oct 2010 03:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=DcfEmXblqLv81zfT2McMgMOGj0rhLbBiyCMV/9xc2Mc=;
        b=s2P6x3wJFTCtov6LXAJ1h/DOGcEsnroKLJ84ZoZ3mCJpAjOo4Bp8T5evqWb0+qpBi5
         lDir2O9fnURAHEjn4r4n6UU/xpv34XJ7IyvOp99xlTHrATi5g47lJxKMwVMEWQ3wtRc5
         CIbsTOL3Eb1t+VTKDGKHju3m4o8STUXTE/w50=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=n/2Zk8Ws3sxeUhGMi0nnIzOIupGEXpSAs+y/kMkeboHV2ohckNWYQwlpThs/tBFuiJ
         G3y8+I7Q0jy99/Jkv2c3vCfko54jQSzyUyzF8WVXRh8MatpG2ACH0XJeJV1WFKADnhW7
         1t3v7e3lFyxP0IzJ9opJVQdcWpSwM0RE+eAQ8=
Received: by 10.216.37.4 with SMTP id x4mr1659825wea.1.1287917156395;
        Sun, 24 Oct 2010 03:45:56 -0700 (PDT)
Received: from localhost ([151.60.176.122])
        by mx.google.com with ESMTPS id w8sm3313395wei.21.2010.10.24.03.45.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Oct 2010 03:45:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.68.g6ec8
In-Reply-To: <1287917136-26103-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159845>

git_get_heads_list(limit, class1, class2, ...) can now be used to retrieve
refs/class1, refs/class2 etc. Defaults to ('heads', 'remotes') or ('heads')
depending on whether the 'remote_heads' feature is enabled or not.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 0e71749..e75d3f4 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3169,15 +3169,18 @@ sub parse_from_to_diffinfo {
 ## parse to array of hashes functions
 
 sub git_get_heads_list {
-	my $limit = shift;
+	my ($limit, @classes) = @_;
+	unless (defined @classes) {
+		my $remote_heads = gitweb_check_feature('remote_heads');
+		@classes = ('heads', $remote_heads ? 'remotes' : ());
+	}
+	my @patterns = map { "refs/$_" } @classes;
 	my @headslist;
 
-	my $remote_heads = gitweb_check_feature('remote_heads');
-
 	open my $fd, '-|', git_cmd(), 'for-each-ref',
 		($limit ? '--count='.($limit+1) : ()), '--sort=-committerdate',
 		'--format=%(objectname) %(refname) %(subject)%00%(committer)',
-		'refs/heads', ($remote_heads ? 'refs/remotes' : ())
+		@patterns
 		or return;
 	while (my $line = <$fd>) {
 		my %ref_item;
-- 
1.7.3.68.g6ec8

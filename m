From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 03/14] gitweb: git_get_heads_list now accepts an optional list of refs.
Date: Fri, 31 Aug 2007 12:55:23 +0200
Message-ID: <11885577231448-git-send-email-giuseppe.bilotta@gmail.com>
References: <cb7bb73a0708301915y47ca4a05nf511889b2bb2eaec@mail.gmail.com>
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 31 12:57:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR4Bg-0005Mc-9i
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 12:57:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbXHaK5G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 06:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932469AbXHaK5F
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 06:57:05 -0400
Received: from jack.tiscali.it ([213.205.33.53]:37503 "EHLO jack.tiscali.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932504AbXHaK5E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 06:57:04 -0400
Received: from localhost.localdomain (84.221.55.162) by jack.tiscali.it (7.3.122)
        id 46A8A7D10038FBCC; Fri, 31 Aug 2007 12:57:02 +0200
X-Mailer: git-send-email 1.5.2.5
In-Reply-To: <cb7bb73a0708301915y47ca4a05nf511889b2bb2eaec@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57151>

git_get_heads_list(limit, dir1, dir2, ...) can now be used to retrieve refs/dir1, refs/dir2 etc.
Defaults to ('heads') or ('heads', 'remotes') depending on the remote_heads option.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 6514bef..4b27352 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2081,15 +2081,18 @@ sub parse_from_to_diffinfo {
 ## parse to array of hashes functions
 
 sub git_get_heads_list {
-	my $limit = shift;
+	my ($limit, @class) = @_;
+	unless (defined @class) {
+		my ($remote_heads) = gitweb_check_feature('remote_heads');
+		@class = ('heads', $remote_heads ? 'remotes' : undef);
+	}
+	my @refs = map { "refs/$_" } @class ;
 	my @headslist;
 
-	my ($remote_heads) = gitweb_check_feature('remote_heads');
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
1.5.2.5

From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv3 2/4] gitweb: git_get_heads_list accepts an optional list of refs.
Date: Sun, 16 Nov 2008 14:28:07 +0100
Message-ID: <1226842089-1159-3-git-send-email-giuseppe.bilotta@gmail.com>
References: <1226842089-1159-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1226842089-1159-2-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 16 14:29:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1hh8-00027T-IW
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 14:29:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751945AbYKPN2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 08:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752001AbYKPN2F
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 08:28:05 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:57037 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751945AbYKPN2C (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 08:28:02 -0500
Received: by ug-out-1314.google.com with SMTP id 39so219624ugf.37
        for <git@vger.kernel.org>; Sun, 16 Nov 2008 05:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=jPGZ6kMXo8OD8OKPbaI31SDQMHKaVQ4mrSIh0pKdBMc=;
        b=afnOTh4IocVrAHoGwNtNR6MqAo6y/udMMPYmN93et5LpnPuzTK5YXUTSM4C0Y+p9aH
         i/VZvgGBHuDOApJpp4qlmvxubLMEymdMCWYMNC6llu2bYoEvj3u6coKuzK91bqkOJMf3
         YEgTJS/CnJs2ui6HSg5cPdi8ZQc5Chj+4CT/o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=RFJnI8lKws3Uqqs1y85Op8N2CRx7av/fRXb8a4FeSpY6hkWD6Jd+HRkr5ukHaPH5bM
         JbU6m0tdC5Va5oNBiNkhYkQJR+RHycf4CmKbrbik+RrfskzeeVtA/J8AQP4r4SpXSnem
         rQds1xdhdH0/82CtdFusyYz8YkgopXcIgOv8Q=
Received: by 10.67.119.20 with SMTP id w20mr831864ugm.78.1226842081562;
        Sun, 16 Nov 2008 05:28:01 -0800 (PST)
Received: from localhost ([94.37.6.2])
        by mx.google.com with ESMTPS id o24sm2512930ugd.31.2008.11.16.05.28.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 16 Nov 2008 05:28:01 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1226842089-1159-2-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101128>

git_get_heads_list(limit, class1, class2, ...) can now be used to retrieve
refs/class1, refs/class2 etc. Defaults to ('heads') or ('heads', 'remotes')
depending on the remote_heads option.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e1f81f6..0512020 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2681,15 +2681,18 @@ sub parse_from_to_diffinfo {
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
1.5.6.5

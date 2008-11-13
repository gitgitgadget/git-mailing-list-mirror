From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH v2 02/11] gitweb: git_get_heads_list accepts an optional list of refs.
Date: Thu, 13 Nov 2008 23:49:08 +0100
Message-ID: <1226616555-24503-3-git-send-email-giuseppe.bilotta@gmail.com>
References: <1226616555-24503-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-2-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 13 23:50:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0l1S-0004iw-U0
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 23:50:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752725AbYKMWtE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 17:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752713AbYKMWtD
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 17:49:03 -0500
Received: from mu-out-0910.google.com ([209.85.134.184]:43326 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625AbYKMWs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 17:48:59 -0500
Received: by mu-out-0910.google.com with SMTP id g7so1096018muf.1
        for <git@vger.kernel.org>; Thu, 13 Nov 2008 14:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=NoLxIrrkRO7ICfZlWbHC8J6786SeHIgGJ0DqFBN7F7Q=;
        b=AUjZM/O6tdj7bmU8o3qPZ1mbxWFdVfAIYAyWvau27d+KS15vZLFjRB6QfoqlxMAzVG
         ZtEjdVVyaXQofSgvDpDZ99eMFC3iO9P3Zv9jMhB6TwMhlb4kzXz/YdiYgpb4FeUIQWQS
         7GHABg//mMTvbuJuz3kVX216YGZzqdQwlcOIk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=OCKTy2AH9/zHeLBsITqdZdzacX5dQAP2YuRjFIMINML5HArQic99LyoQ3wbPI+FNlQ
         4Gh6L3r6PYOFAyNxYwH8lUHFJr9yg+NUOFlKO+6NG72MUmZyQFJWXGGW/n2FdyiJEzNe
         gPPxX4B4r4ebhU3VolSJ4w7L8yVP5bR06lMOs=
Received: by 10.180.233.15 with SMTP id f15mr64628bkh.188.1226616538084;
        Thu, 13 Nov 2008 14:48:58 -0800 (PST)
Received: from localhost ([78.15.2.247])
        by mx.google.com with ESMTPS id f31sm5905255fkf.0.2008.11.13.14.48.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 13 Nov 2008 14:48:57 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1226616555-24503-2-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git_get_heads_list(limit, dir1, dir2, ...) can now be used to retrieve
refs/dir1, refs/dir2 etc. Defaults to ('heads') or ('heads', 'remotes')
depending on the remote_heads option.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b6c4233..d7c97a3 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2663,15 +2663,18 @@ sub parse_from_to_diffinfo {
 ## parse to array of hashes functions
 
 sub git_get_heads_list {
-	my $limit = shift;
+	my ($limit, @class) = @_;
+	unless (defined @class) {
+		my ($remote_heads) = gitweb_check_feature('remote_heads');
+		@class = ('heads', $remote_heads ? 'remotes' : undef);
+	}
+	my @refs = map { "refs/$_" } @class;
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
1.5.6.5

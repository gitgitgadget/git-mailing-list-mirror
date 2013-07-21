From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 3/5] contrib: contacts: interpret committish akin to format-patch
Date: Sun, 21 Jul 2013 06:52:40 -0400
Message-ID: <1374403962-48361-4-git-send-email-sunshine@sunshineco.com>
References: <1374403962-48361-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 21 12:53:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0rGr-0003Xj-4F
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jul 2013 12:53:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755317Ab3GUKxc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jul 2013 06:53:32 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:44271 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755097Ab3GUKxR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jul 2013 06:53:17 -0400
Received: by mail-ie0-f179.google.com with SMTP id c10so13177560ieb.10
        for <git@vger.kernel.org>; Sun, 21 Jul 2013 03:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=g2UBnmSoDYxFFZM58aKK3U9dHHsFrich81hAn1WnDPs=;
        b=q88GXng4JrzrWJ8i1Mox5k0rKGylnY0Jb8N4oGEbuhMg6/O7FcOPAPejBJ32Y0//Uk
         bXYJvU9JB8t5G3Mi1BCZZsNYUS0gEna8m1YSblfGr5U2XvWscdsWx0uqPqF5KjVmmarS
         /dLtvd33iFN4iEXlVv0akR9+HcDUNlgZSfEE79qRAtSwuHxhNWPusTSABdQsRDs1vLUq
         /NsfnCbNV9qqT+t5nKrRMdcR9GGKD360JvviNCUrpdbqb3/1Ey12MU4WQQonr45tDV8j
         9rZ9pylEveiOiyFtnPBYRH0Ya+A3y0eOsQwuKLExqC0A0DiBwbEPgMiZra2eClDwuNfx
         mm1Q==
X-Received: by 10.43.112.198 with SMTP id et6mr14943606icc.4.1374403996742;
        Sun, 21 Jul 2013 03:53:16 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id d14sm50204105igz.6.2013.07.21.03.53.15
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 21 Jul 2013 03:53:15 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.3.803.gd114dc6
In-Reply-To: <1374403962-48361-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230923>

As a convenience, accept the same style <since> committish as accepted
by git-format-patch. For example:

  % git contacts origin

will consider commits in the current branch built atop 'origin', just as
"git format-patch origin" will format commits built atop 'origin'.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 contrib/contacts/git-contacts | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/contrib/contacts/git-contacts b/contrib/contacts/git-contacts
index 1686ff3..4553add 100755
--- a/contrib/contacts/git-contacts
+++ b/contrib/contacts/git-contacts
@@ -102,9 +102,26 @@ sub scan_patch_file {
 	close $f;
 }
 
+sub parse_rev_args {
+	my @args = @_;
+	open my $f, '-|',
+		qw(git rev-parse --revs-only --default HEAD --symbolic), @args
+		or die;
+	my @revs;
+	while (<$f>) {
+		chomp;
+		push @revs, $_;
+	}
+	close $f;
+	return @revs if scalar(@revs) != 1;
+	return "^$revs[0]", 'HEAD' unless $revs[0] =~ /^-/;
+	return $revs[0], 'HEAD';
+}
+
 sub scan_rev_args {
 	my ($commits, $args) = @_;
-	open my $f, '-|', qw(git rev-list --reverse), @$args or die;
+	my @revs = parse_rev_args(@$args);
+	open my $f, '-|', qw(git rev-list --reverse), @revs or die;
 	while (<$f>) {
 		chomp;
 		my $id = $_;
-- 
1.8.3.3.803.gd114dc6

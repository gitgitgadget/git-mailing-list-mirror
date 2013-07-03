From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 3/3] contrib: contacts: interpret committish akin to format-patch
Date: Wed,  3 Jul 2013 16:59:42 -0400
Message-ID: <1372885182-5512-4-git-send-email-sunshine@sunshineco.com>
References: <1372885182-5512-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 03 23:00:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuUAG-000062-I8
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 23:00:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933371Ab3GCVAa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 17:00:30 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:43822 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933348Ab3GCVA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 17:00:27 -0400
Received: by mail-oa0-f42.google.com with SMTP id j6so893889oag.15
        for <git@vger.kernel.org>; Wed, 03 Jul 2013 14:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=CaEWSfwbxv5wRsv1LFlubhYzGgNyl/lcznvhdyF+oxc=;
        b=AVDMma1W+AF6Iy5uSUqSMHZ/HfjcPgKZF804Bk+02gS7IFwWFw+AlOtyDUp2vchb6q
         Dq98Yd8qga6rQvO2oZJLaDjulo90KgQPi73bn+/uYTZ7OKjlMJ+5FUdLHoalxabNdqN8
         NtzT28nFnsdyJu8ZjnhbYtlKWGraJsOorrv38SjZlv9R/Ff2CMgYYpZZWPuJV2Nn6opu
         oy8TafqXnz3SsNfN6S8bt55d36FINII2dIbgPE7N9LJJPMMriGg2IVOiXksS1B0lA0ET
         18ydQWgVHmDBQ9ri/2Nw5T3XwFKjcUrXgd5U2/ZNyTHQHJ8kk9wDeqEXWvwmobYKsBVn
         u+iw==
X-Received: by 10.182.181.73 with SMTP id du9mr2649770obc.106.1372885227012;
        Wed, 03 Jul 2013 14:00:27 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id ps5sm14400579oeb.8.2013.07.03.14.00.25
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 03 Jul 2013 14:00:26 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1372885182-5512-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229531>

As a convenience, accept the same style <since> committish as accepted
by git-format-patch. For example:

  % git contacts master

will consider commits in the current branch built atop 'master', just as
"git format-patch master" will format commits built atop 'master'.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 contrib/contacts/git-contacts | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/contrib/contacts/git-contacts b/contrib/contacts/git-contacts
index 42e6059..3cd0ea2 100755
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
1.8.3.2

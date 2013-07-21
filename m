From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 4/5] contrib: contacts: add mailmap support
Date: Sun, 21 Jul 2013 06:52:41 -0400
Message-ID: <1374403962-48361-5-git-send-email-sunshine@sunshineco.com>
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
	id 1V0rGr-0003Xj-ME
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jul 2013 12:53:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755330Ab3GUKxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jul 2013 06:53:33 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:53950 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755280Ab3GUKxS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jul 2013 06:53:18 -0400
Received: by mail-ie0-f171.google.com with SMTP id qd12so12763965ieb.2
        for <git@vger.kernel.org>; Sun, 21 Jul 2013 03:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=OEx3jZTF9iPAOG9aKOg0cQ+TImL3NkmFAEe2vJiSopc=;
        b=OM4knBBYirMXnbiCWIzPcwInt/R3EqrqxXbO1l+LjHMuCb7J7ibt1+8z2SZSoJJtvk
         XyrsHBI2hI7eScCn/0aarXkpX5D6wNlujHxBwSsSCygrVc8uPwZUzwuALd7eIIeNp92Q
         AX93LDGFJc9o8ZucejPDtvHfGBmudcad+6qhOEOC+iFrXJClWYneb+tDT8Hbyco8kmfN
         q5kPFg39DaB2D7dGQPAHOzCjOgGwzKsXqJhRZRcqY9uevOPE/37SZZAdiZ+EnOixexa5
         FxzQJlFeeLC0YeEBbNYyZZIErEEm4VGfEgarIs5RwRd8+7H3uj6XAXX0+reCUJcR106+
         QRJA==
X-Received: by 10.50.114.233 with SMTP id jj9mr15837718igb.5.1374403998456;
        Sun, 21 Jul 2013 03:53:18 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id d14sm50204105igz.6.2013.07.21.03.53.16
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 21 Jul 2013 03:53:17 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.3.803.gd114dc6
In-Reply-To: <1374403962-48361-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230924>

The purpose of git-contacts is to determine a list of people who might
have some interest in a patch or set of changes. It can be used as
git-send-email's --cc-cmd argument or the computed list might be used to
ask for comments on a proposed change.  As such, it is important to
report up-to-date email addresses in the computed list rather than
potentially outdated ones recorded with commits.  Apply git's mailmap
functionality to the retrieved contacts in order to achieve this goal.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 contrib/contacts/git-contacts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/contrib/contacts/git-contacts b/contrib/contacts/git-contacts
index 4553add..d80f7d1 100755
--- a/contrib/contacts/git-contacts
+++ b/contrib/contacts/git-contacts
@@ -133,6 +133,23 @@ sub scan_rev_args {
 	close $f;
 }
 
+sub mailmap_contacts {
+	my ($contacts) = @_;
+	my %mapped;
+	my $pid = open2 my $reader, my $writer, qw(git check-mailmap --stdin);
+	for my $contact (keys(%$contacts)) {
+		print $writer "$contact\n";
+		my $canonical = <$reader>;
+		chomp $canonical;
+		$mapped{$canonical} += $contacts->{$contact};
+	}
+	close $reader;
+	close $writer;
+	waitpid($pid, 0);
+	die "git-check-mailmap error: $?\n" if $?;
+	return \%mapped;
+}
+
 if (!@ARGV) {
 	die "No input revisions or patch files\n";
 }
@@ -161,6 +178,7 @@ for my $commit (values %commits) {
 		$contacts->{$contact}++;
 	}
 }
+$contacts = mailmap_contacts($contacts);
 
 my $ncommits = scalar(keys %commits);
 for my $contact (keys %$contacts) {
-- 
1.8.3.3.803.gd114dc6

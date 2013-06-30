From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH/RFC 4/4] contrib: contacts: interpret committish akin to format-patch
Date: Sun, 30 Jun 2013 07:08:32 -0400
Message-ID: <1372590512-21341-5-git-send-email-sunshine@sunshineco.com>
References: <1372590512-21341-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 30 13:10:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtFWt-0000lE-Hz
	for gcvg-git-2@plane.gmane.org; Sun, 30 Jun 2013 13:10:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752094Ab3F3LKp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Jun 2013 07:10:45 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:63059 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752051Ab3F3LKi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jun 2013 07:10:38 -0400
Received: by mail-ie0-f173.google.com with SMTP id k13so7455838iea.32
        for <git@vger.kernel.org>; Sun, 30 Jun 2013 04:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=deySNuFqrV1rZkdCLMKQ6byyvfrRcCgQMqxSsBz6SOk=;
        b=azt60WPp3/rtyRmSr40HGOx67GLdluLikf+4m3o3PbBshVLQxk0HRkBqRUnUMLSZFg
         dpahJvjU8dz0UsaIOa/E3Jmsumb7ePeUpOPOInrdTCzlL+wbyRwh3OIfqwQ+f2qaslH7
         VeLAvCn1Bg5HQ96sOTA+yne0V61WiUy44r45aY9QdekFyZVfltZoBnvPo7+QOJk94c68
         3r/fZz20vjSIBnoyrXBp5VtG62XRHZAxGFRAQNLQAJE9ZQrztDfBPAE3Jlkp5P/thf+x
         cXh2SAHBwHA+03Qdn79VC6Rz3wx+JUqLhhkhxcjL7w3Hcn9xKinawEgZWlgQjClYuVEp
         BeaQ==
X-Received: by 10.50.80.9 with SMTP id n9mr10926362igx.42.1372590637582;
        Sun, 30 Jun 2013 04:10:37 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id ir8sm7931119igb.6.2013.06.30.04.10.35
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 30 Jun 2013 04:10:36 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1372590512-21341-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229269>

As a convenience, accept the same style committish as accepted by
git-format-patch. For example:

  % git contacts master

will consider commits in the current branch built atop 'master', just as
"git format-patch master" will format commits built atop 'master'.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 contrib/contacts/git-contacts | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/contrib/contacts/git-contacts b/contrib/contacts/git-contacts
index abb90a1..10d77d3 100755
--- a/contrib/contacts/git-contacts
+++ b/contrib/contacts/git-contacts
@@ -104,9 +104,26 @@ sub commits_from_patch {
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
 sub commits_from_rev_args {
 	my ($commits, $args) = @_;
-	open my $f, '-|', qw(git rev-list --reverse), @$args or die;
+	my @revs = parse_rev_args(@$args);
+	open my $f, '-|', qw(git rev-list --reverse), @revs or die;
 	while (<$f>) {
 		chomp;
 		my $id = $_;
-- 
1.8.3.2

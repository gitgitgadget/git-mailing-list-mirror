From: Samuel GROOT <samuel.groot@grenoble-inp.org>
Subject: [PATCH v4 4/6] send-email: create email parser subroutine
Date: Wed,  8 Jun 2016 15:01:40 +0200
Message-ID: <20160608130142.29879-5-samuel.groot@grenoble-inp.org>
References: <20160607140148.23242-1-tom.russello@grenoble-inp.org>
 <20160608130142.29879-1-samuel.groot@grenoble-inp.org>
Cc: samuel.groot@grenoble-inp.org, tom.russello@grenoble-inp.org,
	erwan.mathoniere@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	matthieu.moy@grenoble-inp.fr, gitster@pobox.com, aaron@schrab.com,
	e@80x24.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 15:04:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAd9Z-0003Rw-Ff
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 15:04:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753695AbcFHNEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 09:04:07 -0400
Received: from zm-smtpout-1.grenet.fr ([130.190.244.97]:35176 "EHLO
	zm-smtpout-1.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753354AbcFHNEF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 09:04:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 3F3C12591;
	Wed,  8 Jun 2016 15:04:03 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vr4SXJmzuxvV; Wed,  8 Jun 2016 15:04:03 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 2FECF2415;
	Wed,  8 Jun 2016 15:04:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 2D0392064;
	Wed,  8 Jun 2016 15:04:03 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3ITfKQGE6SLG; Wed,  8 Jun 2016 15:04:03 +0200 (CEST)
Received: from wificampus-030012.grenet.fr (wificampus-030012.grenet.fr [130.190.30.12])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id F414A2066;
	Wed,  8 Jun 2016 15:04:01 +0200 (CEST)
X-Mailer: git-send-email 2.8.2.667.gf43de12
In-Reply-To: <20160608130142.29879-1-samuel.groot@grenoble-inp.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296792>

We need a simple and generic way to parse an email file.

Since it would be hard to include and maintain an external library,
create an simple email parser subroutine to parse an email file.

Signed-off-by: Samuel GROOT <samuel.groot@grenoble-inp.org>
Signed-off-by: Tom RUSSELLO <tom.russello@grenoble-inp.org>
Signed-off-by: Matthieu MOY <matthieu.moy@grenoble-inp.fr>
---
We chose to create our own simple email parser and only use it for the
"quote email" feature to pave the way for the refactorization of the patch
parser [1] that may come after our current school project.

[1] * http://thread.gmane.org/gmane.comp.version-control.git/295752

 perl/Git.pm | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/perl/Git.pm b/perl/Git.pm
index ce7e4e8..1af4805 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -865,6 +865,40 @@ sub ident_person {
 	return "$ident[0] <$ident[1]>";
 }
 
+=item parse_email
+
+Return a hash of email fields extracted from a file handler.
+
+=cut
+
+sub parse_email {
+	my %mail = ();
+	my $fh = shift;
+	my $last_header;
+
+	# Unfold and parse multiline header fields
+	while (<$fh>) {
+		last if /^\s*$/;
+		s/\r\n|\n|\r//;
+		if (/^([^\s:]+):[\s]+(.*)$/) {
+			$last_header = lc($1);
+			@{$mail{$last_header}} = ()
+				unless defined $mail{$last_header};
+			push @{$mail{$last_header}}, $2;
+		} elsif (/^\s+\S/ and defined $last_header) {
+			s/^\s+/ /;
+			push @{$mail{$last_header}}, $_;
+		} else {
+			die("Mail format undefined!\n");
+		}
+	}
+
+	# Separate body from header
+	$mail{"body"} = [(<$fh>)];
+
+	return \%mail;
+}
+
 =item parse_mailboxes
 
 Return an array of mailboxes extracted from a string.
-- 
2.8.2.537.gb153d2a

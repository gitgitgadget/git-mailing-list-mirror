From: Tom Russello <tom.russello@grenoble-inp.org>
Subject: [PATCH v3 4/6] send-email: create email parser subroutine
Date: Tue,  7 Jun 2016 16:01:46 +0200
Message-ID: <20160607140148.23242-5-tom.russello@grenoble-inp.org>
References: <1464369102-7551-1-git-send-email-tom.russello@grenoble-inp.org>
 <20160607140148.23242-1-tom.russello@grenoble-inp.org>
Cc: erwan.mathoniere@grenoble-inp.org, samuel.groot@grenoble-inp.org,
	jordan.de-gea@grenoble-inp.org, matthieu.moy@grenoble-inp.fr,
	e@80x24.org, aaron@schrab.com, gitster@pobox.com,
	Tom RUSSELLO <tom.russello@grenoble-inp.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 16:02:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAHaW-0005VW-Sf
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 16:02:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755304AbcFGOCZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 10:02:25 -0400
Received: from zm-smtpout-1.grenet.fr ([130.190.244.97]:51082 "EHLO
	zm-smtpout-1.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754967AbcFGOCW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 10:02:22 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id E10312591;
	Tue,  7 Jun 2016 16:02:19 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7ORE05fE1xrJ; Tue,  7 Jun 2016 16:02:19 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id D16A32570;
	Tue,  7 Jun 2016 16:02:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id CED402066;
	Tue,  7 Jun 2016 16:02:19 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ejdd1fL-Nz6s; Tue,  7 Jun 2016 16:02:19 +0200 (CEST)
Received: from ux-305.grenet.fr (eduroam-033003.grenet.fr [130.190.33.3])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id B52FE2064;
	Tue,  7 Jun 2016 16:02:19 +0200 (CEST)
X-Mailer: git-send-email 2.9.0.rc0.40.g1232aeb.dirty
In-Reply-To: <20160607140148.23242-1-tom.russello@grenoble-inp.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296684>

We need a simple and generic way to parse an email file.

Since it would be hard to include and maintain an external library,
create an simple email parser subroutine to parse an email file.

Signed-off-by: Samuel GROOT <samuel.groot@grenoble-inp.org>
Signed-off-by: Tom RUSSELLO <tom.russello@grenoble-inp.org>
Signed-off-by: Matthieu MOY <matthieu.moy@grenoble-inp.fr>
---
We chose to create our own simple email parser and only use it for the
"quote email" feature to pave the way for the refactorization of the patch
parser [0] that may come after our current school project.

[0] * http://thread.gmane.org/gmane.comp.version-control.git/295752

 git-send-email.perl | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/git-send-email.perl b/git-send-email.perl
index 4822f41..db114ae 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1750,3 +1750,31 @@ sub body_or_subject_has_nonascii {
 	}
 	return 0;
 }
+
+sub parse_email {
+        my %mail = ();
+        my $fh = shift;
+        my $last_header;
+
+        # Unfold and parse multiline header fields
+        while (<$fh>) {
+                last if /^\s*$/;
+                s/\r\n|\n|\r//;
+                if (/^([^\s:]+):[\s]+(.*)$/) {
+                        $last_header = lc($1);
+                        @{$mail{$last_header}} = ()
+                                unless defined $mail{$last_header};
+                        push @{$mail{$last_header}}, $2;
+                } elsif (/^\s+\S/ and defined $last_header) {
+                        s/^\s+/ /;
+                        push @{$mail{$last_header}}, $_;
+                } else {
+                        die("Mail format undefined !\n");
+                }
+        }
+
+        # Separate body from header
+        $mail{"body"} = [(<$fh>)];
+
+        return \%mail;
+}
-- 
2.8.3

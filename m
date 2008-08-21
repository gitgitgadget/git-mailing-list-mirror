From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] gitweb: ref markers link to named shortlogs
Date: Thu, 21 Aug 2008 20:04:20 +0200
Message-ID: <1219341860-4913-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Petr Baudis <pasky@ucw.cz>, Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 21 20:07:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWEX0-00007g-BS
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 20:05:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753322AbYHUSEG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 14:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751963AbYHUSEF
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 14:04:05 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:25111 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753149AbYHUSEE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 14:04:04 -0400
Received: by nf-out-0910.google.com with SMTP id d3so41520nfc.21
        for <git@vger.kernel.org>; Thu, 21 Aug 2008 11:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=RI/umD9peUQyfeecExvKm7ZqxtSWEzF94NwtLiLAERc=;
        b=OkUZk+9DAzRN/0gwZebcJexPL44/lfYekO7NitCkqqOXzYIicC8tGvx6zy1M/PX60Z
         MC9HN0IyJjEtGP//gwDkAGAs1cp3Y7ZacxbRXRP4UwrcANN7G8sjjlS5udOgYaiTTFkY
         7bLzNUNNzjJ9sFk6pqGK3o3q/BP5V0M4BpxEo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=nIzW1nbJ7GLSE27w5uq3Oi5LLTzh0Ho/mt1fL4rRbf5+r6lhRvyCGWMel+xzSZCAFp
         AG/5lAFUXWidDfS1p5oJ6QuAOx3kIu7TW/esz0XXiS4qCvVbTLPWma+Olh673Ucry7dk
         xoyacK+UCVWZZERWRiJ+28yEPJWWG9lZvrHzY=
Received: by 10.210.80.17 with SMTP id d17mr80714ebb.119.1219341841541;
        Thu, 21 Aug 2008 11:04:01 -0700 (PDT)
Received: from localhost ( [78.13.49.52])
        by mx.google.com with ESMTPS id k10sm164052nfh.25.2008.08.21.11.03.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Aug 2008 11:04:00 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93185>

This patch turns ref markers for tags and heads into links to
appropriate views for the ref name. Appropriate changes are made in the
CSS to prevent ref markers to be annoyingly blue and underlined.

For all git ref types it's assumed that the preferred view is named like
the ref type itself. For commits, we map the view to shortlog.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---

This is a resend of version 2 of the patch, as it seems to have
dropped into oblivion without ACKs or NACKs.

 gitweb/gitweb.css  |    5 +++++
 gitweb/gitweb.perl |    7 ++++++-
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index aa0eeca..2b43eea 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -481,6 +481,11 @@ span.refs span {
 	border-color: #ffccff #ff00ee #ff00ee #ffccff;
 }
 
+span.refs span a {
+	text-decoration: none;
+	color: inherit;
+}
+
 span.refs span.ref {
 	background-color: #aaaaff;
 	border-color: #ccccff #0033cc #0033cc #ccccff;
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 90cd99b..a12ce87 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1093,10 +1093,14 @@ sub format_log_line_html {
 sub format_ref_marker {
 	my ($refs, $id) = @_;
 	my $markers = '';
+	my %view = (
+		"commit" => "shortlog",
+	);
 
 	if (defined $refs->{$id}) {
 		foreach my $ref (@{$refs->{$id}}) {
 			my ($type, $name) = qw();
+			my $git_type = git_get_type($ref);
 			# e.g. tags/v2.6.11 or heads/next
 			if ($ref =~ m!^(.*?)s?/(.*)$!) {
 				$type = $1;
@@ -1107,7 +1111,8 @@ sub format_ref_marker {
 			}
 
 			$markers .= " <span class=\"$type\" title=\"$ref\">" .
-			            esc_html($name) . "</span>";
+				$cgi->a({-href => href(action=>$view{$git_type} || $git_type, hash=>$name)}, $name) .
+				"</span>";
 		}
 	}
 
-- 
1.5.6.3

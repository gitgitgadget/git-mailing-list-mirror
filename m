From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv6 07/10] gitweb: remotes view for a single remote
Date: Sun, 24 Oct 2010 12:45:33 +0200
Message-ID: <1287917136-26103-8-git-send-email-giuseppe.bilotta@gmail.com>
References: <1287917136-26103-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 24 12:46:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9y5y-0004rf-CJ
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 12:46:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479Ab0JXKqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 06:46:17 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45935 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932465Ab0JXKqO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 06:46:14 -0400
Received: by mail-wy0-f174.google.com with SMTP id 28so2370311wyf.19
        for <git@vger.kernel.org>; Sun, 24 Oct 2010 03:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=XbD1fiC36FJma/VwMLmx4Xdlu2TPbZTtKeljxs8bCrc=;
        b=TRlHigbTheYvhaYIdnU7y8y+OmPOeuchyMSbVXxuX07j78D/e2bnPys9sGx8Y7zmCF
         YhxV0WiD9Kaeh2o5jLm51cZOzZ8BOedw5N4HpqmUeNR8zDCwWz5n9c0rR0414AKHR6na
         R00sBM3FAMaBWWNXDRFzrdG6Iu7UCnwP7nzcE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=vT8cu4LGzWqJ8BgbeTRBilvNnAqHjKNmaN1du+T7qPrZ0/ZY7TNuLjAII+St36mwTp
         qgomxM0vEjRMqjixF20WTpHKciKboNDDnBoH2Gzb4gRzlCb9PBSpJTHWC72vZ94j7h1X
         XtgZF35ls+cwHZNyCAit8iH5DO/HuOaZeoUrY=
Received: by 10.216.51.21 with SMTP id a21mr4857659wec.50.1287917174071;
        Sun, 24 Oct 2010 03:46:14 -0700 (PDT)
Received: from localhost ([151.60.176.122])
        by mx.google.com with ESMTPS id e56sm3315384wer.46.2010.10.24.03.46.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Oct 2010 03:46:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.68.g6ec8
In-Reply-To: <1287917136-26103-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159849>

When 'remotes' view is passed the 'hash' parameter, interpret it as the
name of a remote and limit the view the the heads of that remote.

In single-remote view we let the user switch easily to the default
remotes view by specifying an -action_extra for the page header and by
enabling the 'remotes' link in the reference navigation submenu.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   29 +++++++++++++++++++++++++----
 1 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 3612e63..aa80748 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5561,14 +5561,35 @@ sub git_remotes {
 		or die_error(403, "Remote heads view is disabled");
 
 	my $head = git_get_head_hash($project);
-	git_header_html();
-	git_print_page_nav('','', $head,undef,$head,format_ref_views('remotes'));
-	git_print_header_div('summary', $project);
+	my $remote = $input_params{'hash'};
+
+	my @remotelist;
+
+	if (defined $remote) {
+		# only display the heads in a given remote
+		@remotelist = map {
+			my $ref = $_ ;
+			$ref->{'name'} =~ s!^$remote/!!;
+			$ref
+		} git_get_heads_list(undef, "remotes/$remote");
+	} else {
+		@remotelist = git_get_heads_list(undef, 'remotes');
+	}
+
+	git_header_html(undef, undef, -action_extra => $remote);
+	git_print_page_nav('', '',  $head, undef, $head,
+		format_ref_views($remote ? '' : 'remotes'));
+
+	if (defined $remote) {
+		git_print_header_div('remotes', "$remote remote for $project");
+	} else {
+		git_print_header_div('summary', "$project remotes");
+	}
 
-	my @remotelist = git_get_heads_list(undef, 'remotes');
 	if (@remotelist) {
 		git_heads_body(\@remotelist, $head);
 	}
+
 	git_footer_html();
 }
 
-- 
1.7.3.68.g6ec8

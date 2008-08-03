From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv2] gitweb: ref markers link to named shortlogs
Date: Sun,  3 Aug 2008 22:48:30 +0200
Message-ID: <1217796510-379-1-git-send-email-giuseppe.bilotta@gmail.com>
References: <20080803132050.GA10151@machine.or.cz>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@ucw.cz>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 03 22:49:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPkVt-00024z-Tv
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 22:49:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755612AbYHCUsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 16:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756008AbYHCUsM
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 16:48:12 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:62924 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754923AbYHCUsL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 16:48:11 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1581239fkq.5
        for <git@vger.kernel.org>; Sun, 03 Aug 2008 13:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=SA4GbS06AHoKRUnBBogVVTRHAyiJbVudERVaFXG4rew=;
        b=N1wH7Fapbv/oD2vujsE4Grfeuu4ug1elRjcKgQ11raeyOExnfUHur0xCUUMRlTJnZI
         NkaNlzDvmJs61ne0vcDrz67Y0nkd/ihv1g8KFhGMyhRraXNoenbgQNtvLvWrjwVmSXoc
         AK2HKlEiNK5o/94FDKhhKNIrTCFqV53AIa6KE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=c2/ZLt1qCNSPQDCh19zDmOiiTtHQ8gBP23WRJq143VykdpI/hhBT+baPaR05x5ZA+j
         hH7k4A9gPotamUHPWlboYczmpc9Vikc0WrZ03o1ZmZ/a7DOu2SUOG820huwfAKFIN4LZ
         goH1Ki62izG3ijZs2OzAqHboEktgBOT14vZz8=
Received: by 10.181.22.8 with SMTP id z8mr4815599bki.78.1217796490074;
        Sun, 03 Aug 2008 13:48:10 -0700 (PDT)
Received: from localhost ( [94.37.6.145])
        by mx.google.com with ESMTPS id 31sm3670668fkt.7.2008.08.03.13.48.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 03 Aug 2008 13:48:09 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <20080803132050.GA10151@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91270>

This patch turns ref markers for tags and heads into links to
appropriate views for the ref name. Appropriate changes are made in the
CSS to prevent ref markers to be annoyingly blue and underlined.

For all git ref types it's assumed that the preferred view is named like
the ref type itself. For commits, we map the view to shortlog.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---

Following pasky's suggestion, the action used by the ref marker
is now determined from the ref type, default action to the ref type
itsef. Currently the only non-default action is shortlog for commit
refs, but the map can be expanded as needed.

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

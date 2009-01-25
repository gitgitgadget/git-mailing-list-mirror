From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] gitweb: check if-modified-since for feeds
Date: Sun, 25 Jan 2009 23:42:50 +0100
Message-ID: <1232923370-4427-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1232686121-1800-5-git-send-email-giuseppe.bilotta@gmail.com>
 <1232923370-4427-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 25 23:44:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRDiD-0007JF-CI
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 23:44:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbZAYWmj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 17:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbZAYWmi
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 17:42:38 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:41773 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbZAYWmi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 17:42:38 -0500
Received: by fxm13 with SMTP id 13so1445841fxm.13
        for <git@vger.kernel.org>; Sun, 25 Jan 2009 14:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=gQubeVWaULVUv6EyTxpkE3At5UgMtpxE0fiHUH8En20=;
        b=dz+tS103fjDTBcXp0R9lM5ctA56/pIBLRn/RsKKM4/sXdXD0K83CWdMgmWBBKkbwrD
         6F5c0X3SA/BIn5u0UBdQgm0wEik1louKffRkjeM3GKsFFCvefI3VH4tzwcYFxOYsJOAy
         lHyBR4qNtzS/TkQ2r1gHpfvI1WPxKNTQuTl3E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=XGek/kmHaft2XeOnlI0z6maF77yIyns1PS+PTPpnpYHuEysaiJictlDlhxbI7+LuiC
         fJGNcxpq0Z9D5h6NmdHZfErqEd7j5v4gWZGWzwqQQ9gtbiQOnQ0H2uKVq30NBOq23mTS
         HtKW4o6uGEUMDNnHffJ+1dsTgYxck2EMkiHts=
Received: by 10.103.11.7 with SMTP id o7mr1499269mui.103.1232923355970;
        Sun, 25 Jan 2009 14:42:35 -0800 (PST)
Received: from localhost ([94.37.14.37])
        by mx.google.com with ESMTPS id j6sm6455115mue.24.2009.01.25.14.42.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Jan 2009 14:42:35 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1232923370-4427-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107116>

Offering Last-modified header for feeds is only half the work: we should
also check that same date against If-modified-since, and bail out early
with 304 Not Modified.
---
 gitweb/gitweb.perl |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 8c49c75..0a5d229 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -6015,7 +6015,25 @@ sub git_feed {
 	}
 	if (defined($commitlist[0])) {
 		%latest_commit = %{$commitlist[0]};
-		%latest_date   = parse_date($latest_commit{'committer_epoch'});
+		my $latest_epoch = $latest_commit{'committer_epoch'};
+		%latest_date   = parse_date($latest_epoch);
+		my $if_modified = $cgi->http('IF_MODIFIED_SINCE');
+		if (defined $if_modified) {
+			my $since;
+			if (eval { require HTTP::Date; 1; }) {
+				$since = HTTP::Date::str2time($if_modified);
+			} elsif (eval { require Time::ParseDate; 1; }) {
+				$since = Time::ParseDate::parsedate($if_modified, GMT => 1);
+			}
+			if (defined $since && $latest_epoch <= $since) {
+				print $cgi->header(
+					-type => $content_type,
+					-charset => 'utf-8',
+					-last_modified => $latest_date{'rfc2822'},
+					-status => 304);
+				return;
+			}
+		}
 		print $cgi->header(
 			-type => $content_type,
 			-charset => 'utf-8',
-- 
1.5.6.5

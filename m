From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv2 6/6] gitweb: check if-modified-since for feeds
Date: Mon, 26 Jan 2009 12:50:16 +0100
Message-ID: <1232970616-21167-7-git-send-email-giuseppe.bilotta@gmail.com>
References: <1232970616-21167-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1232970616-21167-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1232970616-21167-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1232970616-21167-4-git-send-email-giuseppe.bilotta@gmail.com>
 <1232970616-21167-5-git-send-email-giuseppe.bilotta@gmail.com>
 <1232970616-21167-6-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 26 12:52:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRQ1E-0004CT-9l
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 12:52:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753227AbZAZLuc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 06:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752080AbZAZLub
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 06:50:31 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:62961 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753133AbZAZLuP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 06:50:15 -0500
Received: by mail-ew0-f21.google.com with SMTP id 14so329602ewy.13
        for <git@vger.kernel.org>; Mon, 26 Jan 2009 03:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=qfxb8v4NFyKmC3baxXVU+hU9feOhxW5dXoZktZIQ7ZQ=;
        b=lyvdmL7TPh5QveXXUdomQi8RcjYgym2/HuqjlMIF8mP5kCZL0ZoH4chluqRok4vp1N
         EkF3bxUwtmUZfQGBAJ+gjd8supCjuiEP/OBqqjE1sJMDvbmv7KtJm8erONf6S1551HU1
         sXPQgoq8x16HIvyd8ObcR8UXLt+6E+bpD4MAM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=KBxNd4yM4Nx0Zp+9z6QyD3G6slUTM2EKTb95fr50JgmXOiSxHnmeXGFf+bivVcMOhx
         hMd+IrA3frRtM8pNztIXZGpufAwNmDT1DtHfxttefkpTuSW1WxqOPcvMjjrWlr2c1ayy
         NIdMvD3NAQKBAJbaydOz3GfIxTPHxgjTse62Q=
Received: by 10.103.6.18 with SMTP id j18mr5821582mui.33.1232970614576;
        Mon, 26 Jan 2009 03:50:14 -0800 (PST)
Received: from localhost ([94.37.14.37])
        by mx.google.com with ESMTPS id j2sm12121768mue.5.2009.01.26.03.50.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Jan 2009 03:50:13 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1232970616-21167-6-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107201>

Offering Last-modified header for feeds is only half the work, even if
we bail out early on HEAD requests. We should also check that same date
against If-modified-since, and bail out early with 304 Not Modified if
that's the case.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 8c49c75..f4defb0 100755
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
+					-status => '304 Not Modified');
+				return;
+			}
+		}
 		print $cgi->header(
 			-type => $content_type,
 			-charset => 'utf-8',
-- 
1.5.6.5

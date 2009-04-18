From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH RFC3.5 08/12] send-email: Move Subject sanitization from --compose code to send_message
Date: Sat, 18 Apr 2009 12:02:04 -0500
Message-ID: <1240074128-16132-9-git-send-email-mfwitten@gmail.com>
References: <1240074128-16132-1-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-2-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-3-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-4-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-5-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-6-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-7-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-8-git-send-email-mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 18 19:08:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvE1V-0007La-69
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 19:08:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757368AbZDRRGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 13:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757308AbZDRRGi
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 13:06:38 -0400
Received: from mail-qy0-f126.google.com ([209.85.221.126]:45168 "EHLO
	mail-qy0-f126.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756999AbZDRRGh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 13:06:37 -0400
Received: by qyk32 with SMTP id 32so634324qyk.33
        for <git@vger.kernel.org>; Sat, 18 Apr 2009 10:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=//ULhTo6VYJSdJBGD+ovifZAXIp97cFotKBOd+ktrtg=;
        b=jhEsm843ysjsKwl1T8WXeal8/N9ZfPtwyK0Fun86hT18sp/AaCNkBeDPinMP4Del3v
         Ny+QvU+kBmPNKGiCDEJ7lNuGGObveVugi0PzUWVd/bNsKZytcWbb9+PwZaw762FgFsTt
         Sim6Bz6hTuy1CPdYSa7BskjfNagiKqUYLE7o4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=fYhBVECa8+/ZWRPTRMmNJQZdoMrIEAUwv4ld94gZccWk6QqwxFINlHdTcw8vsUEP0h
         d2/rgKaO3GVeGavZkHvLfwEDltop5xawq2AgTHbDp2W4b2NDzyXUbi4wR25VEiJFzP6G
         q4Wvdi6QsclVcO1JUukI3IgpzxS2R6BxxCvhQ=
Received: by 10.220.77.1 with SMTP id e1mr4236170vck.91.1240074394900;
        Sat, 18 Apr 2009 10:06:34 -0700 (PDT)
Received: from localhost.localdomain (97-116-125-103.mpls.qwest.net [97.116.125.103])
        by mx.google.com with ESMTPS id 6sm1776586ywn.52.2009.04.18.10.06.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 18 Apr 2009 10:06:34 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.479.g2aec
In-Reply-To: <1240074128-16132-8-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116852>

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 git-send-email.perl |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index f3e2ccd..b9a6d42 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -676,12 +676,7 @@ EOT
 			$need_8bit_cte = 0;
 		} elsif (/^Subject:\s*(.+)\s*$/i) {
 			$initial_subject = $1;
-			my $subject = $initial_subject;
-			$_ = "Subject: " .
-				($subject =~ /[^[:ascii:]]/ ?
-				 quote_rfc2047($subject) :
-				 $subject) .
-				"\n";
+			next;
 		} elsif (/^In-Reply-To:\s*(.+)\s*$/i) {
 			$initial_reply_to = $1;
 			next;
@@ -914,9 +909,11 @@ sub send_message
 	my $sanitized_sender = sanitize_address($sender);
 	make_message_id() unless defined($message_id);
 
+	my $sanitized_subject = ($subject =~ /[^[:ascii:]]/) ? quote_rfc2047($subject) : $subject;
+
 	my $header = "From: $sanitized_sender
 To: $to${ccline}
-Subject: $subject
+Subject: $sanitized_subject
 Date: $date
 Message-Id: $message_id
 X-Mailer: git-send-email $gitversion
-- 
1.6.2.2.479.g2aec

From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH v2 08/11] gitweb: display HEAD in heads list when detached
Date: Thu, 13 Nov 2008 23:49:14 +0100
Message-ID: <1226616555-24503-9-git-send-email-giuseppe.bilotta@gmail.com>
References: <1226616555-24503-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-4-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-5-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-6-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-7-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-8-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 13 23:50:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0l1X-0004iw-0F
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 23:50:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753286AbYKMWtX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 17:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753372AbYKMWtV
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 17:49:21 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:37802 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753197AbYKMWtR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 17:49:17 -0500
Received: by fg-out-1718.google.com with SMTP id 19so912917fgg.17
        for <git@vger.kernel.org>; Thu, 13 Nov 2008 14:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=QktGzREdIqaZ1kO45FSksy0+t8a5kOTzu8LE+w7fRmI=;
        b=IKyTMvnQ0t3tir/ShfAYPLczH0tQlRn3YTwIHYef20oFnzI0rM15S6sb31tAh2a2bg
         lDTge+IEDgxXdk2sDEiA7FG6Rwp2O8ziJs8/grG1pdFrocz1tLsGORGsGJOt9ZxKCEdK
         R9zFtsb2a/FVfhA3cPRRK1YHpBP/WVg+5VcVU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=C/cLfly6zYERlDBnXx0dRaCXWaRL7ijhPFbW9QsXOnUu/m7xYoQdO27YLPvJ4wm8GJ
         m+htzfcrdknLMU9iEWajRVcmHC3/yCevE81v8cw/BpY/OVPsCqdtRoECPdJ3XK0nTWw4
         PYO820Tc/B5tRDjDWMyiMGJaRWU0WdM7Noy2g=
Received: by 10.180.228.19 with SMTP id a19mr70103bkh.93.1226616556637;
        Thu, 13 Nov 2008 14:49:16 -0800 (PST)
Received: from localhost ([78.15.2.247])
        by mx.google.com with ESMTPS id p9sm5902580fkb.5.2008.11.13.14.49.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 13 Nov 2008 14:49:16 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1226616555-24503-8-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 09728cb..a168f6f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2672,6 +2672,27 @@ sub git_get_heads_list {
 	my @refs = map { "refs/$_" } @class;
 	my @headslist;
 
+	if (grep { $_ eq 'heads' } @class) {
+		my @x = (git_cmd(), 'branch');
+		my @ret = split("\n", qx(@x));
+		if (grep { /^\* \(no branch\)$/ } @ret) { ;
+			my %ref_item;
+			@x = (git_cmd(), 'log', '-1', '--pretty=format:%H%n%ct%n%s');
+			my ($hash, $epoch, $title) = split("\n", qx(@x), 3);
+
+			$ref_item{'class'} = 'head';
+			$ref_item{'name'} = 'HEAD';
+			$ref_item{'id'} = $hash;
+			$ref_item{'title'} = $title || '(no commit message)';
+			if ($ref_item{'epoch'} = $epoch) {
+				$ref_item{'age'} = age_string(time - $ref_item{'epoch'});
+			} else {
+				$ref_item{'age'} = "unknown";
+			}
+			push @headslist, \%ref_item;
+		}
+	}
+
 	open my $fd, '-|', git_cmd(), 'for-each-ref',
 		($limit ? '--count='.($limit+1) : ()), '--sort=-committerdate',
 		'--format=%(objectname) %(refname) %(subject)%00%(committer)',
-- 
1.5.6.5

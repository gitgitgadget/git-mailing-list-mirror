From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/2] gitweb: Add 'status_str' to parse_difftree_raw_line output
Date: Thu,  1 Nov 2007 12:38:09 +0100
Message-ID: <1193917089-15920-3-git-send-email-jnareb@gmail.com>
References: <1193917089-15920-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 01 12:36:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InYLB-0001N2-IU
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 12:36:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756937AbXKALfn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 07:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756867AbXKALfn
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 07:35:43 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:64867 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756526AbXKALfm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 07:35:42 -0400
Received: by ug-out-1314.google.com with SMTP id z38so450340ugc
        for <git@vger.kernel.org>; Thu, 01 Nov 2007 04:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=7IxNQyZgunc7VvMTa+9pgjFWSlhLcEfJ0BvshAzjKXI=;
        b=MfE+LE/Chfqj7C5OakLSznThb1RZkwy5RAh3bAxWBHxK7k0820W1RN8JtL1pqku+5JuJ58mbvPLrcmruymBPrLkP7HlHFLl/Qtqy5zOG5kPermLS1KGMTCxun3w9dsGtlREjwaFiFdttB2/Ysmstb1tEuIAn93jyboJ17FPiyYo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Y6M9A+jxo9VsqN5YAbvEf8QUaKmmX1hW9V9vovwKESD17zh/o8JGh8YEqHqHzA4iuCWUXn9J8dgYSynsUwnnLmI64ql8stLRrZwkrW0id1CKudFsyJ0b7220rMYgX/+X/KOjOY3kpVQ3POyY6lHVrYmInZAyNnCbsBLEjAQaf3w=
Received: by 10.67.92.20 with SMTP id u20mr136299ugl.1193916940149;
        Thu, 01 Nov 2007 04:35:40 -0700 (PDT)
Received: from roke.D-201 ( [83.8.199.125])
        by mx.google.com with ESMTPS id j4sm2172752ugf.2007.11.01.04.35.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 Nov 2007 04:35:38 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lA1BcC5Z015953;
	Thu, 1 Nov 2007 12:38:12 +0100
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id lA1BcCL5015952;
	Thu, 1 Nov 2007 12:38:12 +0100
X-Mailer: git-send-email 1.5.3.4
In-Reply-To: <1193917089-15920-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62938>

Add 'status_str' to diffinfo output, which stores status (also for
merge commit) as a string.  This allows for easy checking if there is
given status among all for merge commit, e.g.
  $diffinfo->{'status_str'} =~ /D/;

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 79ea7ec..e36dec1 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1990,7 +1990,7 @@ sub parse_difftree_raw_line {
 		$res{'to_mode'} = $2;
 		$res{'from_id'} = $3;
 		$res{'to_id'} = $4;
-		$res{'status'} = $5;
+		$res{'status'} = $res{'status_str'} = $5;
 		$res{'similarity'} = $6;
 		if ($res{'status'} eq 'R' || $res{'status'} eq 'C') { # renamed or copied
 			($res{'from_file'}, $res{'to_file'}) = map { unquote($_) } split("\t", $7);
@@ -2006,6 +2006,7 @@ sub parse_difftree_raw_line {
 		$res{'to_mode'} = pop @{$res{'from_mode'}};
 		$res{'from_id'} = [ split(' ', $3) ];
 		$res{'to_id'} = pop @{$res{'from_id'}};
+		$res{'status_str'} = $4;
 		$res{'status'} = [ split('', $4) ];
 		$res{'to_file'} = unquote($5);
 	}
@@ -2821,7 +2822,7 @@ sub fill_from_file_info {
 sub is_deleted {
 	my $diffinfo = shift;
 
-	return $diffinfo->{'to_id'} eq ('0' x 40);
+	return $diffinfo->{'status_str'} =~ /D/;
 }
 
 # does patch correspond to [previous] difftree raw line
-- 
1.5.3.4

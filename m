From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3/4] gitweb: Simplify snapshot format detection logic in
	evaluate_path_info
Date: Mon, 11 May 2009 19:42:47 +0200
Message-ID: <20090511173950.15152.61267.stgit@localhost.localdomain>
References: <20090511173025.15152.94215.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 11 19:42:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3ZWj-0007kR-8g
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 19:42:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752494AbZEKRmt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 13:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbZEKRms
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 13:42:48 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:31193 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318AbZEKRms (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 13:42:48 -0400
Received: by fg-out-1718.google.com with SMTP id 16so974554fgg.17
        for <git@vger.kernel.org>; Mon, 11 May 2009 10:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:in-reply-to:references:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=Y/1FDc3O1vatYoYV/YFCmRw9LTMQ5H1i/ik09Vd/C24=;
        b=o8702L3wuhEwM0LwEQae4zvMxxV8lKbRcsJCET4CdVm0N6C3Vf6F1ZWIMEug81Wrk5
         1+pLixEc5DsoiNqeYw5NExbp9XGcYFCk/qUyOLnni3ZzeVEZgI7MkM9BAmXcGu+vpfnH
         6WA7ioLs1sUz6fW9h+t+XyvlexuGb5Dh9wqjE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        b=kvBRjQ0DKj0SdjEv62bNcNBAg+gzgsa6SfOWP/1urAe5FMlvLN1E4FTy45rTN4un54
         BUppyBpodZT7zMz1yG/eFsUD7tr2JPaanCpdJzfTFahYKcMbTUpAMKgdtqVI8tEtZi1T
         2tCDXlf+mXP9WmHgbl3yQihgDWoZheWcAYx5Y=
Received: by 10.86.98.10 with SMTP id v10mr6735009fgb.36.1242063768021;
        Mon, 11 May 2009 10:42:48 -0700 (PDT)
Received: from localhost.localdomain (absh130.neoplus.adsl.tpnet.pl [83.8.127.130])
        by mx.google.com with ESMTPS id e20sm4896776fga.5.2009.05.11.10.42.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 11 May 2009 10:42:47 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n4BHglAL016769;
	Mon, 11 May 2009 19:42:48 +0200
In-Reply-To: <20090511173025.15152.94215.stgit@localhost.localdomain>
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118815>

This issue was caught by perlcritic in harsh severity level noticing
that catch variable was used outside conditional thanks to the
Perl::Critic::Policy::RegularExpressions::ProhibitCaptureWithoutTest
policy.  See "Perl Best Practices", chapter 12. Regular Expressions,
section 12.15. Captured Values:

   Pattern matches that fail never assign anything to $1, $2, etc.,
   nor do they leave those variables undefined. After an unsuccessful
   pattern match, the numeric capture variables remain exactly as they
   were before the match was attempted.

New version is in my opinion much easier to understand; previous
version worked correctly due to the fact that we returned from loop
on first found match.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is not the only place caught by this policy, but this is the one
where fix was obviously needed to improve readibility of code.

In _most_ (but not all) of other places we assume that output we parse
is in given format, and that regexp would always match...

 gitweb/gitweb.perl |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 097bd18..c72ae10 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -690,9 +690,10 @@ sub evaluate_path_info {
 		# format key itself, with a prepended dot
 		while (my ($fmt, $opt) = each %known_snapshot_formats) {
 			my $hash = $refname;
-			my $sfx;
-			$hash =~ s/(\Q$opt->{'suffix'}\E|\Q.$fmt\E)$//;
-			next unless $sfx = $1;
+			unless ($hash =~ s/(\Q$opt->{'suffix'}\E|\Q.$fmt\E)$//) {
+				next;
+			}
+			my $sfx = $1;
 			# a valid suffix was found, so set the snapshot format
 			# and reset the hash parameter
 			$input_params{'snapshot_format'} = $fmt;

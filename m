From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 06/14] difftool: use perl built-ins when testing for msys
Date: Mon,  6 Apr 2009 01:31:21 -0700
Message-ID: <1239006689-14695-7-git-send-email-davvid@gmail.com>
References: <1239006689-14695-1-git-send-email-davvid@gmail.com>
 <1239006689-14695-2-git-send-email-davvid@gmail.com>
 <1239006689-14695-3-git-send-email-davvid@gmail.com>
 <1239006689-14695-4-git-send-email-davvid@gmail.com>
 <1239006689-14695-5-git-send-email-davvid@gmail.com>
 <1239006689-14695-6-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, charles@hashpling.org,
	markus.heidelberg@web.de, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Apr 06 10:35:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqkIG-0002l9-VE
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 10:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754743AbZDFIcD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 04:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754646AbZDFIcA
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 04:32:00 -0400
Received: from rv-out-0506.google.com ([209.85.198.231]:11551 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754114AbZDFIb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 04:31:57 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2100137rvb.1
        for <git@vger.kernel.org>; Mon, 06 Apr 2009 01:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=MnN+t2b2pTGo6UnKhoqzRyNxHIuMeDs76JdCLPb2u9g=;
        b=d8qmfhhahjADqmCwr/Ql2chqmQq8Q4+yXFgZwCUonStanxrcZ+FfoRrUPKDUR8YTjl
         DREN//0/L56F45GCem/vK9B0VsqBiJ0xUvMtzZHxIGTbklqoB8GlqkuVhoZ/opOBFWsh
         5wbh0Cmy80IrXWTQlOLeq1mA5jf56crKLR5ws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=b9ABYkNK7MMk651ajDVc6ajvhTARRRPZa5gu5ziTanc/pCSHXCXeDpgmO34TH6OVxl
         QxBGoXK4qE0AAECRfl5yC4mZ7LlIuRPrM0BYCJZM9Dru9UTIqLRMG+hiV/l2dldsr/Gr
         wEmHY/Q2dSbGNcRDIJzl0pvj+AxqXTUPCTodo=
Received: by 10.114.53.1 with SMTP id b1mr2160820waa.29.1239006715030;
        Mon, 06 Apr 2009 01:31:55 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id j31sm5189339waf.61.2009.04.06.01.31.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Apr 2009 01:31:54 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.414.g81aa9
In-Reply-To: <1239006689-14695-6-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115783>

I don't even know what $COMSPEC means so let's be safe and use the
same perly $^O test add--interactive uses.  While we're at it, make
git-difftool match the prevalent git-perl style.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 contrib/difftool/git-difftool |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/contrib/difftool/git-difftool b/contrib/difftool/git-difftool
index 0deda3a..207dd50 100755
--- a/contrib/difftool/git-difftool
+++ b/contrib/difftool/git-difftool
@@ -33,7 +33,10 @@ sub setup_environment
 sub exe
 {
 	my $exe = shift;
-	return defined $ENV{COMSPEC} ? "$exe.exe" : $exe;
+	if ($^O eq 'MSWin32' || $^O eq 'msys') {
+		return "$exe.exe";
+	}
+	return $exe;
 }
 
 sub generate_command
@@ -47,7 +50,7 @@ sub generate_command
 			$skip_next = 0;
 			next;
 		}
-		if ($arg eq '-t' or $arg eq '--tool') {
+		if ($arg eq '-t' || $arg eq '--tool') {
 			usage() if $#ARGV <= $idx;
 			$ENV{GIT_DIFF_TOOL} = $ARGV[$idx + 1];
 			$skip_next = 1;
-- 
1.6.2.2.414.g81aa9

From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: [PATCH 01/11 GSoC] gitweb: fix esc_url
Date: Tue, 22 Jun 2010 03:30:37 +0530
Message-ID: <1277157648-6029-2-git-send-email-pavan.sss1991@gmail.com>
References: <1277157648-6029-1-git-send-email-pavan.sss1991@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: git@vger.kernel.org, jnareb@gmail.com, chriscool@tuxfamily.org,
	pasky@ucw.cz
X-From: git-owner@vger.kernel.org Tue Jun 22 00:01:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQp3S-0006ZI-8N
	for gcvg-git-2@lo.gmane.org; Tue, 22 Jun 2010 00:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932734Ab0FUWBQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jun 2010 18:01:16 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:61837 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932318Ab0FUWBP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jun 2010 18:01:15 -0400
Received: by mail-pw0-f46.google.com with SMTP id 8so528092pwj.19
        for <git@vger.kernel.org>; Mon, 21 Jun 2010 15:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=y5lf8X0ToWwZuP+znqGd5pt+DIZ/x9oxEvoXnSp16cM=;
        b=p8dD0mDjHiKgOy5iXe/CMJL85Gjo2uzMLf3YUtH7D5uzCbo+VeYCPsv/GLcjXasG42
         wRTHS8bnPbWwOlMGJaS3ETBZWkONnqiXulXiR+XPEirvF4XlUkr27cKbocsqy/wGkBlr
         DOwsPJYlQiGfBiOqCxL5ZrdY+PSMrZYqtphhI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=q5z5IOEymCYBZ3JuVaWXt0UXfk2qeYpMdzDOpzAMQ/o4gArAYxrhdEEpXOnzv2dXlK
         hCEaE9Q1tXD9hkuBLDpxLM0frg9yI/HT1VBP9qL3T2Fof1XgcRLpzsnMJLLbQJTh8dAJ
         cbaL3FxOPonBZscSVCQHmu8My5UFZFAgSevKs=
Received: by 10.143.24.39 with SMTP id b39mr4054705wfj.184.1277157673714;
        Mon, 21 Jun 2010 15:01:13 -0700 (PDT)
Received: from localhost.localdomain ([202.63.112.132])
        by mx.google.com with ESMTPS id y27sm525703wfi.17.2010.06.21.15.01.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 21 Jun 2010 15:01:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.454.g6bbe9.dirty
In-Reply-To: <1277157648-6029-1-git-send-email-pavan.sss1991@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149444>

The custom CGI escaping done in esc_url failed to escape UTF-8
properly. Fix by using CGI::escape on each sequence of matched
characters instead of sprintf()ing a custom escaping for each byte.

Additionally, the space -> + escape was being escaped due to greedy
matching on the first substitution. Fix by adding space to the
list of characters not handled on the first substitution.

Finally, remove an unnecessary escaping of the + sign.

commit 425e225 has missed fixing esc_url.

Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
---
 gitweb/gitweb.perl |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 9446376..518328f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1322,8 +1322,7 @@ sub esc_param {
 sub esc_url {
 	my $str = shift;
 	return undef unless defined $str;
-	$str =~ s/([^A-Za-z0-9\-_.~();\/;?:@&=])/sprintf("%%%02X", ord($1))/eg;
-	$str =~ s/\+/%2B/g;
+	$str =~ s/([^A-Za-z0-9\-_.~();\/;?:@&= ]+)/CGI::escape($1)/eg;
 	$str =~ s/ /\+/g;
 	return $str;
 }
-- 
1.7.1.454.g276eb9.dirty

From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: [PATCHv2 GSOC 01/11] gitweb: fix esc_url
Date: Thu, 15 Jul 2010 12:59:01 +0530
Message-ID: <1279178951-23712-2-git-send-email-pavan.sss1991@gmail.com>
References: <1279178951-23712-1-git-send-email-pavan.sss1991@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: git@vger.kernel.org, jnareb@gmail.com, chriscool@tuxfamily.org,
	pasky@ucw.cz
X-From: git-owner@vger.kernel.org Thu Jul 15 09:29:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZIt2-00035s-El
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 09:29:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755362Ab0GOH30 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jul 2010 03:29:26 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:52152 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754469Ab0GOH3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 03:29:25 -0400
Received: by pvc7 with SMTP id 7so152737pvc.19
        for <git@vger.kernel.org>; Thu, 15 Jul 2010 00:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=8Jf5XdW2MftoL9tnABhdgBZ4dg5HN/v4dbcL2fLEsWE=;
        b=qoTSJ5aD5E1AQ0ngaNQXJ4D1zbqbUWc0ML8PNeqgpzVNF1XcxV0BtWOF9TLxqaFzAE
         X4OkNG2qIG/SiR0E1mSNrUQSqUFMrRb2d0X8wOwLVWPdWQBPZzfWiC3Ofh+jn2gYs7bx
         EewFurhgjnL7eGHBLE/XFdzCXH8am503nCYos=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=DOOl5LPH38Xv5gLfSOjYoQFOHolT86WJBdwTLC7avjK9DjpzNqufX+bEHzZ4NHrRao
         YHH4Du+Cyf11ptGEvRMpaW8q4GJKHSPO5FldS3SVbiCfiR5g03wKYWvwxJuRvqkN0C8M
         J7+XpsjhsnarafiBhAxRyo3fligQ8NB3lFTqQ=
Received: by 10.142.171.9 with SMTP id t9mr5376327wfe.320.1279178963678;
        Thu, 15 Jul 2010 00:29:23 -0700 (PDT)
Received: from localhost.localdomain ([202.63.112.132])
        by mx.google.com with ESMTPS id l29sm8484428rvb.7.2010.07.15.00.29.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Jul 2010 00:29:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.455.g8f441
In-Reply-To: <1279178951-23712-1-git-send-email-pavan.sss1991@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151050>

The custom CGI escaping done in esc_url failed to escape UTF-8
properly. Fix by using CGI::escape on each sequence of matched
characters instead of sprintf()ing a custom escaping for each byte.

Additionally, the space -> + escape was being escaped due to greedy
matching on the first substitution. Fix by adding space to the
list of characters not handled on the first substitution.

Finally, remove an unnecessary escaping of the + sign.

commit 452e225 has missed fixing esc_url.

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
1.7.1.455.g8f441

From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] gitweb: fix esc_param
Date: Tue, 13 Oct 2009 21:51:36 +0200
Message-ID: <1255463496-21617-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 13 21:59:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxnWK-00082T-TI
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 21:58:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761161AbZJMTw1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 15:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761190AbZJMTw1
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 15:52:27 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:41719 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761189AbZJMTw0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 15:52:26 -0400
Received: by fxm27 with SMTP id 27so10634703fxm.17
        for <git@vger.kernel.org>; Tue, 13 Oct 2009 12:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=loZvRb+WaDK6w/Bu3gMLm1lWQI+8IZH/IhKeTLkVDJU=;
        b=I2eanQxsDmgy6W9AwC8Siop4NxGcp5kpvkXN7tafdAkgCVB+GSnKBK3yQYlbX1HVlI
         FkVu2iHHzOtPzR23aiz1NrK8ncC1ncyRs7aaLhhpy5qB6/UHQMwxi6KuQlqW9AtGysOy
         dWSDNXqbTI2Fo9Vsg1oscXF9y19CIsImqq8j4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=W9NiGqcVHVe0fURwyoZxpsNHaKCHCnP9vMZw9LoBhcO2YFiFhqwS23huIaRZqVn1SN
         EnwG7ltHhNZ9ibWna8nfofIj5jOmeOVrKI9skDkGDTZnty4Wv1/Rq3t0LFVRRdEC3VOI
         jQ05TqsdMP20Dm1Z39vSOkqoKeI1pnsFSlEI0=
Received: by 10.204.19.144 with SMTP id a16mr3181443bkb.9.1255463509245;
        Tue, 13 Oct 2009 12:51:49 -0700 (PDT)
Received: from localhost (host-78-13-55-37.cust-adsl.tiscali.it [78.13.55.37])
        by mx.google.com with ESMTPS id 12sm7924551fks.8.2009.10.13.12.51.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Oct 2009 12:51:48 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc1.192.gdbfcb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130196>

The custom CGI escaping done in esc_param failed to escape UTF-8
properly. Fix by using CGI::escape on each sequence of matched
characters instead of sprintf()ing a custom escaping for each byte.

Additionally, the space -> + escape was being escaped due to greedy
matching on the first substitution. Fix by adding space to the
list of characters not handled on the first substitution.

Finally, remove an unnecessary escaping of the + sign.
---
 gitweb/gitweb.perl |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

The issues with this routine were exposed by Stephen's
"author as search link" patch. This should fix them.

Since the idea of esc_param is to replicate CGI::escape except for the /
character (if I read the comment correclty), a possible alternative
would be to just use CGI::escape on the whole string and then undo the
escaping for the / character.

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 6237865..6593e5c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1115,8 +1115,7 @@ sub to_utf8 {
 # correct, but quoted slashes look too horrible in bookmarks
 sub esc_param {
 	my $str = shift;
-	$str =~ s/([^A-Za-z0-9\-_.~()\/:@])/sprintf("%%%02X", ord($1))/eg;
-	$str =~ s/\+/%2B/g;
+	$str =~ s/([^A-Za-z0-9\-_.~()\/:@ ]+)/CGI::escape($1)/eg;
 	$str =~ s/ /\+/g;
 	return $str;
 }
-- 
1.6.3.rc1.192.gdbfcb

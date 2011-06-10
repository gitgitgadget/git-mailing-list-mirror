From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Make $prevent_xss protection for 'blob_plain' more usable
Date: Fri, 10 Jun 2011 14:01:18 +0200
Message-ID: <201106101401.19108.jnareb@gmail.com>
References: <1307177015-880-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Matt McCutchen <matt@mattmccutchen.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 10 14:01:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QV0P9-0005Mb-0l
	for gcvg-git-2@lo.gmane.org; Fri, 10 Jun 2011 14:01:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756064Ab1FJMBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2011 08:01:30 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43767 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755995Ab1FJMB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2011 08:01:28 -0400
Received: by fxm17 with SMTP id 17so1564340fxm.19
        for <git@vger.kernel.org>; Fri, 10 Jun 2011 05:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=NX7WsMXA3lkYM6xqQleLhZy5sNtQ+tbxTcvXCPVZbqE=;
        b=D2T8lf6LxfdrXfXF68TfomAeZFiBIZST5c0zVXh+XbqmjNgHWzwMAnprDdrRTUEm+f
         L9tQikVucuEMd1XSvIlNB7f2bCBlTsq6oMSYIsSh5Fjw3ryk8soPE+PZPfjpYNf1zPPG
         HktuRIsFWDAiOMHqnjBjIUUcod0/xzjGKF3gM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=IGtDAe4tQHP6XScslN6S+tr7ESIxQjTee+QLVsPRGLctUOvg9YwHB1ApkQWFByxSkJ
         k5wt5IEj1OBrh1F91UVkoA5QtAldstGTWeD3kFveyPbDfBtXyO9Mct3N5MJ510ULsISJ
         AGpXDfe/L5CBCGGowo3y9AvAnTGh9sDTol8Ls=
Received: by 10.223.91.156 with SMTP id n28mr205433fam.4.1307707287584;
        Fri, 10 Jun 2011 05:01:27 -0700 (PDT)
Received: from [192.168.1.15] (abvk161.neoplus.adsl.tpnet.pl [83.8.208.161])
        by mx.google.com with ESMTPS id h9sm1036770fai.30.2011.06.10.05.01.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Jun 2011 05:01:26 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1307177015-880-1-git-send-email-jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175604>

One of mechanism enabled by setting $prevent_xss to true is 'blob_plain'
view protection.  With XSS prevention on, blobs of all types except a
few known safe ones are served with "Content-Disposition: attachment" to
make sure they don't run in our security domain.

Instead of serving text/* type files, except text/plain (and including
text/html), as attachements, downgrade it to text/plain.  This way HTML
pages in 'blob_plain' (raw) wiew would be displayed in browser, but
safely as a source, and not asked to be saved.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is what GitHub interface does for text/html pages (*.html), if
I remember it correctly...

 gitweb/gitweb.perl |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 85acbed..470793a 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -6139,7 +6139,15 @@ sub git_blob_plain {
 	# want to be sure not to break that by serving the image as an
 	# attachment (though Firefox 3 doesn't seem to care).
 	my $sandbox = $prevent_xss &&
-		$type !~ m!^(?:text/plain|image/(?:gif|png|jpeg))(?:[ ;]|$)!;
+		$type !~ m!^(?:text/[a-z]+|image/(?:gif|png|jpeg))(?:[ ;]|$)!;
+
+	# serve text/* as text/plain
+	if ($prevent_xss &&
+	    $type =~ m!^text/([a-z]+)\b(.*)$!) {
+		my ($subtype, $rest) = ($1, $2);
+		$rest = defined $rest ? $rest : '';
+		$type = "text/plain$rest" if ($subtype ne 'plain');
+	}
 
 	print $cgi->header(
 		-type => $type,
-- 
1.7.5

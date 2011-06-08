From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 07/19] remote-curl: accept empty line as terminator
Date: Wed,  8 Jun 2011 20:48:38 +0200
Message-ID: <1307558930-16074-8-git-send-email-srabbelier@gmail.com>
References: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>, "Jeff King" <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 20:50:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUNpJ-00087c-Fg
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 20:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752543Ab1FHStl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 14:49:41 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:57880 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255Ab1FHSth (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 14:49:37 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so279692eyx.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 11:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=IyivD7HHcqnXefOZYZOcLKlL2SzfUVcpmodBFNfj8i4=;
        b=dYxxekNESxQpux42v6K1fXi17ksYQUqVPlAtYM6RvhCNzFU2+MgUmnE9eCZnJTDRvP
         ZHo9Qa/AWjKtElAa6zMt64SMJh91hlmWDq/lDUa29BYj67k9Ak5HSWw/LaSnLb2gD8Je
         vTnsSbt2gn6njOBkQ7er3ulYCf+z7uDcRCjQo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=PWvpYjh/GilI4zHJxiyz06fo1KsAFpKbUwgexNbQSwMv6ZUbtT8zhoAzK6aVxUUAfc
         ZbJk8T40Q3ndjXuPrRlRqdt/O5+rjw4jvKZVR+T1sQm+1oySVRMAYqKh3tl87+KWzvmz
         d6e4dUq3e0iIplHHBcG4iY7nO2G2i3GZPV2D4=
Received: by 10.213.102.133 with SMTP id g5mr414986ebo.129.1307558977159;
        Wed, 08 Jun 2011 11:49:37 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id b1sm729674eeg.19.2011.06.08.11.49.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 11:49:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175424>

This went unnoticed because the transport helper infrastructore did
not check the return value of the helper, nor did the helper print
anything before exiting.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Moved to the front for bisectability.

 remote-curl.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 17d8a9b..7e8d50f 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -857,6 +857,8 @@ int main(int argc, const char **argv)
 	do {
 		if (strbuf_getline(&buf, stdin, '\n') == EOF)
 			break;
+		if (buf.len == 0)
+			break;
 		if (!prefixcmp(buf.buf, "fetch ")) {
 			if (nongit)
 				die("Fetch attempted without a local repo");
@@ -895,6 +897,7 @@ int main(int argc, const char **argv)
 			printf("\n");
 			fflush(stdout);
 		} else {
+			fprintf(stderr, "Unknown command '%s'\n", buf.buf);
 			return 1;
 		}
 		strbuf_reset(&buf);
-- 
1.7.5.1.292.g728120

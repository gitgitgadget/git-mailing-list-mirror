From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 11/13] remote-curl: accept empty line as terminator
Date: Sat, 28 Aug 2010 22:45:38 -0500
Message-ID: <1283053540-27042-12-git-send-email-srabbelier@gmail.com>
References: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: "Git List" <git@vger.kernel.org>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Ramkumar Ramachandra" <artagnon@gmail.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 29 05:47:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpYrP-0006pV-L8
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 05:47:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753335Ab0H2Dqx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Aug 2010 23:46:53 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38975 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753278Ab0H2Dqv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Aug 2010 23:46:51 -0400
Received: by mail-iw0-f174.google.com with SMTP id 5so3824467iwn.19
        for <git@vger.kernel.org>; Sat, 28 Aug 2010 20:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=IxNped2Mjf2FEjlulirS9HTw6Kvnb0kXjzHXQrSabLY=;
        b=Z9si987It9HdJ5iVdeiDC+6c78ru8OpSZv97z21Y5V7gW20xkp08Wi9QnJYVSwUgvp
         p63Pn9hjGumUfljqGGCyF1HUIMrd7tBxSmQ66IFIgdqIgikLJY0chC9SI9c3/xAwftEp
         NlRp9yJVlT0v97HGkZmwjVEt/eGUfa4pSxf1I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FCrEfFPcxe0EqR+s/QsoAQu1KYMGRdKRwwQzo0VUJT9a9ez9oOIqY5idnyHU/KNPKk
         uhg9h8ewfKCwZCuxA3k4dkmysxcwPV8E/G7I3kr6ruNJBdCfRH2KnB8/jqfhBM5KTsK6
         vlb3Z5EgklfFq9/OFQ2W+gLVfGoDqkggUsxW4=
Received: by 10.231.14.5 with SMTP id e5mr2413494iba.175.1283053610774;
        Sat, 28 Aug 2010 20:46:50 -0700 (PDT)
Received: from localhost.localdomain (adsl-76-237-184-184.dsl.chcgil.sbcglobal.net [76.237.184.184])
        by mx.google.com with ESMTPS id n20sm5647049ibe.17.2010.08.28.20.46.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 28 Aug 2010 20:46:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.240.g6a95c3
In-Reply-To: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154680>

The remote helper infrastructure terminates with a '\n', which the
remote-curl helper would interpret as a command to do '', a command
it did not understand. Consequently it would 'return 1'.

This went unnoticed because the transport helper infrastructure did
not check the return value of the helper, nor did the helper print
anything before exiting.

CC: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
CC: Daniel Barkalow <barkalow@iabervon.org>
---

  I noticed this when my tests suddenly broke. Bisecting pointed at
  the 'more rigorous return value checking' patch, after which some
  poking around in the remote-curl helper pointed this out as the
  problem.

  I'm not very sure about the error message, if anyone feels it
  should go (it indicates a bug in the remote helper infrastructure,
  not a user error) it can be left out as far as I'm concerned.

 remote-curl.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 04d4813..27fcd69 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -813,6 +813,8 @@ int main(int argc, const char **argv)
 	do {
 		if (strbuf_getline(&buf, stdin, '\n') == EOF)
 			break;
+		if (buf.len == 0)
+			break;
 		if (!prefixcmp(buf.buf, "fetch ")) {
 			if (nongit)
 				die("Fetch attempted without a local repo");
@@ -851,6 +853,7 @@ int main(int argc, const char **argv)
 			printf("\n");
 			fflush(stdout);
 		} else {
+			fprintf(stderr, "Unknown command '%s'\n", buf.buf);
 			return 1;
 		}
 		strbuf_reset(&buf);
-- 
1.7.2.1.240.g6a95c3

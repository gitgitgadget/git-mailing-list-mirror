From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 07/14] fast-import: use message from lockfile API when
 writing marks fails
Date: Tue, 2 Dec 2014 21:19:42 -0800
Message-ID: <20141203051942.GQ6527@google.com>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
 <20141117233525.GC4336@google.com>
 <CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
 <20141118004841.GE4336@google.com>
 <CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
 <20141203050217.GJ6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 06:19:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xw2Lu-0007Wt-2y
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 06:19:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbaLCFTq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 00:19:46 -0500
Received: from mail-ie0-f179.google.com ([209.85.223.179]:50888 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261AbaLCFTp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 00:19:45 -0500
Received: by mail-ie0-f179.google.com with SMTP id rp18so13183502iec.10
        for <git@vger.kernel.org>; Tue, 02 Dec 2014 21:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=zfNJlszXiXeYCamXOxQRPSEahQWdeTimrQyldJDtB8g=;
        b=R1U4dNctOu4xnzXFeWNbw9dpw150WBLnDWjb0pW8PcpzlBjK50n09Pn/uVtk2yDsGX
         DoZ8qFnpN2G9p6rj3LaAuQ7vHDLjlX0g8HS5MTDq4oyWTxsAUf+tQlSkJKWxJONbrQlI
         DOCpvn+lCaz/kYN2Y4+OB3Mxy6Jz8y4KKOO8d1yNd3caaZyVE+Kg5egk/AWslz9pD7EN
         ti/tpX2Q7StNgSDbMWx4LSphFqmqz8baMiidZH3nvOS1E5+V/3JYiUKyckmB8R9kn85w
         pG8I4dUsLduZEFy2Skx9lo92xoVjwFRqSC4OExvx6OtmLGOrQbFRsLDhbk+HSHGFj3yj
         9sMg==
X-Received: by 10.50.7.38 with SMTP id g6mr6784751iga.42.1417583985325;
        Tue, 02 Dec 2014 21:19:45 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:fd7b:507b:3c7b:554e])
        by mx.google.com with ESMTPSA id c139sm4340488ioc.28.2014.12.02.21.19.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Dec 2014 21:19:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141203050217.GJ6527@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260631>

The usual way to handle errors from hold_lock_file_for_update is to
get a message from unable_to_lock_message or unable_to_lock_die, which
can explain to the user how to check for other git processes running
concurrently and unlink the .lock file if safe.

fast-import didn't use the unable_to_lock_message helper because at
the time it started using the lockfile API (v1.5.1-rc1~69^2~2,
2007-03-07) that helper didn't exist.  Later it still was not
appropriate to use that helper because the message assumed the file
being locked was inside a git repository.  Now there is a flag to
indicate that this lockfile is not part of the repository, so we can
finally use the helper.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 fast-import.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index d0bd285..bf8faa9 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1799,9 +1799,14 @@ static void dump_marks(void)
 	if (!export_marks_file)
 		return;
 
-	if (hold_lock_file_for_update(&mark_lock, export_marks_file, 0) < 0) {
-		failure |= error("Unable to write marks file %s: %s",
-			export_marks_file, strerror(errno));
+	if (hold_lock_file_for_update(&mark_lock, export_marks_file,
+				      LOCK_OUTSIDE_REPOSITORY) < 0) {
+		struct strbuf err = STRBUF_INIT;
+
+		unable_to_lock_message(export_marks_file,
+				       LOCK_OUTSIDE_REPOSITORY, errno, &err);
+		failure |= error("%s", err.buf);
+		strbuf_release(&err);
 		return;
 	}
 

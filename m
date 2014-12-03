From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 08/14] credentials: use message from lockfile API when
 locking ~/.git-credentials fails
Date: Tue, 2 Dec 2014 21:20:44 -0800
Message-ID: <20141203052044.GR6527@google.com>
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
X-From: git-owner@vger.kernel.org Wed Dec 03 06:20:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xw2Mu-0007s7-1J
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 06:20:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbaLCFUs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 00:20:48 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:40606 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815AbaLCFUr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 00:20:47 -0500
Received: by mail-ie0-f174.google.com with SMTP id rl12so13132068iec.19
        for <git@vger.kernel.org>; Tue, 02 Dec 2014 21:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=/5kaawGeUd/MT4J3rua5QSe4aD1oxUrapu+MQ/0Zh4g=;
        b=mKd5BZwi+dJ6qr+uI6nMmH8QQEHTd1ywHF5ufBpED8CDSgTyXx9YamlWZLcXO36slK
         ngGkwljxjY/9kAIl0oF6fpbRlvJ+p8s2l/5Lfn59ISWj5WVoR576Oepl0oY8cIpAuDtp
         7o568Qg9w741nKxcZyXwU8S4OgLukpZfatf94aEwUTpZru213BIqcBlnJYQ5Q7rQ8OQ4
         6VOKuxcC33ihu+z6k2Xpi408PSavrs53QGgMgN+gRphn1oDMm2NOkeZd54P/w+Qysakp
         xSUJZmSMpFjVjh8MrLtz7bivqk9z1ZXs+ejmzMaUi+Cu9K340my/OgqWSGXszNXHm4Eb
         c+yg==
X-Received: by 10.42.72.138 with SMTP id o10mr5413509icj.73.1417584047088;
        Tue, 02 Dec 2014 21:20:47 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:fd7b:507b:3c7b:554e])
        by mx.google.com with ESMTPSA id ga3sm13016392igd.10.2014.12.02.21.20.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Dec 2014 21:20:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141203050217.GJ6527@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260632>

If writing $HOME/.git-credentials.lock (or locking another file
specified with the --file option) fails due to the lock file already
existing, chances are that it is because another git process already
locked the file.  Use the message from the lockfile API that says so,
to help the user to look for running git processes and remove the
stray .lock file when it is safe.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 credential-store.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/credential-store.c b/credential-store.c
index d435514..cd71156 100644
--- a/credential-store.c
+++ b/credential-store.c
@@ -55,8 +55,8 @@ static void print_line(struct strbuf *buf)
 static void rewrite_credential_file(const char *fn, struct credential *c,
 				    struct strbuf *extra)
 {
-	if (hold_lock_file_for_update(&credential_lock, fn, 0) < 0)
-		die_errno("unable to get credential storage lock");
+	hold_lock_file_for_update(&credential_lock, fn,
+				  LOCK_DIE_ON_ERROR | LOCK_OUTSIDE_REPOSITORY);
 	if (extra)
 		print_line(extra);
 	parse_credential_file(fn, c, NULL, print_line);

From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH svn-fe] fast-import: make code "-Wpointer-arith" clean
Date: Mon, 28 Feb 2011 15:32:10 -0600
Message-ID: <20110228213210.GD1942@elie>
References: <20101224080505.GA29681@burratino>
 <20110226114435.GB12231@elie>
 <7vhbbolm5q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 28 22:32:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuAhu-0007U3-TM
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 22:32:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752406Ab1B1Vci (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 16:32:38 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:46855 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372Ab1B1Vch (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 16:32:37 -0500
Received: by vxi39 with SMTP id 39so3572570vxi.19
        for <git@vger.kernel.org>; Mon, 28 Feb 2011 13:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=DZkJFrFhNpdyMoEbpMVOkIvKNR3bJtcl1xAmT4K7RJE=;
        b=Gf86MTUnS1fDfZS4JOuBpWb4nGj/NnzQMgtlh6Xm218fR7yqvRZHc84yQOPd7j4dCq
         jg4J13os3nA007l9A28nJm4K2YirJK27z3rKr2p2H0ThuuppIUgk84HkhOk6HKcaZW5k
         GxkoFJZ/HViak3/VnEvGXQRrVU2wXCe99Rdug=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=C0Fi27qxhk8vAgIq5CD+Lo0RRdIGzrYSbEscLusTeXK9Yc+wT/zRx9te2ZEGBYFSlf
         988yGhqVEMPz7nzqpe+bbSh6QZ4nRIyWtvHFC5AZ92qjSsdj4znMH0kAW+a2jIxuPOAf
         XS1NaCqvTCFnOML+FlwynhHmfvS6N+01WnIHs=
Received: by 10.52.156.233 with SMTP id wh9mr9942854vdb.235.1298928737504;
        Mon, 28 Feb 2011 13:32:17 -0800 (PST)
Received: from elie (adsl-76-206-235-173.dsl.chcgil.sbcglobal.net [76.206.235.173])
        by mx.google.com with ESMTPS id q5sm1846950vcr.15.2011.02.28.13.32.15
        (version=SSLv3 cipher=OTHER);
        Mon, 28 Feb 2011 13:32:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vhbbolm5q.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168148>

The dereference() function to peel a tree-ish and find the underlying
tree expects arithmetic to (void *) to work on byte addresses.  We
should be reading the text of objects through a char * anyway.

Noticed-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Junio C Hamano wrote:

> ... Yikes.  I said the above and then my build for "master" breaks with
>
>   fast-import.c: In function 'dereference':
>   fast-import.c:2885: error: pointer of type 'void *' used in arithmetic
>   fast-import.c:2890: error: pointer of type 'void *' used in arithmetic

This should fix it, I suppose?  A

	-std=c99 -O3 -Wall -W
	-Wno-sign-compare
	-Wno-unused-parameter
	-Wno-missing-field-initializers
	-Wno-empty-body
	-Wno-pointer-to-int-cast
	-Wno-type-limits
	-Wno-unused-but-set-variable
	-Wold-style-definition -Wpointer-arith -Wvla
	-Wdeclaration-after-statement -Werror

build passes, except for an "unsigned long expire" in builtin-reflog
that confuses this copy of gcc.

 fast-import.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 6c37b84..e1268b8 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2848,7 +2848,7 @@ static struct object_entry *dereference(struct object_entry *oe,
 					unsigned char sha1[20])
 {
 	unsigned long size;
-	void *buf = NULL;
+	char *buf = NULL;
 	if (!oe) {
 		enum object_type type = sha1_object_info(sha1, NULL);
 		if (type < 0)
-- 
1.7.4.1

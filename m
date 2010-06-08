From: William Pursell <bill.pursell@gmail.com>
Subject: Re: permissions
Date: Tue, 08 Jun 2010 00:25:53 -1000
Message-ID: <4C0E1AB1.2030702@wpursell.net>
References: <4C0A19FE.1020802@wpursell.net> <m27hmdn704.fsf@igel.home> <4C0A9615.4090307@wpursell.net> <AANLkTileRHwUuJpvKJbivRiM9Prn9wJ0zH6abExBgcq0@mail.gmail.com> <4C0B6C32.1090700@wpursell.net> <7vvd9wvswy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: William Pursell <bill.pursell@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 08 12:26:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLw0b-0000wm-B5
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 12:26:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246Ab0FHK0E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 06:26:04 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:64882 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035Ab0FHK0D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 06:26:03 -0400
Received: by pxi8 with SMTP id 8so1516136pxi.19
        for <git@vger.kernel.org>; Tue, 08 Jun 2010 03:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=jOqXFFv7KEfD4gjtt3uDgeY0YDZanTVZdFn1PBupFsk=;
        b=YzTC5bb/SS7Dq6eqRtsLvd9eb196VkuxmMwDDJwzFcTdFHq7fNB+GF92fxUrwg8h4C
         v8HldTUx2HxlbRsbEAsb7KeLUCTZI0DKx897KVSt44ON3c7W8f3uN2CitxX2C4qggqg7
         Xm95WpgINJdNEPx2AyYIfC53+l3XNDs/1MCtY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=kRbkQ2Dws7Ib60mr0OI12U0cWiie2Yi5e80zHESjMpUPFnj21pc00TCMOGTtiL3I7J
         zqYcNp2ermoV+EYntS2bqROX5YSesm5pZDXN60QVIUYHVNj4rW+fhQGSkd0GbRI0rklH
         i6ghgfVwg1adKH7RxmPP1bfWSBHLbE1frAg/Q=
Received: by 10.115.81.6 with SMTP id i6mr12798897wal.48.1275992760347;
        Tue, 08 Jun 2010 03:26:00 -0700 (PDT)
Received: from clam.westell.com (udp278831uds.hawaiiantel.net [72.234.51.251])
        by mx.google.com with ESMTPS id d16sm48795058wam.12.2010.06.08.03.25.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Jun 2010 03:25:57 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.24 (Macintosh/20100228)
In-Reply-To: <7vvd9wvswy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148659>

Junio C Hamano wrote:

> I think it is sane to abort with "permission denied", as it is "not a git
> repository" but it is "we cannot even determine if that .git we see is a
> git repository, and if it is, then we cannot do any git operation here as
> we cannot read it".  As to what you call "the current work flow", I think
> it is not like we _support_ such usage, but more like it _happens to_ work
> that way.

Here's a patch.  This doesn't address the issue of a damaged
repository, but just catches access errors and permissions.

>From 8f1c8f4d572fe62a26d1fca47abc976e78942697 Mon Sep 17 00:00:00 2001
From: William Pursell <bill.pursell@gmail.com>
Date: Tue, 8 Jun 2010 00:16:43 -1000
Subject: [PATCH] Terminate on access errors

This changes the way git finds a repository.  Previously, if
access is denied to .git (or $GIT_DIR), git will use the object
directory in a higher level directory.  With this patch, git will
instead terminate and emit an error message indicating the access
failure.  Also, other errors (such as soft-link loops in
GIT_OBJECT_DIRECTORIES) will cause termination.

Signed-off-by: William Pursell <bill.pursell@gmail.com>
---
 setup.c |   18 +++++++++++++++---
 1 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/setup.c b/setup.c
index 7e04602..a53331c 100644
--- a/setup.c
+++ b/setup.c
@@ -155,6 +155,18 @@ const char **get_pathspec(const char *prefix, const char **pathspec)
 }

 /*
+ * Wrapper around access that terminates on
+ * errors other than ENOENT.
+ */
+static int xaccess(const char *path, int amode)
+{
+	int status = access(path, amode);
+	if (status && errno != ENOENT)
+		die_errno("%s", path);
+	return status;
+}
+
+/*
  * Test if it looks like we're at a git directory.
  * We want to see:
  *
@@ -172,17 +184,17 @@ static int is_git_directory(const char *suspect)

 	strcpy(path, suspect);
 	if (getenv(DB_ENVIRONMENT)) {
-		if (access(getenv(DB_ENVIRONMENT), X_OK))
+		if (xaccess(getenv(DB_ENVIRONMENT), X_OK))
 			return 0;
 	}
 	else {
 		strcpy(path + len, "/objects");
-		if (access(path, X_OK))
+		if (xaccess(path, X_OK))
 			return 0;
 	}

 	strcpy(path + len, "/refs");
-	if (access(path, X_OK))
+	if (xaccess(path, X_OK))
 		return 0;

 	strcpy(path + len, "/HEAD");
-- 
1.7.1.245.g7c42e.dirty



-- 
William Pursell

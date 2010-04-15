From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2] tag -v: use RUN_GIT_CMD to run verify-tag
Date: Thu, 15 Apr 2010 04:36:25 -0500
Message-ID: <20100415093625.GA18612@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Deskin Miller <deskinm@umich.edu>, Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 15 11:36:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2LUo-00069V-Pw
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 11:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108Ab0DOJgZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 05:36:25 -0400
Received: from mail-yw0-f194.google.com ([209.85.211.194]:45243 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932099Ab0DOJgW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 05:36:22 -0400
Received: by ywh32 with SMTP id 32so614350ywh.33
        for <git@vger.kernel.org>; Thu, 15 Apr 2010 02:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=BFcCoPardxR14lG1UIlnR5BPmYA3gOYHkLDbL+wr9YQ=;
        b=qw5Mg3N+MQRXVW5e+gnFeDeS5gmBBBEiaCJyDyKzms2/tYk+McINnRlqLcxz44iGZM
         LsXLGa24zIrKnG1PFGTnBMKd6mT6OeZuLPALyoSRJK1pxQuRc7p61fDuBuJo9yW+aWGX
         55K/AY7Ppau9lDdU0F6CBg6qtW+h4xIawHdpY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=t+TbJaecU1DxM/X2e78PQql5Ti01Osu/8As+pTri/kYJJnpizIpWrZZ4AiajeVBmiO
         GNAMi5ltwxByg7kCzjdwFBCEOkISNk2Uv5xyscfRre3t/I86SB7Dq+v75fvcx7cY6OAH
         m4Hnx1+EccdnVQq0GE5uUhzHoHenBeDND9f90=
Received: by 10.100.222.12 with SMTP id u12mr11943444ang.113.1271324181000;
        Thu, 15 Apr 2010 02:36:21 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm899261iwn.15.2010.04.15.02.36.19
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 15 Apr 2010 02:36:20 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144966>

This is the preferred way to run a git command.

The only obvious observable effects I can think of are that the exec
is properly reported in GIT_TRACE output and that verifying signed
tags will still work if the git-verify-tag hard link in gitexecdir
goes missing.

Helped-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
v1 was part of a longer series that replaced the run_command with a
function call [1].

Thanks to Hannes for the pointer.

[1] http://thread.gmane.org/gmane.comp.version-control.git/142681/focus=142682
What about the rest of the series?  Without some facility [2] to
verify tags without going out of the way to do it, it is hard to end
up using tag -v often enough to notice the speed difference.
[2] maybe a fetch-update hook.
http://thread.gmane.org/gmane.comp.version-control.git/101585/focus=101590

 builtin/tag.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 4ef1c4f..d311491 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -147,11 +147,11 @@ static int delete_tag(const char *name, const char *ref,
 static int verify_tag(const char *name, const char *ref,
 				const unsigned char *sha1)
 {
-	const char *argv_verify_tag[] = {"git-verify-tag",
+	const char *argv_verify_tag[] = {"verify-tag",
 					"-v", "SHA1_HEX", NULL};
 	argv_verify_tag[2] = sha1_to_hex(sha1);
 
-	if (run_command_v_opt(argv_verify_tag, 0))
+	if (run_command_v_opt(argv_verify_tag, RUN_GIT_CMD))
 		return error("could not verify the tag '%s'", name);
 	return 0;
 }
-- 
1.7.1.rc1

From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Small "git clean" annoyance
Date: Fri, 1 Apr 2011 09:34:44 +0200
Message-ID: <AANLkTikksQj3HfOJmi-uZTfc7sTNNuDA4bFVaj2cY3Ad@mail.gmail.com>
References: <AANLkTinQscpkRDftLmCrQR+Aq5RacGyurd3kb15y=1FK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Apr 01 09:35:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5Yt1-0002uw-AL
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 09:35:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755110Ab1DAHfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 03:35:07 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41900 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755065Ab1DAHfF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 03:35:05 -0400
Received: by bwz15 with SMTP id 15so2318992bwz.19
        for <git@vger.kernel.org>; Fri, 01 Apr 2011 00:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=iHiCdruYrguomVTNufORJARvp2OvQ/s8jqZmAkCNh1s=;
        b=EJfqr5Rf8dBNxWOY3GVbN/3F8thD2wdDnBlJkeuDGLSnqVeJ9tEHGJgZais/COaBLw
         AG2uFpYFGT778aR0kPXlkMEnX7uh5jae6ougHZQGtnii/iqiBffYdidtAndqFUNy9NBP
         TqVnQ1Bg+Ixb3g7OS4Wg7dG/fLcVuQNeWO/r0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=x6weulhiKw8L8HO/w0JDFpPKnC2iUTq8sp5/XoJU8gTdkpIBPnbU+lBrgvH5z3WVd/
         dqRyO/QfCBilC1PTMWXT8zOz5twBrsjx9MwMsqSykFFXMiukQoB+B1/ZqhJbu22WEuMX
         phm3qedMB0DTeKo1NJCIwIDOqqX4Y4Ld1xXZ8=
Received: by 10.204.83.228 with SMTP id g36mr1983821bkl.30.1301643304178; Fri,
 01 Apr 2011 00:35:04 -0700 (PDT)
Received: by 10.204.29.2 with HTTP; Fri, 1 Apr 2011 00:34:44 -0700 (PDT)
In-Reply-To: <AANLkTinQscpkRDftLmCrQR+Aq5RacGyurd3kb15y=1FK@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170556>

On Fri, Apr 1, 2011 at 00:01, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> Now, I realize that if the directory isn't empty, and is unreadable,
> we really should give up (although a better error message about _why_
> we failed may be in order) rather than try to chmod it or anything
> like that. But the simple "try to rmdir it" might be a good addition
> for the trivial case.

Something like this?

diff --git a/dir.c b/dir.c
index 325fb56..7251426 100644
--- a/dir.c
+++ b/dir.c
@@ -1191,8 +1191,11 @@ int remove_dir_recursively(struct strbuf *path, int flag)
 		return 0;

 	dir = opendir(path->buf);
-	if (!dir)
+	if (!dir) {
+		if (rmdir(path->buf) == 0)
+			return 0;
 		return -1;
+	}
 	if (path->buf[original_len - 1] != '/')
 		strbuf_addch(path, '/');

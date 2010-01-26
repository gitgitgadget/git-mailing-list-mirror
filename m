From: Benjamin Kramer <benny.kra@googlemail.com>
Subject: [PATCH] grep: use REG_STARTEND (if available) to speed up regexec
Date: Tue, 26 Jan 2010 18:48:36 +0100
Message-ID: <4B5F2AF4.2090307@googlemail.com>
References: <20100125225139.GA3048@fredrik-laptop>  <alpine.LFD.2.00.1001251542100.3574@localhost.localdomain> <4c8ef71001260410l2afd2dbx17b6e216bd9e5d8@mail.gmail.com> <alpine.LFD.2.00.1001260728260.3574@localhost.localdomain> <4B5F1894.4070509@googlemail.com> <alpine.LFD.2.00.1001260836520.3574@localhost.localdomain> <alpine.LFD.2.00.1001260846330.3574@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Fredrik Kuivinen <frekui@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 18:48:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZpWy-0007GB-UD
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 18:48:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754373Ab0AZRsp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 12:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754305Ab0AZRsp
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 12:48:45 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:40442 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753727Ab0AZRso (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 12:48:44 -0500
Received: by bwz27 with SMTP id 27so3817153bwz.21
        for <git@vger.kernel.org>; Tue, 26 Jan 2010 09:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=sdGCECE+nqLLTvu8Qp6oGYdtDorY4p1kTqpEJyYAx/c=;
        b=RoEpkm4lmDiKt43p+IkOpA6gqqeyyKVH1SP8yxNbdlxz9WLmk8Cu4Stb2u7pVPGqx0
         slJQR6zLpqOqpDnEqJ+YX9PX4CNvAvYAX3x+teRQhy4HMR98yLynBxAtj2Um8uW6J4Nk
         ZSTUvAB1MUIulyOKsjLTz3O4XB2UPigPHxXQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=iuyuKfjK0uwI/U2ymGXKrtAvWvDct5og8CVqwcWaEGAgXNXn5ltD3Ek3WMcB2fsTGX
         XWmw00P2f6sQRKoHvNDLHeppt3NlGZWkPB66vNN+QsUQCI8UB6FwX3BMhrlUDwGJGWgD
         Qz81YCk9A572lSWsXAtmgHhK5/OtVZYuZJgzs=
Received: by 10.204.25.130 with SMTP id z2mr3572011bkb.211.1264528121959;
        Tue, 26 Jan 2010 09:48:41 -0800 (PST)
Received: from kallisto.local (p509269B7.dip.t-dialin.net [80.146.105.183])
        by mx.google.com with ESMTPS id 14sm2773201bwz.13.2010.01.26.09.48.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 26 Jan 2010 09:48:41 -0800 (PST)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.1) Gecko/20090715 Thunderbird/3.0b3
In-Reply-To: <alpine.LFD.2.00.1001260846330.3574@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138060>

BSD and glibc have an extension to regexec which takes a buffer + length pair
instead of a NUL-terminated string. Since we already have the length computed
this can save us a strlen call inside regexec.

Signed-off-by: Benjamin Kramer <benny.kra@googlemail.com>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
---

Resend of my previous patch with SOB and correct title.

 grep.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/grep.c b/grep.c
index 8e1f7de..452c2cb 100644
--- a/grep.c
+++ b/grep.c
@@ -640,8 +640,15 @@ static int look_ahead(struct grep_opt *opt,
 
 		if (p->fixed)
 			hit = !fixmatch(p->pattern, bol, p->ignore_case, &m);
-		else
+		else {
+#ifdef REG_STARTEND
+			m.rm_so = 0;
+			m.rm_eo = *left_p;
+			hit = !regexec(&p->regexp, bol, 1, &m, REG_STARTEND);
+#else
 			hit = !regexec(&p->regexp, bol, 1, &m, 0);
+#endif
+		}
 		if (!hit || m.rm_so < 0 || m.rm_eo < 0)
 			continue;
 		if (earliest < 0 || m.rm_so < earliest)
-- 
1.7.0.rc0.12.gc33c3

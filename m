From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Clean up compatibility definitions.
Date: Tue, 6 Dec 2005 09:07:04 +0100
Message-ID: <81b0412b0512060007s589e1d0dr4f47da68a7f3567a@mail.gmail.com>
References: <81b0412b0512050519k5ed80035x9eb4907f569e0a4b@mail.gmail.com>
	 <81b0412b0512050524w7b632651n93c836fda41a39d@mail.gmail.com>
	 <7vfyp7cuii.fsf@assigned-by-dhcp.cox.net>
	 <7voe3vb8fh.fsf@assigned-by-dhcp.cox.net>
	 <20051205215059.GC4443@steel.home>
	 <7vr78r9pg0.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0512052315p1917a04ek264c14abf41a1027@mail.gmail.com>
	 <7vk6ei65r6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1353_18101854.1133856424251"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 06 09:07:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjXqx-0006wN-1L
	for gcvg-git@gmane.org; Tue, 06 Dec 2005 09:07:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbVLFIHH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 03:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbVLFIHH
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 03:07:07 -0500
Received: from nproxy.gmail.com ([64.233.182.195]:16042 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750736AbVLFIHF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Dec 2005 03:07:05 -0500
Received: by nproxy.gmail.com with SMTP id x29so99031nfb
        for <git@vger.kernel.org>; Tue, 06 Dec 2005 00:07:04 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=ZIf1ziT87BxbZYex7/oVIeaQlloE9dkIIdmXXfSwTxex5PV8xnCjepDDikoKpQPUcO6QVQBSJP+5eO6oTIVq3pGahY8KjTiZ4vguvMvmw0la6RyB0BiEZKysIrQvenc7/V3Db0Hiz21u5avIdzeZu83vuSz2byymFXBZgM6SYRk=
Received: by 10.48.217.1 with SMTP id p1mr34010nfg;
        Tue, 06 Dec 2005 00:07:04 -0800 (PST)
Received: by 10.48.248.18 with HTTP; Tue, 6 Dec 2005 00:07:04 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6ei65r6.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13266>

------=_Part_1353_18101854.1133856424251
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 12/6/05, Junio C Hamano <junkio@cox.net> wrote:
> > ... return MAP_FAILED if error, do not
> > exit process, do no output.
> Ah, that is what you meant.  I agree.

now, while we agree, how about the patch removing "user interface"
from gitfakemmap altogether? The patch is not really tested (running
tests is not useful in this case), but I looked over the call sites,
and they seem either to handle mmap's or the previous open's return
values.
One exception is in config.c where neither is handled, the code will
race between stat and open.

Signed-off-by: Alex Riesen <fork0@gmail.com>

------=_Part_1353_18101854.1133856424251
Content-Type: text/plain; 
	name=0004-cleanup-mmap-fake.-No-need-to-output-anything-callers-handle-the-return-value.txt; 
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="0004-cleanup-mmap-fake.-No-need-to-output-anything-callers-handle-the-return-value.txt"

cleanup mmap fake. No need to output anything, callers handle the return value

Signed-off-by: Alex Riesen <fork0@gmail.com>

---

 compat/mmap.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

311da12b7aaca9b7329a07807e1ce4afba4bff77
diff --git a/compat/mmap.c b/compat/mmap.c
index 55cb120..32d7a30 100644
--- a/compat/mmap.c
+++ b/compat/mmap.c
@@ -8,15 +8,17 @@ void *gitfakemmap(void *start, size_t le
 {
 	int n = 0;
 
-	if (start != NULL || !(flags & MAP_PRIVATE))
-		die("Invalid usage of gitfakemmap.");
+	if (start != NULL || !(flags & MAP_PRIVATE)) {
+		errno = ENOTSUP;
+		return MAP_FAILED;
+	}
 
 	if (lseek(fd, offset, SEEK_SET) < 0) {
 		errno = EINVAL;
 		return MAP_FAILED;
 	}
 
-	start = xmalloc(length);
+	start = malloc(length);
 	if (start == NULL) {
 		errno = ENOMEM;
 		return MAP_FAILED;
-- 
0.99.9.GIT

------=_Part_1353_18101854.1133856424251--

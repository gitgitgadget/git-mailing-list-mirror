From: Alex Riesen <raa.lkml@gmail.com>
Subject: fix git-pack-redundant crashing sometimes
Date: Tue, 15 Nov 2005 16:49:30 +0100
Message-ID: <81b0412b0511150749g5672158v7b39c02ffdf13e08@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_5386_12374235.1132069770316"
Cc: =?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>,
	junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Nov 15 16:53:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec33v-0007bz-VW
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 16:49:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbVKOPtd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 10:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbVKOPtd
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 10:49:33 -0500
Received: from nproxy.gmail.com ([64.233.182.200]:58099 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751416AbVKOPtc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Nov 2005 10:49:32 -0500
Received: by nproxy.gmail.com with SMTP id y25so295779nfb
        for <git@vger.kernel.org>; Tue, 15 Nov 2005 07:49:30 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=N+viMgUpBqo5tZgtUoOvtHlf8v0Ppqt3K+hWcDcJBApTYXTI0LWmV+GwiGi7dc++hflqCCJH5rdrn7IQx4/ecMr3yoZW5G4yHGDLHV2T49b69z1eJtVdsG3pz/mCQUdY5P4atzLGdvyrUXuRuvW4vpOQyfjmwxCoX6rGLtJv9to=
Received: by 10.48.239.2 with SMTP id m2mr268224nfh;
        Tue, 15 Nov 2005 07:49:30 -0800 (PST)
Received: by 10.48.247.3 with HTTP; Tue, 15 Nov 2005 07:49:30 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11910>

------=_Part_5386_12374235.1132069770316
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

llist_sorted_difference_inplace didn't handle the match in the first
sha1 correctly and the lists went wild everywhere.

---

I noticed it on a very big repository (more than 100k files), trying
to prune it.
The code could profit from double-linked lists greatly, IMHO.

------=_Part_5386_12374235.1132069770316
Content-Type: application/xxxxx; name=fix-pack-redundant.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="fix-pack-redundant.patch"

diff --git a/pack-redundant.c b/pack-redundant.c
index 28b82ee..47201f1 100644
--- a/pack-redundant.c
+++ b/pack-redundant.c
@@ -141,8 +141,9 @@ void llist_sorted_difference_inplace(str
 		if (!cmp) {
 			x = a;
 			if (a == A->front)
-				A->front = a->next;
-			a = prev->next = a->next;
+				a = A->front = a->next;
+			else
+				a = prev->next = a->next;
 
 			if (a == NULL) /* end of list */
 				A->back = prev;



------=_Part_5386_12374235.1132069770316--

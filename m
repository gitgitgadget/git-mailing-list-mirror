From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 12/23] unpack-trees(): carry skip-worktree bit over in merged_entry()
Date: Mon, 14 Dec 2009 17:30:55 +0700
Message-ID: <1260786666-8405-13-git-send-email-pclouds@gmail.com>
References: <1260786666-8405-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 14 11:33:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NK8FI-0007wL-8K
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 11:33:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756164AbZLNKdD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Dec 2009 05:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756145AbZLNKc6
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 05:32:58 -0500
Received: from mail-px0-f174.google.com ([209.85.216.174]:62201 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756091AbZLNKcy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 05:32:54 -0500
Received: by mail-px0-f174.google.com with SMTP id 4so1691169pxi.33
        for <git@vger.kernel.org>; Mon, 14 Dec 2009 02:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=NnQ/tuvOgFE9o8F2KS74iNqnzgSV0bbqnao9rzEcTKA=;
        b=q3BP+7CE7KFXqb3HG/7OtWcT+xeQfAdoQl5x6hz9d5giV7kUarxuZDdUfAPbw6iII7
         Ucn2ncse5mVJuOIM4n8ZgpKh180JvpbH77xHya1c0dyRrWRv21bMV7UrCc8aHDNoKA6y
         QoLJN/Uvj6I0mLUzbyGTPVH0c8tf5OmRX/GZk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Ta66MQ/K0/o2UxdxsvSUYBkGwRqwo/w2yNnowZ1jn2VNsbqSidjEOppDPFxrS5xm5i
         lDIULE6mPot8SXk+N8uw4a4qCqeLVL+HhHKMCt37rQmWMzlcpk2NhT1y+oeL49l/AeQE
         WlIHv1/HY448eyNtBu++xKSJToL42WXw29Mu0=
Received: by 10.142.4.38 with SMTP id 38mr3030281wfd.119.1260786773945;
        Mon, 14 Dec 2009 02:32:53 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.233.253])
        by mx.google.com with ESMTPS id 20sm4896648pzk.9.2009.12.14.02.32.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Dec 2009 02:32:53 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 14 Dec 2009 17:32:12 +0700
X-Mailer: git-send-email 1.6.5.2.216.g9c1ec
In-Reply-To: <1260786666-8405-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135183>

In this code path, we would remove "old" and replace it with "merge".
"old" may have skip-worktree bit, so re-add it to "merge".

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 unpack-trees.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 1ab3c89..ac59fbe 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -680,6 +680,8 @@ static int merged_entry(struct cache_entry *merge, =
struct cache_entry *old,
 		} else {
 			if (verify_uptodate(old, o))
 				return -1;
+			if (ce_skip_worktree(old))
+				update |=3D CE_SKIP_WORKTREE;
 			invalidate_ce_path(old, o);
 		}
 	}
--=20
1.6.5.2.216.g9c1ec

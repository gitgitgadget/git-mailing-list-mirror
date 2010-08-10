From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC 2/3] write-tree: Avoid leak when index refers to an
 invalid object
Date: Mon, 9 Aug 2010 22:32:11 -0500
Message-ID: <20100810033211.GC2386@burratino>
References: <wes62zknmki.fsf@kanis.fr>
 <7v1va760ip.fsf@alter.siamese.dyndns.org>
 <20100810032647.GA2386@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ivan Kanis <expire-by-2010-08-14@kanis.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 10 05:33:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oifaz-0000qp-84
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 05:33:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757283Ab0HJDdl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Aug 2010 23:33:41 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:64714 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756506Ab0HJDdj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 23:33:39 -0400
Received: by gwb20 with SMTP id 20so3593196gwb.19
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 20:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=EZspQ4h20CucFZJSrSlErXVvuhNmJt6DG55xyh+x6EM=;
        b=B+psWsbeGNAdcGskXwySVH4wydJRKfYjbFwRaRgIc5x/rOrqPNAVejmiGBD0qjVr+D
         a4mSw/PUn55OFJNJkqHBSn9D8aSHCZxaoBF9mEtigUnMA9kK24Da6yEWiMePXqceYlvh
         O5YsdKquhmXSG4F9kyCTmTUOogIm/F7ugC9pA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=GX9MoKDrttNnsmBQoKureXz3UpKSa+D9Bja8VXWWkxeR6asoeOmiIuXP0PpvaDk2KD
         UQVVh/dIGAWOWb5T2GS++42NEtgmXjVgDlvEvkc6OseMN/21O7XRAZHu71sII8KLhQNl
         SQLc2acBCL1XGf0vYkuXNh0cAJF+vg8ypHpEM=
Received: by 10.100.86.4 with SMTP id j4mr18902025anb.230.1281411219024;
        Mon, 09 Aug 2010 20:33:39 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id w6sm9633247anb.23.2010.08.09.20.33.38
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Aug 2010 20:33:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100810032647.GA2386@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153074>

Noticed by valgrind during test t0000.35 =E2=80=9Cwriting this tree wit=
hout
--missing-ok=E2=80=9D.

Even in the cherry-pick foo..bar code path, such an error is the
end of the line.  But maybe some day an interactive porcelain will
want to link to libgit, making this matter.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 cache-tree.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index d917437..c60cf91 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -328,9 +328,11 @@ static int update_one(struct cache_tree *it,
 			mode =3D ce->ce_mode;
 			entlen =3D pathlen - baselen;
 		}
-		if (mode !=3D S_IFGITLINK && !missing_ok && !has_sha1_file(sha1))
+		if (mode !=3D S_IFGITLINK && !missing_ok && !has_sha1_file(sha1)) {
+			strbuf_release(&buffer);
 			return error("invalid object %06o %s for '%.*s'",
 				mode, sha1_to_hex(sha1), entlen+baselen, path);
+		}
=20
 		if (ce->ce_flags & CE_REMOVE)
 			continue; /* entry being removed */
--=20
1.7.2.1.544.ga752d.dirty

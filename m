From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 9/9] racy-git.txt: explain nsec problem in more detail
Date: Fri, 9 Oct 2009 05:25:54 -0500
Message-ID: <20091009102554.GI16558@progeny.tock>
References: <20091009101400.GA16549@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 12:23:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwCcR-0007cM-4l
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 12:22:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760651AbZJIKSU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Oct 2009 06:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760648AbZJIKSU
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 06:18:20 -0400
Received: from mail-yw0-f176.google.com ([209.85.211.176]:34432 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760646AbZJIKST (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 06:18:19 -0400
Received: by ywh6 with SMTP id 6so6102824ywh.4
        for <git@vger.kernel.org>; Fri, 09 Oct 2009 03:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=hHnXZeAMwgA1LpEo5d9lLjGbkZ6+l1bCIGaFM026Wfs=;
        b=ikCBFRuKY4SGTOr6EoMwUW+wRNCToYr1+Iv+ZXkE28dQ8OYqc+v6fgmO8VCCBu39Xx
         gUO34ZEqK3x4qL6OblERRxGnNE2k8H7grfIgg8ljj7o0ugYev5UJ22RslNAcMvEIM4yA
         HgqaSbS9OFkx7H8RHhbWr8NWP86ehY7bPv2Cc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=YLMjz6VNy1bFV1V9z6FkAGwfFOj/9wmHjAWMip7cacLgfuM0tPLx9kO3YLecWwbP5l
         o+fZPCcnRuY+gbSXt3AGvE2VE2CAvoYvmWPwATdwwJxjm7JisH7FQzTPTvZEO/lPOpg2
         ZAn/Dal2a20zSQJaOs4Rn1ri2wRiTO6Q4yL6c=
Received: by 10.151.92.3 with SMTP id u3mr4439594ybl.145.1255083463041;
        Fri, 09 Oct 2009 03:17:43 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 16sm450617gxk.7.2009.10.09.03.17.41
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 09 Oct 2009 03:17:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20091009101400.GA16549@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129765>

Idealists may want USE_NSEC to be the default on Linux some day.
Point to a patch to better explain the requirements on
filesystem code for that to happen.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Am I understanding the problem here correctly?  It seems to me
that ext2/3/4, tmpfs, ntfs, and so on shouldn=E2=80=99t have problems
with USE_NSEC, and all that is left is the monster that is
networked filesystems.

 Documentation/technical/racy-git.txt |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/technical/racy-git.txt b/Documentation/techn=
ical/racy-git.txt
index 48bb97f..53aa0c8 100644
--- a/Documentation/technical/racy-git.txt
+++ b/Documentation/technical/racy-git.txt
@@ -42,10 +42,12 @@ compared, but this is not enabled by default becaus=
e this member
 is not stable on network filesystems.  With `USE_NSEC`
 compile-time option, `st_mtim.tv_nsec` and `st_ctim.tv_nsec`
 members are also compared, but this is not enabled by default
-because the value of this member becomes meaningless once the
-inode is evicted from the inode cache on filesystems that do not
-store it on disk.
-
+because in-core timestamps can have finer granularity than
+on-disk timestamps, resulting in meaningless changes when an
+inode is evicted from the inode cache.  See commit 8ce13b0
+of git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
+([PATCH] Sync in core time granuality with filesystems,
+2005-01-04).
=20
 Racy git
 --------
--=20
1.6.5.rc1.199.g596ec

From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC 2/3] git-gui: Do not hold the user hostage with a full
 gc at startup
Date: Thu, 18 Feb 2010 08:39:03 -0600
Message-ID: <20100218143903.GB30520@progeny.tock>
References: <20100218143431.GA30486@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Mark Brown <broonie@sirena.org.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 18 15:39:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ni7X4-00081E-HZ
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 15:39:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757527Ab0BROjE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Feb 2010 09:39:04 -0500
Received: from mail-yx0-f200.google.com ([209.85.210.200]:64594 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757063Ab0BROjB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 09:39:01 -0500
Received: by yxe38 with SMTP id 38so6434612yxe.4
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 06:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=K006VGcDxClROLHLVnHqd4tbofaHM/hZiIPGhQstEug=;
        b=pjPXqQkp4NqbhhNy6xJVwUhj6UBurMgEUgA6dO4Nx/wNoYNL31QbQGVLNRcyEH8K5b
         ceR2E0N1StF3LEynXYInCtb3Z1KZA64VfHvig0tLSDectEOPL0SzZHRz7GuOTrP7fL8f
         B7ttAvTiaBxE+Gxs+nhmMlltH4c8JwklMr1s4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=BM2U7r9XHLt15FKZxnbzCZrRepWZH2abpefSVJP7bBmKcuIMk5RnsWNOIVshRNExa0
         EN2UOiorgD6qo6X10TF+Ph3rwoquBXKbST1FPpyPNwqCUoZwkBm3r5/rYiUkDm2D6bNt
         6vcNeEdYPEjIw4qTy7oECkuQGVfvzqXR8EX5k=
Received: by 10.101.132.32 with SMTP id j32mr9496834ann.48.1266503940721;
        Thu, 18 Feb 2010 06:39:00 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm3688315yxe.56.2010.02.18.06.38.59
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 18 Feb 2010 06:39:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100218143431.GA30486@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140341>

The 'git gc --auto' command is meant to perform an incremental gc,
avoiding problems from an unpacked repository without forcing the user
wait for intense I/O and computation before getting anything done.

The output is not really ideal for a GUI:

 Auto packing the repository for optimum performance. You may also
 run "git gc" manually. See "git help gc" for more information.
 Nothing new to pack.
 Removing duplicate objects: 100% (256/256), done.

git gc should pass the relevant information in machine-readable form
to fix this.

The gui does not already use gc --auto because it was not implemented
until git commit 2c3c439 (2007-09-05), a while after git gui gained
its gc functionality.  Moreover, the gui does not use git gc at all
ever since commit bc7452f (git-gui: Use builtin version of 'git gc',
2007-01-26) for reasons I don=E2=80=99t understand.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 lib/database.tcl |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/lib/database.tcl b/lib/database.tcl
index 25a0509..c8184de 100644
--- a/lib/database.tcl
+++ b/lib/database.tcl
@@ -78,6 +78,12 @@ proc do_gc {} {
 	}
 }
=20
+proc do_auto_gc {} {
+	set w [console::new {gc} [mc "Compressing the object database"]]
+	set cmd [list git gc --auto]
+	console::exec $w $cmd
+}
+
 proc do_fsck_objects {} {
 	set w [console::new {fsck-objects} \
 		[mc "Verifying the object database with fsck-objects"]]
@@ -126,7 +132,7 @@ proc hint_gc {} {
 To maintain optimal performance it is strongly recommended that you co=
mpress the database.
=20
 Compress the database now?" $objects_current]] eq yes} {
-			do_gc
+			do_auto_gc
 		}
 	}
 }
--=20
1.7.0

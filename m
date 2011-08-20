From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3] fast-import: do not write bad delta for replaced
 subtrees
Date: Sat, 20 Aug 2011 10:43:56 -0500
Message-ID: <20110820154356.GB15864@elie.gateway.2wire.net>
References: <1313145170-24471-1-git-send-email-divanorama@gmail.com>
 <1313346744-30340-3-git-send-email-divanorama@gmail.com>
 <20110820010901.GA2512@elie.sbx02827.chicail.wayport.net>
 <m262lspi0h.fsf@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sat Aug 20 17:44:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuniP-0003n1-Ut
	for gcvg-git-2@lo.gmane.org; Sat, 20 Aug 2011 17:44:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753198Ab1HTPoA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Aug 2011 11:44:00 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:62599 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752507Ab1HTPoA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Aug 2011 11:44:00 -0400
Received: by iye16 with SMTP id 16so7423733iye.1
        for <git@vger.kernel.org>; Sat, 20 Aug 2011 08:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=XmE0c22mqo0Zkv20DZN83b4CxlmUzLfNV0e7a63TIBA=;
        b=B+UtXSEcnhGMAb6uz5pbnDZth4o7X9tInenYXSYplZ32FNpLd3ihKRjF/owdetAM5f
         T02AzQ37PXFRx75V1zScLFJbbp3NOOzYiY+T4VXleyed6fCjS6zL0HuDhtg/2cN8IobQ
         Jz6di5I5Gh14ewbr6jme2HeOZi/dLIm/QFN3Q=
Received: by 10.42.246.136 with SMTP id ly8mr568474icb.454.1313855039451;
        Sat, 20 Aug 2011 08:43:59 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-69-209-48-207.dsl.chcgil.ameritech.net [69.209.48.207])
        by mx.google.com with ESMTPS id n18sm2243278ibg.1.2011.08.20.08.43.57
        (version=SSLv3 cipher=OTHER);
        Sat, 20 Aug 2011 08:43:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <m262lspi0h.fsf@linux-m68k.org>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179762>

Andreas Schwab wrote:

> $ git grep S_ISUID
> compat/mingw.h:#define S_ISUID 0

Good catch, thanks.  Fix below --- despite appearances, this "mode"
field is about tree objects in the repository and there is no need to
match the current platform's file status conventions.

Another worrisome detail is that the patch changes the semantics of
tree_entry.versions[0].mode (by introducing the NO_DELTA bit) without
changing its name.  It would be safer to rename it to te_mode or
something.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
diff --git i/fast-import.c w/fast-import.c
index 95919b63..45e2128a 100644
--- i/fast-import.c
+++ w/fast-import.c
@@ -173,7 +173,7 @@ Format of STDIN stream:
 /*
  * We abuse the setuid bit on directories to mean "do not delta".
  */
-#define NO_DELTA S_ISUID
+#define NO_DELTA 04000
 
 struct object_entry {
 	struct pack_idx_entry idx;
-- 

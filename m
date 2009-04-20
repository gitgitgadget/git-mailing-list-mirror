From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH 2/2] Windows: Skip fstat/lstat optimization in
	write_entry()
Date: Mon, 20 Apr 2009 15:03:02 +0400
Message-ID: <20090420110302.GB25059@dpotapov.dyndns.org>
References: <49EC2F7C.8070209@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Kjetil Barvik <barvik@broadpark.no>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Apr 20 13:05:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvrJn-0002qK-Ep
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 13:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754768AbZDTLDh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 07:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754759AbZDTLDg
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 07:03:36 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:12388 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754728AbZDTLDf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 07:03:35 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1843222rvb.1
        for <git@vger.kernel.org>; Mon, 20 Apr 2009 04:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=c1vVXztlZIwOxcN+NktpBhhzezX8LiwUkKOkb/v8j8U=;
        b=A8KiCOE/TAwTtTtzrtIDH9UbPimXmve8puYrgLk73ls2sa0Qhym4k1qBtQ7jwURCS+
         nU98U5EQHr8U2+xpTpCaj/54mMFCqftKNwreWSgJlyQsv0NDnlHIAfJN6vUrD3cAeCzo
         9VpP7WFIOZam9/zaqYcyZdK+zXR5vl5NXLvvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=IL4Zth0rD31U+lqLaf9h10RiFyRxrRWw57I3EV/DqhfHfXTpgmKPwjLgSPJd6CF0sJ
         qqRMiczRnO1zEg27h6bYZpCMJQDs2j4FweWkTwnMaVJwsX4hg6+Zb1AkLgO7BqQ9TeYN
         oaVPwCN5vXF6VuD5wmmCgqvGwRuHyVnF1sZtw=
Received: by 10.141.172.7 with SMTP id z7mr2476503rvo.128.1240225413275;
        Mon, 20 Apr 2009 04:03:33 -0700 (PDT)
Received: from localhost ([91.78.50.115])
        by mx.google.com with ESMTPS id b8sm9895040rvf.10.2009.04.20.04.03.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Apr 2009 04:03:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <49EC2F7C.8070209@viscovery.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116971>

The cygwin version has the same problem. (In fact, it is even worse,
because we have an optimized version for lstat/stat but not for fstat,
and they return different values for some fields like i_no). But even
if we used the only Cygwin functions, we would still face the problem,
because Windows returns the wrong values for timestamps (and maybe
even size on FAT?). So I think the following patch should be squashed
on top.

-- >8 --
From 1f957680d9b0e0bfeda9bf0e20397b0323b45334 Mon Sep 17 00:00:00 2001
From: Dmitry Potapov <dpotapov@gmail.com>
Date: Mon, 20 Apr 2009 14:54:16 +0400
Subject: [PATCH] cygwin: Skip fstat/lstat optimization in write_entry()

---
 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 2af0dfb..177dc15 100644
--- a/Makefile
+++ b/Makefile
@@ -809,6 +809,7 @@ ifeq ($(uname_S),HP-UX)
 endif
 ifneq (,$(findstring CYGWIN,$(uname_S)))
 	COMPAT_OBJS += compat/cygwin.o
+	UNRELIABLE_FSTAT = UnfortunatelyYes
 endif
 ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_PREAD = YesPlease
-- 
1.6.1.20.gee856
-- >8 --

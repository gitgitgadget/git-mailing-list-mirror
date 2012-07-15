From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH maint-1.6.5 v2] block-sha1: avoid pointer conversion that
 violates alignment constraints
Date: Sun, 15 Jul 2012 16:27:31 -0500
Message-ID: <20120715212731.GG1986@burratino>
References: <20120713233957.6928.87541.reportbug@electro.phys.waikato.ac.nz>
 <20120714002950.GA3159@burratino>
 <5000CBCA.8020607@orcon.net.nz>
 <20120714021856.GA3062@burratino>
 <50010B84.5030606@orcon.net.nz>
 <20120714075906.GD3693@burratino>
 <CA+55aFy+y=TCoJUQarinaduibt4i-46TAuvpp7fsAmjDZj_+3w@mail.gmail.com>
 <20120714205049.GA28502@burratino>
 <FDFB73BB-64E8-48F8-95DB-94C0EC7FFB2A@orcon.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
To: Michael Cree <mcree@orcon.net.nz>
X-From: git-owner@vger.kernel.org Sun Jul 15 23:28:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqWMY-0007fh-VX
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jul 2012 23:28:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751996Ab2GOV1j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jul 2012 17:27:39 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:61605 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919Ab2GOV1i (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2012 17:27:38 -0400
Received: by gglu4 with SMTP id u4so4560923ggl.19
        for <git@vger.kernel.org>; Sun, 15 Jul 2012 14:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=WonGP1eNiz1O/MoISReAgF8Py6Wk234wDNl/RfYVuKw=;
        b=K0bhlW2Xh0WG+frG6bPI1u1xBGpn0cPLSsK7cCWVMINlPpRTEUZOg4UQzHRytc/TxY
         FKnyU6QYH8izJoIh/q6nMYle6M4DmFZukb7pk8cjYgR6ld1aeSWL9GnOBXMw1XPFqhaw
         nHBYUXj9YgFmzcDVBUpyUE7XC7O3CuHfCiAFMyf82KGrqLGGJMk8zFkFmNtCmok5BFCK
         8WUdD1PhwJE38mZk8ccaoNT9yF/6sZOkyJ/gILi3jC8OGcjABaFJCJOpzFXBc5eDNg8c
         MtqQ0ygHM/lwO2if9iYzaU3+IPQyyYWuavbvqgqkAcKgV+qSWWCCtQ8MsCAiSDEvePbX
         KPkw==
Received: by 10.50.95.231 with SMTP id dn7mr3928708igb.18.1342387657471;
        Sun, 15 Jul 2012 14:27:37 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id bj4sm7119386igc.16.2012.07.15.14.27.36
        (version=SSLv3 cipher=OTHER);
        Sun, 15 Jul 2012 14:27:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <FDFB73BB-64E8-48F8-95DB-94C0EC7FFB2A@orcon.net.nz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201485>

Hi,

Michael Cree wrote:

> On 15/07/2012, at 8:50 AM, Jonathan Nieder wrote:

>>                   gcc takes full advantage by converting the get_be32
>> calls back to a load and bswap and producing a whole bunch of
>> unaligned access traps.
>
> Alpha does not have a bswap (or similar) instruction.
[...]
>                                    .  If the pointer is unaligned
> then two neighbouring aligned 32bit loads are required to ensure
> that all four bytes are loaded.  If the pointer is aligned then a
> single 32bit load gets all the four bytes.  Having never looked at
> the generated assembler code, I nevertheless suspect that is the
> guts of the optimisation --- the compiler can eliminate an access to
> memory if it knows the pointer is aligned.

How about:

	gcc takes full advantage by using a single 32-bit load,
	resulting in a whole bunch of unaligned access traps.

You can see the generated assembler with "make block-sha1/sha1.s" and
reading the resulting sha1.s file in the current working directory
(oops).  I don't have an alpha cross-compiler installed or access to
an alpha to check for myself.

-- >8 --
Subject: Makefile: fix location of listing produced by "make subdir/foo.s"

When I invoke "make block-sha1/sha1.s", 'make' runs $(CC) -S without
specifying where it should put its output and the output ends up in
./sha1.s.  Confusing.

Add an -o option to the .s rule to fix this.  We were already doing
that for most compiler invocations but had forgotten it for the
assembler listings.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Thanks,
Jonathan

 Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index dc709029..e8d2798f 100644
--- a/Makefile
+++ b/Makefile
@@ -2230,7 +2230,7 @@ $(ASM_OBJ): %.o: %.S GIT-CFLAGS $(missing_dep_dirs)
 endif
 
 %.s: %.c GIT-CFLAGS FORCE
-	$(QUIET_CC)$(CC) -S $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
+	$(QUIET_CC)$(CC) -o $@ -S $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
 
 ifdef USE_COMPUTED_HEADER_DEPENDENCIES
 # Take advantage of gcc's on-the-fly dependency generation
-- 
1.7.10.4

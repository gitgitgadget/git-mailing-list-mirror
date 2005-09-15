From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-diff-tree rename detection bug
Date: Thu, 15 Sep 2005 07:55:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509150739460.26803@g5.osdl.org>
References: <59a6e583050914094777c4fe96@mail.gmail.com>
 <7vwtljjzc3.fsf@assigned-by-dhcp.cox.net> <59a6e583050914114054b1564d@mail.gmail.com>
 <Pine.LNX.4.58.0509141321180.26803@g5.osdl.org> <17192.56103.803096.526568@cargo.ozlabs.ibm.com>
 <43290DA0.3030402@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>, Wayne Scott <wsc9tt@gmail.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 16:58:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFv9W-0007Bh-SB
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 16:55:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030476AbVIOOzw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 10:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030475AbVIOOzw
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 10:55:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7838 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030474AbVIOOzv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Sep 2005 10:55:51 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8FEtcBo023792
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 15 Sep 2005 07:55:38 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8FEtYil004965;
	Thu, 15 Sep 2005 07:55:36 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <43290DA0.3030402@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8609>



On Wed, 14 Sep 2005, H. Peter Anvin wrote:
> 
> Well, git seems to assume it can mmap() the entirety of any file under 
> its control, so a 64-bit git could handle larger files.

Right now git isn't 64-bit clean anyway (well, it should _work_ fine on
64-bit architectures, but it just can't handle files >32 bits).

I think the core object format should be all perfectly ok (since all the
sizes etc are in ascii), so this is not a huge deal. If you have an 
existing git archive and suddenly notice that you need 32+ bit file 
formats, you don't have to throw your archive away and re-generate it from 
scratch in some new format. 

In fact, I think even the streaming pack format is 64-bit-safe: it has 
binary sizes, but they are all length-encoded, and I think the data 
structure is safe.

Also, the index file - in order to not be unnecessarily big, and to be
able to use standard htonl/ntohl helpers etc - uses 32-bit lengths for
files. Even that _that_ should be 64-bit safe, because the length isn't 
actually _used_ for anything but to verify the curret state, and as with 
the timestamps etc, it's ok to "only" check the low 32 bits. 

So the on-disk format should be capable of handling 64-bit entities.

HOWEVER. I might be wrong. I tried to think about it, but I didn't care
too much, because I think git would suck at truly huge files. If only
because compressing them will take forever. And the _implementation_ uses
"unsigned int" and has never been tested with anything else, so it would 
need a lot of testing.

Also, the "pack index" file can only handle 32-bit offsets - you can make 
a pack-file that is bigger than that, and it should be fine from a 
_streaming_ standpoint (ie in the way we use them for network transport), 
but you can't index them in .git/objects/packs.

Which isn't a disaster: you might choose to say that you never pack huge 
files. That might be ok for some cases (maybe the huge file is a one-off 
satellite picture). It would suck if the huge file is a incrementally 
created log-file, where packing really would be nice.

IF we ever hit this, and IF people decide that git actually makes sense 
for those kinds of files, we CAN change the pack index format. It has a 
version number and everything, so we can even do it gently. Hopefully that 
would be the only actual on-disk format that would need to change. But 
regardless, the git code itself would need a lot of verification to make 
sure that it handles big files correctly.

I'm not seeing that as a high priority. Maybe in five years ;)

			Linus

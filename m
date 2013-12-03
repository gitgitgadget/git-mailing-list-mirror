From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [BUG] Core dump w/ bus error on bad mmap'd packfile
Date: Tue, 03 Dec 2013 20:50:39 +0100
Message-ID: <87vbz5n27k.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098>
References: <CAFGOX=WsGqmgxps64mWKPJ_Anj0tNTz8nQwpyDOpfCVQ_5HXow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Amit Bakshi <ambakshi@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 03 20:50:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vnvzl-0004j8-PQ
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 20:50:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753919Ab3LCTuy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 14:50:54 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:43761 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752028Ab3LCTux (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 14:50:53 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 0DE674D6563;
	Tue,  3 Dec 2013 20:50:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 2KSRljYmia0R; Tue,  3 Dec 2013 20:50:40 +0100 (CET)
Received: from linux-1gf2.Speedport_W723_V_Typ_A_1_00_098.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 637174D64C4;
	Tue,  3 Dec 2013 20:50:40 +0100 (CET)
In-Reply-To: <CAFGOX=WsGqmgxps64mWKPJ_Anj0tNTz8nQwpyDOpfCVQ_5HXow@mail.gmail.com>
	(Amit Bakshi's message of "Mon, 2 Dec 2013 14:20:08 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238727>

Amit Bakshi <ambakshi@gmail.com> writes:

>  I was getting core dumps (bus error 7) with git 1.7.1 when doing a
> git checkout. I tried git fsck, and same thing. I got the same with
> precompiled rpms of 1.7.12, and with a locally compiled version of git
> 1.8.5.
[...]
> $ git fsck
> Checking pack-0ccb5ee4f60003a7ea47d6904633cce5973efa60.pack
> in: 0x7f9070507000 remain: 17345210 offset: 17345230
> Bus error (core dumped)
>
> git verify-pack correctly shows the error, without a bus error.
>
> $ git verify-pack -v pack-0ccb5ee4f60003a7ea47d6904633cce5973efa60.pack
> fatal: read error on input: Input/output error
> pack-0ccb5ee4f60003a7ea47d6904633cce5973efa60.pack: bad

mmap()ing a file and attempting to read from parts that the kernel can
then not page in (in your case because it couldn't read the file) are
expected to give a SIGBUS, so there is no bug here.  The different
behavior comes from some commands using mmap() and some using read() to
access the packs.

Perhaps we could try to map the faulting address back to the file it
came from, though.  The siginfo_t for a SIGBUS contains information
about the faulting address, so for the case of packs we could walk the
'struct packed_git' list and see which open window the address belongs
to.  I need to think about the implications of doing that in a signal
handler, though.

-- 
Thomas Rast
tr@thomasrast.ch

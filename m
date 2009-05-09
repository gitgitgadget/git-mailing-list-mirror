From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re:
Date: Sat, 9 May 2009 09:44:28 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905090926300.3586@localhost.localdomain>
References: <454B76988CBF42F5BCACA5061125D263@caottdt504> <D75C0FA80F7041FFAAC50B314788AD6F@caottdt504> <alpine.LFD.2.01.0905071148500.4983@localhost.localdomain> <A07C3E66E84D46ACB37EDC7D396CCA62@caottdt504> <alpine.LFD.2.01.0905071248250.4983@localhost.localdomain>
 <alpine.LFD.2.01.0905071312000.4983@localhost.localdomain> <alpine.LFD.2.01.0905071446500.4983@localhost.localdomain> <81b0412b0905080117v3aad0c44o7b3bbcc7fe70d3b1@mail.gmail.com> <alpine.LFD.2.01.0905080734260.4983@localhost.localdomain>
 <eFUCK0_CEtLa6Qvg6X1SqHmCgRnY3_3dy3OCJK26lGP-_kDRyWtlRA@cipher.nrlssc.navy.mil> <alpine.LFD.2.01.0905080857130.4983@localhost.localdomain> <Ah7lj3UWxgwxNiQs6kqiiVurulv4F00ssWrb3OzfTrXYlK8ZBCSBOQ@cipher.nrlssc.navy.mil>
 <OWEdfN5mNBoNl1TcdOvhhNfi_nLsao-aFrHkz_rNtuX_4lqXHisfcQ@cipher.nrlssc.navy.mil> <alpine.LFD.2.01.0905081432150.4983@localhost.localdomain> <twBG1KnSrgPNk7NoVey4mgig1BeAk7e1GHOT90PSV9ZGTs-zCWYdtA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Bevan Watkiss <bevan.watkiss@cloakware.com>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Sat May 09 18:47:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2piB-0006qP-5r
	for gcvg-git-2@gmane.org; Sat, 09 May 2009 18:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751966AbZEIQr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2009 12:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751595AbZEIQr2
	(ORCPT <rfc822;git-outgoing>); Sat, 9 May 2009 12:47:28 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35567 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751528AbZEIQr1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 May 2009 12:47:27 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n49GiT7Q029770
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 9 May 2009 09:45:05 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n49GiSmV026935;
	Sat, 9 May 2009 09:44:29 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <twBG1KnSrgPNk7NoVey4mgig1BeAk7e1GHOT90PSV9ZGTs-zCWYdtA@cipher.nrlssc.navy.mil>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.461 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118674>



On Fri, 8 May 2009, Brandon Casey wrote:
> 
> btw, I've since done some more testing on some centos5.3 boxes we have.
> I get similar results (less ancient kernel 2.6.18).

Yes, 2.6.18 is still much too old to matter from a locking standpoint. 

When people initially worried about scalability, the issues were more 
about server side stuff and the cached cases. NFS (as a client) is 
certainly used on the server side too, but it tends to be a somewhat 
secondary worry where only specific parts really matter. So people worked 
a lot more on the core kernel, and on local high-performance filesystem 
scaling.

Only lately have we been pretty aggressive about finally really getting 
rid of the old "single big lock" (BKL) model entirely, or moving outwards 
from the core.

And while we removed the BKL from the normal NFS read/write paths long 
long ago, all the name lookup and directory handling code still had it 
until a year ago.

That, btw, is directly explained by perceived scalability issues: NFS is 
fairly often used as the backing store for a database and scaling thus 
matters there. But databases tend to keep their few big files open and use 
pread/pwrite - so pathname lookup is not nearly as significant for server 
ops as plain read/write.

(Pathname lookup is important for things like web servers etc, but they 
rely heavily on caching for that, and the cached case scales fine).

> I've also scanned through the errata announcements that RedHat has 
> released for their kernel updates.  A few of them involve NFS.  
> Possibly, whatever RedHat modified in the 5.X kernel was also backported 
> to the 4.X kernel.

That is very possibly the case. Expanding the BKL usage in some case could 
easily trigger the lock getting contention - and the way lock contention 
works, once you get a just even a small _hint_ of contention, things often 
fall off a cliff. The contention slows locking down, which in turn causes 
more CPU usage, which in turn causes _more_ contention.

So even a small amount of extra locking - or even just slowing down some 
code that was inside the lock - can have catastrophic behavioural changes 
when the lock is close to being a problem. You do not get a nice gradual 
slowdown at all - you just hit a hard wall.

I guess I should really try to set up some fileserver here at home to 
improve my test coverage. And to do better backups (or the little private 
data I have that I can't just mirror out to the world by turning it into 
an open-source project ;^)

				Linus

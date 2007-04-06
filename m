From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 09/13] drop objects larger than --blob-limit if specified
Date: Fri, 6 Apr 2007 12:24:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704061214230.6730@woody.linux-foundation.org>
References: <56b7f5510704051536s7de9638fs8cd811d580f6a7dc@mail.gmail.com> 
 <alpine.LFD.0.98.0704052103410.28181@xanadu.home> 
 <56b7f5510704051919v7daac590m6ac52c4fcabd5321@mail.gmail.com> 
 <alpine.LFD.0.98.0704052257200.28181@xanadu.home> 
 <Pine.LNX.4.64.0704060845120.6730@woody.linux-foundation.org>
 <56b7f5510704061109n2878a221p391b7c3edba89c63@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 23:26:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZu3j-0004PX-KE
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 21:25:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751672AbXDFTZP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 15:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751697AbXDFTZP
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 15:25:15 -0400
Received: from smtp.osdl.org ([65.172.181.24]:60209 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751672AbXDFTZM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 15:25:12 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l36JOsPD015519
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 6 Apr 2007 12:24:54 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l36JOrFL016969;
	Fri, 6 Apr 2007 12:24:54 -0700
In-Reply-To: <56b7f5510704061109n2878a221p391b7c3edba89c63@mail.gmail.com>
X-Spam-Status: No, hits=-0.954 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43918>



On Fri, 6 Apr 2007, Dana How wrote:
>
> I agree with your arguments, but packs have different uses
> and to me there are several differing (non-)reasons for --pack-limit.
> * To split packs into smaller chunks when the .pack format is used as a
>  communications protocol. But the discussion has converged to
>  "we're not going to split packs at the transmitter". I agree with this
>  conclusion,  since it would make the total transmission larger (loss
>  of deltas).

I don't agree with it, since I don't think the delta advantage is 
noticeable once packs are "big enough". 

Splitting on the sending side means that it needs to split just in one 
place, rather than have the same logic in two different places.

I don't think it really "convered" on anything, I think the discussion 
just didn't continue along that thing.

>  Since no .idx file is sent there is no requirement for --pack-limit here.

I really don't think the idx file is the only - or even primary - reason. 
We need *some* size limiter for a lot of reasons. If the idx file was the 
only reason, we should just switch to a new index format and forget about 
it.

But since there are *other* reasons that cannot go away, that doesn't 
obviate the need for size limits, so while I think the idx one is the 
*first* reason to do this, I don't think it is really the most important 
one, exactly because the idx file we *could* solve other ways.

> * To avoid offsets larger than 31 bits in .idx files.  Your proposal,
>  and what I was doing for --pack-limit && --stdout, is sufficient to
>  address this.

Right. 

> * Avoiding (e.g.) 2GB+ files when none already exist in the repository --
>  either the filesystem doesn't support anything beyond the limit,
>  or we don't want to use a >31b off_t with mmap.  (Perhaps
>  the latter case is completely avoided by some glibc 64b trickery,
>  but is that always true?)  Only the write rollback approach can address this.

I disagree violently. 

IN THEORY only write rollback can address that. But "theory" is not 
practice, and anybody who thinks that theory is even *relevant* here is 
missing the big picture.

If you use FATFS as the place to store your objects, it's really easy to 
just say: you can't have objects bigger than 2GB. That's the real life 
solution. The "theory" that you could have pack-files larger than 32 bits 
is just about as relevant as quantum mechanics is to designing the tensile 
strength of a sky-scraper. Sure, *in*theory* quantum mechanics matters, 
but in practice, you'd be crazy if you tried to convince anybody that it 
should be done using QM rather than traditional means.

Quite frankly, if you have objects that compress to >2GB, you're going to 
be in so much pain even on *other* filesystems, that I seriously doubt 
you'd want to track them using git anyway. And even if you want to, just 
tell people: don't use FATFS, because this repository is insane.

> * Creating .pack files that fit on e.g. CDROM etc.
> The 2nd and 3rd cases are what I'm thinking about,
> which is why the first version of my patch did both.

Again, *in*practice*, for any sane situation, if you want to fit things on 
a CD-ROM, just give a limit of 600MB, and I can pretty much guarantee that 
you'll see a slop of just a percent or two for any realistic setup. And if 
it goes up to 660MB, you'll still fit on any CD.

So please ignore theory, when theory isn't relevant. Designing for 
something that practically cannot happen sounds pretty wrong.

(Of course, since you have a 55GB archive, you probably have an insane 
thing in the first place. My condoleances if so ;)

		Linus

From: Andreas Ericsson <ae@op5.se>
Subject: Re: git to libgit2 code relicensing
Date: Mon, 17 Nov 2008 22:44:39 +0100
Message-ID: <4921E5C7.5030203@op5.se>
References: <491DE6CC.6060201@op5.se> <200811151615.42345.chriscool@tuxfamily.org> <49200914.6090506@op5.se> <alpine.DEB.1.00.0811162159280.30769@pacific.mpi-cbg.de> <49211C19.5010409@op5.se> <20081117154040.GO2932@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Nov 17 22:46:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2Bv1-0006To-5W
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 22:46:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752205AbYKQVor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 16:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752141AbYKQVor
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 16:44:47 -0500
Received: from mail.op5.se ([193.201.96.20]:43431 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752140AbYKQVoq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2008 16:44:46 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id F41131B80072;
	Mon, 17 Nov 2008 22:39:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5Ijw2ZiPAfeU; Mon, 17 Nov 2008 22:39:32 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.30])
	by mail.op5.se (Postfix) with ESMTP id 6B67F1B8005E;
	Mon, 17 Nov 2008 22:39:30 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20081117154040.GO2932@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101246>

Shawn O. Pearce wrote:
> Andreas Ericsson <ae@op5.se> wrote:
>> "Copy-rewrite", naturally. Being able to lift much of the data-munging code
>> is a great benefit. It's basically just the revision traversal (which is
>> heavy on state-dependant code) that I haven't quite figured out how to do
>> yet, but I believe Shawn's idea of using revision pools is most likely the
>> way to go. Each application has to make sure a pool isn't modified by more
>> than one thread, but each application can have as many pools as it likes.
> 
> I also like Pierre's idea of using annotation data in different
> annotation pools, and storing the rewritten parents in such a pool.
> Then an application can more easily reuse a revision pool, by just
> tossing the rewritten parent pool, or any other annotations it
> wants to recompute.
> 
> It may still be important to have revision pools and make them
> not thread-safe, so we can void fine-grained locking costs in
> the library during the tight revision traversal loops.
> 

Well, since git_revpool (I've renamed it in my tree, as I had a hard
time not pronouncing it "rev pointer" in my head) is a variable the
user gets back from us, it's about as thread-safe as the various IO
interfaces. That is, if several threads try to write at once, weird
things happen. That's just something the application writer has to
take care of though, and we should make sure to mark the revpool as
"const" in functions that will only read from it without modifying
it.

Speaking of threads though; I think I've solved the thread-local
storage problem for libgit. At least for pretty much all compilers
we care about (gcc, Intel C, MSVC, MSVC++) and a slew of others,
which means we can probably use a saner error-handling now. Personally
I think that's something we can benefit greatly from, as many functions
return "int" where they should return a pointer, only to accommodate
error handling.

I'll get those commits reordered and publish what I've got right now.
http://git.op5.org/git/?p=git/libgit2.git;a=summary will have most of
the stuff in an hour or so.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

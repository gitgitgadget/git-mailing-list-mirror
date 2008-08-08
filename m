From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Show of hands, how many set USE_NSEC
Date: Fri, 8 Aug 2008 10:42:06 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808081027590.3462@nehalem.linux-foundation.org>
References: <20080808163455.GE9152@spearce.org> <alpine.DEB.1.00.0808081854120.24820@pacific.mpi-cbg.de.mpi-cbg.de> <20080808165718.GG9152@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Aug 08 19:44:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRVzg-00081A-Fa
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 19:43:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752573AbYHHRmN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 13:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752567AbYHHRmM
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 13:42:12 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49033 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752463AbYHHRmL (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Aug 2008 13:42:11 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m78Hg74w008949
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 8 Aug 2008 10:42:08 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m78Hg6mK020264;
	Fri, 8 Aug 2008 10:42:06 -0700
In-Reply-To: <20080808165718.GG9152@spearce.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.409 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91699>



On Fri, 8 Aug 2008, Shawn O. Pearce wrote:
> 
> Really I'd just like to scrap the entire DIRC file format and do
> it over again.  Having the flat namespace is nuts.  Linus and I
> really disagree here, and since I have never produced code for C
> Git to replace it (and prove why its better) I think he has me in
> his kill file now.  :)

I really disagree, because you have no clue about performance.

The flat file format is absolutely _critical_ for performance.

Try this:

	time cat .git/index > /dev/null
	time git ls-tree -r HEAD > /dev/null

which isn't quite fair (but see how it's unfair both ways later), but 
gives you an idea of the cost of recursively reading lots of small files.

Notice how the latter is about an order-and-a-half slower? 

Then try it with a cold cache. If you thought the "ls-tree" was unfair 
because it used things like zlib and pack-files, realize that the ls-tree 
actually almost certainly has _better_ IO patterns than doing individual 
files. So when you do the cold-cache case, we're actually giving an unfair 
advantage to ls-tree (assuming fully packed repo like I have).

And it still loses in a big big way. If it was actually one file per 
directory, it would be _horrible_. You could kind of approximate the IO 
patterns for that case by doing

	time find . -name don-t-exist > /dev/null

(which obviousyl uses "readdir()" instead of read(), but the IO patterns 
should be similar).

The point is, the index file absolutely *HAS* to be a single file in order 
to perform well in a big project. Otherwise there's no point, and you 
might as well just use a git "tree" object for everything.

Now, if you talk about the _sorting_ order (as opposed to the flatness of 
the file), I could probably agree. The sort order was probably a mistake. 
That said, we're stuck with it.  You can't change it without changing the 
tree object format, so it's not just an "local index file" format issue.

			Linus

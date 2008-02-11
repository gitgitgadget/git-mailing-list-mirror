From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Add "--show-all" revision walker flag for debugging
Date: Mon, 11 Feb 2008 07:59:33 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802110748370.2920@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0802091341210.2896@woody.linux-foundation.org> <200802102353.40230.jnareb@gmail.com> <alpine.LFD.1.00.0802101507100.2896@woody.linux-foundation.org> <200802110224.48790.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nicolas Pitre <nico@cam.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 17:08:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JObC5-0005Sn-7a
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 17:07:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757388AbYBKQHL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 11:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757164AbYBKQHK
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 11:07:10 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:34324 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755055AbYBKQHG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Feb 2008 11:07:06 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1BG5H2b005946
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 11 Feb 2008 08:05:20 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1BFxXdt020893;
	Mon, 11 Feb 2008 07:59:33 -0800
In-Reply-To: <200802110224.48790.jnareb@gmail.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.726 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73547>



On Mon, 11 Feb 2008, Jakub Narebski wrote:
> 
> Errr... index is per workarea (per checkout), and this information
> is per repository, so IMHO storing this info in an index (dircache)
> is a layering violation. Unless you were talking about pack-file-index.

I did mean the pack-file index, not the "cache" index.

> Weren't the cases of multiple roots that were difficult? Storing roots
> would help with 'hard' (if seldom happening) cases then.

It's not that they aren't difficult, it's that they are so rare (ie having 
ranges that really *are* separate never happens in practice). So it's not 
worth worrying about from a performance angle.

The thing that worried me about multiple roots was that they make the 
generation numbers essentially "meaningless" when compared across totally 
unrelated commits, and might give incorrect results for generation number 
comparisons as a result.

However, I decided that if two commits really *are* totally unrelated and 
don't share a commit, then:

 - yes, the generation number comparison is "meaningless"

 - BUT: we don't actually care if it's correct or not, because it will 
   never matter: whatever we choose to do, it's correct. Because there are 
   just two choices:

    (a) stop early because everything we have left is uninteresting

        This is correct, because if they have two separate roots, they'll 
        never meet anyway, so from a correctness standpoint they will 
        never change a interesting commit into an uninteresting one.

    (b) continue to the root because we think we might turn something 
        interesting into an uninteresting commit. This may be wasteful 
        (because the generation numbers happened to fool us into thinking 
        we migth care and one is older than the other), but it's still 
        technically _correct_.

        And we really don't need to care about the performance issues 
        since continuing down to the root is what we'd have had to do even 
        without the generation numbers anyway, but more importantly 
        because we simply don't care - if people start doing comparisons 
        across truly independent commits, they are doing something wrong.

So that's why a generation number is sufficient.

And yes, just generating the generation number when repacking is fine. It 
would mean that unpacked objects don't have generation numbers, but of you 
have tons and tons of unpacked objects, you have more serious problems 
anyway!

			Linus

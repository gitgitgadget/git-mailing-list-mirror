From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git and larger trees, not so fast?
Date: Fri, 10 Aug 2007 09:07:01 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708100852540.30176@woody.linux-foundation.org>
References: <20070809163026.GD568@mbox.bz>
 <alpine.LFD.0.999.0708090948250.25146@woody.linux-foundation.org>
 <alpine.LFD.0.999.0708091015500.25146@woody.linux-foundation.org>
 <alpine.LFD.0.999.0708091056180.25146@woody.linux-foundation.org>
 <7vmyx0y3vp.fsf@assigned-by-dhcp.cox.net> <7v7io4xwvp.fsf@assigned-by-dhcp.cox.net>
 <20070809165218.9b76ebf7.seanlkml@sympatico.ca>
 <alpine.LFD.0.999.0708091426050.25146@woody.linux-foundation.org>
 <alpine.LFD.0.999.0708091444550.25146@woody.linux-foundation.org>
 <7vtzr8wemb.fsf@assigned-by-dhcp.cox.net> <7vps1wwa5w.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.999.0708091734210.25146@woody.linux-foundation.org>
 <7vhcn8w6sw.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.999.0708091754150.25146@woody.linux-foundation.org>
 <7v643ovyli.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>, moe <moe-git@mbox.bz>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 18:08:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJX1r-0005b3-FP
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 18:08:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S940620AbXHJQH4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 12:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S940601AbXHJQHz
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 12:07:55 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:51967 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S940350AbXHJQHv (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Aug 2007 12:07:51 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7AG76Sp020945
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 10 Aug 2007 09:07:07 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7AG71vl029413;
	Fri, 10 Aug 2007 09:07:01 -0700
In-Reply-To: <7v643ovyli.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-2.724 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.20__
X-MIMEDefang-Filter: lf$Revision: 1.184 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55549>



On Thu, 9 Aug 2007, Junio C Hamano wrote:
> > 
> > (I didn't test it, though, maybe I missed something).
> 
> I do not think the change affects the normal codepath.  The
> one-liner patch to git-commit.sh touches the codepath that
> updates the index used only to write out the partial commit, and
> losing the cached stat info from that index does not matter, as
> that index is removed immediately after writing the tree out and
> is never compared with working tree as far as I can tell.

You are, of course, mostly right. Using "-m" there is largely pointless, 
since it's a throw-away index, and we'll only ever use the exact paths 
that were given to us.

However, it does actually matter for one case: the case where you give a 
directory name or other name pattern, resulting in a *lot* of filenames. 
In that case, the commit will end up piping that (potentially very large) 
list to "git update-index --add --remove --stdin", and that will now mean 
that they *all* get their SHA1's recomputed.

Of course, that was the other performance bug that we already knew about 
(except we were thining "git add .", and fixed that case). So we're 
already slow at it - but we *shouldn't* be.

Try this on the kernel archive (use a clean one, so these things *should* 
all be no-ops):

	time sh -c "git add . ; git commit"

which is nice and fast and takes just over a second for me, but then try

	time git commit .

which *should* be nice and fast, but it takes forever, because we now 
re-compute all the SHA1's for *every* file. Of course, if it's all in the 
cache, it's still just 4s for me, but I tried with a cold cache, and it 
was over half a minute!

(I don't actually ever do something like "git commit .", but I could see 
people doing it. What I *do* do is that if I have multiple independent 
changes, I may actually do "git commit fs" to commit just part of them, 
and rather than list all the files, I literally just say "commit that 
sub-tree". So this really is another valid performance issue).

Sad.

			Linus

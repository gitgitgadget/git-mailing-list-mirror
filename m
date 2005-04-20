From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: WARNING! Object DB conversion (was Re: [PATCH] write-tree
 performance problems)
Date: Wed, 20 Apr 2005 07:29:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504200725110.6467@ppc970.osdl.org>
References: <200504191250.10286.mason@suse.com>  <200504191708.23536.mason@suse.com>
  <Pine.LNX.4.58.0504191420060.19286@ppc970.osdl.org>  <200504192049.21947.mason@suse.com>
  <Pine.LNX.4.58.0504192337120.6467@ppc970.osdl.org>  <42660708.60109@zytor.com>
  <Pine.LNX.4.58.0504200144260.6467@ppc970.osdl.org> <2cfc4032050420050655265d3a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 20 16:25:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOG6w-0005Al-Pr
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 16:23:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261641AbVDTO1g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 10:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbVDTO1g
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 10:27:36 -0400
Received: from fire.osdl.org ([65.172.181.4]:65157 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261641AbVDTO1e (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 10:27:34 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3KERVs4030736
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 20 Apr 2005 07:27:32 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3KERU1R006402;
	Wed, 20 Apr 2005 07:27:31 -0700
To: jon@zeta.org.au
In-Reply-To: <2cfc4032050420050655265d3a@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 20 Apr 2005, Jon Seymour wrote:
> 
> Am I correct to understand that with this change, all the objects in the 
> database are still being compressed (so no net performance benefit), but by 
> doing the SHA1 calculations before compression you are keeping open the 
> possibility that at some point in the future you may use a different 
> compression technique (including none at all) for some or all of the 
> objects?

Correct. There is zero performance benefit to this right now, and the only 
reason for doing it is because it will allow other things to happen.

Note that the other things include:
 - change the compression format to make it cheaper
 - _keep_ the same compression format, but notice that we already have an 
   object by looking at the uncompressed one.

I'm actually leaning towards just #2 at this time. I like how things
compress, and it sure is simple. The fact that we use the equivalent of
"-9" may be expensive, but the thing is, we don't actually write new files
that often, and it's "just" CPU time (no seeking on disk or anything like
that), which tends to get cheaper over time.

So I suspect that once I optimize the tree writing to notice that "oh, I
already have this tree object", and thus build it up but never compressing
it, "write-tree" performance will go up _hugely_ even without removing the
compressioin. Because most of the time, write-tree actually only needs to
create a couple of small new tree objects.

			Linus

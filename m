From: Derek Fawcus <dfawcus@cisco.com>
Subject: Re: space compression (again)
Date: Fri, 15 Apr 2005 19:50:38 +0100
Message-ID: <20050415195038.E6735@mrwint.cisco.com>
References: <Pine.LNX.4.61.0504151232160.27637@cag.csail.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Apr 15 20:48:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMVqe-00085b-HL
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 20:47:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbVDOSuw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 14:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbVDOSuw
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 14:50:52 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:29848 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S261893AbVDOSum (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2005 14:50:42 -0400
Received: from ams-core-1.cisco.com (144.254.224.150)
  by ams-iport-1.cisco.com with ESMTP; 15 Apr 2005 20:50:42 +0200
Received: from cisco.com (mrwint.cisco.com [64.103.71.48])
	by ams-core-1.cisco.com (8.12.10/8.12.6) with ESMTP id j3FIoc54001899
	for <git@vger.kernel.org>; Fri, 15 Apr 2005 20:50:39 +0200 (MEST)
Received: (from dfawcus@localhost)
	by cisco.com (8.8.8-Cisco List Logging/8.8.8) id TAA18818
	for git@vger.kernel.org; Fri, 15 Apr 2005 19:50:38 +0100 (BST)
To: git@vger.kernel.org
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.61.0504151232160.27637@cag.csail.mit.edu>; from cscott@cscott.net on Fri, Apr 15, 2005 at 01:19:30PM -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 15, 2005 at 01:19:30PM -0400, C. Scott Ananian wrote:
> Why are blobs per-file?  [After all, Linus insists that files are an 
> illusion.]  Why not just have 'chunks', and assemble *these* 
> into blobs (read, 'files')?  A good chunk size would fit evenly into some 
> number of disk blocks (no wasted space!).

[ I've only been earwigging,  not paying a lot of attention,  however ...]

Funny I was just think of this having read Linus' discourse on
"files don't matter", the obvious chunking factor would be say
a function.

The problem being tending towards having very small files - I know
I tend to prefer small functions.  Hmm - a underlying filesystem that
efficiently stores small files - why does that ring a bell :-)

However the simple answer is to have a preparser for a file / tree
checkin which split say a .c file into it's associated chunks,  anf
represented it in git as a signed/hashed object.  i.e. a automatically
created extra level of indirection (as I seem to recall was added
somewhere else?).

  So say fred.c:

  /*
   * File boiler
   */
  #include <guff>
  #include <more guff>

  /*
   * Fn a boiler
   */
  int fn_a(args) {
  }

  /*
   * Fn b boiler
   */
  long fn_b(args) {
  }

Would be split into 4 parts within git,  the 'file object' which simply
points to the content objects,  and 3 contents objects,  being the stuff
before 'Fn a boiler',  fn_a and it's boiler,  fn_b and it's boiler.

The interesting bit is needing a preprocessor which can roughly parse
the code - i.e. detect where to place the boiler blocks.

You would then do most of your tree operations upon the file objects,
but get the space savings from the content objects being shared.

I suspect that simply to prevent pathological conditions you'd have to
arrange that the contents objects have a minimal size,  irrespective
of the number of desired chunks (functions) they would naturally
contain.  i.e. for compresion efficiency,  you may choose something like
2K as the minimal pre compression content object size.

DF

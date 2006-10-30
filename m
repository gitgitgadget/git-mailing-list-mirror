X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: WARNING: THIS PATCH CAN BREAK YOUR REPO,
 was Re: [PATCH 2/3] Only repack active packs by skipping over kept packs.
Date: Mon, 30 Oct 2006 14:07:57 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0610301332440.11384@xanadu.home>
References: <20061029093754.GD3847@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Mon, 30 Oct 2006 19:25:43 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <20061029093754.GD3847@spearce.org>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30513>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GecUZ-0005ZY-Ao for gcvg-git@gmane.org; Mon, 30 Oct
 2006 20:08:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161449AbWJ3TIA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 14:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161451AbWJ3TH7
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 14:07:59 -0500
Received: from relais.videotron.ca ([24.201.245.36]:18016 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1161449AbWJ3TH6
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 14:07:58 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J7Y007WGQHAJ7J0@VL-MH-MR002.ip.videotron.ca> for git@vger.kernel.org; Mon,
 30 Oct 2006 14:07:58 -0500 (EST)
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

On Sun, 29 Oct 2006, Shawn Pearce wrote:

> During `git repack -a -d` only repack objects which are loose or
> which reside in an active (a non-kept) pack.  This allows the user
> to keep large packs as-is without continuous repacking and can be
> very helpful on large repositories.

Something is really broken here.

Here's how to destroy your GIT's git repository.

WARNING: MAKE A COPY BEFORE TRYING THIS!  I'm serious.

First, let's make a single pack just to make things simpler and 
reproducible:

$ git-repack -a -f -d
$ git-prune
$ git-fsck-objects --full

So far everything should be fine.  It's still time to make a backup copy 
of your .git directory if you've not done so.

Now let's create a second pack containing a subset of the existing one.

$ git-rev-list --objects v1.4.3..v1.4.3.3 | \
  git-pack-objects --stdout | \
  git-index-pack --stdin -v --keep
$ git-fsck-objects --full

At this point the repository is still fine, but the --keep to 
git-index-pack above will have created a file called 
.git/objects/pack/pack-aceb4c6394c586abaf65d76dd6cf088f50a5b806.keep and 
that is the source of all the trouble to come.  You still can remove 
that file if you don't have a backup yet.

If you still want to give it the coup de grace, just do:

$ git-repack -a -d

And now you've just lost a large amount of objects.  To see the extent 
of the dammage, just do:

$ git-fsck-objects

So... what is the --unpacked=<pack>.pack switch supposed to mean?  It is 
not documented anywhere and it certainly doesn't produce the expected 
result with a repack.



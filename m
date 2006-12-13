X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Using GIT to store /etc (Or: How to make GIT store all file
 permission bits)
Date: Wed, 13 Dec 2006 13:10:01 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612131156500.20138@iabervon.org>
References: <787BE48C-1808-4A33-A368-5E8A3F00C787@mac.com>
 <Pine.LNX.4.64.0612111837210.20138@iabervon.org> <8900B938-1360-4A67-AB15-C9E84255107B@mac.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 13 Dec 2006 18:16:53 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 13:16:42 EST
In-Reply-To: <8900B938-1360-4A67-AB15-C9E84255107B@mac.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34228>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuYet-0003ty-D1 for gcvg-git@gmane.org; Wed, 13 Dec
 2006 19:16:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932556AbWLMSQo (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 13:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932652AbWLMSQo
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 13:16:44 -0500
Received: from iabervon.org ([66.92.72.58]:4151 "EHLO iabervon.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S932556AbWLMSQn
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006 13:16:43 -0500
Received: (qmail 29606 invoked by uid 1000); 13 Dec 2006 13:10:01 -0500
Received: from localhost (sendmail-bs@127.0.0.1) by localhost with SMTP; 13
 Dec 2006 13:10:01 -0500
To: Kyle Moffett <mrmacman_g4@mac.com>
Sender: git-owner@vger.kernel.org

On Tue, 12 Dec 2006, Kyle Moffett wrote:

> Hmm, ok.  It would seem to be a reasonable requirement that if you want to
> change any of the "preserve_*_attributes" config options you need to blow away
> and recreate your index, no?  I would probably change the underlying index
> format pretty completely and stick a new version tag inside it.

You should be able to promote an insufficient-version index to a 
new-version index that's needs to be refreshed for every entry. (And then 
update-index would take care of the necessary rewrite-everything in the 
normal way). But I suspect that the right thing is to require that the 
repository be created with a "commits-include-directories-not-trees" flag, 
and this means that you always use the extra-detailed index, and the 
options only affect what information is filtered out in transit between 
the directory object and the index. Having more information in the index 
is merely a potential waste of space, not a correctness issue (we have 
extra information for trees in the index now, remember); it just means 
that there are more things that will cause git to reread the file, rather 
than declaring it unchanged with a stat().

For that matter, it may be best for the directory objects to record what 
information in them is real, and keep the "what's content" mask in the 
index as well. If it changes over the history of a repository, you want to 
correctly interpret the historical commits.

> Ok, seems straightforward enough.  One other thing that crossed my mind was
> figuring out how to handle hardlinks.  The simplest solution would be to add
> an extra layer of indirection between the "file inode" and the "file data".
> Instead of your directory pointing to a "file-data" blob and "file-attributes"
> object, it would point to an "file-inode" object with embedded attribute data
> and a pointer to the file contents blob.
>
> I remember reading some discussions from the early days of GIT about how that
> was considered and discarded because the extra overhead wouldn't give any real
> tangible benefit.  On the other hand for something like /etc the added
> benefits of tracking extended attributes and hardlinks might outweigh the cost
> of a bunch of extra objects in the database.  A bit of care with the
> construction of the index file should make it sufficiently efficient for
> day-to-day usage.

I was thinking this could be internal to the directory object, but you 
probably want to support hardlinks shared between dentries in different 
directory objects, so you're probably right that this makes sense. 

Alternatively, you could use a single "directory" object for the whole 
state (including subdirectories), making hardlinks out of the object 
clearly impossible, or you could use some scheme for sharing 
sub-"directory" objects that would imply that hardlinks are within an 
object (the hard part here is finding things when their locations aren't 
predictable by name).

	-Daniel

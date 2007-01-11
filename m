From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Speedup recursive by flushing index only once for all entries
Date: Thu, 11 Jan 2007 15:53:22 -0800
Message-ID: <7vk5zt15ot.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0701040447u329dcf9bvcd7adb9e9d199f18@mail.gmail.com>
	<7v8xgileza.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0701050322u67131900xea969b2da9981a94@mail.gmail.com>
	<20070107163112.GA9336@steel.home>
	<7vr6u2adgx.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0701101507n764aed73p31c7533e743283f0@mail.gmail.com>
	<Pine.LNX.4.64.0701101521410.3594@woody.osdl.org>
	<81b0412b0701110102m5264696dg68a573e9d5f2a17c@mail.gmail.com>
	<Pine.LNX.4.64.0701110823300.3594@woody.osdl.org>
	<7vfyah48j2.fsf@assigned-by-dhcp.cox.net>
	<20070111221053.GD6058@steel.home>
	<Pine.LNX.4.64.0701111424400.3594@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 12 00:53:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H59jq-0004OJ-MY
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 00:53:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932651AbXAKXxj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 18:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932819AbXAKXxj
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 18:53:39 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:55803 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932651AbXAKXxi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 18:53:38 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070111235337.LUIA25875.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>;
          Thu, 11 Jan 2007 18:53:37 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 9zsm1W00Z1kojtg0000000; Thu, 11 Jan 2007 18:52:47 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36635>

Linus Torvalds <torvalds@osdl.org> writes:

> On Thu, 11 Jan 2007, Alex Riesen wrote:
>> 
>> It must have been large leak, as I really have seen the memory usage
>> dropping down significantly.
>
> I really think it was about 6MB (or whatever your index file size was) per 
> every single resolved file. I think merge-recursive used to flush the 
> index file every time it resolved something, and every flush would 
> basically leak the whole buffer used to write the index.

This does not change the conclusion "leaking is bad", but it was
not as bad as "the whole buffer used to write the index".

There are 10 4-byte ints, 20-bye SHA1, and a short plus pathname
and padding stored per a file and Alex has 44k files.  They are
not included in that *data the code was leaking, I would suspect
maybe a meg or so per path.

The version of merge-recursive in 'next' would not write out the
index at all until the very end once, so that makes this leak
somewhat irrelevant for that particular program ;-) but thanks
for the fix.

Here is the list of what I have queued for 'master' (I am
sending the list because it will be some time before I can push
them out):

Eric Wong (1):
      Avoid errors and warnings when attempting to do I/O on zero bytes

Junio C Hamano (5):
      Document git-init
      index-pack: write-or-die instead of unchecked write-in-full.
      config-set: check write-in-full returns in set_multivar
      git-rm: do not fail on already removed file.
      git-status: wording update to deal with deleted files.

Linus Torvalds (3):
      write-cache: do not leak the serialized cache-tree data.
      write_in_full: really write in full or return error on disk full.
      Better error messages for corrupt databases

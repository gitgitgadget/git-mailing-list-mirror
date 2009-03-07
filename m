From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git memory usage (1): fast-import
Date: Sat, 7 Mar 2009 13:01:30 -0800
Message-ID: <20090307210130.GO16213@spearce.org>
References: <20090307201920.GE12880@zoy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sam Hocevar <sam@zoy.org>
X-From: git-owner@vger.kernel.org Sat Mar 07 22:03:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lg3fn-0004ku-5b
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 22:03:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755515AbZCGVBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 16:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755423AbZCGVBc
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 16:01:32 -0500
Received: from george.spearce.org ([209.20.77.23]:34839 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723AbZCGVBb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 16:01:31 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 1F7E938215; Sat,  7 Mar 2009 21:01:30 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090307201920.GE12880@zoy.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112584>

Sam Hocevar <sam@zoy.org> wrote:
>    I joined a project that uses very large binary files (up to 1 GiB) in
> a p4 repository and as I would like to use Git, I am trying to make it
> more memory-efficient when handling huge files.

Yikes.  As you saw, this won't play well...
 
>    In practice, it takes even more memory than that. Experiment shows
> that importing six 100 MiB files made of urandom data takes 370 MiB of
> memory [...]

Yes.

As you saw, this is the last object, the current object, the delta
index of the last object (in order to more efficiently compare the
current one to it), and the deflate buffer for the current object,
oh, and probably memory fragmentation....

I'm not surprised a 100 MiB file turned into 370 MiB heap usage.
 
>    - stop trying to compute deltas in fast-import and leave that task
>    to other tools

This isn't practical for source code imports, unless we do...

> (optionally, define a file size threshold beyond
>    which the last file is not kept in memory, and maybe make that a
>    configuration option).

what you suggest here.  fast-import is faster than other methods
because we get some delta compression on the content, so the output
pack uses up less virtual memory when the front-end or end-user
finally gets around to doing `git repack -a -d -f` to recompute
the delta chains.

>    - use a temporary file to store the deflate data when it reaches a
>    given size threshold (and maybe make that a configuration option).

Zoiks.  There's no reason for that.

A better method would be to just look at the size of the incoming
blob, and if its over some configured threshold (default e.g. 100
MB is perhaps sane) we just stream the data through deflate()
and into the pack file, with no delta compression.

That would also bypass the "massive" buffer in the last object slot,
as you point out above.
 
>    - also, I haven't tracked all strbuf_* uses in fast-import, but I got
>    the feeling that strbuf_release() could be used in a few places
>    instead of strbuf_setlen(0) in order to free some memory.

Examples?  I haven't gone through the code in detail since it
was modified to use strbufs.  But I had the feeling that the code
wasn't freeing strbufs that it would just reuse on the next command,
and that are likely to be "smallish", e.g. just a few KiBs in size.

-- 
Shawn.

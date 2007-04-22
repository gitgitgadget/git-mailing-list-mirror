From: David Lang <david.lang@digitalinsight.com>
Subject: Re: [PATCH 0/4] External 'filter' attributes and drivers
Date: Sun, 22 Apr 2007 02:01:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0704220155230.5946@qynat.qvtvafvgr.pbz>
References: <11771520591529-git-send-email-junkio@cox.net>
 <20070422052008.GH17480@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Apr 22 11:35:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfYTw-0007c1-3M
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 11:35:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754038AbXDVJfe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 05:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754044AbXDVJfe
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 05:35:34 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:44378 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1754038AbXDVJfd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 05:35:33 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Sun, 22 Apr 2007 02:35:33 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Sun, 22 Apr 2007 02:35:19 -0700
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <20070422052008.GH17480@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45230>

On Sun, 22 Apr 2007, Shawn O. Pearce wrote:

> Junio C Hamano <junkio@cox.net> wrote:
>> I know this is controversial, but here is a small four patch
>> series to let you insert arbitrary external filter in checkin
>> and checkout codepath.
>
> This series is some pretty nice work.
>
> But I really don't think we want filters.  Actually, I'm very
> against them, and I'm actually very against the CRLF work that
> has already been added.  Since the CRLF ship has sailed I won't
> try to call it back to port.  But I don't want to see the filter
> stuff raise anchor...
>
> I've only really seen a few arguments for the filters:
>
> 1) Better compress structured content (e.g. ODF) by storing the
>   ZIP as a tree, allowing normal deltification within packfiles
>   to apply to the contained files.
>
> 2) Use a custom diff function on special files (e.g. ODF) as they
>   are otherwise unreadable with the internal xdiff based engine.
>
> 3) Mutate content prior to extracting from the tree, e.g. printing.
>
>
> Let me try to address these points.
>
> #1: There are a limited number of content formats that we could
> reasonably filter into the repository such that the standard
> deltification routines will have good space/performance benefits.
> Most of them today are ZIP archives (e.g. ODF, JAR).

I think that there are a lot more that could benifit from application specific 
knowledge. git today just deals with line-based formats. anything that has more 
structure to it could benifit from a diff/merge/delta/etc specific to it

> Why don't we just teach the packfile format how to better compress
> these types of streams?  Let read_sha1_file() and pack-objects do all
> of the heavy translation work, just as they do today for text files.
> Explode them into a "tree-like" thing that allows deltification
> against any other content (even cross ZIP streams) just like we
> do with trees, but always expose them to the working directory
> level of the system as blobs.
>
> This way we never get into the mess that David Lang pointed out
> where we have many optimizations that reuse working tree files when
> stat data matches; nor do we have to worry about major structural
> differences between the working tree (1 file) and the repository
> format (exploded ZIP as 10,000 files).
>

nobody is suggesting that the working tree format be one file and the repository 
format be 1000 files. but if you think that skipping borrowing from a working 
tree is expensive, consider how expsndive it is to uncompress and recompress 
files.

>
> #2: We already support using any diff tool you want: set the
> GIT_EXTERNAL_DIFF environment variable before running a program that
> generates a diff.  As Junio pointed out on #git tonight, that could
> be any shell script that decides how to produce the diff based on
> its own logic.  Though we could also use the new attribute stuff
> to select diff programs, much like we do now for merge conflict
> resolution in merge-recursive.

but not diff tools per file, only per repository. not all files in a repository 
should be handled the same way.

>
> #3: This has already been discussed at length on the list.
> Letting the build system perform this sort of work is better than
> making the VCS do it; especially when you want the VCS to do its
> sole job well (track the state of the working directory) and the
> build system do its sole job well (produce files suitable for use
> outside of the repository).

sometimes there isn't a build system to shove this work off to.

I'll add a few more

managing permissions on files

managing system config files (where you want many systems to share what's 
logicly the same config, but each system needs it's own specifics)

David Lang

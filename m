From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH WIP] sha1-lookup: make selection of 'middle' less aggressive
Date: Mon, 31 Dec 2007 17:40:15 -0500
Message-ID: <20071231224015.GW14735@spearce.org>
References: <7vd4soa3cw.fsf@gitster.siamese.dyndns.org> <7vtzm08l9w.fsf@gitster.siamese.dyndns.org> <e5bfff550712301106l133dd38btd2cc4be02159387d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 31 23:40:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9TJP-0001ag-Ix
	for gcvg-git-2@gmane.org; Mon, 31 Dec 2007 23:40:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbXLaWkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2007 17:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbXLaWkU
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Dec 2007 17:40:20 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:36784 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085AbXLaWkU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2007 17:40:20 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1J9TIm-000787-4R; Mon, 31 Dec 2007 17:40:08 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 820F820FBAE; Mon, 31 Dec 2007 17:40:15 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <e5bfff550712301106l133dd38btd2cc4be02159387d@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69423>

Marco Costalba <mcostalba@gmail.com> wrote:
> Just for document the profiling I have uploaded a snapshot of
> KCachegrind profiling data on a run of git-log on the git tree:
> 
> http://digilander.libero.it/mcostalba/callgrind_git_log1.png
> 
> From there you can see that pretty.c and strbuf.c, after all the
> optimizations, account for less then 8% of total time.
> The biggest part is that 86.64% that is due almost entirely to zlib.
> 
> In particular
> 
> st = inflate(&stream, Z_FINISH);
> 
> called from unpack_compressed_entry() in sha1_file.c accounts for 72%
> of total time.

That's one of the areas where packv4 was actually a reasonably
good gain.  It was faster for packv4 to convert a dict based commit
or tree into the canonical raw format used by git than it was for
zlib inflate to decompress the very same data.

It wasn't a huge gain, but if I recall we were saving a good half
second on a 4 second "git log --raw >/dev/null" time.  And that
was before we even tried to improve the tree walking APIs to
take advantage of the smaller (and easier to read) dict based
tree objects.

Linus already mentioned in another reply on this thread that the
inflate time may be all page faults.  The savings we were seeing
from the dict based format may have simply been due to less page
faults; the dict based format was slightly smaller so we probably
got a lot more in disk cache at once.

-- 
Shawn.

From: david@lang.hm
Subject: Re: Git performance results on a large repository
Date: Mon, 6 Feb 2012 17:28:06 -0800 (PST)
Message-ID: <alpine.DEB.2.02.1202061722310.1107@asgard.lang.hm>
References: <CB55A6A4.40AFD%joshua.redstone@fb.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Joey Hess <joey@kitenet.net>,
	"dgma@mohsinc.com" <dgma@mohsinc.com>,
	Matt Graham <mdg149@gmail.com>,
	Tomas Carnecky <tom@dbservice.com>,
	Greg Troxel <gdt@ir.bbn.com>,
	David Barr <davidbarr@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Redstone <joshua.redstone@fb.com>
X-From: git-owner@vger.kernel.org Tue Feb 07 02:31:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuZte-0004lr-0S
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 02:31:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756595Ab2BGBa4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 20:30:56 -0500
Received: from mail.lang.hm ([64.81.33.126]:58871 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756051Ab2BGBaz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 20:30:55 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id q171S65A008412;
	Mon, 6 Feb 2012 17:28:06 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <CB55A6A4.40AFD%joshua.redstone@fb.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190131>

On Mon, 6 Feb 2012, Joshua Redstone wrote:

> David Lang and David Barr, I generated the pack files by doing a repack:
> "git repack -a -d -f --max-pack-size=10g --depth=100 --window=250"  after
> generating the repo.

how many pack files does this end up creating?

I think that doing a full repack the way you did will group all revisions 
of a given file into a pack.

while what I'm saying is that if you create the packs based on time, 
rather than space efficiency of the resulting pack files, you may end up 
not having to go through as much date when doing things like a git blame.

what you did was

initialize repo
4M commits
repack

what I'm saying is

initialize repo
loop
    500K commits
    repack (and set pack to .keep so it doesn't get overwritten)

so you will end up with ~8 sets of pack files, but time based so that when 
you only need recent information you only look at the most recent pack 
file. If you need to go back through all time, the multiple pack files 
will be a little more expensive to process.

this has the added advantage that the 8 small repacks should be cheaper 
than the one large repack as it isn't trying to cover all commits each 
time.

David Lang

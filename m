From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Query remote repository files, blobs
Date: Sat, 19 Dec 2009 11:24:15 -0800
Message-ID: <20091219192415.GC10687@spearce.org>
References: <d16b1c80912182345h4163430bv810adb860575d67a@mail.gmail.com> <alpine.DEB.1.00.0912191159280.4985@pacific.mpi-cbg.de> <19244.54684.250532.801766@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>,
	Shakthi Kannan <shakthimaan@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Dec 19 20:24:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NM4uf-0001Gb-Rr
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 20:24:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753168AbZLSTYV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2009 14:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752671AbZLSTYU
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Dec 2009 14:24:20 -0500
Received: from mail-yw0-f182.google.com ([209.85.211.182]:57098 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751319AbZLSTYU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2009 14:24:20 -0500
Received: by ywh12 with SMTP id 12so4491202ywh.21
        for <git@vger.kernel.org>; Sat, 19 Dec 2009 11:24:19 -0800 (PST)
Received: by 10.150.21.20 with SMTP id 20mr8632827ybu.117.1261250658934;
        Sat, 19 Dec 2009 11:24:18 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 21sm3191288iwn.10.2009.12.19.11.24.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 19 Dec 2009 11:24:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <19244.54684.250532.801766@lisa.zopyra.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135498>

Bill Lear <rael@zopyra.com> wrote:
> On Saturday, December 19, 2009 at 12:02:02 (+0100) Johannes Schindelin writes:
> >On Sat, 19 Dec 2009, Shakthi Kannan wrote:
> >...
> >> I am able to query for list of remote heads, and tags. I would like to
> >> know if it is possible to query for information on remote files, or
> >> blobs?
> >
> >This has been discussed a number of times, but we cannot allow that for 
> >security reasons.  A blob might contain confidential information, in which 
> >case the branch has to be rewritten and force-pushed.  However, that does 
> >not make the blob go away, but makes it only unreachable.  Until the next 
> >garbage collection kicks in, that is (which you typically cannot control).
> 
> Hmm, I thought this had been addressed by git in a different way (removing
> confidential information).  A company will not be satisfied that its
> proprietary information is "unreachable" in your software repository.
> They want absolute assurance that the information is completely
> removed.
> 
> Have I remembered wrongly --- is this still not possible with git?

Its still possible, but you have to wipe out the reflog record(s)
that had the object in it, and you have to repack to evict it from
the pack files, and you have to run `git prune --expire=0` to force
it to wipe out the object immediately.

We already support dumping back random commits via upload-archive, if
its enabled in the daemon, and I think a lot of people do turn it on.
There is no validation that the requested tree-ish is reachable.

I think gitweb winds up doing the same thing, it doesn't actually
try to validate the object is reachable, it just serves whatever
it was asked for, if its present in the repository.


I'm getting some mild suggestions over here at $DAY_JOB to implement
shallow clones by lazily downloading large blobs on demand.
We've resisted doing this in git because of the reachability test
Dscho mentioned above... but many people skip that anyway due
to gitweb and upload-archive being enabled.  Which is making me
start to question who is broken... upload-pack for not being more
willing to serve arbitrary content, or gitweb/upload-archive for
not validating their requests are reachable.

-- 
Shawn.

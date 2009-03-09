From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: JGit server performance
Date: Mon, 9 Mar 2009 08:27:50 -0700
Message-ID: <20090309152750.GD11989@spearce.org>
References: <20090308032214.GU16213@spearce.org> <d411cc4a0903090801w7748d26pb821a7bfb3db660@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 16:29:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LghPu-0006xi-1o
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 16:29:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbZCIP1x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 11:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbZCIP1x
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 11:27:53 -0400
Received: from george.spearce.org ([209.20.77.23]:55456 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031AbZCIP1w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 11:27:52 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 039BE38211; Mon,  9 Mar 2009 15:27:50 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <d411cc4a0903090801w7748d26pb821a7bfb3db660@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112703>

[+git]

Scott Chacon <schacon@gmail.com> wrote:
> On Sat, Mar 7, 2009 at 8:22 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> > As Gerrit Code Review provides Gitosis-like functionality, but
> > that is implemented through JGit's pure Java implementation, the
> > performance of JGit's UploadPack matters to me.
> >
> > JGit is about 66% slower on my hardware when cloning the linux-2.6
> > repository, compared to git-core (jgit 2m21s, git-core 1m23s).
> 
> What about packfile caching?  I thought I just saw someone propose
> this for a GSOC project - it obviously wouldn't help with making the
> first clone faster, but since it seems that you're talking about a
> server that is probably recomputing the same packfile bits over and
> over, perhaps caching the final output would be a simpler way to get
> more aggregate time savings.  I remember there were some issues with
> client capabilities and whatnot, but would that be a useful solution
> to speeding up overall throughput?

Indeed.

I think over the weekend I came to the conclusion that the only
way I can "fix" this is to implement some form of automatic caching
inside of JGit.

I came up with two ideas, but haven't tried either one yet:

Cache Object List:

  The idea here is that JGit spends the majority of its server side
  resources enumerating objects, doing the `git rev-list --objects
  $wants --not $haves` computation.  Once you reach a certain point
  on the DAG, that computation just isn't going to change much.

  So, for example, if we tag a dump of the object listing for all
  objects that are reachable from the most recently reachable
  annotated tag, and cache that dump, we can reload it when we
  encounter that tag again.  By restoring that dump, we can cut
  off a huge part of the object evaluation.

  Initial clones would always benefit from this dump, and we can
  expand it to cover more of the DAG as new tags are produced.

  The really recent commits still require enumeration, but this
  is a small percentage of the total objects being processed,
  and should go quite quickly.

  We still need to select and serve ranges of existing packs,
  based on the objects chosen for transmission.

Cache Packs:

  As you point out above, do the GSoC project idea (but in JGit)
  where we cache packs.

  My problem with this approach is it doesn't help initial clones
  very much once any one of the refs changes.  As soon as any
  ref is updated in any way, that cached pack is invalid and must
  be recomputed from scratch.

  However, it probably would generalize nicely into supporting a
  decent cache for incremental updates of clients.  In many cases
  in a Linus/Junio single-push-a-day world, all clients would be
  roughly asking for the same pack, and we'd get a decent return on
  our investment by saving the thin pack to disk in some cache area.

  But in a Gerrit Code Review world, its expected that the
  branches will update hundreds of times per day, and clients
  will be fetching off those multiple times throughout the day.
  So the life span of any given cached pack is probably quite small.

  However, I have no real proof to back this theory up with yet,
  its just back of the envelope guessing on my part.

Hybrid:

  I also considered some sort of hybrid approach.

  E.g. create a cache pack for everything reachable from a stable
  tag point (the object set in that pack is the same as the cached
  object list).  When sending data to a client, we send the current
  objects that aren't in the big cache pack, and then we tack the
  pack onto the end of the data stream.  So we only need to "read,
  SHA-1, send" through the entire length of the file (minus the 12
  byte header, 20 byte footer).
  
  Really quite efficient.

  My problem with this approach is you cannot duplicate an object
  in a pack stream.  So I have to be very careful when using this
  pack to complete a larger pack stream, as I need to avoid writing
  any object in the front if it will appear in the pack I am tacking
  onto the end.

  That is more common that you might expect, e.g.  consider a
  "Documentation/SubmittingPatches" file that hasn't been touched in
  ages...  it would appear in the recent commit object enumeration,
  but it also will appear in the big cache pack I want to tack on
  the end, as it hasn't changed since the pack was created.


Right now I am leaning towards caching the object enumeration
(the first approach mentioned).

-- 
Shawn.

From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Repacking many disconnected blobs
Date: Wed, 14 Jun 2006 08:53:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606140826200.5498@g5.osdl.org>
References: <1150269478.20536.150.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 14 17:53:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqXgZ-00063x-CM
	for gcvg-git@gmane.org; Wed, 14 Jun 2006 17:53:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965017AbWFNPxe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Jun 2006 11:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965018AbWFNPxe
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jun 2006 11:53:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5869 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965017AbWFNPxd (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jun 2006 11:53:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5EFrPgt026841
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 14 Jun 2006 08:53:25 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5EFrMLb008649;
	Wed, 14 Jun 2006 08:53:24 -0700
To: Keith Packard <keithp@keithp.com>
In-Reply-To: <1150269478.20536.150.camel@neko.keithp.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21848>



On Wed, 14 Jun 2006, Keith Packard wrote:
>
> parsecvs scans every ,v file and creates a blob for every revision of
> every file right up front. Once these are created, it discards the
> actual file contents and deals solely with the hash values.
> 
> The problem is that while this is going on, the repository consists
> solely of disconnected objects, and I can't make git-repack put those
> into pack objects.

Ok. That's actually _easily_ rectifiable, because it turns out that your 
behaviour is something that re-packing is actually really good at 
handling.

The thing is, "git repack" (the wrapper function) is all about finding all 
the heads of a repository, and then tellign the _real_ packing logic which 
objects to pack.

In other words, it literally boils down to basically

	git-rev-list --all --objects $rev_list |
		git-pack-objects --non-empty $pack_objects .tmp-pack

where "$rev_list" and "$pack_objects" are just extra flags to the two 
phases that you don't really care about.

But the important point to recognize is that the pack generation itself 
doesn't care about reachability or anything else AT ALL. The pack is just 
a jumble of objects, nothing more. Which is exactly what you want.

> I'm assuming that if I could get these disconnected blobs all neatly
> tucked into a pack object, things might go a bit faster.

Absolutely. And it's even easy.

What you should do is to just generate a list of objects every once in a 
while, and pass that list off to "git-pack-objects", which will create a 
pack-file for you. Then you just move the generated pack-file (and index 
file) into the .git/objects/pack directory, and then you can run the 
normal "git-prune-packed", and you're done.

There's just two small subtle points to look out for:

 - You can list the objects with "most important first" order first, if 
   you can.  That will improve locality later (the packing will try to 
   generate the pack so that the order you gave the objects in will be a 
   rough order of the resul - the first objects will be together at the 
   beginning, the last objects will be at the end)

   This is not a huge deal. If you don't have a good order, give them in 
   any order, and then after you're done (and you do have branches and 
   tag-heads), the final repack (with a regular "git repack") will fix it 
   all up.

   You'll still get all of the size/access advantage of packfiles without 
   this, it just won't have the additional "nice IO patterns within the 
   packfile" behaviour (which mainly matters for the cold-cache case, so 
   you may well not care).

 - append the filename the object is associated with to the object name on 
   the list, if at all possible. This is what git-pack-objects will use as 
   part of the heuristic for finding the deltas, so this is actually a big 
   deal. If you forget (or mess up) the filename, packing will still 
   _work_ - it's just a heuristic, after all, and there are a few others 
   too - but the pack-file will have inferior delta chains.

   (The name doesn't have to be the "real name", it really only needs to 
   be something unique per *,v file, but real name is probably best)

   The corollary to this is that it's better to generate the pack-file 
   from a list of every version of a few files than it is to generate it 
   from a few versions of every file. Ie, if you process things one file 
   at a time, and create every object for that file, that is actually good 
   for packing, since there will be the optimal delta opportunity.

In other words, you should just feed git-pack-file a list of objects in 
the form "<sha1><space><filename>\n", and git-pack-file will do the rest.

Just as a stupid example, if you were to want to pack just the _tree_ that 
is the current version of a git archive, you'd do

	git-rev-list --objects HEAD^{tree} |
		git-pack-objects --non-empty .tmp-pack

which you can try on the current git tree just to see (the first line will 
generate a list of all objects reachable from the current _tree_: no 
history at all, the second line will create two files under the name of  
".tmp-pack-<sha1-of-object-list>.{pack|idx}".

The reason I suggest doing this for the current tree of the git archive is 
simply that you can look at the git-rev-list output with "less", and see 
for yourself what it actually does (and there are just a few hundred 
objects there: a few tree objects, and the blob objects for every file in 
the current HEAD).

So the git pack-format is actually _optimal_ for your particular case, 
exactly because the pack-files don't actually care about any high-level 
semantics: all they contain is a list of objects.

So in phase 1, when you generate all the objects, the simplest thing to do 
is to literally just remember the last five thousand objects or so as you 
generate them, and when that array of objects fills up, you just start the 
"git-pack-objects" thing, and feed it the list of objects, move the 
pack-file into .git/objects/pack/pack-... and do a "git prune-packed". 

Then you just continue.

So this should all fit the parsecvs approach very well indeed.

		Linus

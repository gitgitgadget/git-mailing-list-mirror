From: Andre Noll <maan@systemlinux.org>
Subject: Re: Odd behavior with git and cairo-devel repo
Date: Wed, 21 Jun 2006 19:46:32 +0200
Message-ID: <20060621174632.GP11245@skl-net.de>
References: <20060621010030.GP2820@artsapartment.org> <20060621024605.GO11245@skl-net.de> <20060621120618.GR2820@artsapartment.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Jun 21 19:47:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ft6nL-00088k-GH
	for gcvg-git@gmane.org; Wed, 21 Jun 2006 19:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbWFURrM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Jun 2006 13:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbWFURrM
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jun 2006 13:47:12 -0400
Received: from systemlinux.org ([83.151.29.59]:54661 "EHLO m18s25.vlinux.de")
	by vger.kernel.org with ESMTP id S932271AbWFURrM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jun 2006 13:47:12 -0400
Received: from maan by m18s25.vlinux.de with local (Exim 3.36 #1 (Debian))
	id 1Ft6me-0005dS-00; Wed, 21 Jun 2006 19:46:32 +0200
To: Art Haas <ahaas@airmail.net>
Content-Disposition: inline
In-Reply-To: <20060621120618.GR2820@artsapartment.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22283>

On 07:06, Art Haas wrote:
> I see this patch has made it into git now, and it fixes the problem
> described above. Thanks!
> 
> However, I'm still seeing the problem where 'git prune' leaves the
> repo in an invalid state. In the case above, running 'git prune' on a
> freshly checked-out repo works without problems; when the repo has a
> number of unpacked objects, however, things go bad. On the FC4 machine
> I have, I updated my git repo, rebuilt, and installed the build with
> the patch above, then updated my cairo repo. The 'git pull' retrieved
> a handful of objects, and 'git fsck-objects' ran without problem.
> Then 'git prune' was run, seemingly without problem, and when I tried
> 'git repack -a -d' things went boom. A subsequent 'git fsck-object'
> run indicated the repo was missing tree and commit objects.
> 
> Is anyone else seeing a similar problem with 'git prune'?

Yeah. This is due to a thinko in grow_refs_hash() which was introduced in

	commit 3e4339e6f96e8c4f38a9c6607b98d3e96a2ed783
	Author: Linus Torvalds <torvalds@osdl.org>
	Date:   Sun Jun 18 11:45:02 2006 -0700

	    Remove "refs" field from "struct object"

Fix below.
---
Fix grow_refs_hash()

As the hash values depend on the hash size, they have to be
recalulated when growing the hash. It's possible (though unlikely)
that there are duplicates even with the new, larger hash size, so
make grow_refs_hash() check for duplicates.

Signed-off-by: Andre Noll <maan@systemlinux.org>
---
diff --git a/object-refs.c b/object-refs.c
index 8afa227..fa1d3c1 100644
--- a/object-refs.c
+++ b/object-refs.c
@@ -25,6 +25,8 @@ static void grow_refs_hash(void)
 		if (!ref)
 			continue;
 		j = hash_obj(ref->base, new_hash_size);
+		while (new_hash[j])
+			j = (j + 1) % new_hash_size;
 		new_hash[j] = ref;
 	}
 	free(refs_hash);
-- 
The only person who always got his work done by Friday was Robinson Crusoe

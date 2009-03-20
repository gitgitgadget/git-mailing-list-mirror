From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 0/5] repack improvements
Date: Thu, 19 Mar 2009 22:47:49 -0500
Message-ID: <t_s5aa51o2kq_ePRWgLTEkVg4HqH1dQa6_mVq4djPPG4Vxylm2hNqmx7fPC2W5AsfcXg83DYbGc@cipher.nrlssc.navy.mil>
References: <EblkEXbcYUWby1OEDup9n0l6lbwNL-4-jyt02Cjab2pqLqekAUji0w@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, drafnel@gmail.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 20 04:50:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkVk7-000158-PI
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 04:50:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753075AbZCTDsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 23:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752320AbZCTDsP
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 23:48:15 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:60265 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752065AbZCTDsM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 23:48:12 -0400
Received: by mail.nrlssc.navy.mil id n2K3m6KP019885; Thu, 19 Mar 2009 22:48:07 -0500
In-Reply-To: <EblkEXbcYUWby1OEDup9n0l6lbwNL-4-jyt02Cjab2pqLqekAUji0w@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 20 Mar 2009 03:48:06.0387 (UTC) FILETIME=[AD98AC30:01C9A90E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113889>


As I mentioned in a previous email, the recent changes to
pack-objects/rev-list partially fixed one repacking flaw, but introduced 2
others.  There were actually two emails, but the first one never made it
to the list.

There existed a flaw that prevented repack from properly repacking objects
contained in packs from alternate repositories if the local repository
contained any non-kept packs.  This was fixed by the --kept-pack-only feature,
in exchange for not being able to pack objects contained in alternate packs
which had a keep file.  Since the user may not have control over the referenced
object database, I think it is fair not to the honor the keep files in that
case.

Additionally, if repack told pack-objects to loosen unreferenced objects,
it would even loosen objects residing in alternate packs.  They would then be
immediately deleted by the call to prune-packed though.

The solution I chose is actually to fall back to the --honor-pack-keep option
and to stop using the --kept-pack-only option.  pack-objects already iterates
over every object added for packing and searches the pack array to check
whether it is already packed, so for the case where no keep files are used,
there is actually one less iteration through the pack array for each commit.
But one more (?) for each object referenced by a commit that is packed in a
pack with a .keep file.

So this keeps the local and keep_pack decision making in pack-objects.  The
other way would be to move the --local option over into rev-list and teach
the pack lookup machinery to differentiate between local and non-local packs.
Not sure which is better, but this was easier.

I think there is still one case where an object will be loosened unnecessarily.
If an unreferenced object exists in a local pack _and_ in an alternate object
database, then I believe it will be loosened and then pruned.  To fix it,
loosen_unused_packed_objects and add_objects_in_unpacked_packs would have to
iterate through the non-local packs to check whether they contained the object 
before loosening/repacking it. Probably won't happen often in practice though.

Also, I think the --kept-pack-only option is now not necessary.  The last
patch removes the --kept-pack-only feature /ducks and can be dropped if you
think this feature may be useful in the future.


Brandon Casey (5):
  t7700-repack: add two new tests demonstrating repacking flaws
  git-repack.sh: don't use --kept-pack-only option to pack-objects
  pack-objects: only repack or loosen objects residing in "local" packs
  t7700-repack: repack -a now works properly, expect success from test
  Remove --kept-pack-only option and associated infrastructure

 builtin-pack-objects.c |    5 ++---
 cache.h                |    1 -
 git-repack.sh          |    6 +-----
 revision.c             |    9 +--------
 revision.h             |    1 -
 sha1_file.c            |   21 +--------------------
 t/t7700-repack.sh      |   46 +++++++++++++++++++++++++++++++++++++++++++++-
 7 files changed, 50 insertions(+), 39 deletions(-)

From: Martin Fick <mfick@codeaurora.org>
Subject: Fixing the git-repack replacement gap?
Date: Tue, 18 Jun 2013 10:52:50 -0600
Organization: CAF
Message-ID: <201306181052.50490.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Shawn Pearce <sop@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 18:52:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uoz9M-0006lL-89
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 18:52:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933159Ab3FRQwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 12:52:54 -0400
Received: from smtp.codeaurora.org ([198.145.11.231]:38346 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932112Ab3FRQww (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 12:52:52 -0400
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2D1F813EF02;
	Tue, 18 Jun 2013 16:52:52 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
	id 213BC13EFFC; Tue, 18 Jun 2013 16:52:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	pdx-caf-smtp.dmz.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.1
Received: from mfick-lnx.localnet (mfick-lnx.qualcomm.com [129.46.10.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: mfick@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id C1A9813EF02;
	Tue, 18 Jun 2013 16:52:51 +0000 (UTC)
User-Agent: KMail/1.13.5 (Linux/2.6.32.49+drm33.21-mfick7; KDE/4.4.5; x86_64; ; )
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228272>

I have been trying to think of ways to fix git-repack so 
that it no longer momentarily makes the objects in a repo 
inaccessible to all processes when it replaces packfiles 
with the same objects in them as an already existing pack 
file.  To be more explicit, I am talking about the way it 
moves the existing pack file (and index) to old-<sha1>.pack 
before moving the new packfile in place.  During this moment 
in time the objects in that packfile are simply not 
available to anyone using the repo.  This can be 
particularly problematic for busy servers.

There likely are at lest 2 ways that the fundamental design 
of packfiles, their indexes, and their names have led to 
this issue.  If the packfile and index were stored in a 
single file, they could have been replaced atomically and 
thus it would potentially avoid the issue of them being 
temporarily inaccessible (although admittedly that might not 
work anyway on some filesystems).  Alternatively, if the 
pack file were named after the sha1 of the packed contents 
of the file instead of the sha1 of the objects in the sha1, 
then the replacement would never need to happen since it 
makes no sense to replace a file with another file with the 
exact same contents (unless, of course the first one is 
corrupt, but then you aren't likely making the repo 
temporarily worse, you are fixing a broken repo).

I suspect these 2 ideas have been discussed before, but 
since they are fundamental changes to the way pack files 
work (and thus would not be backwards compatible), they are 
not likely to get implemented soon.  This got me wondering 
if there wasn't an easier backwards compatible solution to 
avoid making the objects inaccessible?

It seems like the problem could be avoided if we could 
simply change the name of the pack file when a replacement 
would be needed?  Of course, if we just changed the name, 
then the name would not match the sha1 of the contained 
objects and would likely be considered bad by git?  So, what 
if we could simply add a dummy object to the file to cause 
it to deserve a name change?

So the idea would be, have git-repack detect the conflict in 
filenames and have it repack the new file with an additional 
dummy (unused) object in it, and then deliver the new file 
which no longer conflicts.  Would this be possible?  If so, 
what sort of other problems would this cause?  It would 
likely cause an unreferenced object and likely cause it to 
want to get pruned by the next git-repack?  Is that OK, 
maybe you want it to get pruned because then the pack file 
will get repacked once again without the dummy object later 
and avoid the temporarily inaccessible period for objects in 
the file?  

Hmm, but then maybe that could even be done in a single git-
repack run (at the expense of extra disk space)?  

1) Detect the conflict, 
2) Save the replacement file 
3) Create a new packfile with the dummy object
4) Put the new file with the dummy object into service
5) Remove the old conflicting file (no gap)
6) Place the new conflicting file in service (no dummy)
7) Remove the new file with dummy object (no gap again)

done?  Would it work?

If so, is there an easy way to create the dummy file?  Can 
any object simply be added at the end of a pack file after 
the fact (and then added to the index too)?  Also, what 
should the dummy object be?  Is there some sort of null 
object that would be tiny and that would never already be in 
the pack?

Thanks for any thoughts,

-Martin

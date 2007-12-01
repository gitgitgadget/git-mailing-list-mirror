From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git pack-objects input list
Date: Sat, 1 Dec 2007 09:49:00 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712010933370.8458@woody.linux-foundation.org>
References: <20071201104502.GA1457@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sat Dec 01 18:49:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyWTK-0005rs-0K
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 18:49:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752440AbXLARtZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2007 12:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752437AbXLARtZ
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Dec 2007 12:49:25 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:40871 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751903AbXLARtZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Dec 2007 12:49:25 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lB1Hn80P024302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 1 Dec 2007 09:49:09 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lB1Hn0dr000805;
	Sat, 1 Dec 2007 09:49:05 -0800
In-Reply-To: <20071201104502.GA1457@glandium.org>
X-Spam-Status: No, hits=-2.428 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_31
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66728>



On Sat, 1 Dec 2007, Mike Hommey wrote:
> 
> While playing around with git-pack-objects, it seemed to me that the
> input it can take is not a simple list of object SHA1s.

Well, it *can* take a simple list of object SHA1's. But yes, the preferred 
format is a list of "SHA1 <basename>", where the basename is used as part 
of the heuristics on what other objects to try doing a delta against.

But if you give no basename, that heuristic just won't have the name hint, 
and things will still *work*, it's just more likely (but not certain) that 
the resulting packfile will be larger.

> Could someone knowing the delta calculation internals enlighten me ?

The delta calculations simply create a small hash based on the basename, 
and use that to clump blobs/trees with the same basename together. That's 
*usually* a huge win in terms of finding good deltas, since the most 
likely delta is for a previous version of the same file (or tree!) and 
since we don't try to find deltas against *all* other blobs, but just use 
a sliding window, having good delta candidates close to each other is 
going to help a lot.

Without the basename information, the delta list will just be sorted by 
type and size, which works fine, but generally finds fewer deltas.

But it's all a heuristic, and if can go both ways. If you have lots of 
renames (which aren't just cross-directory ones, but actually change the 
basename), then the basename information may actually hurt.

(Btw: the hash we generate is on purpose not a very good one. It actually 
thinks that the last characters are "more important", so it tends to hash 
files that end in the same few characters together. So *.c files clump 
together etc. At least that's the intent).

See builtin-pack-objects.c:
 - type_size_sort(): this is the rule for sortign objects for deltaing. 

   Type is most important (ie we always sort commits, trees, blobs 
   separately and clump them together and effectively delta them only 
   against objects of the same type)

   Then comes the basename hash (so that we sort objects with the same 
   name together, and *.c files closer to each other than to *.h files, 
   for example).

   Then comes the preferred_base (so that we sort things that already have 
   specific delta bases together), and then the size (so that we sort
   files that are similar in size).

   And finally, if everything else is equal (the size will generally be 
   identical for tree objects of the same directory with no new files but 
   just SHA1 changes, for example) we sort by the order they were found in 
   the history ("recency") by just comparing the pointer itself, since 
   the original thing will be just one big array filled in by order of 
   objects.

 - find_deltas() - this is the actual thing that does the "look through 
   the object window and try to find good deltas", which operates on the 
   array that was created by the type_size_sort.

Hope that clarified something.

		Linus

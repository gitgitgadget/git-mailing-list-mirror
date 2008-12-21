From: John Chapman <thestar@fussycoder.id.au>
Subject: Re: Memory issue with fast-import, why track branches?
Date: Sun, 21 Dec 2008 19:10:42 +1100
Message-ID: <1229847042.798.5.camel@therock.nsw.bigpond.net.au>
References: <94a0d4530812202154l26dfe0dfm49397c63dbfdfdf9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 21 09:02:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEJGB-000454-6r
	for gcvg-git-2@gmane.org; Sun, 21 Dec 2008 09:01:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbYLUH7X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2008 02:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbYLUH7X
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Dec 2008 02:59:23 -0500
Received: from nschwmtas04p.mx.bigpond.com ([61.9.189.146]:64354 "EHLO
	nschwmtas04p.mx.bigpond.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751195AbYLUH7W (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Dec 2008 02:59:22 -0500
Received: from nschwotgx01p.mx.bigpond.com ([58.173.132.215])
          by nschwmtas04p.mx.bigpond.com with ESMTP
          id <20081221075920.MJSL12089.nschwmtas04p.mx.bigpond.com@nschwotgx01p.mx.bigpond.com>;
          Sun, 21 Dec 2008 07:59:20 +0000
Received: from therock.local ([58.173.132.215])
          by nschwotgx01p.mx.bigpond.com with ESMTP
          id <20081221075919.ERCN18392.nschwotgx01p.mx.bigpond.com@therock.local>;
          Sun, 21 Dec 2008 07:59:19 +0000
In-Reply-To: <94a0d4530812202154l26dfe0dfm49397c63dbfdfdf9@mail.gmail.com>
X-Mailer: Evolution 2.6.3 
X-RPD-ScanID: Class unknown; VirusThreatLevel unknown, RefID str=0001.0A150203.494DF757.0060,ss=1,fgs=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103690>

My first response was along the lines of "Why the heck are you storing
sha1's like that!?", until I realised that you're not storing actual git
sha1's, but mtn's hashes, which does make sense.

I'm doing something very similar with my perforce scripts, however I am
doing a bit more magic instead of making so many branches.

Instead of making branches, I make a tag instead, for each and every
changeset.  Every time I make a new git commit, if I need to do it from
a tag, I first read the tag and determine the sha1 I should use, and use
that instead.

Alternatively, you could choose to manage your mapping yourself, and
write them to a .git/mtg-git-map file.

On Sun, 2008-12-21 at 07:54 +0200, Felipe Contreras wrote:
> Hi,
> 
> I tracked down an issue I have when importing a big repository. For
> some reason memory usage keeps increasing until there is no more
> memory.
> 
> Here is what valgrind shows:
> ==21034== 471,080,280 bytes in 114,517 blocks are still reachable in
> loss record 8 of 8
> ==21034==    at 0x4004BA2: calloc (vg_replace_malloc.c:397)
> ==21034==    by 0x806A340: xcalloc (wrapper.c:75)
> ==21034==    by 0x8063BC1: use_pack (sha1_file.c:808)
> ==21034==    by 0x8063DA9: unpack_object_header (sha1_file.c:1443)
> ==21034==    by 0x8064F4F: unpack_entry (sha1_file.c:1736)
> ==21034==    by 0x8065393: cache_or_unpack_entry (sha1_file.c:1606)
> ==21034==    by 0x8065464: read_packed_sha1 (sha1_file.c:2000)
> ==21034==    by 0x80655E5: read_object (sha1_file.c:2090)
> ==21034==    by 0x8065677: read_sha1_file (sha1_file.c:2106)
> ==21034==    by 0x8056AE9: parse_object (object.c:190)
> ==21034==    by 0x805E90A: write_ref_sha1 (refs.c:1214)
> ==21034==    by 0x804CC4F: update_branch (fast-import.c:1558)
> 
> After looking at the code my guess is that I have a humongous amount
> of branches.
> 
> Actually they are not really branches, but refs. For each git commit
> there's an original mtn ref that I store in 'refs/mtn/sha1', but since
> I'm using 'commit refs/mtn/sha1' to store it, a branch is created for
> every commit.
> 
> I guess there are many ways to fix the issue, but for starters I
> wonder why is fast-import keeping track of all the branches? In my
> case I would like fast-import to work exactly the same if I specify
> branches or not (I'll update them later).
> 
> Cheers.
> 

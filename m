From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-svnimport failed and now git-repack hates me
Date: Wed, 03 Jan 2007 22:25:30 -0800
Message-ID: <7v1wmbnw9x.fsf@assigned-by-dhcp.cox.net>
References: <204011cb0701031552j8292d23v950f828279702d3@mail.gmail.com>
	<Pine.LNX.4.64.0701031737300.4989@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Lee <chris133@gmail.com>, Shawn Pearce <spearce@spearce.org>,
	Sasha Khapyorsky <sashak@voltaire.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 04 07:25:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2M2i-0000PQ-6p
	for gcvg-git@gmane.org; Thu, 04 Jan 2007 07:25:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbXADGZd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Jan 2007 01:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbXADGZd
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 01:25:33 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:34615 "EHLO
	fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932285AbXADGZc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jan 2007 01:25:32 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070104062531.JODK16632.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>;
          Thu, 4 Jan 2007 01:25:31 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 6uRl1W00g1kojtg0000000; Thu, 04 Jan 2007 01:25:46 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701031737300.4989@woody.osdl.org> (Linus
	Torvalds's message of "Wed, 3 Jan 2007 17:59:28 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35917>

Linus Torvalds <torvalds@osdl.org> writes:

> On Wed, 3 Jan 2007, Chris Lee wrote:
>>
>> So I'm using git 1.4.1, and I have been experimenting with importing
>> the KDE sources from Subversion using git-svnimport.
>
> As one single _huge_ import? All the sub-projects together? I have to say, 
> that sounds pretty horrid.

Thanks -- you said everything I should have said on this issue
while I was in bed ;-).

> Junio - I suspect "pack-check.c" really shouldn't try to do it as one 
> single humungous "SHA1_Update()" call. It showed one bug on PPC, I 
> wouldn't be surprised if it's implicated now on some other architecture. 

If Chris still has that huge .pack & .idx pair, it would be a
very good guinea pig to try a few things on, assuming that this
problem is that the pack-check.c feeds a huge blob to SHA-1
function with a single call.

 (1) Apply the attached patch on top of "master" (the patch
     should apply to 1.4.1 almost cleanly as well, except that
     we have hashcmp(a,b) instead of memcmp(a,b,20) since then),
     and see what it says about the packfile.  If your suspicion
     is correct, it should complain about your SHA-1
     implementation.

 (2) Try tip of "next" to see if its verify-pack passes the
     check.  Again, if your suspicion is correct, it should, since it
     uses Shawn's sliding mmap() stuff that will not feed the
     whole pack in one go.

 (3) I suspect that the tip of "master" should work except
     verify-pack.  It may be interesting to see how well the tip
     of "master" and "next" performs on the resulting huge pack
     (say, "time git log -p HEAD >/dev/null").  I am hoping this
     would be another datapoint to judge the runtime penalty of
     Shawn's sliding mmap() in "next" -- I suspect the penalty
     is either negligible or even negative.

diff --git a/pack-check.c b/pack-check.c
index c0caaee..738a0c5 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -29,6 +29,28 @@ static int verify_packfile(struct packed_git *p)
 	pack_base = p->pack_base;
 	SHA1_Update(&ctx, pack_base, pack_size - 20);
 	SHA1_Final(sha1, &ctx);
+
+	if (1) {
+		SHA_CTX another;
+		unsigned char *data = p->pack_base;
+		unsigned long size = pack_size - 20;
+		const unsigned long batchsize = (1u << 20);
+		unsigned char another_sha1[20];
+
+		SHA1_Init(&another);
+		while (size) {
+			unsigned long batch = size;
+			if (batchsize < batch)
+				batch = batchsize;
+			SHA1_Update(&another, data, batch);
+			size -= batch;
+			data += batch;
+		}
+		SHA1_Final(another_sha1, &another);
+		if (hashcmp(sha1, another_sha1))
+			die("Your SHA-1 implementation cannot hash %lu bytes correctly at once", pack_size - 20);
+	}
+
 	if (hashcmp(sha1, (unsigned char *)pack_base + pack_size - 20))
 		return error("Packfile %s SHA1 mismatch with itself",
 			     p->pack_name);

From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: pack operation is thrashing my server
Date: Fri, 15 Aug 2008 17:34:45 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808151729070.3324@nehalem.linux-foundation.org>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com> <20080811030444.GC27195@spearce.org> <a6b6acf60808110043t76dc0ae6l428c5da473d79c71@mail.gmail.com> <87vdy71i6w.fsf@basil.nowhere.org> <1EE44425-6910-4C37-9242-54D0078FC377@adacore.com>
 <alpine.LFD.1.10.0808131024460.4352@xanadu.home> <20080813145944.GB3782@spearce.org> <alpine.LFD.1.10.0808131123221.4352@xanadu.home> <20080813155016.GD3782@spearce.org> <alpine.LFD.1.10.0808131228270.4352@xanadu.home> <alpine.LFD.1.10.0808141014410.3324@nehalem.linux-foundation.org>
 <alpine.LFD.1.10.0808141022500.3324@nehalem.linux-foundation.org> <alpine.LFD.1.10.0808141442150.4352@xanadu.home> <alpine.LFD.1.10.0808141215520.3324@nehalem.linux-foundation.org> <alpine.LFD.1.10.0808141633080.4352@xanadu.home>
 <alpine.LFD.1.10.0808141544150.3324@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Geert Bosch <bosch@adacore.com>,
	Andi Kleen <andi@firstfloor.org>, Ken Pratt <ken@kenpratt.net>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Aug 16 02:36:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KU9mQ-0007IB-Ft
	for gcvg-git-2@gmane.org; Sat, 16 Aug 2008 02:36:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472AbYHPAf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 20:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752393AbYHPAf0
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 20:35:26 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35577 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751938AbYHPAf0 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Aug 2008 20:35:26 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7G0YmUd003733
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 15 Aug 2008 17:34:49 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7G0YjFD027528;
	Fri, 15 Aug 2008 17:34:46 -0700
In-Reply-To: <alpine.LFD.1.10.0808141544150.3324@nehalem.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.417 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92522>



On Thu, 14 Aug 2008, Linus Torvalds wrote:
> 
> So yeah, trees are the problem here, and yes, avoiding inflating them 
> would help - but mainly because we do it something like four times per 
> object on average!

Interestingly, it turns out that git also hits a sad performance downside 
of using zlib.

We always tend to set "stream.avail_out" to the exact size of the expected 
output. And it turns out that that means that the fast-path case of 
inffast.c doesn't trigger as often as it could. This (idiotic) patch 
actually seems to help performance on git rev-list by about 5%.

But maybe it's just me seeing things. But I did this because of the entry 
assumptions in inflate_fast(), that code only triggers for the case of 
strm->avail_out >= 258.

Sad, if true.

		Linus

---
 sha1_file.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index a57155d..5ca7ce2 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1500,11 +1500,11 @@ static void *unpack_compressed_entry(struct packed_git *p,
 	z_stream stream;
 	unsigned char *buffer, *in;
 
-	buffer = xmalloc(size + 1);
+	buffer = xmalloc(size + 256 + 1);
 	buffer[size] = 0;
 	memset(&stream, 0, sizeof(stream));
 	stream.next_out = buffer;
-	stream.avail_out = size;
+	stream.avail_out = size + 256;
 
 	inflateInit(&stream);
 	do {

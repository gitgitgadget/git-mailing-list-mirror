From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 03/15] Add IntList as a more efficient
	representation of List<Integer>
Date: Fri, 12 Dec 2008 07:41:15 -0800
Message-ID: <20081212154115.GO32487@spearce.org>
References: <1229049981-14152-1-git-send-email-spearce@spearce.org> <1229049981-14152-2-git-send-email-spearce@spearce.org> <1229049981-14152-3-git-send-email-spearce@spearce.org> <1229049981-14152-4-git-send-email-spearce@spearce.org> <bd6139dc0812120243y2b1a3dddu4975162114280e17@mail.gmail.com> <20081212151533.GM32487@spearce.org> <bd6139dc0812120733o7c828532qbcd78c46a321fe6b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 16:42:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBA9y-0007mT-7g
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 16:42:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757260AbYLLPlR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 10:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757005AbYLLPlQ
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 10:41:16 -0500
Received: from george.spearce.org ([209.20.77.23]:49008 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756717AbYLLPlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 10:41:16 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 8C0CA38200; Fri, 12 Dec 2008 15:41:15 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <bd6139dc0812120733o7c828532qbcd78c46a321fe6b@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102905>

Sverre Rabbelier <srabbelier@gmail.com> wrote:
> On Fri, Dec 12, 2008 at 16:15, Shawn O. Pearce <spearce@spearce.org> wrote:
> > Hmm, yea, good point.  But I don't care too much about the toString()
> > in this case, its meant as a debugging aid and not something one
> > would rely upon.  Hence I didn't think it was worth testing for the
> > empty list, writing the first entry, then doing a loop for [1,count).
> 
> Fair enough :).

If you'd like to send a patch to change it, I'll apply it.  But I
don't think its worth my time to make this toString() more efficient.

Other areas of JGit I do try to micro-optimize, because they are
right smack in the middle of the critical paths.

E.g. look at ObjectId.equals(byte[],int,byte[],int). I hand-unrolled
the memcmp loop because the JIT on x86 does *soooo* much better
when the code is spelled out:

	public static boolean equals(final byte[] firstBuffer, final int fi,
			final byte[] secondBuffer, final int si) {
		return firstBuffer[fi] == secondBuffer[si]
				&& firstBuffer[fi + 1] == secondBuffer[si + 1]
				&& firstBuffer[fi + 2] == secondBuffer[si + 2]
				&& firstBuffer[fi + 3] == secondBuffer[si + 3]
				&& firstBuffer[fi + 4] == secondBuffer[si + 4]
				&& firstBuffer[fi + 5] == secondBuffer[si + 5]
				&& firstBuffer[fi + 6] == secondBuffer[si + 6]
				&& firstBuffer[fi + 7] == secondBuffer[si + 7]
				&& firstBuffer[fi + 8] == secondBuffer[si + 8]
				&& firstBuffer[fi + 9] == secondBuffer[si + 9]
				&& firstBuffer[fi + 10] == secondBuffer[si + 10]
				&& firstBuffer[fi + 11] == secondBuffer[si + 11]
				&& firstBuffer[fi + 12] == secondBuffer[si + 12]
				&& firstBuffer[fi + 13] == secondBuffer[si + 13]
				&& firstBuffer[fi + 14] == secondBuffer[si + 14]
				&& firstBuffer[fi + 15] == secondBuffer[si + 15]
				&& firstBuffer[fi + 16] == secondBuffer[si + 16]
				&& firstBuffer[fi + 17] == secondBuffer[si + 17]
				&& firstBuffer[fi + 18] == secondBuffer[si + 18]
				&& firstBuffer[fi + 19] == secondBuffer[si + 19];
	}

This block is in the critical path for any tree diff code, in
particular for a "git log -- a/" sort of operation.  Its used
to compare the SHA-1s from two different tree records to see if
they differ.  Not unrolling this was a huge penalty.

-- 
Shawn.

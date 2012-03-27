From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [GSoC] Designing a faster index format
Date: Tue, 27 Mar 2012 13:47:23 +0200
Message-ID: <87r4we9sfo.fsf@thomas.inf.ethz.ch>
References: <F9D452C3-B11E-4915-A0F2-B248F92CE5DE@gmail.com>
	<CACsJy8CKqv2P2Co9MKpePfOTwe4fu-wxAYiigbYt3YHTxZ6wWQ@mail.gmail.com>
	<8D287169-1AD9-4586-BDBC-F820220328FC@gmail.com>
	<CACsJy8D2RwG-Nr5btcQj0f9=JACvH6mf7LNi=Jnb_y+j4_2u0A@mail.gmail.com>
	<871uomrubl.fsf@thomas.inf.ethz.ch>
	<8901F6B5-7396-44E1-9687-20BF95114728@gmail.com>
	<871uomq64c.fsf@thomas.inf.ethz.ch>
	<BDFA27C9-C999-4C95-8804-5E7B3B3D1BFD@gmail.com>
	<878virfx11.fsf@thomas.inf.ethz.ch>
	<2A61C352-5C71-4EDF-9DBE-01CC09AE03A5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 13:47:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCUsB-00050J-Bt
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 13:47:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752933Ab2C0Lr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 07:47:29 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:5945 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752559Ab2C0Lr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 07:47:29 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.283.3; Tue, 27 Mar
 2012 13:47:23 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 27 Mar
 2012 13:47:23 +0200
In-Reply-To: <2A61C352-5C71-4EDF-9DBE-01CC09AE03A5@gmail.com> (Thomas
	Gummerer's message of "Mon, 26 Mar 2012 22:35:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194039>

Hi Thomas

Thomas Gummerer <t.gummerer@gmail.com> writes:

> -- Proposed solution --
> The proposed solution is to rework the index, in order to make it possible to
> have a complexity of O(log(n)), where n is the number of index entries, for 
> simple operations like adding files. More complex operations shall also
> benefit from the new index format, although a complexity of O(log(n)) might not
> be reached, while keeping the index format easy enough to parse for .git reading
> programs. The amount of data for which that the hash will be computed however
> shall be log(n). N is the number of entries in the index.

Can you phrase this in terms of three variables: the number of entries
'n' in the index, the number of entries 'k' (or in the case of
extensions, the amount of data) that must be changed, and the size of
the index 's'?

Bear in mind that the current code uses a lock-write-rename scheme and
I'm not sure we can (or for that matter want to) change that.

That should clear up the picture somewhat and also answer Junio's concerns.

> In phase one the pysical index format shall be replaced with the new index 
> format, which does neither require a full recalculation of the sha-1 hash nor a
> full rewrite of the index to the disk. The new index format will be mapped to 
> the current in-memory structure, which will only be changed in phase two. For 
> further optimization the cache-tree sha-1 hashes shall be mapped to the new 
> index format, which should avoid cache-tree invalidations. In phase one the 
> savings will mainly be on disk I/O and commands that usually cause a lot of 
> cache-tree invalidations. To ensure backward compatibility, git shall keep the
> ability able to read version 2/3 of the index. The user shall also have the 
> possibility to configure git to write the index in either the new or the old 
> format. While this will produce some code overhead, it will make the life of git 
> users which don't use core git exclusively easier in the transition phase. 
> If the user sets the write format to the new format and the repository is a 
> already existing version 2/3 repository, the old index will be transformed to 
> the new format.

Can you split this somewhat?  My wall-of-text-detector is complaining.

- Backwards compatibility: good.  What happens after stage two, are we
  still going to support writing the old format?  If not, why?

- cache-tree: I'm not sure you can skip the invalidations, at least not
  without the tie-in.  We primarily want to be able to change the
  cache-tree data -- or for that matter any extension data -- cheaply
  without rewriting (or rehashing, see the s/n/k issue) the entire
  index.

- cache-tree tie-in: I realize I tossed this in the air without any
  hints on how you could achieve it, but since you also allocate quite
  some development time to it I think you should outline a plan on how
  to do this.

- I'm sure you can find another point :-)

> Another way to speed up the hashing would be to exchange the SHA-1 hash for
> something faster. That may however not be feasible while keeping the current
> in-memory structure.

Hum, if you look where and over what this hash is currently computed,
you'll see what the right answer to that last non-question is...

> 24/04 - 12/05: Getting familiar with the old index

What Junio said.  On top of that, I think this shouldn't take three
weeks even if you still spend some time within the project.

> 24/06 - 21/07: Write the index to disk in both the old and the new format
> depending on the choice of the user and make sure only the changed parts are 
> really written to disk in the new format.

What's interesting here is how you determine the changed part.  Are you
planning to change all users to properly mark changed entries, so that
everyone benefits (at a huge amount of code churn) or do you want to
take another approach?

> /* Development work will be a bit slower from 18/06 to 21/07 because at my
>  * University there are exams in this period. I probably will only be able to
>  * work half the hours. I'll be back up to full speed after that. */

Out of curiosity, what courses are you taking exams in?

> 22/06 - 04/08: Parse the index from the disk to the current in-memory format.
> 05/08 - 10/08: Make sure the converstion from the old format to the new format
> works without problems.
> 11/08 - 13/08: Test the new index and profile the gains compared to the old
> format.

I see this is partially overlaps the entries before it.  What's the plan here?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch

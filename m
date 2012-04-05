From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [GSoC] Designing a faster index format
Date: Thu, 05 Apr 2012 12:43:37 +0200
Message-ID: <4F7D7759.6020603@alum.mit.edu>
References: <F9D452C3-B11E-4915-A0F2-B248F92CE5DE@gmail.com> <CACsJy8CKqv2P2Co9MKpePfOTwe4fu-wxAYiigbYt3YHTxZ6wWQ@mail.gmail.com> <8D287169-1AD9-4586-BDBC-F820220328FC@gmail.com> <CACsJy8D2RwG-Nr5btcQj0f9=JACvH6mf7LNi=Jnb_y+j4_2u0A@mail.gmail.com> <871uomrubl.fsf@thomas.inf.ethz.ch> <8901F6B5-7396-44E1-9687-20BF95114728@gmail.com> <871uomq64c.fsf@thomas.inf.ethz.ch> <BDFA27C9-C999-4C95-8804-5E7B3B3D1BFD@gmail.com> <878virfx11.fsf@thomas.inf.ethz.ch> <2A61C352-5C71-4EDF-9DBE-01CC09AE03A5@gmail.com> <87r4we9sfo.fsf@thomas.inf.ethz.ch> <5CE5AEC7-22C8-4911-A79E-11F2F3D902A2@gmail.com> <7vk423qfps.fsf@alter.siamese.dyndns.org> <CACsJy8Ag9yvGwKE_oiW8T+hR2hN_fzXvGCdOJ_H44DCOm9RF0Q@mail.gmail.com> <1604FE70-8B77-4EC1-823A-DC1F0334CD3A@gmail.com> <4F7ABA19.7040408@alum.mit.edu> <C15BAB9A-EAFA-4EA4-
 85B2-0E0C5FF473E9@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Thomas Gummerer <italyhockeyfeed@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 05 12:43:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFkAW-00005K-V1
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 12:43:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753926Ab2DEKnv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 06:43:51 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:41012 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905Ab2DEKnv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 06:43:51 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q35AhbRV028150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 5 Apr 2012 12:43:38 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.28) Gecko/20120313 Lightning/1.0b2 Thunderbird/3.1.20
In-Reply-To: <C15BAB9A-EAFA-4EA4-85B2-0E0C5FF473E9@gmail.com>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194765>

On 04/03/2012 09:07 PM, Thomas Gummerer wrote:
> On Apr 3, 2012, at 10:51 AM, Michael Haggerty wrote:
>> On 04/02/2012 11:02 PM, Thomas Gummerer wrote:
>>> - Append-only data structure
>>> [...]
>>> To make sure the index isn't corrupted, without calculating the sha1 hash for
>>> the whole index file every time something is changed, the hash is always
>>> calculated for the whole index when merging, but when only a single entry is 
>>> changed the sha-1 hash is only calculated for the last change. This will 
>>> increase the cost for reading the index to log(n) + k * log(k) where n is the 
>>> number of entries in the sorted part of the index and k is the number of entries
>>> in the unsorted part of the index, which will have to be merged with the rest 
>>> of the index.
>>
>> I don't understand this analysis of the reading time.  I suppose you are
>> assuming that you want to read the status of a single file.  But in that
>> case, it is enough to find the entry in the old index (O(log(n))
>> assuming some sort of tree structure) plus do a linear scan through the
>> unsorted entries (i.e., O(k), not O(k log(k))).
> 
> The current way git operates it always reads the whole index, making it necessary
> to merge the unsorted entries with the sorted part. Thinking about it it would even
> be O(k log(n)), because the appended part is unsorted.
> O(log(n)) + O(k) would be the complexity for loading only a single entry from the
> index.

I was confused because in your original mail you seemed to claim that
reading the whole sorted part of the index scales like O(log(n)), where
it certainly scales at least like O(n).

To read the whole index if using an append-only data structure, I would
do the following:

1. Read the file header to find where the addenda begin: one seek plus O(1).
2. Read the addenda in order (I assume each addendum to be sorted on
disk), and merge-sort the addenda together, discarding the earlier of
any duplicates: one seek plus O(k) I/O plus O(k log k) computation (this
is the worst case, if each addendum contains a single file).
3. Read the sorted part of the file in order, while merging it together
with the combined addenda: one seek plus O(n) I/O plus O(n + k) computation.

Total: 3 seeks plus O(n+k) I/O plus O(n + k log(k)) computation.

Whereas for a B-tree, it is hard to estimate the complexity because you
have provided very little detail about how you want to lay the data
structure out on disk.  But presumably the number of seeks will be
significantly larger.  And if you are not careful, the number of seeks
will approach the number of nodes in the index O(n) or perhaps the
number of added nodes (not files!) which could go something like O(k
log(k)).

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/

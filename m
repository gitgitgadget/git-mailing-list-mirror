From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [GSoC] Designing a faster index format
Date: Sun, 25 Mar 2012 03:28:25 +0200
Message-ID: <82A01AF9-D38E-4AC4-89C5-21A01232A88A@gmail.com>
References: <F9D452C3-B11E-4915-A0F2-B248F92CE5DE@gmail.com> <CACsJy8CKqv2P2Co9MKpePfOTwe4fu-wxAYiigbYt3YHTxZ6wWQ@mail.gmail.com> <8D287169-1AD9-4586-BDBC-F820220328FC@gmail.com> <CACsJy8D2RwG-Nr5btcQj0f9=JACvH6mf7LNi=Jnb_y+j4_2u0A@mail.gmail.com> <871uomrubl.fsf@thomas.inf.ethz.ch> <8901F6B5-7396-44E1-9687-20BF95114728@gmail.com> <871uomq64c.fsf@thomas.inf.ethz.ch> <BDFA27C9-C999-4C95-8804-5E7B3B3D1BFD@gmail.com> <878virfx11.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Mar 25 03:28:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBcG4-00051p-A4
	for gcvg-git-2@plane.gmane.org; Sun, 25 Mar 2012 03:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755171Ab2CYB2b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Mar 2012 21:28:31 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:62616 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755034Ab2CYB2a convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Mar 2012 21:28:30 -0400
Received: by wgbdr13 with SMTP id dr13so2937129wgb.1
        for <git@vger.kernel.org>; Sat, 24 Mar 2012 18:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=kDpNkzHpkV9hJbrvt9zY4TW3H6/WaOAL90ACU7dwZ0s=;
        b=Sr77BBpJ4E+fC6gq4tCRfu2s1LSbxj8kYGEgX1vNNQhxE1VjxiMSyy0Z7LEmA8p2Nr
         TNexe7B7DLWn0uTLfxBAgqwHtQj7LVb6aQ9XRP6BFSx6Zjn1XGwbwXT6ZQ3EZVHZ1kr5
         yfkaAB3OL9z3UvWXx+M4vcvxMoGKv8dtfeDxN9dZ+67XPbK/STdOZcq7Eu/4scbvocxr
         lFPblnvLYw9HvBoB13G3DP8hIHTkb6jLrcenc02XrSFwo07BTsTxdt4macSIE1Qp/njY
         amZV3t28I1IBcxNVv55+cxYZr66PxcnYhs/mVH11kOWRvCJ6WWn/Ttik+ebVCBcnRlsF
         Jocg==
Received: by 10.180.102.101 with SMTP id fn5mr8067488wib.6.1332638909104;
        Sat, 24 Mar 2012 18:28:29 -0700 (PDT)
Received: from [192.168.0.3] (host20-19-dynamic.8-87-r.retail.telecomitalia.it. [87.8.19.20])
        by mx.google.com with ESMTPS id e6sm27545186wix.8.2012.03.24.18.28.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 24 Mar 2012 18:28:28 -0700 (PDT)
In-Reply-To: <878virfx11.fsf@thomas.inf.ethz.ch>
X-Mailer: Apple Mail (2.1257)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193856>

I have now read through the methods and understand the cache_tree a bit 
better (thanks Thomas for the explanation :) ) and have rewritten my proposal 
draft. Any suggestions are very welcome.

Designing a faster index format

-- Problem --
The current git index is pretty slow when working with large git repositories,
because the whole index has to be rewritten for nearly every operation. For
example for adding a single file with git add, even though logically only one 
single blob sha-1 is changed in the index, git has to recompute the hash over 
the whole index and rewrite the index file.

-- Proposed solution --
The proposed solution is to rework the index, in order to make it possible to
have a complexity of O(log(n)), where n is the number of index entries, for 
simple operations like adding files. More complex operations shall also
benefit from the new index format, although O(log(n)). While it may not be
possible to get to a complexity of O(log(n)), while keeping the index format
still easy enough to parse for other programs that read the index, the amount of
data for which that the hash will be computed shall be log(n).

The problem will be solved in two phases. 

In phase one the pysical index format shall be replaced with the new index 
format, which doesn't require a full recalculation of the sha-1 hash and a full
rewrite to the disk. The new index format will be mapped to the current
in-memory structure, which will only be changed in phase two. For further 
optimization the cache-tree the sha-1 hashes shall be mapped to the index, which
should avoid cache-tree invalidations. In phase the savings will mainly be on
disk I/O.

In phase two the core parts of git would be made aware of the new index format,
changing the current in-memory structure. The in-memory structure will be left
untouched in phase one, to allow for more testing and to make sure there won't
be any problems with the new index. After this phase git takes full advantage
of the features of the new index.

Another way to speed up the hashing would be to exchange the SHA-1 hash for
something faster. That may however not be feasible when keeping the current
in-memory structure.

To make the project feasible for Google Summer of Code, the plan is to
implement phase one and if this goes smoother then expected and there is
still time left, phase two should also be implemented as bonus work.

-- Timeline --
24/04 - 12/05: Getting familiar with the old index
24/04 - 05/05: Decide on the data structure for the new index format and 
document it. Check the feasibility of exchanging SHA-1 with a faster hash
algorithm.
06/05 - 26/05: Map the current internal structure to the new index format.
27/05 - 23/06: Tie the cache-tree hashes to the index hashes.
24/06 - 21/07: Write the index to disk in the new format and make sure only the
changed parts are really written to disk.
/* Development work will be a bit slower from 18/06 to 21/07 because at my
 * University there are exams in this period. I probably will only be able to
 * work half the hours. I'll be back up to full speed after that. */
22/06 - 04/08: Parse the index from the disk to the current in-memory format.
05/08 - 13/08: Optimize the algorithm and profile the gains. 

-- Why git --
I'm using git since about 2-3 years and wanted to contribute to it earlier, but
couldn't find the time to do it. I would also like to continue contributing
once the Summer of Code is over.

-- About me --
I'm Thomas Gummerer (@tgummerer on Twitter, tgummerer on IRC), 21 years old
from Italy. I'm currently a 3rd year Bachelor student in Applied Computer 
Science at the Free University of Bolzano. I started programming in High School 
about 8 years ago with Pascal and then learned C and Java. For some of my
projects you can visit my homepage (http://tgummerer.com/projects), most of them
were for university and some personal projects I did in my free time. My blog is
also on the same homepage, but not really active. Unfortunately I couldn't yet 
participate in any bigger open source project, although I'm interested in
it basically since I started programming. 
On Mar 23, 2012, at 11:10 AM, Thomas Rast wrote:

> Hi Thomas,
> 
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
>> 24/04 - 12/05: Getting familiar with the old index
> 
> I am aware that this falls into the period for "getting up to speed",
> however I think if you spend a day or so *now* reading through
> read_index, write_index and the relevant docs.  We can then give you the
> brief rundown on cache_tree, and you'll have a much clearer picture of
> how things fall together.
> 
> I think that should lead to a lot of enlightenment and a greatly
> improved proposal.
> 
> - Thomas
> 
> -- 
> Thomas Rast
> trast@{inf,student}.ethz.ch

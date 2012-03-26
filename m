From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [GSoC] Designing a faster index format
Date: Mon, 26 Mar 2012 22:35:07 +0200
Message-ID: <2A61C352-5C71-4EDF-9DBE-01CC09AE03A5@gmail.com>
References: <F9D452C3-B11E-4915-A0F2-B248F92CE5DE@gmail.com> <CACsJy8CKqv2P2Co9MKpePfOTwe4fu-wxAYiigbYt3YHTxZ6wWQ@mail.gmail.com> <8D287169-1AD9-4586-BDBC-F820220328FC@gmail.com> <CACsJy8D2RwG-Nr5btcQj0f9=JACvH6mf7LNi=Jnb_y+j4_2u0A@mail.gmail.com> <871uomrubl.fsf@thomas.inf.ethz.ch> <8901F6B5-7396-44E1-9687-20BF95114728@gmail.com> <871uomq64c.fsf@thomas.inf.ethz.ch> <BDFA27C9-C999-4C95-8804-5E7B3B3D1BFD@gmail.com> <878virfx11.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Mar 26 22:35:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCGdW-0001qO-LF
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 22:35:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756205Ab2CZUf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 16:35:26 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:56545 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753040Ab2CZUfZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Mar 2012 16:35:25 -0400
Received: by yhmm54 with SMTP id m54so4178923yhm.19
        for <git@vger.kernel.org>; Mon, 26 Mar 2012 13:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=5kd4UbAuyZmB1AeTPPAwq0ve3sBFDVZSSR/F9ZYROxI=;
        b=w6SeOLOFGtvfSv9VW/GVbBC+znodagc9QjrGtt9exaoQIrizvYnR6CvqOxCqbFajnZ
         fyhLLH63VKLds4YoCnUK3jxIWdOSgZFWZzsGuoWAw42EnP3VebBgnFP4RXblok4mijt2
         jSL3WSjSC3SnEpoGLhuNm/oaAgki40puzQiFoYvzk9qWku0n9oHhlFcXepheI+3Llp6A
         44/jhdpSBPlu6BGyTuq59HooFhrqpcXKX2HLBvlxtHFRoABkAGZHPlT/zzOAhEFKA88g
         X2xSjeLtvWhaZKuxYBRPTti6tBkIOzhwvHEQf1w1n9qy9rhgrBNwqEs97ycmo6Xrk/2/
         2VPg==
Received: by 10.60.14.226 with SMTP id s2mr13138078oec.29.1332794121130;
        Mon, 26 Mar 2012 13:35:21 -0700 (PDT)
Received: from [10.9.26.196] ([216.18.212.218])
        by mx.google.com with ESMTPS id ch5sm17417756obb.16.2012.03.26.13.35.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 26 Mar 2012 13:35:19 -0700 (PDT)
In-Reply-To: <878virfx11.fsf@thomas.inf.ethz.ch>
X-Mailer: Apple Mail (2.1257)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193974>


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

I've updated my proposal draft, which now includes a idea of backward
compatibility and some changes for language problems. Any comments or
suggestions are greatly appreciated.

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
benefit from the new index format, although a complexity of O(log(n)) might not
be reached, while keeping the index format easy enough to parse for .git reading
programs. The amount of data for which that the hash will be computed however
shall be log(n). N is the number of entries in the index.

The problem will be solved in two phases. 

In phase one the pysical index format shall be replaced with the new index 
format, which does neither require a full recalculation of the sha-1 hash nor a
full rewrite of the index to the disk. The new index format will be mapped to 
the current in-memory structure, which will only be changed in phase two. For 
further optimization the cache-tree sha-1 hashes shall be mapped to the new 
index format, which should avoid cache-tree invalidations. In phase one the 
savings will mainly be on disk I/O and commands that usually cause a lot of 
cache-tree invalidations. To ensure backward compatibility, git shall keep the
ability able to read version 2/3 of the index. The user shall also have the 
possibility to configure git to write the index in either the new or the old 
format. While this will produce some code overhead, it will make the life of git 
users which don't use core git exclusively easier in the transition phase. 
If the user sets the write format to the new format and the repository is a 
already existing version 2/3 repository, the old index will be transformed to 
the new format.

In phase two the core parts of git would be made aware of the new index format,
changing the current in-memory structure. The in-memory structure will be left
untouched in phase one, to allow for more testing and to make sure there won't
be any problems with the new index. After this phase git is able to take full 
advantage of the features of the new index.

Another way to speed up the hashing would be to exchange the SHA-1 hash for
something faster. That may however not be feasible while keeping the current
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
24/06 - 21/07: Write the index to disk in both the old and the new format
depending on the choice of the user and make sure only the changed parts are 
really written to disk in the new format.
/* Development work will be a bit slower from 18/06 to 21/07 because at my
 * University there are exams in this period. I probably will only be able to
 * work half the hours. I'll be back up to full speed after that. */
22/06 - 04/08: Parse the index from the disk to the current in-memory format.
05/08 - 10/08: Make sure the converstion from the old format to the new format
works without problems.
11/08 - 13/08: Test the new index and profile the gains compared to the old
format.

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

--
Thomas Gummerer

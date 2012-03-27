From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [GSoC] Designing a faster index format
Date: Tue, 27 Mar 2012 13:08:30 +0200
Message-ID: <BC3319C2-EBDD-4E08-9FEE-88920409C537@gmail.com>
References: <F9D452C3-B11E-4915-A0F2-B248F92CE5DE@gmail.com> <CACsJy8CKqv2P2Co9MKpePfOTwe4fu-wxAYiigbYt3YHTxZ6wWQ@mail.gmail.com> <8D287169-1AD9-4586-BDBC-F820220328FC@gmail.com> <CACsJy8D2RwG-Nr5btcQj0f9=JACvH6mf7LNi=Jnb_y+j4_2u0A@mail.gmail.com> <871uomrubl.fsf@thomas.inf.ethz.ch> <8901F6B5-7396-44E1-9687-20BF95114728@gmail.com> <871uomq64c.fsf@thomas.inf.ethz.ch> <BDFA27C9-C999-4C95-8804-5E7B3B3D1BFD@gmail.com> <878virfx11.fsf@thomas.inf.ethz.ch> <2A61C352-5C71-4EDF-9DBE-01CC09AE03A5@gmail.com> <7vd37znjyo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Thomas Rast <trast@student.ethz.ch>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 13:08:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCUGa-0005z9-Ko
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 13:08:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753684Ab2C0LIk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 07:08:40 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:40707 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753663Ab2C0LIj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Mar 2012 07:08:39 -0400
Received: by pbcun15 with SMTP id un15so100056pbc.19
        for <git@vger.kernel.org>; Tue, 27 Mar 2012 04:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=2GzTYpKpi3AK/Me2K/+srHlRgc2obU22bsF2tCvCchI=;
        b=s6HpaAERAE0SpS6xxDGDHhg/gwaCFdZfvADl+QdXSvzb+oXyX0YyZ+w8Pd+fvg7Aj5
         DkPXvm2MfJ8/OlGGZfTMKl5U8k0PiCpTjnFcWS06IhX3K6q1y74pkgw1OpHFbcfXRWT8
         R03c5aMug6Tjque2fYaQ+fwmX6h/Qdj7bu1ire1sENaz1yfhBQ3HZWbQyotKafkLaGq9
         alkhQydLtUUF//RP9WEpKVsu4STsxX9+ut285+QE+n/dzV+B0mSwBzx6SEV+kcD+H8Cx
         2F2zSvP9UhrFEk/rvuiZ81SVmjjzuU30rOo2yN83qT5Hj81CZrOtgbrDCJ2gh4nXbOFP
         yQHA==
Received: by 10.68.221.71 with SMTP id qc7mr12019593pbc.36.1332846518668;
        Tue, 27 Mar 2012 04:08:38 -0700 (PDT)
Received: from [10.9.26.196] ([216.18.212.218])
        by mx.google.com with ESMTPS id l1sm154516pbs.34.2012.03.27.04.08.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 27 Mar 2012 04:08:37 -0700 (PDT)
In-Reply-To: <7vd37znjyo.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1257)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194038>


On Mar 26, 2012, at 11:14 PM, Junio C Hamano wrote:

> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
>> The proposed solution is to rework the index, in order to make it possible to
>> have a complexity of O(log(n)), where n is the number of index entries, for 
>> simple operations like adding files. More complex operations shall also
>> benefit from the new index format, although a complexity of O(log(n)) might not
>> be reached, while keeping the index format easy enough to parse for .git reading
>> programs. The amount of data for which that the hash will be computed however
>> shall be log(n). N is the number of entries in the index.
> 
> Where does log(N) come from, and is that a hard requirement?

The log(n) comes from the plan to implement the index in a tree-like structure. It
isn't a hard requirement, but it certainly shouldn't be much slower than that, otherwise
the change wouldn't make sense.

> Rephrasing your problem description, you want to address the inefficiency
> that we have to write the full 1m entries to a new file in order to update
> only one file when the index tracks 1m paths.  
> 
> Wouldn't the goal be more in line with that problem statement if you
> instead aim to make the cost proportional to the number of entries that
> are updated, regardless of how many entries exist in the index?

Making the cost proportional to the number of entries that are updated would
be the superior solution, but probably not possible to achieve.

> 
>> In phase one the pysical index format shall be replaced with the new index 
>> format, which does neither require a full recalculation of the sha-1 hash nor a
>> full rewrite of the index to the disk. The new index format will be mapped to 
>> the current in-memory structure, which will only be changed in phase two. For 
>> further optimization the cache-tree sha-1 hashes shall be mapped to the new 
>> index format, which should avoid cache-tree invalidations.
> 
> It is unclear what you meant by the last sentence.  The cache-tree
> invalidation is a critical part of the machinery that allows later
> write-tree to reuse the already computed subtree object names, without
> having to recompute subtree object names until they are really necessary
> (i.e. when writing a tree out).  By "avoiding" it, are you going to make
> write-tree always recompute all the subtree object names?  Or are you
> planning to keep the cached tree information always up to date by
> recomputing subtree object names and keeping them in the index even when
> they are not yet needed?  If the latter, how would you handle when a part
> of the index contains unmerged entries?

The plan was to do the latter, if it is feasible to keep them always up to date,
without slowing other commands down. For the unmerged entries, I don't
have a plan yet, but I'll try to come up with one, when understanding the
source code better.

> Right now, the code that updates the in-core index records "Is the in-core
> index clean, or modified?" bit and nothing else.  Without updating the
> in-core structure and the codepaths that access it, how is it possible for
> your phase I to selectively write out only the modified (either added,
> updated or removed) part of it?  In other words, I do not think it is
> realistic to expect that the core parts to stay oblivious to the new index
> semantics during the "phase one".

When it's impossible to write only the modified part of the index without
changing the in-core parts, the in-core parts will only changed in the
minimal possible way, adding only a flag for the changed parts, so only
those can be effectively written to disk.

>> -- Timeline --
>> 24/04 - 12/05: Getting familiar with the old index
> 
> It might make more sense to write the "proposed solution" *after* this
> step is done; otherwise you wouldn't even know the problems you are trying
> to solve.  That may mean that this part of the schedule may need to be
> shortened or started way before the beginning of GSoC.

Yes, I'm currently on this, reading through documentation and source code.

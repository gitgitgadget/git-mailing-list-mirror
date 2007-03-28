From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] Packing large repositories
Date: Wed, 28 Mar 2007 09:53:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703280943450.6730@woody.linux-foundation.org>
References: <56b7f5510703280005o7998d65pcbcd4636b46d8d23@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 18:53:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWbOf-0004QJ-7Z
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 18:53:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932960AbXC1QxM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Mar 2007 12:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933140AbXC1QxL
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Mar 2007 12:53:11 -0400
Received: from smtp.osdl.org ([65.172.181.24]:50055 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932960AbXC1QxK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2007 12:53:10 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2SGr8U2014791
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 28 Mar 2007 09:53:08 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2SGr7w6015374;
	Wed, 28 Mar 2007 09:53:08 -0700
In-Reply-To: <56b7f5510703280005o7998d65pcbcd4636b46d8d23@mail.gmail.com>
X-Spam-Status: No, hits=-0.966 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43378>



On Wed, 28 Mar 2007, Dana How wrote:
> 
> I just started experimenting with using git on
> a large engineering project which has used p4 so far.
> Part of a checkout is about 55GB;
> after an initial commit and packing I have a 20GB+ packfile.

Oh wow. You don't do half measures, do you ;)

> Of course this is unusable, since object_entry's in an .idx
> file have only 32 bits in their offset fields.  I conclude that
> for such large projects,  git-repack/git-pack-objects would need
> new options to control maximum packfile size.

Either that, or update the index file format. I think that your approach 
of having a size limiter is actually the *better* one, though. 

> [ I don't think this affects git-{fetch,receive,send}-pack
> since apparently only the pack is transferred and it only uses
> the variable-length size and delta base offset encodings
> (of course the accumulation of the 7 bit chunks in a 32b
> variable would need to be corrected, but at least the data
> format doesn't change).]

Well, it does affect fetching, in that "git index-pack" obviously would 
also need to be taught how to split the resulting indexed packs up into 
multiple smaller ones from one large incoming one. But that shouldn't be 
fundamentally hard either, apart from the inconvenience of having to 
rewrite the object count in the pack headers..

To avoid that issue, it may be that it's actually better to split things 
up at pack-generation time *even* for the case of --stdout, exactly so 
that "git index-pack" wouldn't have to split things up (we potentially 
know a lot more about object sizes up-front at pack-generation time than 
we know at re-indexing).

> So I am toying with adding a --limit <size> flag to
> git-repack/git-pack-objects.

Sounds very sane.

> This cannot be used with --stdout.  If specified, e.g.
>  git-repack --limit 2g
> then each packfile created could be at most 2^31-1 bytes in size.

Sounds good, apart from the caveat above about "--stdout" that needs some 
thinking about.

> It's possible that multiple packfiles would be created in one shot.
> Thus git-pack-objects could write multiple names to stdout
> and git-repack would need to be updated accordingly.

Yes. That seems to be the least of all problems.

> Finally, I wonder if having tree/commit/tag objects mixed into
> such large packfiles would be a performance hit.

My initial reaction is that it's best to start off without worrying about 
that, and just do everything in the order that we do now (ie "sort by 
type first, recency second") and just split when we hit the size limit.

But if you actually want to experiment with different organizations, I 
don't think that's wrong. I would just personally start without it.

		Linus

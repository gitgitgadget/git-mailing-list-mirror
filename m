X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: fetching packs and storing them as packs
Date: Fri, 27 Oct 2006 13:22:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610271310450.3849@g5.osdl.org>
References: <Pine.LNX.4.64.0610252333540.12418@xanadu.home> <4540CA0C.6030300@tromer.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Fri, 27 Oct 2006 20:25:47 +0000 (UTC)
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <4540CA0C.6030300@tromer.org>
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30346>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdYEL-0001e4-8L for gcvg-git@gmane.org; Fri, 27 Oct
 2006 22:23:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751233AbWJ0UXA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 16:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWJ0UXA
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 16:23:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29373 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1751233AbWJ0UXA (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 16:23:00 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9RKMJPo022830
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Fri, 27
 Oct 2006 13:22:19 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9RKMIhc003072; Fri, 27 Oct
 2006 13:22:18 -0700
To: Eran Tromer <git2eran@tromer.org>
Sender: git-owner@vger.kernel.org



On Thu, 26 Oct 2006, Eran Tromer wrote:
>
> This creates a race condition w.r.t. "git repack -a -d", similar to the
> existing race condition between "git fetch --keep" and
> "git repack -a -d". There's a point in time where the new pack is stored
> but not yet referenced, and if "git repack -a -d" runs at that point it
> will eradicate the pack. When the heads are finally updated, you get a
> corrupted repository.

(I note that there's a whole thread on this, but I was off doing other 
things, so I probably missed part of it)

We really should _never_ create a pack in-place with the final name.

The way to fix the race is to simply not create the patch as

	.git/objects/packed/pack-xyz.{pack|idx}

in the first place, but simply "mv" them into place later. If you do that 
after you've written the temporary pointer to it, there is no race (the 
temporary pointer may not be usable, of course, but that's a separate 
issue).

That said, I think some of the "git repack -d" logic is also unnecessarily 
fragile. In particular, it shouldn't just do

	existing=$(find . -type f \( -name '*.pack' -o -name '*.idx' \))

like it does to generate the "existing" list, it should probably only ever 
remove a pack-file and index file _pair_, ie it should do something like

	existing=$(find . -type f -name '*.pack')

and then do

	for pack in $existing
	do
		index="$(basename $pack).idx"
		if [ -f $index ] && [ "$pack"!= "$newpack" ]
		then
			rm -f "$pack" "$index"
		fi
	done

etc, exactly so that it would never remove anything that is getting 
indexed or is otherwise half-way done, regardless of any other issues.

Hmm?


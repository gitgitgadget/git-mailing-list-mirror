From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] pack-objects: re-validate data we copy from elsewhere.
Date: Sat, 2 Sep 2006 17:27:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609021720500.27779@g5.osdl.org>
References: <20060830015122.GE22935@spearce.org>
 <9e4733910608291958l45c0257dla6e5ebd4176f7164@mail.gmail.com>
 <20060830031029.GA23967@spearce.org> <Pine.LNX.4.64.0608300124550.9796@xanadu.home>
 <7vzmdmh2lu.fsf@assigned-by-dhcp.cox.net> <44F871BA.3070303@gmail.com>
 <Pine.LNX.4.64.0609011129270.27779@g5.osdl.org> <7vveo741tc.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0609011721390.27779@g5.osdl.org> <7vd5ae3ox2.fsf@assigned-by-dhcp.cox.net>
 <20060902045246.GB25146@spearce.org> <7vodty1swz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 03 02:28:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJfqQ-0002ng-Du
	for gcvg-git@gmane.org; Sun, 03 Sep 2006 02:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbWICA14 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Sep 2006 20:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751788AbWICA14
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Sep 2006 20:27:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44431 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751787AbWICA1z (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Sep 2006 20:27:55 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k830RnnW021867
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 2 Sep 2006 17:27:50 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k830RmxB006903;
	Sat, 2 Sep 2006 17:27:48 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vodty1swz.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-2.471 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.146 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26360>



On Sat, 2 Sep 2006, Junio C Hamano wrote:
> 
> repack without -a essentially boils down to:
> 
> 	rev-list --objects --all --unpacked |
>         pack-objects $new_pack
> 
> which picks up all live loose objects and create a new pack.
> 
> If rev-list had an extention that lets you say
> 
> 	rev-list --objects --all --unpacked=$active_pack |
> 	pack-objects $new_pack

I have to say, that adding another pack-objects-specific flag to rev-list 
doesn't necessarily strike me as very nice.

It might be much better to just teach "git pack-objects" to walk the 
object list by hand. The whole "git-rev-list | git-pack-objects" approach 
made more sense back when git-rev-list was the _only_ think listing 
objects, but now that we've librarized the whole object listing thing, 
maybe it's time to avoid the pipeline and just do it inside the packer 
logic.

Of course, having git-pack-objects be able to take input from stdin is 
still useful, but I'd rather start moving the obviously packing-specific 
flags out of git-rev-list, and into git-pack-objects instead.

[ That would also potentially make packing more efficient - right now the 
  "phase 1" of packing is literally to just figure out the type and the 
  size of the object, in order to sort the object list.

  So when you do a big repack, first "git-rev-list" ends up doing all this 
  work, and then "git-pack-object" ends up _redoing_ some of it. 

  Especially for tree objects (which are one of the most common kinds), we 
  already opened the object once when we traversed it, so opening it again 
  just to look at its size is kind of sad.. ]

We also used to have a bug with repacking, where a git-rev-list that died 
with a failure would silently cause a "good" repack to happen because it 
had fed git-pack-objects an incomplete list of objects. Junio fixed that 
with a hack, but if we did all the object listing inside git-pack-objects, 
we'd not need that kind of things at all..

Hmm? Comments?

		Linus

-- 
VGER BF report: U 0.500053

From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: diff against a tag ?
Date: Thu, 28 Apr 2005 16:27:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504281619080.18901@ppc970.osdl.org>
References: <20050428200953.GD8514@redhat.com>  <7vpswe7hvj.fsf@assigned-by-dhcp.cox.net>
  <Pine.LNX.4.58.0504281358060.18901@ppc970.osdl.org>
 <118833cc05042816141ba672a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Dave Jones <davej@redhat.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 01:20:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRIJD-0007Po-4e
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 01:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262333AbVD1X0K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 19:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262334AbVD1X0K
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 19:26:10 -0400
Received: from fire.osdl.org ([65.172.181.4]:41933 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262333AbVD1X0D (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 19:26:03 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3SNPos4025570
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 28 Apr 2005 16:25:50 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3SNPnMc019217;
	Thu, 28 Apr 2005 16:25:49 -0700
To: Morten Welinder <mwelinder@gmail.com>
In-Reply-To: <118833cc05042816141ba672a4@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 28 Apr 2005, Morten Welinder wrote:
> 
> Which begs the question: why wasn't the type of the object made part of the
> file name?

Because it would just have complicated the code and made it less flexible.

As it is, we can open an object by just knowing its name, and by "name" I 
mean the true one, the SHA1. No need for "open_blob()" or anything like 
that. You just do

	sha1_file_name(const unsigned char *sha1)

to find out what the filesystem name of the object is, and this works for 
_any_ object.

And thanks to this, we can pass in a sha1 _without_ knowing whether it's a 
tree or a commit (or a tag) and just open in. Then, when we figure out 
that it was a commit rather than a tree, we look up the tree instead. 

Being able to open files _without_ knowing what they are is hugely useful. 
The user passes you a name, and you can just do the right thing. 

Besides, I _still_ don't want scripts mucking around with the objects
directly. Remember? They're encrypted with my super-sekrit zlib encoder
ring, just because people shouldn't be mucking around in them.

Trust me, when the object directories have a million files, you'll thank
me. You do _not_ want to do a readdir and try to figure out tags that way. 
You want to do it the way I _force_ you to do it, ie the right way.

		Linus

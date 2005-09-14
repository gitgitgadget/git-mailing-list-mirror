From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: does git prune packs?
Date: Wed, 14 Sep 2005 08:30:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509140824090.26803@g5.osdl.org>
References: <432805E6.6030905@pobox.com> <Pine.LNX.4.58.0509140808010.26803@g5.osdl.org>
 <43283E66.5080101@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 14 17:31:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFZDc-0002Gq-AQ
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 17:30:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030184AbVINPah (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 11:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965246AbVINPah
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 11:30:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23733 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965243AbVINPag (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2005 11:30:36 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8EFU6Bo026129
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 14 Sep 2005 08:30:06 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8EFU3JH007220;
	Wed, 14 Sep 2005 08:30:05 -0700
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <43283E66.5080101@pobox.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8531>



On Wed, 14 Sep 2005, Jeff Garzik wrote:
> 
> I never repack, I just use your packs.

Oh, ok. Then, do something like this:

	mv .git/objects/pack .git/objects/old-packs
	mkdir .git/objects/pack
	for i in .git/objects/old-packs/*.pack
	do
		echo $i:
		git-unpack-objects < $i
	done

and it will do the right thing. Doing the right thing means, among other 
things, that if an object already exists in an alternate object directory, 
it won't be written to disk again.

(So if you have an "alternates" file pointing to my objects, and your 
packs contain mainly/only objects that I've pulled, basically nothing will 
actually be unpacked.)

After that, do a git-fsck-cache to make sure everything looks good, and 
just "rm -rf .git/objects/old-packs".

And yes, we could make something like this a helper script.

NOTE! During the unpacking, the repository may not be usable, so make sure 
that nobody else tries to access it while you do this.

		Linus

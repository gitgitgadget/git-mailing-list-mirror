From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: "git reset --hard" leaves empty directories that shouldn't exist
Date: Wed, 15 Feb 2006 17:35:21 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602151720490.22082@g5.osdl.org>
References: <87y80dhxfd.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 16 02:35:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9Y3P-0002K2-2d
	for gcvg-git@gmane.org; Thu, 16 Feb 2006 02:35:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbWBPBf2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Feb 2006 20:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWBPBf2
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Feb 2006 20:35:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:6634 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751214AbWBPBf1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Feb 2006 20:35:27 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1G1ZMDZ022752
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 15 Feb 2006 17:35:22 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1G1ZLq3024177;
	Wed, 15 Feb 2006 17:35:21 -0800
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87y80dhxfd.wl%cworth@cworth.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16257>



On Tue, 14 Feb 2006, Carl Worth wrote:
>
> I've been exploring the potential for git-sync, and I found some odd
> behavior with "git reset --hard". It appears that if the current tree
> has some directory structure (at least two levels deep) that does not
> exist in the tree being reset to, that empty directories are left
> around after the reset:

"git reset --hard xyz" in many ways is a sledgehammer, and it says "I want 
the state at the point of xyz, and I don't care _what_ the heck the 
current state is".

Now, that's somewhat problematic, exactly because of that "screw the 
current state" thing. It actually tries to remove files (see the 
"tmp-exists" thing in the git-reset script), but it's being pretty stupid 
about it. It also very definitely will not try to remove subdirectories, 
empty or not.

(I say that without being able to read perl, so I might be wrong. Maybe it 
tries and just fails).

Anyway, if you want to do the "gentle and smart" thing, you should 
probably actually use

	git-read-tree -m -u <oldtree> <newtree>

which unlike "git-reset" will gently _update_ the tree from one version to 
another (and will error out if your checked-out copy doesn't match the 
old tree).

And the gentle way will actually do the right thing wrt subdirectories 
(note that it will _not_ remove empty subdirectories if you have left 
files - like object files - around that it doesn't know about: that's not 
an error, but the unknown file will not, nor the subdirectory, be 
removed).

And yes, git-reset should probably do the subdirectory thing too. In the 
meantime you should think of it as the brute-force and not very smart way 
(in Calvin and Hobbes terms, "git reset" is Moe).

			Linus

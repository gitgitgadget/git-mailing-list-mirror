From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git "tag" objects implemented - and a re-done commit
Date: Mon, 25 Apr 2005 15:05:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504251457510.18901@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504251213530.18901@ppc970.osdl.org>
 <426D62C0.40104@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 26 00:02:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQBeD-0006ha-GZ
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 00:01:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbVDYWFu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 18:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbVDYWFt
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 18:05:49 -0400
Received: from fire.osdl.org ([65.172.181.4]:20156 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261238AbVDYWDT (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2005 18:03:19 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3PM3Is4004457
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 25 Apr 2005 15:03:18 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3PM3Hkp009504;
	Mon, 25 Apr 2005 15:03:17 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <426D62C0.40104@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 25 Apr 2005, H. Peter Anvin wrote:
> 
> It would be good if the tag object could permit junk lines before the 
> start of the header; in particular, the standard PGP/GPG signed message 
> format looks like:

No, I've already explained why git doesn't parse arbitrary junk: I want 
git to have 100% repeatable behaviour. And that very much means that if 
git doesn't understand something, it just doesn't touch it or parse it.

Here's my trivial script to generate tags in proper format. Go wild:

	#!/bin/sh
	( echo -e "object $(cat .git/HEAD)\ntype commit\ntag $1\n"; cat ) > .tmp-tag
	rm -f .tmp-tag.asc
	gpg -bsa .tmp-tag && cat .tmp-tag.asc >> .tmp-tag
	git-mktag < .tmp-tag
	rm -f .tmp-tag*

and it creates objects like this one:


	torvalds@ppc970:~/git> cat-file tag 
	ba613c023dcd03e06158caee9c0337e6b6988854
	object ec4465adb38d21966acdc9510ff15c0fe4539468
	type commit
	tag test-release
	Testing tagging
	-----BEGIN PGP SIGNATURE-----
	Version: GnuPG v1.2.4 (GNU/Linux)
	
	iD8DBQBCbVwSF3YsRnbiHLsRAliaAKCMlb6k6VAS7hxajwUtwRdzDZn9rACffVTb
	dRdDS6n+pjSAYbA6Lp11bQU=
	=JNiv
	-----END PGP SIGNATURE-----

and then you just split it at the (last occurrence of) the 

	-----BEGIN PGP SIGNATURE-----

and you can do

	torvalds@ppc970:~/git> gpg --verify tag.asc
	gpg: Signature made Mon 25 Apr 2005 02:07:30 PM PDT using DSA key ID 76E21CBB
	gpg: Good signature from "Linus Torvalds (tag signing key) <torvalds@osdl.org>"

to verify the dang thing.

And that way git never guesses anything at all, and you can use whatever 
you want to sign the things.

		Linus

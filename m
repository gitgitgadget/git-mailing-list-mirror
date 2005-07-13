From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC PATCH] cogito --- don't overwrite metadata files in place
 (breaks CoW use)
Date: Wed, 13 Jul 2005 14:23:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507131410430.17536@g5.osdl.org>
References: <20050712190552.GA7178@taniwha.stupidest.org>
 <loom.20050712T233332-364@post.gmane.org> <20050713045338.GA19819@taniwha.stupidest.org>
 <pan.2005.07.13.07.03.26.398212@smurf.noris.de> <20050713185339.GA9260@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 23:26:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsokE-0005DZ-Om
	for gcvg-git@gmane.org; Wed, 13 Jul 2005 23:26:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbVGMVZ7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jul 2005 17:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262476AbVGMVZu
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jul 2005 17:25:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4581 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261420AbVGMVYP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2005 17:24:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6DLNJjA021859
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 13 Jul 2005 14:23:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6DLNIH4005522;
	Wed, 13 Jul 2005 14:23:19 -0700
To: Chris Wedgwood <cw@f00f.org>
In-Reply-To: <20050713185339.GA9260@taniwha.stupidest.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 13 Jul 2005, Chris Wedgwood wrote:
> 
> How about the following?
> 
>     echo_to_file() {
> 	local DEST="$2"
> 	local count=1
> 	local RET
> 
> 	# follow symlinks until we run out or end up with something
> 	# dangling
> 	while [ -L "$DEST" ] ; do

If you really want to do something like this, then you should do it like 
this:

	update_head() {
		head="$GIT_DIR/HEAD"
		newvalue=$(git-rev-parse --verify "$1"^0) || exit
		if [ -L "$head" ]; then
			head=$(readlink "$head")
			case "$head" in
			refs/heads/*)
				head="$GIT_DIR"/"$head"
				;;
			*)
				exit 1
				;;
			esac
		fi
		echo $newvalue > "$head.lock" && rename "$head.lock" "$head"
	}

which is at least slightly simpler, and might even work thanks to that.

Your was buggy for several reasons:

 - following multiple links is _wrong_, since the next-level link could 
   actually be a symlink to another tree entirely (if somebody is crazy 
   enough to use "cp -Rl" to copy trees, then why not "cp -Rs"?)

   Ergo: you should only follow a symlink if it points to refs/heads, and 
   anything else would be a BUG.

 - you got relative links wrong.

Now, admittedly the above is totally untested too, so I'll probably have 
typos etc in there. But the basic point stands: don't go for complexity. 
Go for one _particular_ case.

		Linus

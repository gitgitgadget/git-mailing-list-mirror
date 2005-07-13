From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC PATCH] cogito --- don't overwrite metadata files in place
 (breaks CoW use)
Date: Wed, 13 Jul 2005 14:33:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507131425080.17536@g5.osdl.org>
References: <20050712190552.GA7178@taniwha.stupidest.org>
 <loom.20050712T233332-364@post.gmane.org> <20050713045338.GA19819@taniwha.stupidest.org>
 <pan.2005.07.13.07.03.26.398212@smurf.noris.de> <20050713185339.GA9260@taniwha.stupidest.org>
 <Pine.LNX.4.58.0507131256490.17536@g5.osdl.org> <20050713204458.GB11403@taniwha.stupidest.org>
 <Pine.LNX.4.58.0507131402210.17536@g5.osdl.org> <20050713211106.GA12047@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthias Urlichs <smurf@smurf.noris.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 13 23:40:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dsowk-0007Bi-1J
	for gcvg-git@gmane.org; Wed, 13 Jul 2005 23:39:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbVGMVib (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jul 2005 17:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262767AbVGMVf5
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jul 2005 17:35:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9447 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262604AbVGMVeg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2005 17:34:36 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6DLXijA022705
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 13 Jul 2005 14:33:45 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6DLXhn7006124;
	Wed, 13 Jul 2005 14:33:43 -0700
To: Chris Wedgwood <cw@f00f.org>
In-Reply-To: <20050713211106.GA12047@taniwha.stupidest.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 13 Jul 2005, Chris Wedgwood wrote:
> 
> I would however like to be able to hardlink more than just the
> _object_ directory --- hardlinking the source is quite nice too.
> Might that be considered safe?  (I'm of course assuming that editors
> do write + rename when saving their buffers).

Hmm.. I don't think it's necessarily wrong, although as you say, your
editor had better DTRT. That said, even if your editor doesn't, at least
you won't corrupt your git archive, although you might have surprising
changes creep into the other side..

But I've not verified that every git program does the right thing...

Search-search-search.. Indeed: at least "git-apply" seems to modify the
file in place. That may be the only one, though - and should be easily
fixed by adding an "unlink()" (and make it use O_EXCL just to make it 
easy to grep to verify that we always use O_EXCL with O_WR.*).

entry.c should also add O_EXCL (it seems to already do the unlink).

Anybody want to go through and verify it? I think we should support 
hardlinked source trees if we can do so easily, and it _looks_ like we're 
pretty close..

		Linus

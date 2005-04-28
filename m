From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] add a diff-files command (revised and cleaned up)
Date: Thu, 28 Apr 2005 10:08:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504280950340.18901@ppc970.osdl.org>
References: <Pine.LNX.4.62.0504272239420.14033@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 19:01:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRCNh-0002UM-Uf
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 19:00:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262172AbVD1RGZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 13:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262173AbVD1RGZ
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 13:06:25 -0400
Received: from fire.osdl.org ([65.172.181.4]:9895 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262172AbVD1RGW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 13:06:22 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3SH68s4019925
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 28 Apr 2005 10:06:09 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3SH67BZ028005;
	Thu, 28 Apr 2005 10:06:08 -0700
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.62.0504272239420.14033@localhost.localdomain>
X-Spam-Status: No, hits=0.001 required=5 tests=REMOVE_IN_QUOTES
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 27 Apr 2005, Nicolas Pitre wrote:
>
> In the same spirit as diff-tree and diff-cache, here is a diff-files 
> command that processes differences between the index cache and the 
> working directory content.

I really think the current "show-diff" does that very well, and what 
you're doing is really different.

I think this thing is really a replacement for "show-files", which is a 
piece of crap (hey, I wrote it, but I don't have to be proud of it), and 
which really was meant to be more of what your diff-files is.

The thing is, I really don't want the "core" diff-xxx programs to worry 
about exclude patters, and current directory contents. They do one thing, 
and one thing only: compare the files they were explicitly told to 
compare. 

HOWEVER, there clearly is a separate problem, which is what "show-files"  
currently does very badly (and not at all in some cases), which is the 
"ok, what about the _other_ files?"

And once you start talking about files that are _not_ mentioned in the
index, now you really do have something totally different, and now it does
need to be able to have exclude patterns to know to avoid object files and
other crud that we know we're not interested in).

But for the crud we don't know about, we're not really interested in the
diff against something we _do_ know about. So I think that the whole
"--others" and "--all" thing is wrong (yeah, yeah, it was me that started
it with show-files), and that this thing should always _only_ look at
files that aren't mentioned in the index file (ie "others" is always
enabled, and "all" is pointless).

Because those are special files: they are files we don't know what to do
with (conversely, files that _are_ mentioned in the index but don't 
actually seem to show up are interesting for the exact same reason).

That set of files is interesting for several reasons:

 - maybe we're about to check something in. We want to know whether maybe 
   we've forgotten to "add" a file or "remove" a file.

 - is it a file we've lost track of, and if so, does it look anything like 
   some _other_ file in the index. This happens if you do a "mv", and 
   don't tell the SCM about it: git doesn't care (it looks like a remove 
   and add), but it would be good to have a tool that warns about it and 
   then it would be nice if it could actually say "files xxx and yyy seem 
   to have gone away, but I see new files aaa and bbb, and it looks like 
   bbb might be similar to yyy, and aaa looks a lot like the old xxx"

This was all stuff that "show-files" was kind of supposed to work up to, 
but I just couldn't find it in myself to be interested enough.

		Linus

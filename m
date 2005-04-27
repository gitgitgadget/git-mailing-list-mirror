From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: A shortcoming of the git repo format
Date: Wed, 27 Apr 2005 12:11:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504271154470.18901@ppc970.osdl.org>
References: <426F2671.1080105@zytor.com> <Pine.LNX.4.58.0504270820370.18901@ppc970.osdl.org>
 <426FD3EE.5000404@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 27 21:04:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQrpl-0000ap-4o
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 21:04:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbVD0TJl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 15:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261971AbVD0TJi
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 15:09:38 -0400
Received: from fire.osdl.org ([65.172.181.4]:57270 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261969AbVD0TJJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 15:09:09 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3RJ95s4004826
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 27 Apr 2005 12:09:05 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3RJ949p002580;
	Wed, 27 Apr 2005 12:09:04 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <426FD3EE.5000404@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 27 Apr 2005, H. Peter Anvin wrote:
> 
> That's true for email addresses, but the point was to distinguish links 
> to other git objects from any other kind of text.

No, that's definitely _not_ the point.

I repeat: git does not do any free-form parsin AT ALL. The links are in 
well-defined places, and you do not ever search for them. And that's 
really very very important.

> Currently there is no  such delimiter for that.

There absolutely is.

For a "commit", the format is

 - first line is exactly 46 bytes: five bytes of "tree ", 40 bytes of hex 
   sha1, and one byte of "\n".

   NOTHING ELSE. Not extra spaces at the end, not extra spaces at the 
   beginning or the middle. It's ASCII, but it's not free-format ASCII.

 - the next <n> (where 'n' can be 0 or more) lines are _exactly_ 48 bytes
   each:  seven bytes of "parent ", 40 bytes of hex sha1, and one byte of 
   "\n".

   NOTHING ELSE.

 - the next lines are "author " and "committer ". They have well-defined 
   delimters for their fields, and no sha1's. The fields cannot contain 
   '<', '>' or newlines, since those are the field/line delimeters.

There is no free-format text _anywhere_ that git parses. No room for 
guesses, no room for mistakes, no room for anything half-way questionable.

And fsck actually enforces this. We do _not_ just use "gets()" to read one 
line at a time. We literally verify that the lines are 46/48 bytes long, 
and have the delimeters in the expected places.

Same goes for "tree" and "tag" objects. They all have fixed-format stuff. 
A "tree" entry is always

	"%o <space> %s" \0 [ 20 bytes of sha1 ]

with "%o" being "mode", and "%s" being "path". We don't guess. 

And this really is _important_. Exactly because we name things by the SHA1
hash of the contents, we MUST NOT have flexible formats. Having a format
which allows non-canonical representations (extra spaces etc) would mean
that two trees that were identical would depend on how you happened to
format them.

So there's really two issues:
 - we don't guess or parse contents. We have strict rules, and that makes 
   git more reliable. There are no gray areas. There's "right" and there 
   is "wrong", and the right one works, and the wrong one gets flagged as 
   being wrong and the tools refuse to touch it.
 - there is only _one_ right way to do things, and that means that the 
   the content is well-defined, and thus the SHA1 of the content is 
   well-defined.

For example, another rule is that a "tree" object is always sorted by 
the bytes in the filename (not by entry, btw: a directory called "foo" 
will sort as "foo/", even though the _entry_ only shows "foo"). That rule 
not only makes a lot of operations faster, but again, it means that there 
is only _one_ way to represent a tree validly.

IOW, you _cannot_ represent a tree any other way (and I've been too lazy
to check this in fsck, but it's alway sbeen my plan), and that is exactly 
why we can just compare the hashes of the results - because there is no 
random component of "layout" in the contents.

This really is important. It means that if you get to the same two tree
contents in totally unrelated ways (you unpack a tar-file and encode it in
git, or you have 5 years of git history and check it out), the "tree" will
match _exactly_. There's no history. There's no "optional" stuff. Since
the contents of the trees are the same, the SHA1 of the two trees will be
the same. Exactly because git refuses to touch any free-format stuff.

		Linus

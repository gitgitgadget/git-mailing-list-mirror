From: "Brian O'Mahoney" <omb@khandalf.com>
Subject: The git repo format
Date: Wed, 27 Apr 2005 21:47:04 +0200
Message-ID: <426FEC38.1060507@khandalf.com>
References: <426F2671.1080105@zytor.com>
    <Pine.LNX.4.58.0504270820370.18901@ppc970.osdl.org>
    <426FD3EE.5000404@zytor.com>
    <Pine.LNX.4.58.0504271154470.18901@ppc970.osdl.org>
Reply-To: omb@bluewin.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 27 21:43:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQsPW-0006Tt-27
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 21:41:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbVD0Tqt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 15:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261983AbVD0Tqt
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 15:46:49 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:9198 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S261981AbVD0Tqj (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 15:46:39 -0400
Received: from khandalf.com (80-218-57-125.dclient.hispeed.ch [80.218.57.125])
	(authenticated bits=0)
	by smtp.hispeed.ch (8.12.6/8.12.6/tornado-1.0) with ESMTP id j3RJkbdE003772
	for <git@vger.kernel.org.>; Wed, 27 Apr 2005 21:46:37 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by
    teraflex.teraflex-research.com (8.12.10/8.12.10/SuSE Linux 0.7) with ESMTP
    id j3RJl7Mr021462 for <git@vger.kernel.org>; Wed, 27 Apr 2005 21:47:09
    +0200
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
In-Reply-To: <Pine.LNX.4.58.0504271154470.18901@ppc970.osdl.org>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
X-Md5-Body: c244a13e51b8700b3575ccede9897781
X-Transmit-Date: Wednesday, 27 Apr 2005 21:47:14 +0200
X-Message-Uid: 0000b49cec9d61680000000200000000426fec420005e032000000010008d704
Replyto: omb@bluewin.ch
X-Sender-Postmaster: Postmaster@80-218-57-125.dclient.hispeed.ch.
X-Virus-Scanned: ClamAV version 0.83, clamav-milter version 0.83 on smtp-02.tornado.cablecom.ch
X-Virus-Status: Clean
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

In understanding how to work with 'git' I had a number of initial
difficulties which are mostly covered by the e-mail from Linus below.

Most of these are already covered in the README:

for objects, ie blob, commit, tag, tree: inflate, then
<type>\s<size>\0<data>

where <data> is in the form, described by Linus below

when you look at them closely, all the formats are simple,
un-ambiguous, and very easy to parse.

The index is also easy to parse, but there is a detail,
after the 3-int header the records are padded to a multiple
of 8 bytes. The detail is in cache.h.

Maybe the README needs to re-inforce this.

Brian

> I repeat: git does not do any free-form parsin AT ALL.
========================================================

 The links are in well-defined places, and you do not ever search for them.

And that's really very very important.


> For a "commit", the format is
> 
>  - first line is exactly 46 bytes: five bytes of "tree ", 40 bytes of hex 
>    sha1, and one byte of "\n".
> 
>    NOTHING ELSE. Not extra spaces at the end, not extra spaces at the 
>    beginning or the middle. It's ASCII, but it's not free-format ASCII.
> 
>  - the next <n> (where 'n' can be 0 or more) lines are _exactly_ 48 bytes
>    each:  seven bytes of "parent ", 40 bytes of hex sha1, and one byte of 
>    "\n".
> 
>    NOTHING ELSE.
> 
>  - the next lines are "author " and "committer ". They have well-defined 
>    delimters for their fields, and no sha1's. The fields cannot contain 
>    '<', '>' or newlines, since those are the field/line delimeters.
> 
> There is no free-format text _anywhere_ that git parses. No room for 
> guesses, no room for mistakes, no room for anything half-way questionable.
> 
> And fsck actually enforces this. We do _not_ just use "gets()" to read one 
> line at a time. We literally verify that the lines are 46/48 bytes long, 
> and have the delimeters in the expected places.
> 
> Same goes for "tree" and "tag" objects. They all have fixed-format stuff. 
> A "tree" entry is always
> 
> 	"%o <space> %s" \0 [ 20 bytes of sha1 ]
> 
> with "%o" being "mode", and "%s" being "path". We don't guess. 
> 
> And this really is _important_. Exactly because we name things by the SHA1
> hash of the contents, we MUST NOT have flexible formats. Having a format
> which allows non-canonical representations (extra spaces etc) would mean
> that two trees that were identical would depend on how you happened to
> format them.
> 
> So there's really two issues:
>  - we don't guess or parse contents. We have strict rules, and that makes 
>    git more reliable. There are no gray areas. There's "right" and there 
>    is "wrong", and the right one works, and the wrong one gets flagged as 
>    being wrong and the tools refuse to touch it.
>  - there is only _one_ right way to do things, and that means that the 
>    the content is well-defined, and thus the SHA1 of the content is 
>    well-defined.
> 
> For example, another rule is that a "tree" object is always sorted by 
> the bytes in the filename (not by entry, btw: a directory called "foo" 
> will sort as "foo/", even though the _entry_ only shows "foo"). That rule 
> not only makes a lot of operations faster, but again, it means that there 
> is only _one_ way to represent a tree validly.
> 
> IOW, you _cannot_ represent a tree any other way (and I've been too lazy
> to check this in fsck, but it's alway sbeen my plan), and that is exactly 
> why we can just compare the hashes of the results - because there is no 
> random component of "layout" in the contents.
> 
> This really is important. It means that if you get to the same two tree
> contents in totally unrelated ways (you unpack a tar-file and encode it in
> git, or you have 5 years of git history and check it out), the "tree" will
> match _exactly_. There's no history. There's no "optional" stuff. Since
> the contents of the trees are the same, the SHA1 of the two trees will be
> the same. Exactly because git refuses to touch any free-format stuff.


From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git annotate runs out of memory
Date: Tue, 11 Dec 2007 11:42:01 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712111122400.25032@woody.linux-foundation.org>
References: <4aca3dc20712110933i636342fbifb15171d3e3cafb3@mail.gmail.com>  <alpine.LFD.0.9999.0712111018540.25032@woody.linux-foundation.org> <4aca3dc20712111109y5d74a292rf29be6308932393c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Daniel Berlin <dberlin@dberlin.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 20:42:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2B0I-0002ra-OY
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 20:42:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752538AbXLKTme (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 14:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752736AbXLKTmd
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 14:42:33 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:38122 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752111AbXLKTmc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Dec 2007 14:42:32 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBBJg1l5024424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 11 Dec 2007 11:42:02 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBBJg1C3005724;
	Tue, 11 Dec 2007 11:42:01 -0800
In-Reply-To: <4aca3dc20712111109y5d74a292rf29be6308932393c@mail.gmail.com>
X-Spam-Status: No, hits=-2.716 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67921>



On Tue, 11 Dec 2007, Daniel Berlin wrote:
>
> I understand this, and completely agree with you.
> However, I cannot force GCC people to adopt completely new workflow in
> this regard.

Oh, I agree. It's why we do have "git blame" these days, and it's why I've 
tried to make people use the nicer incremental mode, which is not at all 
faster, but it's a hell of a lot more pleasant to use because you get some 
output immediately.

In other words,

	git blame gcc/ChangeLog

is virtually useless because it's too expensive, but try doing

	git gui blame gcc ChangeLog

instead, and doesn't that just seem nicer? (*)

The difference is that the GUI one does it incrementally, and doesn't have 
to get _all_ the results before it can start reporting blame.

Not that I claim that the gui blame is perfect either (I dunno why it 
delays the nice coloring so long, for example), but it was something I 
pushed - and others made the gui for - exactly to help people with the 
fact that git interally really does it that incremental way.

> SVN had the same problem (the file retrieval was the most expensive op
> on FSFS). One of the things i did to speed it up tremendously was to
> do the annotate from newest to oldest (IE in reverse), and stop
> annotating when we had come up with annotate info for all the lines.

We do that. The expense for git is that we don't do the revisions as a 
single file at all. We'll look through each commit, check whether the 
"gcc" directory changed, if it did, we'll go into it, and check whether 
the "ChangeLog" file changed - and if it did, we'll actually diff it 
against the previous version.

> In GCC history, it is likely you will be able to cut off at least 30%
> of the time if you do this, because files often have changed entirely
> multiple times.

Not gcc/ChangeLog, though (apart from the renames that happen 
occasionally).

Btw, an example of something git *should* do right, but is just too damn 
expensive, is doing

	git gui blame gcc/ChangeLog-2000

and have it actually be able to track the original source of each of those 
annotations across that "ChangeLog split from hell". 

I bet it would eventually get it right, but that's a large file, way back 
in history, and it will try to do a non-whitespace blame with copy 
detection.

That's *expensive*, although it is an amusing thing to try to do ;)

			Linus

PS. I also do agree that we seem to use an excessive amount of memory 
there. As to whether it's the same issue or not, I'd not go as far as Nico 
and say "yes" yet. But it's interesting.

It's not entirely surprising that we see multiple issues with the gcc 
repo, simply because it's not the kind of repo that people have ever 
really worked on. So I don't think it's necessarily related at all, except 
in the sense of it being a different load and showing issues.

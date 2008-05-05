From: Steven Grimm <koreth@midwinter.com>
Subject: Re: merge renamed files/directories?
Date: Mon, 5 May 2008 16:07:57 -0700
Message-ID: <ADDE27A8-6329-4C09-BC07-8EB023BA6D48@midwinter.com>
References: <4819CF50.2020509@tikalk.com> <481D52CC.1030503@tikalk.com> <32541b130805050940x1297e907ofc67ee65494897eb@mail.gmail.com> <200805052349.35867.robin.rosenberg.lists@dewire.com> <alpine.LFD.1.10.0805051512060.32269@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Ittay Dror <ittayd@tikalk.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue May 06 01:08:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jt9ne-0003sL-Oy
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 01:08:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752424AbYEEXIA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 19:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752380AbYEEXH7
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 19:07:59 -0400
Received: from tater.midwinter.com ([216.32.86.90]:55716 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751747AbYEEXH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 19:07:59 -0400
Received: (qmail 11514 invoked from network); 5 May 2008 23:07:58 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=gq0pK9V0xUrca9Kxv+Y9xzavQet41CuRwYkXaUUrKXusBJLauebf3+oBIV0GTCIg  ;
Received: from localhost (HELO ?IPv6:::1?) (127.0.0.1)
  by localhost with SMTP; 5 May 2008 23:07:58 -0000
In-Reply-To: <alpine.LFD.1.10.0805051512060.32269@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81314>

On May 5, 2008, at 3:20 PM, Linus Torvalds wrote:
> I really don't understand why people expect a directory rename to be
> handled automatically, when it is (a) not that common and (b) not  
> obvious
> what the solution is, but MOST OF ALL (c) so damn _easy_ to handle it
> manually after-the-fact when you notice that something doesn't  
> compile!

Assuming all you track with git is source code that has dependencies  
such that a compile command fails cleanly when things end up in the  
wrong directory, sure.

If you're using git to, say, track a tree of documentation files or  
images that are referred to using relative URLs in HTML pages,  
detecting the breakage is less trivial unless you have a really solid  
automated QA process that can check for dangling references.

Are directory renames as common as file renames? Certainly not. But  
they happen often enough that it's annoying to have to manually clean  
up after them. Note that I did not say it is difficult or impossible  
to manually clean up after them. I think the number of people who've  
mentioned this on the list should stand as some kind of refutation of  
the idea that directory renames are so vanishingly rare as to not be  
worth mentioning. I've run into the problem a few times myself.

> and "Tadaa! All done". Your merge that was *fundamentally  
> impossible* to
> do automatically, was trivially done manually, with no actual big
> head-scratiching involved.

$ mkdir parent
$ cd parent
$ hg init
$ mkdir subdir1
$ echo "I am the walrus" > subdir1/file1
$ hg add subdir1/file1
$ hg commit -m 'initial commit'
$ cd ..
$ hg clone parent child
$ cd child
$ hg mv subdir1 subdir2
$ hg commit -m 'rename subdir1 to subdir2'
$ cd ../parent
$ echo 'I love prunes' > subdir1/file2
$ hg add subdir1/file2
$ hg commit -m 'new file in subdir'
$ cd ../child
$ hg pull
$ hg merge
$ ls subdir2
file1   file2

Doesn't seem *fundamentally* impossible to produce the results that  
are most likely to be what people want. (Which doesn't equal  
"guaranteed to be 100% correct 100% of the time or your money back" --  
as you say, merging is an inexact science.)

-Steve

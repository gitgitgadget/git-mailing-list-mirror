From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: git on Cygwin: Not a valid object name HEAD
Date: Wed, 8 Aug 2007 00:46:49 +0200
Message-ID: <A80CCC35-DE1E-4A0B-9144-A8165AF6C98A@zib.de>
References: <f99cem$4a4$1@sea.gmane.org> <Pine.LNX.4.64.0708071257350.14781@racer.site> <f99nm6$9vi$1@sea.gmane.org> <f99rei$ou$1@sea.gmane.org> <20070807143616.GO9527@spearce.org> <20070807145825.GO21692@lavos.net> <66DD7425-6073-4CA8-BF01-BF07213A4804@zib.de> <30e4a070708071042g5623cb7ak724a8b8e588bd1da@mail.gmail.com> <07BB2580-4406-496F-8ACE-F6A03D1687BE@zib.de> <alpine.LFD.0.999.0708071439021.5037@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mark Levedahl <mlevedahl@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Sebastian Schuberth <sschuberth@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Aug 08 00:47:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIXpJ-0003YG-0W
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 00:46:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759489AbXHGWqn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 18:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759314AbXHGWqm
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 18:46:42 -0400
Received: from mailer.zib.de ([130.73.108.11]:65354 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760285AbXHGWqk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 18:46:40 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l77Mk8fK023546;
	Wed, 8 Aug 2007 00:46:08 +0200 (CEST)
Received: from [192.168.178.32] ([77.177.245.91])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l77Mk2bN000778
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 8 Aug 2007 00:46:03 +0200 (MEST)
In-Reply-To: <alpine.LFD.0.999.0708071439021.5037@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55280>


On Aug 7, 2007, at 11:44 PM, Linus Torvalds wrote:

>
>
> On Tue, 7 Aug 2007, Steffen Prohaska wrote:
>>
>> Is there any chance that patches would be accepted that try to
>> do so? Even if they add "b" to fopen and O_BINARY to open, which
>> both are useless on Unix?
>
> I certainly don't think it would be wrong to add O_BINARY to the  
> open()
> parameters (and "b" to fopen() and friends), if it makes a difference.
>
> Add a
>
> 	#ifndef O_BINARY
> 	#define O_BINARY 0
> 	#endif
>
> and it should be harmless anywhere else.
>
> So if you're willing to test, and extend on this, maybe something like
> this gets you started (I think the main issue will be the object  
> files,
> no?)

I took a more radical approach and used a small script to add
"b" to all calls to fopen and O_BINARY to all calls to open.
O_BINARY is provided by the Makefile if not on cygwin. I don't
think we need to differentiate between binary and textfiles.
I'll send the patch shortly.


I started to run the tests on cygwin in textmode. I chose the
following setup.

- cygwin is set to binmode, that is cygwin's git is working.

- I used git to cloned git to a Windows directory, say c:\git
   and compiled there. The Windows directory is mounted in binmode.

- For testing I 'mount' this directory in text mode, in my example

     cd /
     mkdir git-textmode
     mount --text 'c:\git' git-textmode

This setup allows you to work with git and test in the same
working directory in textmode. You should double check in which
of your directories you commit. Right now, committing in the
textmode directory is only for the brave ones.
'git read-tree HEAD' in the binmode directory should help if
you executed the wrong git in the wrong directory and your index
got corrupted.


The first problems I ran into are pre-computed sha1's for the
test cases. I started to add d2u to the test scripts to generate
files with unix style line endings even if cygwin is in textmode.
This is needed to match the expected results that come with
the test files. I'll send the first changes in a second patch.
The patch is only for illustrating the problem. It's not thought
to be applied.

The tests are running. t0000-basic and t0010-racy-git pass. I'll
send a testlog later. It's running inside a virtual machine on a
laptop, so it may take some more time.

I suspect the tests will report a lot of errors. At least all
tests that compare 'echo' output with precomputed sha1's or
expected results that come with the tests should fail. I haven't
fully understood the details of line conversion of cygwin. Some
work may be needed to eliminate false fails from the tests, e.g. by
adding 'd2u', and find the real problems.

I have no time to continue today.

	Steffen

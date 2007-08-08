From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: git on Cygwin: Not a valid object name HEAD
Date: Wed, 8 Aug 2007 07:46:18 +0200
Message-ID: <11631546-D4E4-491A-8A12-98A42043C535@zib.de>
References: <Pine.LNX.4.64.0708071257350.14781@racer.site> <f99nm6$9vi$1@sea.gmane.org> <f99rei$ou$1@sea.gmane.org> <20070807143616.GO9527@spearce.org> <20070807145825.GO21692@lavos.net> <66DD7425-6073-4CA8-BF01-BF07213A4804@zib.de> <30e4a070708071042g5623cb7ak724a8b8e588bd1da@mail.gmail.com> <07BB2580-4406-496F-8ACE-F6A03D1687BE@zib.de> <alpine.LFD.0.999.0708071439021.5037@woody.linux-foundation.org> <A80CCC35-DE1E-4A0B-9144-A8165AF6C98A@zib.de> <20070808042513.GP21692@lavos.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Sebastian Schuberth <sschuberth@gmail.com>
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Wed Aug 08 07:47:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIeO1-0000dB-4d
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 07:47:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbXHHFrF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 01:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbXHHFrE
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 01:47:04 -0400
Received: from mailer.zib.de ([130.73.108.11]:37656 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750768AbXHHFrD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 01:47:03 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l785jd8a005213;
	Wed, 8 Aug 2007 07:45:39 +0200 (CEST)
Received: from [192.168.178.32] ([77.177.245.231])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l785jX5t019965
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 8 Aug 2007 07:45:33 +0200 (MEST)
In-Reply-To: <20070808042513.GP21692@lavos.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55302>


On Aug 8, 2007, at 6:25 AM, Brian Downing wrote:

> On Wed, Aug 08, 2007 at 12:46:49AM +0200, Steffen Prohaska wrote:
>> I started to run the tests on cygwin in textmode. I chose the
>> following setup.
>
> In addition to all the other stuff discussed, I believe you also need
> to worry about the binaryness of stdin and stdout.
>
> Looking at:
>
> http://www.cygwin.com/cygwin-ug-net/using-textbinary.html
>
> I think this can be achieved by putting something like:
>
> 	setmode(0, O_BINARY);
> 	setmode(1, O_BINARY);
>
> at the start of git's main().

I agree. This is my understanding as well.

> When I was trying to get this to work, I did this as well as fixing up
> open() and fopen() calls as has already been discussed.  What got me
> to quit, however, was that I never found a decent way to make the Git
> shell scripts binary safe, and enough of the system was in shell as to
> make it pretty much useless for everyday use.

Did you find a way, maybe not as decent as you wished?


> Looking at the examples on the above page:
>
>     To illustrate the various rules, we provide scripts to delete  
> CRs from
>     files by using the tr program, which can only write to standard  
> output.
>     The script
>
>     #!/bin/sh
>     # Remove \r from the file given as argument
>     tr -d '\r' < "$1" > "$1".nocr
>
>     will not work on a text mounted systems because the \r will be
>     reintroduced on writing. However scripts such as
>
>     #!/bin/sh
>     # Remove \r from the file given as argument
>     tr -d '\r' | gzip | gunzip > "$1".nocr
>
>     work fine. In the first case (assuming the pipes are binary) we  
> rely
>     on gunzip to set its output to binary mode, possibly overriding  
> the
>     mode used by the shell.
>
> was all it took to convince me this was probably a fool's errand.

Yeah, it looks quite crazy. I started to search for an
option that would force the shell to provide redirection
in binary mode, overriding the standard rules. I found
the igncr option [1], which is not what I need. But
apparently there have been some efforts to deal with
line endings in bash beyond the cygwin standard rules.
Maybe there's a useful option that I haven't found yet.

[1] http://cygwin.com/ml/cygwin-announce/2007-01/msg00015.html


> I wound up fixing our software so it would build on a binary mount,
> which I decided was a much more sane solution.

Well, our software already builds and I was not even aware
that there is a problem with git on cygwin until I asked
more people to test it. I naively chose the default option
because I didn't have a reason to do otherwise. But
apparently there is an option, and people use this option.

My fear is that the first impression of git is too bad on
Windows if it can't handle textmode. I can't recommend it.
People will make me responsible for recommending them a
tool that only cause troubles or forces them to reconfigure
their cygwin, which worked for them for years. I even
remember that we had a policy to explicitly set cygwin
to textmode to avoid problems with cvs commits in combination
with Visual Studio 6.

	Steffen

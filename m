From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT] maven build fails on OS X
Date: Fri, 6 Feb 2009 21:54:34 +0100
Message-ID: <200902062154.34997.robin.rosenberg.lists@dewire.com>
References: <320075ff0902060708m5ec566b9g755829c25c7727d8@mail.gmail.com> <20090206153155.GL26880@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Nigel Magnay <nigel.magnay@gmail.com>, Git ML <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Feb 06 21:56:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVXkE-00071m-7A
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 21:56:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753308AbZBFUyn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 15:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752698AbZBFUyn
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 15:54:43 -0500
Received: from mail.dewire.com ([83.140.172.130]:11340 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752530AbZBFUym (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 15:54:42 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id E1326147E89E;
	Fri,  6 Feb 2009 21:54:36 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id szTgLiKdBtzf; Fri,  6 Feb 2009 21:54:35 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id A4AC1147E896;
	Fri,  6 Feb 2009 21:54:35 +0100 (CET)
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; i686; ; )
In-Reply-To: <20090206153155.GL26880@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108783>

fredag 06 februari 2009 16:31:55 skrev Shawn O. Pearce:
> Nigel Magnay <nigel.magnay@gmail.com> wrote:
> > I don't know if this is known about - I get failures running the m2
> > build for jgit:
> 
> Yup.
>  
> > Failed tests:
> >   testParse_implicit_mixed_encoded(org.spearce.jgit.revwalk.RevCommitParseTest)
> >   testParse_explicit_bad_encoded(org.spearce.jgit.revwalk.RevCommitParseTest)
> >   testParse_implicit_mixed_encoded(org.spearce.jgit.revwalk.RevTagParseTest)
> >   testParse_explicit_bad_encoded(org.spearce.jgit.revwalk.RevTagParseTest)
> >   testDequote_OctalAll(org.spearce.jgit.util.QuotedStringGitPathStyleTest)
> >   testDequote_Latin1(org.spearce.jgit.util.QuotedStringGitPathStyleTest)
> >   testDequote_RawLatin1(org.spearce.jgit.util.QuotedStringGitPathStyleTest)
> >   testGetText_DiffCc(org.spearce.jgit.patch.GetTextTest)
> > 
> > Curiously, the tests work in eclipse and from ./make_jgit.sh - I
> > suspect some environment setting with the mac's charset.
> 
> make_jgit.sh doesn't run tests.  But Eclipse does, and as you state,
> I have also seen these pass in Eclipse but fail from m2.
> 
> What's even more curious is look at the surefire report files for
> these tests.  The actual result looks correct, the expected result
> looks wrong.  I think m2 miscompiled the Java sources for the tests
> somehow and produced incorrect literal strings which are used for
> the expected values in the tests.
> 
> I don't see these failures on Linux, from either Eclipse or Maven.

One thing to suspect could be the better-than-everybody-else decomposed
unicode causing our tests to decompose too. I don't have a Mac so Ic
cannot test my hypothesis myself, but consider

	testDequote_RawLatin1(org.spearce.jgit.util.QuotedStringGitPathStyleTest)

Here we intend to feed the dequote an ISO-Latin encoded string. Our decoder
will first try to decode it as UTF-8, which should fail, then we try to decode it
as the platform default (Linear A, Hieroglyphs, MacRoman or something not
known to living mankind). A problem is that Git *forces* us to guess the encoding,
and in some situations you'd need human intelligence to figure it out. Software
with a little more hindsight recognize this and declare UTF-8 to be the one
and only encoding. JGit always encodes things as UTF-8 for this reason, but
we cannot trust the input. These test cases are supposed to prove that we
can guess things correctly at least some of the time.. Using "platform
default" may be the wrong thing if it does not match what a C Git user on
this platform would encounter. 

Sorry about the long explanation, but I didn't have the time to write a short
one.

-- robin



> 
> > I can try and fix it if it's new, but I wanted to check first..
> 
> I've looked at it and gave up.  I don't know what Maven is doing here
> on the Mac.  Maybe fresh eyes will have a better chance at fixing it.
> 
> My experience with Maven is it works about 5% of the time, and the
> other 95% of the time you have to work around it by skipping tests,
> or by writing massive blocks of XML in your pom.xml file, or by
> redesigning your entire project directory structure and revision
> control system to use SVN instead of Git.
> 

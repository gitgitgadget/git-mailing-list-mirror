From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Mon, 21 Jan 2008 17:13:48 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801211702050.2957@woody.linux-foundation.org>
References: <478E1FED.5010801@web.de> <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org> <Pine.LNX.4.64.0801211509490.17095! @ds9.cixit.se> <440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org> <alpine.LFD.1.00.0801! 210934400.2957@woody.linux-foundation.org>
 <C6C0E6A1-053B-48CE-90B3-8FFB44061C3B@sb.org> <alpine.LFD.1.00.08! 01211129130.2957@woody.linux-foundation.org> <373E260A-6786-4932-956A-68706AA7C469@sb.org> <alpine.LFD.1.00.! 0801211210270.2957@woody.linux-foundation.org> <7EB98659-4036-45DA-BD50-42CB23ED517A@sb.org>
 <alpine.LFD.1.0! 0.0801211323120.2957@woody.linux-foundation.org> <C373E12A-2AC4-4961-833A-7D51584143C9@sb.org> <alpine.LFD.1.00.0! 801211407130.2957@woody.linux-foundation.org> <0CA4DF3F-1B64-4F62-8794-6F82C21BD068@sb.org>
 <alpine.LFD.1.00.0801211538590.2957@woody.linux-foundation.org> <F663E088-BCAD-4C5D-89D5-EAF97A29C1DE@sb.org> <alpine.LFD.1.00.0801211656130.2957@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Tue Jan 22 02:14:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH7iq-0003Xb-O3
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 02:14:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753928AbYAVBOA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 20:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753981AbYAVBN7
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 20:13:59 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:55453 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752356AbYAVBN7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 20:13:59 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0M1Dnnt008032
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 21 Jan 2008 17:13:50 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0M1Dmlx029462;
	Mon, 21 Jan 2008 17:13:48 -0800
In-Reply-To: <alpine.LFD.1.00.0801211656130.2957@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.722 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71392>



On Mon, 21 Jan 2008, Linus Torvalds wrote:
> 
> Think about the file name "Abc", and think about what happens when you 
> create it.
> 
> Now, think about what happens if that filename is considered equivalent in 
> case..
> 
> See? The filesystem has to *corrupt* the filename.

Let me make this really clear, because I'm afraid that you won't get it 
when I leave out any steps of the way.

Let us say that there is a filename "xyz" that is equivalent to a filename 
"abc" in *any* way. It does not matter if xyz/abc is Hello/hello, or 
whether it's two canonically equivalent strings.

So now, do

	close(open(xyz, O_WRONLY | O_CREAT, 0666));
	close(open(abc, O_WRONLY | O_CREAT, 0666));

and then look at the directory contents afterwards.

There are two, and only two, choices here (*):
 - the filesystem created both files, and they show up as created
 - the filesystem decided they were equivalent, and munged one (or both) 
   of them

Now, let's go back to my claim:
 - munging user data is unacceptable
and realize that equivalence BY DEFINITION must do it.

So no, you do *not* get to have your cake and eat it too. You simply 
fundamentally *cannot* have both filename equivalence and a non-munging 
filesystem. See above why.

		Linus

(*) Actually, there is third choice above, which is:

 - the filesystem created the first file, and errored out on the second 
   because it noticed it was equivalent - but not identical - to one it 
   already had

   This one is actually a perfectly fine choice, but it's not "your" kind 
   of equivalence, since it actually makes a difference between two 
   equivalent but non-identical names. So the filenames aren't actually 
   interchangable, and this case is really more of a "the filesystem has 
   some very specific limitations on what it allows".

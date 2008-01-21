From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Mon, 21 Jan 2008 15:15:30 -0500
Message-ID: <20080121201530.GF29792@mit.edu>
References: <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org> <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org> <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se> <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org> <Pine.LNX.4.64.0801211509490.17095!@ds9.cixit.se> <440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org> <alpine.LFD.1.00.0801210934400.2957@woody.linux-foundation.org> <C6C0E6A1-053B-48CE-90B3-8FFB44061C3B@sb.org> <20080121195703.GE29792@mit.edu> <998717B0-0165-4383-AAB8-33BD2A49954E@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 21:17:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH34t-0002I9-5N
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 21:17:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752614AbYAUUQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 15:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752545AbYAUUQg
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 15:16:36 -0500
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:48460 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752576AbYAUUQf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 15:16:35 -0500
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m0LKFWPx018930;
	Mon, 21 Jan 2008 15:15:32 -0500 (EST)
Received: from closure.thunk.org (c-76-19-244-124.hsd1.ma.comcast.net [76.19.244.124])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m0LKFUPv021164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 21 Jan 2008 15:15:31 -0500 (EST)
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@mit.edu>)
	id 1JH33K-0007ig-Mu; Mon, 21 Jan 2008 15:15:30 -0500
Content-Disposition: inline
In-Reply-To: <998717B0-0165-4383-AAB8-33BD2A49954E@sb.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71325>

On Mon, Jan 21, 2008 at 03:01:43PM -0500, Kevin Ballard wrote:
>
> You seem to be under the impression that I'm advocating that git treat all 
> filenames as unicode strings, and thus change its hashing algorithm as 
> described. I am not. I am saying that, if git only had to deal with HFS+, 
> then it could treat all filenames as strings, etc. However, since git does 
> not only have to deal with HFS+, this will not work. What I am describing 
> is an ideal, not a practicality.

Well, why are you arguing on the git list about precisely that (when
you reponsed to Linus), then?

> In other words, what I'm saying is that treating filenames as strings works 
> perfectly fine, *provided you can do that 100% of the time*. git cannot do 
> that 100% of the time, therefore it's not appropriate here. The purpose of 
> this argument is to illustrate that treating filenames as strings isn't 
> wrong, it's simply incompatible with treating filenames as byte sequences.

No, it's still broken, because of the Unicode-is-not-static problem.
What happens when you start adding more composable characters, which
some future version of HFS+ will start breaking apart? 

Presumably the whole *reason* why HFS+ was corrupting strings was so
that "stupid applications" that only did byte comparisons would work
correctly.  But when you upgrade from Mac OS 10.5 to 10.6, and it adds
support for new composable characters, and you now take a USB hard
drive that was hooked up to a MacBook Air, running one version of
MacOS, and hook it up to another Macintosh, running another version of
MacOS, the normalization algorithm will be different, so the byte
comparisons won't work.  

So all of this extra work which MacOS put in to corrupt filenames
behind our back doesn't actually do any good; applications still need
to be smart, or there will be rare, hard to reproduce bugs
nevertheless.  So if MacOS wants to supply Unicode libraries that
compare strings keeping in mind Unicode "equivalences" it can be our
guest (although how they deal with different versions of Unicode with
different equivalence classes will be their cross to bear).  BUT MacOS
X SHOULD NOT BE CORRUPTING FILENAMES.  TO DO SO IS BROKEN.

Even Microsoft got this right; its filesystem is case-preserving, but
it has case-insensitive lookups.  Hence, it is not corrupting
filenames behind the application's back, unlike MacOS.

						- Ted

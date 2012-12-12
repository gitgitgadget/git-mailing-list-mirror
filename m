From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Tue, 11 Dec 2012 22:11:09 -0700
Message-ID: <50C811ED.4000600@workspacewhiz.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com> <CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com> <50B1F684.5020805@alum.mit.edu> <CACsJy8BgOpWdxgCfwBwZ=abAEDr+sbj3hnmKY2EYCFeBPRUT7w@mail.gmail.com> <CACh33FrGPhaeNzZ2Tj5OxScecOPN13idw8TwU8Mf6o0KsAOB9A@mail.gmail.com> <CAMK1S_hy8U0rVY=-u-QCqXjhn-6jwz5ofj_q_mbokVn8CGCMtw@mail.gmail.com> <20121212033043.GA24937@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Patrick Donnelly <batrick@batbytes.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Wed Dec 12 06:11:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiebR-0003rt-FO
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 06:11:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862Ab2LLFLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 00:11:12 -0500
Received: from hsmail.qwknetllc.com ([208.71.137.138]:52958 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790Ab2LLFLL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 00:11:11 -0500
Received: (qmail 27163 invoked by uid 399); 11 Dec 2012 22:11:09 -0700
Received: from unknown (HELO SlamDunk) (jjensen@workspacewhiz.com@76.23.33.208)
  by hsmail.qwknetllc.com with ESMTPAM; 11 Dec 2012 22:11:09 -0700
X-Originating-IP: 76.23.33.208
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <20121212033043.GA24937@thyrsus.com>
X-Antivirus: avast! (VPS 121211-1, 12/11/2012), Outbound message
X-Antivirus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211326>

----- Original Message -----
From: Eric S. Raymond
Date: 12/11/2012 8:30 PM
> It might be a good fit for extending git; I wouldn't be very surprised if
> that worked. However, I do have concerns about the "Oh, we'll just
> lash together a binding to C" attitude common among lua programmers; I
> foresee maintainability problems and the possibility of slow death by
> low-level details as that strategy tries to scale up.
I don't understand this statement: "Oh, we'll just lash together a 
binding to C" attitude.

??
> My sense is that git's use cases are better served by a glue language
> in the Python/Perl/Ruby class rather than an extension langage. But
> my mind is open on this issue.
I spend nearly 100% of my Git time on Windows.

Spawning new processes in Windows is dog slow.  Using 'git rebase', 
arguably my favorite Git command, is time-waiting torture.  I'm also on 
about as fast of a Windows machine as money can buy these days.

I have a Git add-on similar to git-media that uses the smudge and clean 
filters to read/write large binary files into a separate storage 
location.  When checking out a workspace, Git shells out to run a filter 
for each file it needs to write to the workspace.

I can get a maximum of 100 processes per second with this technique, 
resulting in just 100 files being written to disk.  However, I tend to 
see closer to 60 files written to disk.

So, I patched Git to allow the smudge/clean filters to load up a DLL 
that executes a Lua script.  The Lua script properly retrieves+caches a 
file locally, or it puts the file on a network share.

The in-process DLL checkout ends up being every bit as fast as when we 
use Perforce to sync files to our local workspace.  Git, then, can be a 
Perforce replacement for our needs.

(For those who don't know, Perforce handles large workspaces with 
massive binary files very efficiently.)

Anyway, my preference is to allow scripts to run in-process within Git, 
because it is far, far faster on Windows.  I imagine it is faster than 
forking processes on non-Windows machines, too, but I have no statistics 
to back that up.

Python, Perl, or Ruby can be embedded, too, but Lua probably embeds the 
easiest and smallest out of those other 3 languages.

And shell scripts tend to be the slowest on Windows due to the excessive 
numbers of process invocations needed to get anything reasonable done.

-Josh

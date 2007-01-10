From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: How git affects kernel.org performance
Date: Wed, 10 Jan 2007 14:20:49 +1100
Message-ID: <1168399249.2585.6.camel@nigel.suspend2.net>
References: <1168140954.2153.1.camel@nigel.suspend2.net>
	 <45A08269.4050504@zytor.com> <45A083F2.5000000@zytor.com>
	 <Pine.LNX.4.64.0701062130260.3661@woody.osdl.org>
	 <20070107085526.GR24090@1wt.eu> <20070107011542.3496bc76.akpm@osdl.org>
	 <20070108030555.GA7289@in.ibm.com> <20070108125819.GA32756@thunk.org>
	 <368329554.17014@ustc.edu.cn>
	 <Pine.LNX.4.64.0701090821550.3661@woody.osdl.org>
	 <20070110015739.GA26978@mail.ustc.edu.cn>
Reply-To: nigel@nigel.suspend2.net
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, Theodore Tso <tytso@mit.edu>,
	Suparna Bhattacharya <suparna@in.ibm.com>,
	Andrew Morton <akpm@osdl.org>, Willy Tarreau <w@1wt.eu>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org,
	"J.H." <warthog9@kernel.org>,
	Randy Dunlap <randy.dunlap@oracle.com>,
	Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	webmaster@kernel.org,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 10 04:21:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4U1K-0006rU-Bd
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 04:20:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932696AbXAJDUx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 22:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932700AbXAJDUx
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 22:20:53 -0500
Received: from nigel.suspend2.net ([203.171.70.205]:44177 "EHLO
	nigel.suspend2.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932696AbXAJDUw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 22:20:52 -0500
Received: from [127.0.0.1] (nigel.suspend2.net [127.0.0.1])
	by nigel.suspend2.net (Postfix) with ESMTP id 1F676E82E4;
	Wed, 10 Jan 2007 14:20:50 +1100 (EST)
To: Fengguang Wu <fengguang.wu@gmail.com>
In-Reply-To: <20070110015739.GA26978@mail.ustc.edu.cn>
X-Mailer: Evolution 2.8.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36474>

Hi.

On Wed, 2007-01-10 at 09:57 +0800, Fengguang Wu wrote:
> On Tue, Jan 09, 2007 at 08:23:32AM -0800, Linus Torvalds wrote:
> >
> >
> > On Tue, 9 Jan 2007, Fengguang Wu wrote:
> > > >
> > > > The fastest and probably most important thing to add is some readahead
> > > > smarts to directories --- both to the htree and non-htree cases.  If
> > >
> > > Here's is a quick hack to practice the directory readahead idea.
> > > Comments are welcome, it's a freshman's work :)
> >
> > Well, I'd probably have done it differently, but more important is whether
> > this actually makes a difference performance-wise. Have you benchmarked it
> > at all?
> 
> Yes, a trivial test shows a marginal improvement, on a minimal debian system:
> 
> # find / | wc -l
> 13641
> 
> # time find / > /dev/null
> 
> real    0m10.000s
> user    0m0.210s
> sys     0m4.370s
> 
> # time find / > /dev/null
> 
> real    0m9.890s
> user    0m0.160s
> sys     0m3.270s
> 
> > Doing an
> >
> > 	echo 3 > /proc/sys/vm/drop_caches
> >
> > is your friend for testing things like this, to force cold-cache
> > behaviour..
> 
> Thanks, I'll work out numbers on large/concurrent dir accesses soon.

I gave it a try, and I'm afraid the results weren't pretty.

I did:

time find /usr/src | wc -l

on current git with (3 times) and without (5 times) the patch, and got

with:
real   54.306, 54.327, 53.742s
usr    0.324, 0.284, 0.234s
sys    2.432, 2.484, 2.592s

without:
real   24.413, 24.616, 24.080s
usr    0.208, 0.316, 0.312s
sys:   2.496, 2.440, 2.540s

Subsequent runs without dropping caches did give a significant
improvement in both cases (1.821/.188/1.632 is one result I wrote with
the patch applied).

Regards,

Nigel

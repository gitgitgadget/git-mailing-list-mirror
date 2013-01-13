From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH 0/8] Initial support for Python 3
Date: Sun, 13 Jan 2013 11:40:45 -0500
Message-ID: <20130113164045.GA30371@padd.com>
References: <cover.1358018078.git.john@keeping.me.uk>
 <20130112234304.GC23079@padd.com>
 <20130113004129.GH4574@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Eric S. Raymond" <esr@thyrsus.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sebastian Morr <sebastian@morr.cc>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Jan 13 17:41:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuQcP-0007no-FY
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 17:41:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755385Ab3AMQkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2013 11:40:49 -0500
Received: from honk.padd.com ([74.3.171.149]:44652 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755090Ab3AMQkt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 11:40:49 -0500
Received: from arf.padd.com (50-52-235-227.drr01.drhm.nc.frontiernet.net [50.52.235.227])
	by honk.padd.com (Postfix) with ESMTPSA id DBE742F3F;
	Sun, 13 Jan 2013 08:40:47 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 3078A28EBE; Sun, 13 Jan 2013 11:40:45 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20130113004129.GH4574@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213386>

john@keeping.me.uk wrote on Sun, 13 Jan 2013 00:41 +0000:
> On Sat, Jan 12, 2013 at 06:43:04PM -0500, Pete Wyckoff wrote:
> > Can you give me some hints about the byte/unicode string issues
> > in git-p4.py?  There's really only one place that does:
> > 
> >     p4 = subprocess.Popen("p4 -G ...")
> >     marshal.load(p4.stdout)
> > 
> > If that's the only issue, this might not be too paniful.
> 
> The problem is that what gets loaded there is a dictionary (encoded by
> p4) that maps byte strings to byte strings, so all of the accesses to
> that dictionary need to either:
> 
>    1) explicitly call encode() on a string constant
> or 2) use a byte string constant with a "b" prefix
> 
> Or we could re-write the dictionary once, which handles the keys... but
> some of the values are also used as strings and we can't handle that as
> a one-off conversion since in other places we really do want the byte
> string (think content of binary files).
> 
> Basically a thorough audit of all access to variables that come from p4
> would be needed, with explicit decode()s for authors, dates, etc.

Your auto-conversion snippet in the follow-up mail would work
fine for most keys and values.  A few perforce docs and some
playing around convince me that it is mostly utf-8, except for
file data for particular types.

I'd still rather handle each command separately, and think about
the conversions, to do it right in the long run.

> > I hesitated to take Sebastian's changes due to the huge number of
> > print() lines, but maybe a 2to3 approach would make that aspect
> > of python3 support not too onerous.
> 
> I think we'd want to change to print() eventually and having a single
> codebase for 2 and 3 would be nicer for development, but I think we need
> to be able to say "no one is using Python 2.5 or earlier" before we can
> do that and I'm not sure we're there yet.  From where we are at the
> moment I think 2to3 is a good answer, particularly where we're already
> using distutils to generate a release image.

Agreed.  The 2to3 diff is large but straightforward.  But these
p4 -G interface errors require a lot of thought and work.  I'm
not too eager to work on this yet.

Thanks.

		-- Pete

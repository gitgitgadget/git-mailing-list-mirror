From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH] git-remote-testgit: fix race when spawning fast-import
Date: Sat, 21 Apr 2012 22:16:08 -0400
Message-ID: <20120422021608.GA11892@padd.com>
References: <20120415105943.GD6263@ecki>
 <4F8AAE7C.1020507@gmail.com>
 <20120415114518.GB9338@ecki>
 <4F8AB7F1.1020705@gmail.com>
 <20120415125140.GA15933@ecki>
 <20120419233445.GA20790@padd.com>
 <4F9145A1.6020201@gmail.com>
 <20120421201524.GA18419@padd.com>
 <20120421234555.GA11808@padd.com>
 <20120421234211.GC20473@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sun Apr 22 04:16:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLmM5-00038G-UJ
	for gcvg-git-2@plane.gmane.org; Sun, 22 Apr 2012 04:16:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752434Ab2DVCQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Apr 2012 22:16:12 -0400
Received: from honk.padd.com ([74.3.171.149]:60897 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751683Ab2DVCQM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2012 22:16:12 -0400
Received: from arf.padd.com (unknown [50.55.145.32])
	by honk.padd.com (Postfix) with ESMTPSA id 2E774E8E;
	Sat, 21 Apr 2012 19:16:11 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id DD3F8313E3; Sat, 21 Apr 2012 22:16:08 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20120421234211.GC20473@ecki>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196068>

drizzd@aon.at wrote on Sun, 22 Apr 2012 01:42 +0200:
> On Sat, Apr 21, 2012 at 07:45:55PM -0400, Pete Wyckoff wrote:
> >
> > @@ -258,6 +264,7 @@ def main(args):
> >  
> >      more = True
> >  
> > +    sys.stdin = os.fdopen(sys.stdin.fileno(), 'r', 0)
> >      while (more):
> >          more = read_one_line(repo)
> 
> There's another read in do_import(). I am not sure if it also suffers
> from this race condition, but it certainly has the potential.

It just takes one reopen of stdin for the whole program.  So that
one is handled automatically too.

> > +test_expect_success 'racily pushing to local repo' '
> > +	cp -a server server2 &&
> > +	git clone "testgit::${PWD}/server2" localclone2 &&
> > +	test_when_finished "rm -rf server2 localclone2" &&
> > +	(cd localclone2 &&
> > +	echo content >>file &&
> > +	git commit -a -m three &&
> > +	GIT_REMOTE_TESTGIT_SLEEPY=2 git push) &&
> > +	compare_refs localclone2 HEAD server2 HEAD
> > +'
> 
> Should this test be running unconditionally? It will delay the otherwise
> almost instant test by 2 seconds.

More like 6 seconds, in fact, for all three interactions in "git
push".  I'll change the test to add a prereq on TOOSLOW; is there
a better way to leave a test in to document the issue, but have
it skipped?

		-- Pete

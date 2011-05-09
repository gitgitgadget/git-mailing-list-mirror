From: Pete Wyckoff <pw@padd.com>
Subject: Re: [RFC v1] git-p4: test case for RCS keyword problem
Date: Mon, 9 May 2011 19:00:34 -0400
Message-ID: <20110509230034.GC1716@arf.padd.com>
References: <1304927397-24614-1-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Horowitz <michael.horowitz@ieee.org>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Tue May 10 01:00:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJZRT-0002pq-Fy
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 01:00:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755252Ab1EIXAi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 19:00:38 -0400
Received: from honk.padd.com ([74.3.171.149]:60712 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752871Ab1EIXAh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 19:00:37 -0400
Received: from arf.padd.com (unknown [50.52.168.230])
	by honk.padd.com (Postfix) with ESMTPSA id 1337820B7;
	Mon,  9 May 2011 16:00:37 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id D4ED35AA98; Mon,  9 May 2011 19:00:34 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1304927397-24614-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173283>

luke@diamand.org wrote on Mon, 09 May 2011 08:49 +0100:
> This is following on from some earlier threads about RCS keywords
> and git-p4:
> 
> http://marc.info/?l=git&m=122145837226632&w=2
> http://marc.info/?l=git&m=130470278328964&w=2

I hadn't read Mike's mail.  Not that deep into my backlog yet.

> The problem is that git-p4 imports into git with RCS keywords
> unexpanded (e.g. as $Id$), which is certainly the right thing
> to do given how nasty RCS keywords are.
> 
> However, when it comes to try to apply your changes, it
> applies them against a checked-out p4 tree, where the RCS keywords
> *are* expanded. This then fails if in git you modify any lines
> that contain RCS keywords (i.e. deleting them, or deleting the
> entire file).
> 
> You would think you could just tell p4 to not expand RCS keywords
> in your client view, but sadly that option doesn't exist :-(

One idea.  I snuck in a2b665d "convert filter: supply path to
external driver" that lets you do:

    git config filter.p4.clean git-p4-filter --clean %f
    git config filter.p4.smudge git-p4-filter --smudge %f
    echo "*.c filter=p4" >> .gitattributes

Then your git tree can have expanded keywords too.  The script to
clean is pretty easy; to smudge you have to ask p4 for the
information using fstat and filelog.  My script is pretty nasty
and full of dependencies, but I could clean it up if you think
this is a good way to go.

We'd need to discover text+k files at clone and sync time
and maintain the .gitattributes accordingly.  Filtering all
files would be wrong, and slow.

Dhruva's approach has the downside of always including RCS lines
in every commit when the file changes in p4.

> This isn't a fix, it's just a test case that shows the problem,
> and doesn't even try to test the whole-file deletion case.
> 
> I'm hoping someone will suggest a good way to handle this.
> 
> Otherwise, I've got a possible scheme that involves spotting the
> failure to apply the patch, patching up RCS keywords in the
> p4 client shadow and then trying again. It's not pretty but it seems
> like it ought to work. My current version doesn't handle deletion,
> and zaps *all* RCS keywords rather than just the ones zapped in git;
> more work is needed before I can submit it.

I'm a little hazy on how you would identify a patch failure as
due to an RCS keyword, but maybe it's possible.  The deleted line
case is surely hard.

Curious what you think of switching to having expanded keywords
in the repo, but using smudge/clean instead.

Maybe hang onto this test case until we figure out how we want
to deal with it.

		-- Pete

From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH] Fix git p4 sync errors
Date: Sun, 28 Oct 2012 11:06:23 -0400
Message-ID: <20121028150623.GA9249@padd.com>
References: <AC43C2B4-623F-4590-9F92-6CCA26645EFE@gmail.com>
 <7vwqyjfxwd.fsf@alter.siamese.dyndns.org>
 <F0F92B0A-D37F-40D4-A0DF-43EEDA2818B9@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Luke Diamand <luke@diamand.org>
To: Matt Arsenault <arsenm2@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 28 16:06:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSURj-00046Y-UK
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 16:06:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752637Ab2J1PG1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2012 11:06:27 -0400
Received: from honk.padd.com ([74.3.171.149]:58102 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752402Ab2J1PG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2012 11:06:27 -0400
Received: from arf.padd.com (unknown [50.55.148.232])
	by honk.padd.com (Postfix) with ESMTPSA id 43C35D02;
	Sun, 28 Oct 2012 08:06:26 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 09C0C22714; Sun, 28 Oct 2012 11:06:23 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <F0F92B0A-D37F-40D4-A0DF-43EEDA2818B9@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208548>

arsenm2@gmail.com wrote on Wed, 24 Oct 2012 19:41 -0700:
> 
> On Oct 21, 2012, at 12:06 , Junio C Hamano <gitster@pobox.com> wrote:
> > 
> >> 
> >> This solves errors in some cases when syncing renamed files.
> > 
> > Can you be a bit more descriptive?  What are "errors in some case"?
> > 
> It might just be when files are renamed. I ran into this after months of using it, and I'm skeptical that in that time no files were ever renamed. I'm not sure what was special about the file that was renamed. (There also might have been deleted files in the same commit, not sure if that matters)

I set up a test case where I did a "p4 move" on a file and tried
syncing it, with and without "-s" to describe.  It works in both
cases, for an old (2009.2) and new (2012.1) version of p4.

The output of -s versus no -s does differ, and the differences
are different with server version worse yet.  But in no case is
there ever a set of file differences.  -G does seem to disable
that.

I'd love to track this down, but can't seem to provoke anything
on my own.  Let me know if you have any hints based on what is in
your depot or server/client config.  Or if you see it again.

> > In short, what I am getting at are:
> > 
> > - What breaks by not passing "-s"?  What are the user visible
> >   symptoms?
> 
> There's a key error on the line
> line 2198:        epoch = details["time"]
> The details object is an error different fields set (I don't remember what it is exactly, I'm not at work right now)

This would happen if describe did not return a "time" field, but
there's an explicit check for that:

        res = p4CmdList("describe -s %d" % newestRevision)
        newestTime = None   
        for r in res:       
            if r.has_key('time'):
                newestTime = int(r['time'])
        if newestTime is None:
            die("Output from \"describe -s\" on newest change %d did not give a time" %                     
                newestRevision) 
        details["time"] = newestTime

so I'm confused how this could happen.  Maybe your version is
older/different than what is in the git source?


I'm not against putting in your patch, since it is true we don't
want the file diff, and adding "-s" should be harmless in theory.
And it doesn't cause any existing tests to fail.  It just scares
me that there's something else going on we haven't figured out.

		-- Pete

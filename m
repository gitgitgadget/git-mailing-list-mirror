From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH v2 7/8] git-p4: decode p4 wildcard characters
Date: Thu, 24 Feb 2011 07:12:10 -0500
Message-ID: <20110224121210.GA16475@arf.padd.com>
References: <1298121481-7005-1-git-send-email-pw@padd.com>
 <1298121481-7005-8-git-send-email-pw@padd.com>
 <7vbp25hsk6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tor Arvid Lund <torarvid@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 13:12:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Psa3T-0007Y8-Hx
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 13:12:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752397Ab1BXMMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 07:12:15 -0500
Received: from honk.padd.com ([74.3.171.149]:52585 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752074Ab1BXMMO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 07:12:14 -0500
Received: from arf.padd.com (pool-71-111-208-86.rlghnc.dsl-w.verizon.net [71.111.208.86])
	by honk.padd.com (Postfix) with ESMTPSA id B1DA820B3;
	Thu, 24 Feb 2011 04:12:13 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 3814C31A5B; Thu, 24 Feb 2011 07:12:10 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vbp25hsk6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167801>

gitster@pobox.com wrote on Mon, 21 Feb 2011 15:32 -0800:
> Pete Wyckoff <pw@padd.com> writes:
> 
> > There are four wildcard characters in p4.  Files with these
> > characters can be added to p4 repos using the "-f" option.
> > They are stored in %xx notation, and when checked out, p4
> > converts them back to normal.
> >
> > This patch does the same thing when importing into git,
> > converting the four special characters.  Without this change,
> > the files appear with literal %xx in their names.
> >
> > Be careful not to produce "*" in filenames on windows.  That
> > will fail.
> 
> > +    # P4 wildcards are not allowed in filenames.  P4 complains
> > +    # if you simply add them, but you can force it with "-f", in
> > +    # which case it translates them into %xx encoding internally.
> > +    # Search for and fix just these four characters.  Do % last so
> > +    # that fixing it does not inadvertently create new %-escapes.
> > +    #
> > +    def wildcard_decode(self, path):
> > +        # Cannot have * in a filename in windows; untested as to
> > +        # what p4 would do in such a case.
> > +        if not self.isWindows:
> > +            path = path.replace("%2A", "*")
> 
> I'll queue the patch as-is, but perhaps we can ask for help from people
> who have access to P4 on both non-Windows and Windows to run a small test
> to determine what happens in the native client?
> 
>  1. On a non-Windows client, add a path with '*' in it to the depot;
>     perhaps "p4 add" might fail at this point, in which case we don't
>     need to worry about this issue at all.
>  
>  2. Create a p4 client on Windows against that depot, and sync it; unless
>     the previous step failed, we will see what happens (I would imagine it
>     either dies or mangles the pathname and warns), so that we have
>     something to emulate.
> 
> and then the quoted part can be further refined in a separate patch later.

I tried this myself in a VM when Tor Arvid pointed out the
problem with Windows:

http://article.gmane.org/gmane.comp.version-control.git/166374

1.  "*" is acceptable in filenames, but users must use "p4 add -f"
    to indicate that they really want that wildcard character in
    the filename.

2.  Windows clients fail to create the file in "p4 sync".  The
    error is:

    open for write: c:\Documents and Settings\Administrator\Desktop\file*star:
    The filename, directory name, or volume label syntax is incorrect.

The behavior for git-p4 I chose is to sync the file but leave
the name with its encoded %2A.  If we think it is better to
duplicate p4's failure, we can simply try to create the file
and let the OS produce the same error message.

		-- Pete

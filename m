From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH v2] git-p4: Ask "p4" to interpret View setting
Date: Sat, 10 Aug 2013 16:11:23 -0400
Message-ID: <20130810201123.GA31706@padd.com>
References: <CACGba4zdA=3tBE9UR=i9P9kNAL1HUc3UwSHbYeq4s9fwaN4=Mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: kazuki saitoh <ksaitoh560@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 10 22:11:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8FVc-000266-6F
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 22:11:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758718Ab3HJUL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Aug 2013 16:11:28 -0400
Received: from honk.padd.com ([74.3.171.149]:49967 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754567Ab3HJUL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Aug 2013 16:11:27 -0400
Received: from arf.padd.com (unknown [50.105.10.190])
	by honk.padd.com (Postfix) with ESMTPSA id B6A372B8F;
	Sat, 10 Aug 2013 13:11:26 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id E99B122792; Sat, 10 Aug 2013 16:11:23 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CACGba4zdA=3tBE9UR=i9P9kNAL1HUc3UwSHbYeq4s9fwaN4=Mw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232109>

ksaitoh560@gmail.com wrote on Tue, 06 Aug 2013 15:45 +0900:
> In Perforce, View setting of p4 client can describe
>   -//depot/project/files/*.xls //client/project/files/*.xls
> to exclude Excel files.
> But "git p4 --use-client-spec" cannot support '*'.
> 
> In git-p4.py, "map_in_client" method analyzes View setting and return
> client file path.
> So I modify the method to just ask p4.
> 
> 
> > Let me play with this for a bit.  I wonder about the performance
> > aspects of doing a "p4 fstat" for every file.  Would it be
> > possible to do one or a few batch queries higher up somewhere?
> To reduce p4 access, it cache result of asking "client path".
> And addition, "fstat" depends on sync status, so modify to use "p4
> where" instead of "fstat".

I played around with your patch a bit, ending up with this
teensy series.

I redid the code to use clientFile, not path, as that
will work better with AltRoots.  Also I simplified your
test and added a couple more for the now-supported wildcards.
And deleted a bunch of newly dead code.

My only concern is in the commit message, about performance.  A
change that has lots of files in it will cause many roundtrips to
p4d to do "p4 where" on each.  When the files don't have much
edited content, this new approach will make the import take twice
as long, I'll guess.  Do you have a big repository where you
could test that?

Tell me what you think.

		-- Pete

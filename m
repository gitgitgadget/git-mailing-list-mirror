From: John Keeping <john@keeping.me.uk>
Subject: Re: Using clean/smudge filters with difftool
Date: Thu, 18 Jun 2015 23:39:27 +0100
Message-ID: <20150618223927.GP18226@serenity.lan>
References: <5582BA1F.1030409@drmicha.warpmail.net>
 <CAGA3++LrVSs3rMkg=S2Og48pz1yEBxwpcRsPt7sNLENRh1ooAg@mail.gmail.com>
 <20150618132622.GJ18226@serenity.lan>
 <CAGA3+++_mx=O=Un0pip8Q41X5PZBLmES=Hd=U=aSowryx5r=8w@mail.gmail.com>
 <20150618141116.GK18226@serenity.lan>
 <CAGA3+++ibw=8Q1LtM6yJrZ7Q4eVs_MEHmPAzctSVSREXMmBiMQ@mail.gmail.com>
 <20150618142852.GL18226@serenity.lan>
 <CAGA3+++LqZ8Qv6tpuoqQwi37kO5LLODwcbFQtvneorjiV4KARw@mail.gmail.com>
 <20150618160133.GO18226@serenity.lan>
 <xmqqsi9oeqhn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Florian Aspart <florian.aspart@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 00:39:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5iTL-0007PZ-F7
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 00:39:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751708AbbFRWjn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 18:39:43 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:34368 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001AbbFRWjm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 18:39:42 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 5A027CDA5AE;
	Thu, 18 Jun 2015 23:39:41 +0100 (BST)
X-Quarantine-ID: <ghWvRzcGoSWi>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ghWvRzcGoSWi; Thu, 18 Jun 2015 23:39:40 +0100 (BST)
Received: from serenity.lan (griffin.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id EFEB6CDA5A6;
	Thu, 18 Jun 2015 23:39:29 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <xmqqsi9oeqhn.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272090>

On Thu, Jun 18, 2015 at 01:00:36PM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > I think this is a difference between git-diff's internal and external
> > diff modes which is working correctly, although possibly not desirably
> > in this case.  The internal diff always uses clean files (so it runs the
> > working tree file through the "clean" filter before applying the diff
> > algorithm) but the external diff uses the working tree file so it
> > applies the "smudge" filter to any blobs that it needs to checkout.
> >
> > Commit 4e218f5 (Smudge the files fed to external diff and textconv,
> > 2009-03-21) was the source of this behaviour.
> 
> The fundamental design to use smudged version when interacting with
> external programs actually predates that particular commit, I think.
> 
> The caller of the function that was updated by that commit, i.e.
> prepare_temp_file(), reuses what is checked out to the working tree
> when we can (i.e. it hasn't been modified from what we think is
> checked out) and when it is beneficial to do so (i.e. on a system
> with FAST_WORKING_DIRECTORY defined), which means the temporary file
> given by the prepare_temp_file() that is used by the external tools
> (both --ext-diff program and textconv filter) are designed to be fed
> and work on the smudged version of the file.  4e218f5 did not change
> that fundamental design; it just made things more consistent between
> the case where we do create a new temporary file out of blob and we
> allow an unmodified checked out file to be reused.

When I started looking at this, I assumed the problem would be that
git-difftool wasn't smudging the non-working-tree files.  But actually
everything is working "correctly", I'm just not sure it's always what
the user wants (at least it isn't what was wanted in this case).

Currently, the behaviour is:

	internal diff: compare clean files
	external diff: compare smudged files

This makes sense for LF/CRLF conversion, where platform-specific tools
clearly want the platform's line ending but the internal diff machinery
doesn't care.

However, from the filter description in an earlier email, I think
Florian is using a clean filter to remove output from IPython notebook
files (it seems that IPython saves both the input and the output in the
same file [1] and the output is the equivalent of, for example, C object
files).  In this case, the filter is one-way and discards information
from the working tree file, producing a smaller and more readable diff
in the process.

I think the summary is that there are some scenarios where the external
diff tool should see the smudged version and others where the clean
version is more appropriate and Git should support both options.  It
seems this is a property of the filter, so I wonder if the best solution
is a new "filter.<name>.extdiff = [clean|smudge]" configuration
variable (there's probably a better name for the variable than
"extdiff").


[1] http://pascalbugnion.net/blog/ipython-notebooks-and-git.html

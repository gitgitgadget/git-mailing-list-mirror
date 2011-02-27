From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH v2 7/8] git-p4: decode p4 wildcard characters
Date: Sun, 27 Feb 2011 16:16:22 -0500
Message-ID: <20110227211622.GA15075@arf.padd.com>
References: <1298121481-7005-1-git-send-email-pw@padd.com>
 <1298121481-7005-8-git-send-email-pw@padd.com>
 <7vbp25hsk6.fsf@alter.siamese.dyndns.org>
 <20110224121210.GA16475@arf.padd.com>
 <AANLkTik=KWwszN9ETOh11btPvcPXCcoA=evT4Fgxt-Fm@mail.gmail.com>
 <7voc612xns.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tor Arvid Lund <torarvid@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 27 22:16:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ptnyr-0007RO-N8
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 22:16:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751895Ab1B0VQf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Feb 2011 16:16:35 -0500
Received: from honk.padd.com ([74.3.171.149]:39835 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751643Ab1B0VQc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Feb 2011 16:16:32 -0500
Received: from arf.padd.com (pool-71-111-208-86.rlghnc.dsl-w.verizon.net [71.111.208.86])
	by honk.padd.com (Postfix) with ESMTPSA id 27DAE20BE;
	Sun, 27 Feb 2011 13:16:29 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id C981B5A96D; Sun, 27 Feb 2011 16:16:22 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7voc612xns.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168054>

gitster@pobox.com wrote on Thu, 24 Feb 2011 08:40 -0800:
> Tor Arvid Lund <torarvid@gmail.com> writes:
> 
> > On Thu, Feb 24, 2011 at 1:12 PM, Pete Wyckoff <pw@padd.com> wrote:
> > ...
> > Yeah, I was thinking... what happens now if we do:
> >
> > 1) Create "my*file" in linux, and submit.
> > 2) git-p4 sync from windows, and get my%2Afile on windows.
> > 3) modify my%2Afile and do git commit.
> > 4) git-p4 submit
> >
> > I haven't had time to test right now, but maybe p4 will not recognise
> > my%2Afile (or try to check it in as my%252Afile (replacing the '%'
> > character) or something like that? (Or maybe I just haven't had enough
> > coffee today :-/ )
> 
> This shares the same issue as "checking files out on case insensitive
> filesystems" topic in the other thread.  "my*file" may not be usable by
> the project when renamed to "my%2Afile", so "git-p4 sync" may want to warn
> the user about the path when this happens.
> 
> And you need to reverse this quoting upon "git-p4 submit".  Does that
> happen already?

I have not found any testers to try these things on windows.

We have a separate bug in git-p4 for submitting files with
wildcards, windows or unix.  This could be fixed anytime in
a separate patch; any takers?

Another unrelated p4-linux-only bug is this:

    arf$ echo hello > my%file
    arf$ p4 add -f my%file
    //depot/my%25file#1 - opened for add
    arf$ p4 submit -d 'add my file'
    Submitting change 1.
    Locking 1 files ...
    add //depot/my%25file#1
    Change 1 submitted.
    arf$ p4 sync
    File(s) up-to-date.
    arf$ p4 open my%file
    my%file - file(s) not on client.
    arf$ p4 open my%25file
    //depot/my%25file#1 - opened for edit

I can create and add my%file, but cannot edit or delete it.  The
"-f" option does not help.  It can be edited/deleted using the %25
expansion.  I found this same problem on Windows.

Conclusion:  p4 is buggy and incomplete with respect to wildcard
characters in filenames already.  This particular change does not make
anything worse, and fixes a problem seen in the wild for a filename with
"@".  I'd like to hope p4 gets fixed at which point this % issue goes
away, and we can decide what to do with * on windows, following their
lead.

		-- Pete

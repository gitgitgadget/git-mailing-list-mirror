From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH] Git-p4: git-p4.changeOnSubmit to do 'change' instead of
 'submit'.
Date: Mon, 17 Oct 2011 18:32:02 -0400
Message-ID: <20111017223202.GA1834@arf.padd.com>
References: <83923897.7841.1318868319131.JavaMail.root@zimbra-prod-mbox-2.vmware.com>
 <4E9C799E.70700@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andrei Warkentin <andreiw@vmware.com>,
	Tor Arvid Lund <torarvid@gmail.com>,
	Luke Diamand <luke@diamand.org>, gitster@pobox.com
To: Andrei Warkentin <awarkentin@vmware.com>
X-From: git-owner@vger.kernel.org Tue Oct 18 00:32:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFvjE-0001HT-O1
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 00:32:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756397Ab1JQWcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 18:32:09 -0400
Received: from honk.padd.com ([74.3.171.149]:43278 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753879Ab1JQWcH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 18:32:07 -0400
Received: from arf.padd.com (unknown [50.55.131.180])
	by honk.padd.com (Postfix) with ESMTPSA id 69F7D5AFA;
	Mon, 17 Oct 2011 15:32:06 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 8DCE131567; Mon, 17 Oct 2011 18:32:02 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <4E9C799E.70700@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183836>

luke@diamand.org wrote on Mon, 17 Oct 2011 19:53 +0100:
> On 17/10/11 17:18, Andrei Warkentin wrote:
> >Hi,
> >
> >----- Original Message -----
> >Anyway, the other suggestion I had was to create a new command
> >instead of overriding behaviour of an existing one. Of course,
> >copy-pasting P4Submit into P4Change is silly, so...
> >
> >How about something like this?
> >
> >The commands dict maps command name to class and optional dict passed to cmd.run(). That way 'change'
> >can really mean P4Submit with an extra parameter not to submit but to do a changelist instead. The
> >reason why I initially made the config flag was because I didn't want to copy-paste P4Submit into P4Change.
> >
> >commands = {
> >     "debug" : [ P4Debug, {} ]
> >     "submit" : [ P4Submit, { "doChange" : 0 } ]
> >     "commit" : [ P4Submit, { "doChange" : 0 } ]
> >     "change" : [ P4Submit, { "doChange" : 1 } ]
> >     "sync" : [ P4Sync, {} ],
> >     "rebase" : [ P4Rebase, {} ],
> >     "clone" : [ P4Clone, {} ],
> >     "rollback" : [ P4RollBack, {} ],
> >     "branches" : [ P4Branches, {} ]
> >}
> >
> >Thanks for the review,
> >A
> >
> 
> Sounds plausible to me. The alternative would be a command line
> parameter, although that could get annoying and error prone,
> especially as you can't easily unsubmit a perforce change.

This seems like a useful thing to do, but needs some care.

Git can have multiple commits outstanding that touch the same
file, but p4 cannot really have multiple pending changes in the
same workspace that touch the same file.

If you call "git-p4 change", it would build a p4 change for each
of those commits.  If the commits happen to touch the same file,
the changes get rearranged as far as p4 is concerned so that all
changes to a given file are lumped in the first change that sees
the file.  This is highly counterintuitive from a git mindset.

The most restrictive implementation would have to:

    1.  ensure no pending changes in the P4 clientPath
    2.  ensure number of commits ("git rev-list") is 1

You could be more permissive, allowing multiple pending changes
if the file sets do not conflict.  In that case, the first test
would look at the files in pending changes and allow the
operation if they did not intersect with files in origin..master.
The second would make sure that each file appears in no more than
1 commit in origin..master.

Also make sure this works with preserveUser.  Not sure if an
unsubmitted change can be handled the same way.

Because it feels like a delicate operation that could have big
negative consequences, this needs a few unit tests.

For the code structure, I'd like to see a proper subclass instead
of the dictionary idea.  Something like, e.g.:

class P4Submit(...):
    def __init__(self, change_only=0)
	...
	self.change_only = change_only

class P4Change(P4Submit):
    def __init__(self):
	P4Submit.__init__(self, change_only=1)

Sorry this is looking so difficult now.

		-- Pete

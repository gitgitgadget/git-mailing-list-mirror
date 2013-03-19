From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH] git-p4: support exclusively locked files
Date: Tue, 19 Mar 2013 15:23:12 -0400
Message-ID: <20130319192312.GA16872@padd.com>
References: <20130317200437.GA29115@padd.com>
 <CD6CC10C.1DE4E%danny.thomas@blackboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Danny Thomas <Danny.Thomas@blackboard.com>
X-From: git-owner@vger.kernel.org Tue Mar 19 20:21:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UI25z-0000jC-1H
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 20:21:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155Ab3CSTUr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 15:20:47 -0400
Received: from honk.padd.com ([74.3.171.149]:51920 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754586Ab3CSTUq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 15:20:46 -0400
Received: from tic.padd.com (unknown [216.115.121.27])
	by honk.padd.com (Postfix) with ESMTPSA id 22E6DE9A;
	Tue, 19 Mar 2013 12:20:45 -0700 (PDT)
Received: by tic.padd.com (Postfix, from userid 1000)
	id 4FC6710071F; Tue, 19 Mar 2013 15:23:12 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CD6CC10C.1DE4E%danny.thomas@blackboard.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218550>

Danny.Thomas@blackboard.com wrote on Mon, 18 Mar 2013 09:26 -0400:
> Interesting. 'Implementing sitewide pessimistic locking with p4 typemap',
> http://www.perforce.com/perforce/doc.current/manuals/p4sag/03_superuser.htm
> l seems to suggest this is all that's needed. I believe we're using the
> default configuration, the exclusive lock on all files behaviour was
> researching the exclusive locking problem,
> http://ericlathrop.com/2012/12/how-to-set-up-git-p4-in-windows/, so I
> thought I'd mention it.
> 
> You might be onto something w/ fstat, it doesn't include the exclusive
> indicator:
> 
> ... type binary+l
> 
> Latest P4 client, and fairly recent server build:
> 
> P4/DARWIN90X86_64/2012.2/536738 (2012/10/16)
> P4D/LINUX26X86_64/2012.2/538478 (2012/10/16)

Great, thanks for the pointer and explanation.  Do you want to
reroll your patch to use fstat?  I'll work on the tests, and
also look into potential failure modes of "git p4 submit" when somebody
else has the exclusive file open.

		-- Pete

> On 17/03/2013 20:04, "Pete Wyckoff" <pw@padd.com> wrote:
> 
> >Danny.Thomas@blackboard.com wrote on Wed, 13 Mar 2013 13:51 -0400:
> >> By default, newly added binary files are exclusively locked by Perforce:
> >>
> >> 'add default change (binary+l) *exclusive*'
> >>
> >> This results in a 'Could not determine file type' error as the regex
> >> expects
> >> the line to end after the file type matching group. Some repositories
> >>are
> >> also configured to always require exclusive locks, so may be a problem
> >>for
> >> all revisions in some cases.
> >
> >Can you explain how to configure p4d to default everything to
> >binary+l?  Also, what version are you using ("p4 info")?  I'm
> >trying to write a test case for this.
> >
> >I did find a way to play with typemap to get +l, as:
> >
> >    ( p4 typemap -o ; printf "\tbinary+l\t//.../bash*" ) | p4 typemap -i
> >
> >With this, the 2011.1 here just says:
> >0
> >    tic-git-test$ p4 opened bash
> >    //depot/bash#1 - add default change (binary+l)
> >
> >I've not been able to make it say " *exclusive*" too.
> >
> >>      result = p4_read_pipe(["opened", wildcard_encode(file)])
> >> -    match = re.match(".*\((.+)\)\r?$", result)
> >> +    match = re.match(".*\((.+)\)(?:.+)?\r?$", result)
> >
> >I think this whole function would be less brittle
> >using p4's "-G" output, like:
> >
> >    d = p4Cmd(["fstat", "-T", "type", wildcard_encode(file)])
> >    # some error checking
> >    return d['type']
> >
> >But I'm curious if your p4d includes " *exclusive*" in the
> >type there too, in which case we'll have to strip it.
> >
> >Thanks for starting the patch on this.  It's good if we can keep
> >others from running into the same problem.

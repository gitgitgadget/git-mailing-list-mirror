From: "Bert Huijben" <rhuijben@collab.net>
Subject: RE: [PATCH v2] Add svnrdump
Date: Wed, 14 Jul 2010 21:25:39 +0200
Message-ID: <000101cb238a$5b2bfea0$1183fbe0$@collab.net>
References: <20100709142910.GB20383@debian> <20100713201105.GN13310@ted.stsp.name> <20100714153206.GH25630@jack.stsp.name> <20100714160149.GA7561@debian>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <dev@subversion.apache.org>,
	"'Daniel Shahaf'" <d.s@daniel.shahaf.name>,
	"'Will Palmer'" <wmpalmer@gmail.com>,
	"'David Michael Barr'" <david.barr@cordelta.com>,
	"'Jonathan Nieder'" <jrnieder@gmail.com>,
	"'Sverre Rabbelier'" <srabbelier@gmail.com>,
	"'Git Mailing List'" <git@vger.kernel.org>
To: "'Ramkumar Ramachandra'" <artagnon@gmail.com>,
	"'Stefan Sperling'" <stsp@elego.de>
X-From: git-owner@vger.kernel.org Wed Jul 14 21:26:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ7ap-0002BI-VE
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 21:26:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754264Ab0GNT0D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jul 2010 15:26:03 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:53355 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822Ab0GNT0B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 15:26:01 -0400
Received: by ewy23 with SMTP id 23so28937ewy.19
        for <git@vger.kernel.org>; Wed, 14 Jul 2010 12:25:59 -0700 (PDT)
Received: by 10.213.10.67 with SMTP id o3mr1831887ebo.31.1279135559210;
        Wed, 14 Jul 2010 12:25:59 -0700 (PDT)
Received: from dv7 (haeghehorst.demon.nl [212.238.142.105])
        by mx.google.com with ESMTPS id v59sm737721eeh.16.2010.07.14.12.25.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 Jul 2010 12:25:57 -0700 (PDT)
In-Reply-To: <20100714160149.GA7561@debian>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQHizdjSIJmJn+smtZpiXIOjqwcWaQEyMB2WAc8bKTYA3aikhpJifx7w
Content-Language: nl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151029>



> -----Original Message-----
> From: Ramkumar Ramachandra [mailto:artagnon@gmail.com]
> Sent: woensdag 14 juli 2010 18:02
> To: Stefan Sperling
> Cc: dev@subversion.apache.org; Bert Huijben; Daniel Shahaf; Will Palmer;
> David Michael Barr; Jonathan Nieder; Sverre Rabbelier; Git Mailing List
> Subject: Re: [PATCH v2] Add svnrdump
> 
> Hi Stefan,
> 
> Stefan Sperling writes:
> > Playing with svnrdump and comparing its output to the output of
> > svnadmin dump --deltas, I noticed that:
> 
> Thanks for testing!
> 
> >  - svnrdump doesn't dump revision 0.
> >    It should dump revision 0, because that revision can contain
important
> >    revprops such as metadata for svnsync (svn:sync-last-merge-rev etc.)
> 
> Yeah, I forgot to ask about this: passing 0 as an argument to the
> replay API doesn't seem to work. Why? How do I dump revision 0 then?
> 
> >  - You're missing a couple of fields:
> >    The UUID of the repository.
> >    Text-content-sha1
> >    Text-delta-base-md5
> >    Text-delta-base-sha1
> 
> Yes, I'm aware. Since these fields aren't strictly necessary, I
> decided not to take the extra effort to print them out: you'll notice
> that I'm printing the md5 sum that the server gives me instead of
> calculating anything. SHA1 sum would require /some/ calculation. UUID
> and text-delta-base-md5 aren't a big deal though: I'll fix these
> later.

We added the sha1 field to the format in 1.6, as we have it available in the
fs layer anyway and we might want to prefer it over md5 in later version
(for future proofing the dump format). It's not used by our tools yet and we
don't send the value over the ra layer yet. Without revving the editor layer
it will be pretty hard to calculate it remotely even from the most recent
repositories.

I assume you don't get the SHA1 values when you use a recent svnadmin dump
on an older repository. (Untested statement)

 
> >  - I've seen a "Prop-delta: true" line which svnadmin dump does not
print.
> 
> Correct. `svnadmin dump` has a logic for determining when the prop is
> really a delta (as opposed to a delta against /dev/null). Since
> there's no harm printing extra Prop-delta headers, I decided not to
> implement this logic.

Do you know if this is this something as simple as: 'Is this a new node?' or
if this is some advanced scheme?
> 
> >  - You're missing some newlines that svnadmin dump prints (cosmetic,
> >    but it would be nice if both produced matching output).
> 
> This isn't in the dump-load-format spec document (atleast afaik), and
> it's very hard to get this right (yes, I tried). Moreover, it's very
> ungratifying to have a few extra newlines (reverse engineered from
> `svnadmin dump`) printed at the end of 10+ hrs of work; yes, that's
> what I estimate it'll take to fix this.
> 
> > How to reproduce what I'm seeing:
> >   Use svnsync to get a copy of the numptyphysics repository at
> >     https://vcs.maemo.org/svn/numptyphysics (I had a dump of that lying
> >     around... other repositories might do the job just as well, of
course)
> >   Dump the repository using svnadmin dump --deltas.
> >   Dump the repository using svnrdump.
> >   Compare output with diff -u.
> 
> Right. My validation script (validate.sh in the original repository)
> runs the following filter on the diff and validates if nothing seeps
> through. In other words, I know that these differences exist, and have
> determined that they're safe.
> 
> gawk '$0 !~ "Prop-delta: true|Text-delta-base-|sha1|Text-copy-source-|^-
> $" && $0 ~ "^+|^-" { print; }'

Your mail explains Prop-delta, sha1, but what about these Text-delta-base
and Text-copy-source lines?

	Bert

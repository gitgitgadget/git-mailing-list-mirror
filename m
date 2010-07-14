From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2] Add svnrdump
Date: Wed, 14 Jul 2010 18:01:49 +0200
Message-ID: <20100714160149.GA7561@debian>
References: <20100709142910.GB20383@debian>
 <20100713201105.GN13310@ted.stsp.name>
 <20100714153206.GH25630@jack.stsp.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "dev@subversion.apache.org" <dev@subversion.apache.org>,
	Bert Huijben <rhuijben@collab.net>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Will Palmer <wmpalmer@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Stefan Sperling <stsp@elego.de>
X-From: git-owner@vger.kernel.org Wed Jul 14 18:00:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ4Nf-00056Y-Ij
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 18:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756672Ab0GNQAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jul 2010 12:00:07 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:53148 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754818Ab0GNQAF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 12:00:05 -0400
Received: by eya25 with SMTP id 25so1029291eya.19
        for <git@vger.kernel.org>; Wed, 14 Jul 2010 09:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=VQGU2zQBiudCdt8htJLMgDy0NcD+lGxDERIWOMaVkZc=;
        b=dd+cEIAiTWhIXCuB6eDNDBJXxojwgZvAmv7wYcjV4BvdsVycIhlIvLRFeFm/S097fN
         46QIJrjuh+yTaZKDZ3YboS2QANYAnN/x93UC9uYbSWgteqmcBmzewz6dleXBWeFrY6ew
         N9Rj5ylb8zSVmdI82r5YzGC5V6bbWg7LgJttY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=rN8Usq5isI5v1W6bcxiTC9YDtQYFNuHxxOCL4meKMZXsg/E18Hj5hkP683BFItf8rS
         o1vYTSanXEJ/s+P/ebNh81aTXZIlak0ZIZXPIsnXRhHgYsONQhXLoFYAFBYbaqJ8fnFV
         XwMgXBdUIUNq24IAu6Nld8LmEV9vneUIUqAAk=
Received: by 10.213.33.135 with SMTP id h7mr1573906ebd.56.1279123203169;
        Wed, 14 Jul 2010 09:00:03 -0700 (PDT)
Received: from debian (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id x54sm58329824eeh.5.2010.07.14.09.00.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 Jul 2010 09:00:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100714153206.GH25630@jack.stsp.name>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151001>

Hi Stefan,

Stefan Sperling writes:
> Playing with svnrdump and comparing its output to the output of
> svnadmin dump --deltas, I noticed that:

Thanks for testing!

>  - svnrdump doesn't dump revision 0.
>    It should dump revision 0, because that revision can contain important
>    revprops such as metadata for svnsync (svn:sync-last-merge-rev etc.)

Yeah, I forgot to ask about this: passing 0 as an argument to the
replay API doesn't seem to work. Why? How do I dump revision 0 then?

>  - You're missing a couple of fields:
>    The UUID of the repository.
>    Text-content-sha1
>    Text-delta-base-md5
>    Text-delta-base-sha1

Yes, I'm aware. Since these fields aren't strictly necessary, I
decided not to take the extra effort to print them out: you'll notice
that I'm printing the md5 sum that the server gives me instead of
calculating anything. SHA1 sum would require /some/ calculation. UUID
and text-delta-base-md5 aren't a big deal though: I'll fix these
later.

>  - I've seen a "Prop-delta: true" line which svnadmin dump does not print.

Correct. `svnadmin dump` has a logic for determining when the prop is
really a delta (as opposed to a delta against /dev/null). Since
there's no harm printing extra Prop-delta headers, I decided not to
implement this logic.

>  - You're missing some newlines that svnadmin dump prints (cosmetic,
>    but it would be nice if both produced matching output).

This isn't in the dump-load-format spec document (atleast afaik), and
it's very hard to get this right (yes, I tried). Moreover, it's very
ungratifying to have a few extra newlines (reverse engineered from
`svnadmin dump`) printed at the end of 10+ hrs of work; yes, that's
what I estimate it'll take to fix this.

> How to reproduce what I'm seeing:
>   Use svnsync to get a copy of the numptyphysics repository at
>     https://vcs.maemo.org/svn/numptyphysics (I had a dump of that lying
>     around... other repositories might do the job just as well, of course)
>   Dump the repository using svnadmin dump --deltas.
>   Dump the repository using svnrdump.
>   Compare output with diff -u.

Right. My validation script (validate.sh in the original repository)
runs the following filter on the diff and validates if nothing seeps
through. In other words, I know that these differences exist, and have
determined that they're safe.

gawk '$0 !~ "Prop-delta: true|Text-delta-base-|sha1|Text-copy-source-|^-$" && $0 ~ "^+|^-" { print; }'

> Please get rid of all global variables in svnrdump.c:
> subversion/svnrdump/svnrdump.c:43: warning: declaration of `pool' shadows a glob
> al declaration
> subversion/svnrdump/svnrdump.c:33: warning: shadowed declaration is here
> subversion/svnrdump/svnrdump.c:91: warning: declaration of `pool' shadows a glob
> al declaration
> subversion/svnrdump/svnrdump.c:33: warning: shadowed declaration is here

Will do. I'm waiting for commit access, because I don't want to make
un-versioned edits to the file that I cannot track or revert in
future.

> When adding unit tests for svnrdump, please make each and every one of
> those tests compare with output of svnadmin dump --deltas, so that we
> will keep them in sync.

Right. Please see the current `validate.sh` for an example of the
functionality I'll write into the unit tests.

-- Ram

From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH] check_refname_component: Optimize
Date: Wed, 28 May 2014 19:49:28 -0400
Organization: Twitter
Message-ID: <1401320968.18134.98.camel@stross>
References: <1401311055-480-1-git-send-email-dturner@twitter.com>
	 <1401311055-480-2-git-send-email-dturner@twitter.com>
	 <538658C0.8050001@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	David Turner <dturner@twitter.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu May 29 01:49:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpnbK-0001T6-3X
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 01:49:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754701AbaE1Xtd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 19:49:33 -0400
Received: from mail-qg0-f52.google.com ([209.85.192.52]:49891 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754325AbaE1Xtc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 19:49:32 -0400
Received: by mail-qg0-f52.google.com with SMTP id a108so19646673qge.25
        for <git@vger.kernel.org>; Wed, 28 May 2014 16:49:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=Dow2W1Ebf+n9Uwdbp1EQR+tqlDRRzxuhRdS0YWv8s28=;
        b=PDsJOJJUGBc1IS5OgqZp6x00xOQR4BfEBG+gGnY4+oNn1x86nYs3jXtOlnYNQ0CqXF
         6HL3ahPIarL13mX70D4oF8E9CaOJqMxFd0JgVn+GcwN8cZlLdfuyDnLASS+UYbSWldCM
         6B81Ty5W6wyjF77eT7Z9z4iqjEYUHBj/78+o4Wnpz0n25eBp0zF27T+vza1GOeN15CFL
         JRoPSlp9LfaZGZG8qPfkMGx0DYj/mTrDwiFqZkJJ72esU44ZPY7GsphWpfBOdFDUNUYK
         S8qSmSlOFHetTjGUl345l5RBhmAK0VZ1rzhRY3/3BhXZ0/IH5MJOXewrL6ca9yTC4gQv
         J8/w==
X-Gm-Message-State: ALoCoQkpMrVz4jhBnLOp1AVvNxvciGGBfgjSluwfsVTeAxO0rL5Y2NuJys2ytbD3EvdP8Ssndr5Q
X-Received: by 10.140.81.74 with SMTP id e68mr4161154qgd.77.1401320971178;
        Wed, 28 May 2014 16:49:31 -0700 (PDT)
Received: from [172.17.3.46] ([38.104.173.198])
        by mx.google.com with ESMTPSA id m7sm32890522qao.20.2014.05.28.16.49.29
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Wed, 28 May 2014 16:49:30 -0700 (PDT)
In-Reply-To: <538658C0.8050001@alum.mit.edu>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250347>

On Wed, 2014-05-28 at 23:44 +0200, Michael Haggerty wrote:
> On 05/28/2014 11:04 PM, David Turner wrote:
> > In a repository with tens of thousands of refs, the command
> > ~/git/git-diff-index --cached --quiet --ignore-submodules [revision]
> > is a bit slow.  check_refname_component is a major contributor to the
> > runtime.  Provide two optimized versions of this function: one for
> > machines with SSE4.2, and one for machines without.  The speedup for
> > this command on one particular repo (with about 60k refs) is about 12%
> > for the SSE version and 8% for the non-SSE version.
> 
> Interesting.  Thanks for the patch.

Thanks for your thoughtful comments.

> Why do you use "git diff-index" to benchmark your change?  Is there
> something particular about that command that leads to especially bad
> performance with lots of references?

Because a colleague specifically asked me to look at it because he uses
it as part of the zsh/bash git prompt dirty bit display. But that is not
actually a good reason to use it in the commit-message.  This is also
the reason why milliseconds matter, although at present other parts of
git are slow enough that the prompt stuff is still somewhat infeasible
for large repos.

> I assume that most of the time spent in check_refname_component() is
> while reading the packed-refs file, right?  

Yes.

> If so, there are probably
> other git commands that would better measure that time, with less other
> work.  For example, "git rev-parse refname" will read the packed-refs
> file, too (assuming that "refname" is not a loose reference).  If you
> test the speedup of a cheaper command like that, it seems to me that you
> will get a better idea of how much you are speeding up the ref-reading
> part.  It would also be interesting to see the difference in
> milliseconds (rather than a percentage) for some specified number of
> references.

I'll change it to rev-parse and to show the difference in milliseconds.

The times on rev-parse are 35/29/25ms on one particular computer, for
original, LUT, SSE.  So, somewhat larger speedup in percentage terms.  I
should also note that this represents a real use-case, and I expect that
the number of refs will be somewhat larger in the future.

> I think it's worth using your LUT-based approach to save 8%.  I'm less
> sure it's worth the complication and unreadability of using SSE to get
> the next 4% speedup.  But the gains might be proven to be more
> significant if you benchmark them differently.

I was actually hoping at some point to use SSE to speed up a small few
of the other slow bits e.g. get_sha1_hex.  I have not yet tested if this
will actually be faster, but I bet it will.  And my watchman branch uses
it to speed up the hashmap (but it seems CityHash works about as well so
I might just port that instead).

But actually speaking of SSE: is there a minimum compiler version for
git?  Because I have just discovered gcc-4.2 on the Mac has a bug which
causes this code to misbehave.  Yet again, compiler intrinsics prove
less portable than straight assembly language.  I would be just as happy
to write it in assembly, but I suspect that nobody would enjoy that.  I
could also work around the bug with a compiler-specific ifdef, but Apple
has been shipping clang for some years now, so I think it's OK to leave
the code as-is.

> I won't critique the code in detail until we have thrashed out the
> metaissues, but I made a few comments below about nits that I noticed
> when I scanned through.

I'll go ahead and roll a new version with the nits picked.

> Please add a comment here about what the values in refname_disposition
> signify.  And maybe add some line comments explaining unusual values,
> for people who haven't memorized the ASCII encoding; e.g., on the third
> line,

I think I'm going to say, "see below for the list of illegal characters,
from which this table is derived.", if that's OK with you. 

From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/4] Extract some utilities from git-svn to allow
 extracting Git::SVN.
Date: Fri, 27 Jul 2012 11:34:33 +0000
Message-ID: <20120727113433.GA20883@dcvr.yhbt.net>
References: <1343344945-3717-1-git-send-email-schwern@pobox.com>
 <1343344945-3717-2-git-send-email-schwern@pobox.com>
 <7vobn13hps.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael G. Schwern" <schwern@pobox.com>, git@vger.kernel.org,
	robbat2@gentoo.org, bwalton@artsci.utoronto.ca, jrnieder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 27 13:34:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuioZ-0007Fx-Op
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 13:34:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977Ab2G0Lef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 07:34:35 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:57156 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751757Ab2G0Lee (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 07:34:34 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED8C31F4CB;
	Fri, 27 Jul 2012 11:34:33 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vobn13hps.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202349>

Junio C Hamano <gitster@pobox.com> wrote:
> "Michael G. Schwern" <schwern@pobox.com> writes:
> > +# Note: not certain why this is in use instead of die.  Probably because
> > +# the exit code of die is 255?  Doesn't appear to be used consistently.

Yes, 255 caused problems for the test suite:

commit d25c26e771fdf771f264dc85be348719886d354f
Author: Eric Wong <normalperson@yhbt.net>
Date:   Fri Nov 24 22:38:18 2006 -0800

    git-svn: exit with status 1 for test failures
    
    Some versions of the SVN libraries cause die() to exit with 255,
    and 40cf043389ef4cdf3e56e7c4268d6f302e387fa0 tightened up
    test_expect_failure to reject return values >128.

> > +sub fatal (@) { print STDERR "@_\n"; exit 1 }
> 
> Very true.  Also I do not think the line-noise prototype buys us
> anything (other than making the code look mysterious to non Perl
> programmers); we are not emulating any Perl's builtin with this
> function, and I do not see a reason why we want to force list
> context to its arguments, either.  But removal of it is not part of
> this step anyway, so I wouldn't complain.

I think I just learned Perl prototypes around that time :x
We can certainly remove it later.

> > +my $can_compress;
> > +sub can_compress {
> > +    return $can_compress if defined $can_compress;
> > +
> > +    return $can_compress = eval { require Compress::Zlib; } ? 1 : 0;
> > +}
> 
> The original said "eval { require Compress::Zlib; 1; }"; presumably,
> when require does succeed, the value inside is the "1;" that has to
> be at the end of Compress::Zlib, so the difference should not matter.

I just squashed in the simplification and made the indentation
consistent with other .pm files:

	return $can_compress = eval { require Compress::Zlib; };

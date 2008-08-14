From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/3] Git.pm: Add faculties to allow temp files to be cached
Date: Wed, 13 Aug 2008 23:58:00 -0700
Message-ID: <20080814065800.GA16918@untitled>
References: <489DBB8A.2060207@griep.us> <1218470035-13864-1-git-send-email-marcus@griep.us> <1218470035-13864-2-git-send-email-marcus@griep.us> <48A33E70.8060804@gmail.com> <7vskt8mz0g.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lea Wiemann <lewiemann@gmail.com>, Marcus Griep <marcus@griep.us>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 14 08:59:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTWnd-0005k7-JX
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 08:59:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831AbYHNG6E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 02:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751527AbYHNG6D
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 02:58:03 -0400
Received: from hand.yhbt.net ([66.150.188.102]:35747 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751331AbYHNG6C (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 02:58:02 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id D87B22DC01B;
	Wed, 13 Aug 2008 23:58:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vskt8mz0g.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92329>

Junio C Hamano <gitster@pobox.com> wrote:
> Lea Wiemann <lewiemann@gmail.com> writes:
> 
> > Marcus Griep wrote:
> >> diff --git a/perl/Git.pm b/perl/Git.pm
> >>
> >> +require File::Spec;
> >
> > This makes Git.pm dependent on Perl 5.6.1.
> 
> Ouch.  Thanks for being extra careful.
> 
> Unfortunately I've already pulled these changes via Eric.
> 
> Among the existing Perl scripts, cvsexportcommit and cvsimport already do
> use it, so do svnimport and cidaemon in contrib.
> 
> > ...  Hence to avoid
> > complaints about failing tests, I suggest that you add a check for
> > File::Spec availability at the beginning of any test that (indirectly)
> > uses Git.pm.
> 
> Hmm, wouldn't something like this (untested) be more contained?
> 
> ---
>  perl/Git.pm |   16 ++++++++++++++--
>  1 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/perl/Git.pm b/perl/Git.pm
> index 405f68f..2a92945 100644
> --- a/perl/Git.pm
> +++ b/perl/Git.pm
> @@ -1023,7 +1035,7 @@ sub _temp_cache {
>  		}

What about just lazy requiring inside _temp_cache() so it
won't get loaded by folks that don't need it? (completely untested):

		eval { require File::Temp };
		if ($@) {
			throw Error::Simple("couldn't require File::Temp: $@");
		}
		eval { require File::Spec };
		if ($@) {
			throw Error::Simple("couldn't require File::Spec: $@");
		}

It'll also remove the minor performance hit CGI/gitweb users got since
we won't load these extra modules during startup.

>  		$$temp_fd = File::Temp->new(
>  			TEMPLATE => 'Git_XXXXXX',
> -			DIR => File::Spec->tmpdir
> +			DIR => $tmpdir,
>  			) or throw Error::Simple("couldn't open new temp file");
>  		$$temp_fd->autoflush;
>  		binmode $$temp_fd;

Fwiw, git-svn has been a File::Temp user for a few months since Adam's
cat-file optimization; but it also has lower visibility since boxes
with <5.6.1 probably don't have SVN.  git-svn previously used
IO::File->new_tmpfile exclusively (and very heavily).

-- 
Eric Wong

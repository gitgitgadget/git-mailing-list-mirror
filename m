From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 2/1] git svn: remove extraneous newline from log output
Date: Mon, 26 Jul 2010 12:09:45 -0700
Message-ID: <20100726190945.GA2727@dcvr.yhbt.net>
References: <20100423134611.GA3440@merkur.sol.de> <20100426132710.GA9930@progeny.tock> <20100427112656.GB16323@merkur.sol.de> <20100725023114.GB18606@burratino> <20100725081057.GA22373@dcvr.yhbt.net> <20100725081344.GB22373@dcvr.yhbt.net> <20100725173549.GA7930@merkur.sol.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Jens Seidel <jensseidel@users.sf.net>
X-From: git-owner@vger.kernel.org Mon Jul 26 21:09:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdT3f-0006NC-Fo
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 21:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754863Ab0GZTJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 15:09:47 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:54333 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752235Ab0GZTJq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 15:09:46 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id E13E31F509;
	Mon, 26 Jul 2010 19:09:45 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20100725173549.GA7930@merkur.sol.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151885>

Jens Seidel <jensseidel@users.sf.net> wrote:
> Hi Eric,
> 
> On Sun, Jul 25, 2010 at 08:13:44AM +0000, Eric Wong wrote:
> > This is to match the output of "svn log", which does not
> > add an extra newline before the next log entry.
> 
> thanks for the patch but it doesn't work in the general case.
> 
> I attached a sample Subversion repository dump where the output of
> git svn log and svn log still differs by empty lines.
> 
> I also noticed the following error:
> Can't use an undefined value as an ARRAY reference at                                                                                            
> /usr/lib/git-core/git-svn line 5717, <$fh> line 53.
> 
> I'm not sure whether I introduced this error once I patched
> git-svn ...
> The affected line is the second one in:
>            } elsif (/^${esc_color}    (git-svn-id:.+)$/o) {
>                         if (@{$c->{l}} && $c->{l}->[-1] eq "\n") {
>                                 pop @{$c->{l}};
>                         }
> (is -1 valid?)

Yes, -1 is valid but $c->{l} may not exist at that point..

But I had forgotten about a similar piece of code in the
"show_commit_normal" subroutine which does a similar job:

		while ($l->[$#$l] eq "\n" && $#$l > 0
		                          && $l->[($#$l - 1)] eq "\n") {
			pop @$l;
		}

This is partially because SVN doesn't enforce a trailing "\n" in
commit messages (unlike "git commit"), so we always append one
when we fetch and add "\ngit-svn-id: ...\n".  But then we also
need to take noMetadata users into account, too.

I'll let you ponder issues with this since you appear to care more than
I do about completely matching SVN output :)


For what it's worth, over the years, nobody ever "outed" me as a git-svn
user in SVN projects when I shared log output.  Some folks worked with
for years in the same offices and never made indication to knowing I
used git-svn (even after they started using it themselves).

-- 
Eric Wong

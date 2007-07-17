From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] translate bad characters in refnames during git-svn fetch
Date: Tue, 17 Jul 2007 05:28:52 -0700
Message-ID: <20070717122852.GA21372@mayonaise>
References: <20070715130548.GA6144@piper.oerlikon.madduck.net> <20070716033050.GA29521@muzzle> <20070716111509.GC18293@efreet.light.src> <20070715130548.GA6144@piper.oerlikon.madduck.net> <20070716033050.GA29521@muzzle> <20070716174731.GA4792@lapse.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 17 14:29:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAmAk-0000qK-Rh
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 14:28:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752393AbXGQM2z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 08:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752465AbXGQM2z
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 08:28:55 -0400
Received: from hand.yhbt.net ([66.150.188.102]:43282 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752075AbXGQM2y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 08:28:54 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 5488F2DC08D;
	Tue, 17 Jul 2007 05:28:52 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 17 Jul 2007 05:28:52 -0700
Content-Disposition: inline
In-Reply-To: <20070716174731.GA4792@lapse.madduck.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52757>

martin f krafft <madduck@madduck.net> wrote:
> also sprach Eric Wong <normalperson@yhbt.net> [2007.07.16.0530 +0200]:
> > The major issue with this is that it doesn't handle odd cases
> > where a refname is sanitized into something (say "1234~2"
> > sanitizes to "1234=2"), and then another branch is created named
> > "1234=2".
> 
> Well, we can't please everyone, can we? :)
> 
> I like Jan's proposal about using the % escape, even though it
> doesn't make pretty branch names.

I like it, too.  How about something like the two functions below?  This
will break things a bit for people currently using % in refnames,
however.

I think this will work rather nicely once I've figured out how the path
globbing code works[1] and where to sanitize/desanitize the refnames
properly.

It would be far easier to take your approach and sanitize them only
for the command-line, but storing unsanitized git refnames into the
.git/config is something I want to avoid:

  Somebody naming directories on the SVN side with the path component
  ":refs/remotes" in them could screw things up for us.

# transform the refname as per rules in git-check-ref-format(1):
sub sanitize_ref_name {
	my ($refname) = @_;

	# It cannot end with a slash /, we'll throw up on this because
	# SVN can't have directories with a slash in their name, either:
	if ($refname =~ m{/$}) {
		die "ref: '$refname' ends with a trailing slash, this is ",
		    "not permitted by git nor Subversion\n";
	}

	# It cannot have ASCII control character space, tilde ~, caret ^,
	# colon :, question-mark ?, asterisk *, or open bracket[ anywhere
	#
	# Additionally, % must be escaped because it is used for escaping
	# and we want our escaped refname to be reversible
	$refname =~ s{( \%~\^:\?\*\[\t)}{uc sprintf('%%%02x',ord($1))}eg;

	# no slash-separated component can begin with a dot .
	# /.* becomes /%2E*
	$refname =~ s{/\.}{/%2E}g;
	# It cannot have two consecutive dots .. anywhere
	# .. becomes %2E%2E
	$refname =~ s{\.\.}{%2E%2E}g;

	$refname;
}

sub desanitize_ref_name {
	my ($refname) = @_;
	$refname =~ s{%(?:([0-9A-F]{2})}{chr hex($1)}g;

	$refname;
}

> On the other hand, we could make the translation regexps
> configurable...

Hopefully not needed.  I fear it would just add to confusion.


[1] I don't remember writing the globbing code myself, maybe it was my
psychotic alter ego, but I'm having trouble following it at this time of
the night/morning.

-- 
Eric Wong

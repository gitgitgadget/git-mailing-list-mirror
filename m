From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: add --ignore-paths option for fetching
Date: Sun, 25 Jan 2009 14:42:38 -0800
Message-ID: <20090125224238.GA31581@untitled>
References: <1232864842-8841-1-git-send-email-public_vi@tut.by> <200901251521.15591.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Vitaly _Vi Shukela <public_vi@tut.by>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Jan 25 23:44:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRDiE-0007JF-3q
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 23:44:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbZAYWmn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 17:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbZAYWmm
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 17:42:42 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:45247 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750854AbZAYWmk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 17:42:40 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFFE51F586;
	Sun, 25 Jan 2009 22:42:38 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200901251521.15591.trast@student.ethz.ch>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107115>

Thomas Rast <trast@student.ethz.ch> wrote:
> Vitaly "_Vi" Shukela wrote:
> > 
> > Signed-off-by: Vitaly "_Vi" Shukela <public_vi@tut.by>
> 
> This would be a good place to explain why this is useful, and (if
> applicable) why you chose to implement it the way you did.
> 
> > --- a/Documentation/git-svn.txt
> > +++ b/Documentation/git-svn.txt
> > @@ -96,6 +96,10 @@ COMMANDS
> >  	Store Git commit times in the local timezone instead of UTC.  This
> >  	makes 'git-log' (even without --date=local) show the same times
> >  	that `svn log` would in the local timezone.
> > +--ignore-paths=<regex>;;
> > +	This allows one to specify regular expression that will
> > +	cause skipping of all matching paths from checkout from SVN.
> > +	Example: --ignore-paths='^doc'
> >  
> >  This doesn't interfere with interoperating with the Subversion
> >  repository you cloned from, but if you wish for your local Git
> 
> You put the --ignore-paths explanation in the middle of the
> --localtime documentation (the last paragraph quoted still talks about
> --localtime).
> 
> > @@ -3245,6 +3246,15 @@ use warnings;
> >  use Carp qw/croak/;
> >  use File::Temp qw/tempfile/;
> >  use IO::File qw//;
> > +use vars qw/ $ignoreRegex/;
> > +
> > +# 0 -- don't ignore, 1 -- ignore
> > +sub isPathIgnored($) {
> > +    return 0 unless defined($ignoreRegex);
> > +    my $path = shift;
> > +    return 1 if $path =~ m!^$ignoreRegex!o;
> > +    return 0;
> > +}
> 
> This is the first function in git-svn.perl using camelCase.  Consider
> sticking to the current style and spelling it is_path_ignored().

Also, indentation is always done with tabs in git-svn (and the vast
majority of git as well).

> > @@ -3372,11 +3384,14 @@ sub add_file {
> >  	my ($self, $path, $pb, $cp_path, $cp_rev) = @_;
> >  	my $mode;
> >  
> > +	goto out if isPathIgnored($path);
> > +
> >  	if (!in_dot_git($path)) {
> >  		my ($dir, $file) = ($path =~ m#^(.*?)/?([^/]+)$#);
> >  		delete $self->{empty}->{$dir};
> >  		$mode = '100644';
> >  	}
> > +out:
> >  	{ path => $path, mode_a => $mode, mode_b => $mode,
> >  	  pool => SVN::Pool->new, action => 'A' };
> >  }
> 
> You broke the symmetry here, while all other hunks just add an
> equivalent check to the existing in_dot_git().
> 
> However, the latter makes me wonder if it would be cleaner to move the
> in_dot_git() test to isPathIgnored (er, is_path_ignored) too?

Thanks for the review, Thomas.  I agree with all your suggestions.

Vitaly: thank you for the patch.  Can you also provide a testcase to
ensure this functionality doesn't break during refactorings?  Thanks.

-- 
Eric Wong

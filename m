From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 3/3] git-svn log: handle unreachable revisions like "svn log"
Date: Sun, 11 Nov 2007 18:50:45 -0800
Message-ID: <20071112025045.GA25705@mayonaise>
References: <D6A0D2B9-A355-4216-8D15-84993C26B503@lrde.epita.fr> <189577.85054.qm@web52407.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Benoit Sigoure <tsuna@lrde.epita.fr>, git@vger.kernel.org,
	gitster@pobox.com
To: "David D. Kilzer" <ddkilzer@kilzer.net>
X-From: git-owner@vger.kernel.org Mon Nov 12 03:51:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrPOD-0001fT-M6
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 03:51:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754253AbXKLCuu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 21:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753734AbXKLCut
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 21:50:49 -0500
Received: from hand.yhbt.net ([66.150.188.102]:57071 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752543AbXKLCut (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 21:50:49 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 533467DC0FE;
	Sun, 11 Nov 2007 18:50:45 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 11 Nov 2007 18:50:45 -0800
Content-Disposition: inline
In-Reply-To: <189577.85054.qm@web52407.mail.re2.yahoo.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64554>

"David D. Kilzer" <ddkilzer@kilzer.net> wrote:

Hi Dave, thanks for the patches, and thanks to Benoit for the review.

> Benoit Sigoure <tsuna@lrde.epita.fr> wrote:
> 
> > thanks for the patches, the series looks good to me, I added some  
> > comments below, for this patch.
> 
> Thanks for the review, Benoit!  Comments below.
> 
> > On Nov 11, 2007, at 7:10 AM, David D Kilzer wrote:
> > 
> > >  sub find_rev_before {
> > > -	my ($self, $rev, $eq_ok) = @_;
> > > +	my ($self, $rev, $eq_ok, $min_rev) = @_;
> > 
> > Could you please document this function?  I guess that you had to  
> > figure out what each argument was for, so please save the time of the  
> > contributors that will read this code after you :)
> 
> What is the format for documenting functions in git Perl scripts?  I
> haven't see any "perlpod" use anywhere.  Do you just want comments
> before the function?

Just a regular comment is enough, perlpod uses too much space.

> This method returns the git commit hash and svn revision of the first svn
> revision that exists on the current branch that is less than $rev (or
> less-than-or-equal-to $rev if $eq_ok is true).
> 
> Please note that I don't have a full understanding of how find_rev_before()
> works (other than it's computing an offset into a sparse? data file based on
> the revision number) since I'm still new to git.

Pretty much.  The .rev_db format is documented above the _rev_db_set
sub.  I'm considering replacing the current rev_db format with something
more compact for larger repos, though.

> > > +sub find_rev_after {
> > > +	my ($self, $rev, $eq_ok, $max_rev) = @_;
> > > +	++$rev unless $eq_ok;
> > > +	$max_rev ||= $self->rev_db_max();
> > > +	while ($rev <= $max_rev) {
> > > +		if (my $c = $self->rev_db_get($rev)) {
> > > +			return ($rev, $c);
> > > +		}
> > > +		++$rev;
> > > +	}
> > > +	return (undef, undef);
> > > +}
> > 
> > Too much code duplication.  It should be possible to write a sub  
> > find_rev_ (or _find_rev, don't know what's the naming convention for  
> > internal details) that takes a 5th argument, an anonymous sub that  
> > does the comparison.  So that basically, find_rev_before will be  
> > something along these (untested) lines:
> > 
> > sub find_rev_before {
> > 	my ($self, $rev, $eq_ok, $min_rev) = @_;
> > 	return find_rev_($self, $rev, $eq_ok, $min_rev, sub { my ($a, $b) =  
> > @_; return $a >= $b; });
> > }
> 
> I think that combining find_rev_before() and find_rev_after() would greatly
> sacrifice readability of the code in exchange for removing ~10 lines of code. 
> Also, you must do more than just replace the comparison in the while() loop:
> 
> - before() decrements $rev while after() increments it
> - stop limits are different ($max_rev versus $min_rev)
> 
> This is what such a method might look like (untested).  Since you already
> requested find_rev_before() be documented, is this really going to help?
> 
> sub find_rev_ {
> 	my ($self, $rev, $eq_ok, $is_before, $limit_rev) = @_;
> 	($is_before ? --$rev : ++$rev) unless $eq_ok;
> 	$limit_rev ||= ($is_before ? 1 : $self->rev_db_max());
> 	while ($is_before ? $rev >= $limit_rev : $rev <= $limit_rev) {
> 		if (my $c = $self->rev_db_get($rev)) {
> 			return ($rev, $c);
> 		}
> 			$is_before ? --$rev : ++$rev;
> 	}
> 	return (undef, undef);
> }

find_rev_ is too complicated, please keep them as separate functions.

> Defining wrapper functions would help, but I still think it's just as clear to
> keep the two methods separate.
> 
> sub find_rev_before() {
> 	my ($self, $rev, $eq_ok, $min_rev) = @_;
> 	return $self->find_rev_($rev, $eq_ok, 1, $min_rev);
> }
> 
> sub find_rev_after() {
> 	my ($self, $rev, $eq_ok, $max_rev) = @_;
> 	return $self->find_rev_($rev, $eq_ok, 0, $max_rev);
> }
> 
> Do you agree, or do you think the methods should still be combined?
> 
> > > +		if ($r_max < $r_min) {
> > > +			($r_min, $r_max) = ($r_max, $r_min);
> > > +		}
> > > +		my (undef, $c_max) = $gs->find_rev_before($r_max, 1, $r_min);
> > > +		my (undef, $c_min) = $gs->find_rev_after($r_min, 1, $r_max);
> > > +		# If there are no commits in the range, both $c_max and $c_min
> > > +		# will be undefined.  If there is at least 1 commit in the
> > > +		# range, both will be defined.
> > > +		return () if !defined $c_min;
> > 
> > Fair enough but I'd strengthen the test by writing something like:
> > 		return () if not defined $c_min || not defined $c_max;
> > unless you can prove that `rev_db_get' can never return `undef' or  
> > something like that.

I prefer '!' instead of 'not' unless operator precedence matters.

> Will make this change.
> 
> > > +sub commit_log_separator {
> > > +    return ('-' x 72) . "\n";
> > > +}
> > > +
> > 
> > This is basically a constant, I think that declaring it with a  
> > prototype helps Perl to optimize it:
> > sub commit_log_separator() {

use constant commit_log_separator => ('-' x 72) . "\n";

is probably most readable...

-- 
Eric Wong

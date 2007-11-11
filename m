From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: Re: [PATCH 3/3] git-svn log: handle unreachable revisions like "svn log"
Date: Sun, 11 Nov 2007 11:51:33 +0100
Message-ID: <D6A0D2B9-A355-4216-8D15-84993C26B503@lrde.epita.fr>
References: <1194761435-7286-1-git-send-email-ddkilzer@kilzer.net> <1194761435-7286-2-git-send-email-ddkilzer@kilzer.net> <1194761435-7286-3-git-send-email-ddkilzer@kilzer.net> <1194761435-7286-4-git-send-email-ddkilzer@kilzer.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-22--424754509"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: David D Kilzer <ddkilzer@kilzer.net>
X-From: git-owner@vger.kernel.org Sun Nov 11 11:52:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrAQF-00085N-MZ
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 11:52:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753574AbXKKKvx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 05:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753772AbXKKKvx
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 05:51:53 -0500
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:34256 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753568AbXKKKvw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 05:51:52 -0500
Received: from quanta.tsunanet.net ([82.229.223.213])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1IrAPp-0004cp-4V; Sun, 11 Nov 2007 11:51:45 +0100
In-Reply-To: <1194761435-7286-4-git-send-email-ddkilzer@kilzer.net>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64444>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-22--424754509
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

Hi David,
thanks for the patches, the series looks good to me, I added some  
comments below, for this patch.

On Nov 11, 2007, at 7:10 AM, David D Kilzer wrote:

> When unreachable revisions are given to "svn log", it displays all  
> commit
> logs in the given range that exist in the current tree.  (If no commit
> logs are found in the current tree, it simply prints a single  
> commit log
> separator.)  This patch makes "git-svn log" behave the same way.
>
> Ten tests added to t/t9116-git-svn-log.sh.
>
> Signed-off-by: David D Kilzer <ddkilzer@kilzer.net>
> ---
>  git-svn.perl           |   58 +++++++++++++++++++++++++++ 
> +--------------
>  t/t9116-git-svn-log.sh |   66 +++++++++++++++++++++++++++++++++++++ 
> +++++++++++
>  2 files changed, 105 insertions(+), 19 deletions(-)
>
> diff --git a/git-svn.perl b/git-svn.perl
> index 39585d8..c584715 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -2257,9 +2257,10 @@ sub rev_db_get {
>  }
>
>  sub find_rev_before {
> -	my ($self, $rev, $eq_ok) = @_;
> +	my ($self, $rev, $eq_ok, $min_rev) = @_;

Could you please document this function?  I guess that you had to  
figure out what each argument was for, so please save the time of the  
contributors that will read this code after you :)

>  	--$rev unless $eq_ok;
> -	while ($rev > 0) {
> +	$min_rev ||= 1;
> +	while ($rev >= $min_rev) {
>  		if (my $c = $self->rev_db_get($rev)) {
>  			return ($rev, $c);
>  		}
> @@ -2268,6 +2269,19 @@ sub find_rev_before {
>  	return (undef, undef);
>  }
>
> +sub find_rev_after {
> +	my ($self, $rev, $eq_ok, $max_rev) = @_;
> +	++$rev unless $eq_ok;
> +	$max_rev ||= $self->rev_db_max();
> +	while ($rev <= $max_rev) {
> +		if (my $c = $self->rev_db_get($rev)) {
> +			return ($rev, $c);
> +		}
> +		++$rev;
> +	}
> +	return (undef, undef);
> +}
> +

Too much code duplication.  It should be possible to write a sub  
find_rev_ (or _find_rev, don't know what's the naming convention for  
internal details) that takes a 5th argument, an anonymous sub that  
does the comparison.  So that basically, find_rev_before will be  
something along these (untested) lines:

sub find_rev_before {
	my ($self, $rev, $eq_ok, $min_rev) = @_;
	return find_rev_($self, $rev, $eq_ok, $min_rev, sub { my ($a, $b) =  
@_; return $a >= $b; });
}

>  sub _new {
>  	my ($class, $repo_id, $ref_id, $path) = @_;
>  	unless (defined $repo_id && length $repo_id) {
> @@ -3587,19 +3601,19 @@ sub git_svn_log_cmd {
>  			push @cmd, $c;
>  		}
>  	} elsif (defined $r_max) {
> -		my ($c_min, $c_max);
> -		$c_max = $gs->rev_db_get($r_max);
> -		$c_min = $gs->rev_db_get($r_min);
> -		if (defined $c_min && defined $c_max) {
> -			if ($r_max > $r_min) {
> -				push @cmd, "--boundary", "$c_min..$c_max";
> -			} else {
> -				push @cmd, "--boundary", "$c_max..$c_min";
> -			}
> -		} elsif ($r_max > $r_min) {
> -			push @cmd, $c_max;
> +		if ($r_max < $r_min) {
> +			($r_min, $r_max) = ($r_max, $r_min);
> +		}
> +		my (undef, $c_max) = $gs->find_rev_before($r_max, 1, $r_min);
> +		my (undef, $c_min) = $gs->find_rev_after($r_min, 1, $r_max);
> +		# If there are no commits in the range, both $c_max and $c_min
> +		# will be undefined.  If there is at least 1 commit in the
> +		# range, both will be defined.
> +		return () if !defined $c_min;

Fair enough but I'd strengthen the test by writing something like:
		return () if not defined $c_min || not defined $c_max;
unless you can prove that `rev_db_get' can never return `undef' or  
something like that.

> +		if ($c_min eq $c_max) {
> +			push @cmd, '--max-count=1', $c_min;
>  		} else {
> -			push @cmd, $c_min;
> +			push @cmd, '--boundary', "$c_min..$c_max";
>  		}
>  	}
>  	return (@cmd, @files);
> @@ -3705,9 +3719,13 @@ sub show_commit_changed_paths {
>  	print "Changed paths:\n", @{$c->{changed}};
>  }
>
> +sub commit_log_separator {
> +    return ('-' x 72) . "\n";
> +}
> +

This is basically a constant, I think that declaring it with a  
prototype helps Perl to optimize it:
sub commit_log_separator() {

>  sub show_commit_normal {
>  	my ($c) = @_;
> -	print '-' x72, "\nr$c->{r} | ";
> +	print commit_log_separator(), "r$c->{r} | ";
>  	print "$c->{c} | " if $show_commit;
>  	print "$c->{a} | ", strftime("%Y-%m-%d %H:%M:%S %z (%a, %d %b %Y)",
>  				 localtime($c->{t_utc})), ' | ';
> diff --git a/t/t9116-git-svn-log.sh b/t/t9116-git-svn-log.sh
> index 5000892..56dd8fe 100755
> --- a/t/t9116-git-svn-log.sh
> +++ b/t/t9116-git-svn-log.sh
> @@ -59,4 +65,64 @@ test_expect_success 'test descending revision  
> range' "
[...]
> +
> +echo  
> ---------------------------------------------------------------------- 
> -- > expected-separator

This will choke on shells with buggy/fragile `echo'.  I think it'd be  
safer to use printf here.


Cheers,

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-22--424754509
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHNt61wwE67wC8PUkRAjwdAKCrVP3VJt5MiE1xPtLHBzzPGmLCQACfehg5
XzfSocV4uE6vva/F2YcChTA=
=GL5P
-----END PGP SIGNATURE-----

--Apple-Mail-22--424754509--

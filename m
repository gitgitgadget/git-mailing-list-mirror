From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: Re: [PATCH 3/3] git-svn log: handle unreachable revisions like "svn log"
Date: Sun, 11 Nov 2007 17:36:50 +0100
Message-ID: <4A2CBEB1-F7B1-4DEC-9F72-506EBCDA2233@lrde.epita.fr>
References: <189577.85054.qm@web52407.mail.re2.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-27--404037667"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: ddkilzer@kilzer.net
X-From: git-owner@vger.kernel.org Sun Nov 11 17:37:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrFoJ-0004gs-6O
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 17:37:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757208AbXKKQhG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 11:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757202AbXKKQhF
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 11:37:05 -0500
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:45108 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757128AbXKKQhC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 11:37:02 -0500
Received: from quanta.tsunanet.net ([82.229.223.213])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1IrFnw-0005Ee-Me; Sun, 11 Nov 2007 17:37:00 +0100
In-Reply-To: <189577.85054.qm@web52407.mail.re2.yahoo.com>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64473>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-27--404037667
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On Nov 11, 2007, at 3:20 PM, David D. Kilzer wrote:

> Benoit Sigoure <tsuna@lrde.epita.fr> wrote:
>
>> On Nov 11, 2007, at 7:10 AM, David D Kilzer wrote:
>>
>>>  sub find_rev_before {
>>> -	my ($self, $rev, $eq_ok) = @_;
>>> +	my ($self, $rev, $eq_ok, $min_rev) = @_;
>>
>> Could you please document this function?  I guess that you had to
>> figure out what each argument was for, so please save the time of the
>> contributors that will read this code after you :)
>
> What is the format for documenting functions in git Perl scripts?   
> I haven't
> see any "perlpod" use anywhere.  Do you just want comments before  
> the function?
>
> This method returns the git commit hash and svn revision of the  
> first svn
> revision that exists on the current branch that is less than $rev (or
> less-than-or-equal-to $rev if $eq_ok is true).

Personally, I don't care.  Maybe Eric has his own preference.  For  
me, as long as the code is documented one way or another, that's fine  
by me.  Under-documented code hinders new contributors, so I think  
it's important to add documentation whenever possible.

> Please note that I don't have a full understanding of how  
> find_rev_before()
> works (other than it's computing an offset into a sparse? data file  
> based on
> the revision number) since I'm still new to git.
>
>>> +sub find_rev_after {
>>> +	my ($self, $rev, $eq_ok, $max_rev) = @_;
>>> +	++$rev unless $eq_ok;
>>> +	$max_rev ||= $self->rev_db_max();
>>> +	while ($rev <= $max_rev) {
>>> +		if (my $c = $self->rev_db_get($rev)) {
>>> +			return ($rev, $c);
>>> +		}
>>> +		++$rev;
>>> +	}
>>> +	return (undef, undef);
>>> +}
>>
>> Too much code duplication.  It should be possible to write a sub
>> find_rev_ (or _find_rev, don't know what's the naming convention for
>> internal details) that takes a 5th argument, an anonymous sub that
>> does the comparison.  So that basically, find_rev_before will be
>> something along these (untested) lines:
>>
>> sub find_rev_before {
>> 	my ($self, $rev, $eq_ok, $min_rev) = @_;
>> 	return find_rev_($self, $rev, $eq_ok, $min_rev, sub { my ($a, $b) =
>> @_; return $a >= $b; });
>> }
>
> I think that combining find_rev_before() and find_rev_after() would  
> greatly
> sacrifice readability of the code in exchange for removing ~10  
> lines of code.
> Also, you must do more than just replace the comparison in the while 
> () loop:
>
> - before() decrements $rev while after() increments it
> - stop limits are different ($max_rev versus $min_rev)
>
> This is what such a method might look like (untested).  Since you  
> already
> requested find_rev_before() be documented, is this really going to  
> help?
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
>
> Defining wrapper functions would help, but I still think it's just  
> as clear to
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

Er... you're right, I overlooked the differences between the two  
functions.  So merging them would make the code more complex than it  
needs to be, or so I think.

Thanks!

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-27--404037667
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHNy+iwwE67wC8PUkRAiqZAJ9QyQKzC53aDFqJNJrqb+8pZoYP4wCeOdEQ
wexMQbgb1/cyXUzsF2u9DsE=
=gN9W
-----END PGP SIGNATURE-----

--Apple-Mail-27--404037667--

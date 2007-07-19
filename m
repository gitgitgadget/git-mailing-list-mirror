From: Benoit SIGOURE <tsuna@lrde.epita.fr>
Subject: Re: [PATCH] Proposal for git-svn
Date: Thu, 19 Jul 2007 19:41:07 +0200
Message-ID: <6F6FBB0C-5CDB-4280-AD25-C805634B8B7B@lrde.epita.fr>
References: <FAFA899D-EC45-4313-98ED-2D0A3FF37669@lrde.epita.fr> <20070719042255.GA17433@muzzle>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-22-401237239"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Wong <eric@petta-tech.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 19:41:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBa0Q-0003so-DA
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 19:41:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936753AbXGSRl1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 13:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932722AbXGSRl0
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 13:41:26 -0400
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:55982 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936753AbXGSRlZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 13:41:25 -0400
Received: from tsunaxbook.lrde.epita.fr ([192.168.101.162])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA:16)
	(Exim 4.50)
	id 1IBa08-0004qA-UQ; Thu, 19 Jul 2007 19:41:20 +0200
In-Reply-To: <20070719042255.GA17433@muzzle>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53010>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-22-401237239
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On Jul 19, 2007, at 6:22 AM, Eric Wong wrote:

> Benoit SIGOURE <tsuna@lrde.epita.fr> wrote:
>> Hello,
>>
>> I'm importing many SVN repositories in Git and I ran across a  
>> problem:
>> ufloat.h has mode 120000but is not a link
>>
>> I've read the code and checked-out the revision where the problem
>> occured and it turns out that some stupid user commited a broken
>> symlink and I think that's where the problem came from.  I'm
>> proposing the following trivial change to let git-svn clone continue
>> its work:
>>
>> diff --git a/git-svn.perl b/git-svn.perl
>> index 01c3904..a82baf4 100755
>> --- a/git-svn.perl
>> +++ b/git-svn.perl
>> @@ -2555,8 +2555,8 @@ sub close_file {
>>                 sysseek($fh, 0, 0) or croak $!;
>>                 if ($fb->{mode_b} == 120000) {
>>                         sysread($fh, my $buf, 5) == 5 or croak $!;
>> -                       $buf eq 'link ' or die "$path has mode  
>> 120000",
>> -                                              "but is not a link\n";
>> +                       $buf eq 'link ' or warn "$path has mode  
>> 120000",
>> +                                              " but is not a link 
>> \n";
>>                 }
>>                 defined(my $pid = open my $out,'-|') or die "Can't
>> fork: $!\n";
>>                 if (!$pid) {
>>
>> (I also added a whitespace because "120000but" does not look good :D)
>> I checked out the problematic revision in git and I see the broken
>> symlink just like in SVN so I assume this change is correct.
>
> Very strange.  Since $buf didn't have the string "link " in it, did it
> have a path name in it?  If so, the sysread() would've advanced the  
> $fh
> offset by 5 bytes; causing an even more broken symlink to be added  
> by git.
>
> Would the following be more correct?
>
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -2552,9 +2552,15 @@ sub close_file {
>  		}
>  		sysseek($fh, 0, 0) or croak $!;
>  		if ($fb->{mode_b} == 120000) {
> -			sysread($fh, my $buf, 5) == 5 or croak $!;
> -			$buf eq 'link ' or die "$path has mode 120000",
> -			                       "but is not a link\n";
> +			eval {
> +				sysread($fh, my $buf, 5) == 5 or croak $!;
> +				$buf eq 'link ' or die "$path has mode 120000",
> +						       " but is not a link";
> +			};
> +			if ($@) {
> +				warn "$@\n";
> +				sysseek($fh, 0, 0) or croak $!;
> +			}
>  		}
>  		defined(my $pid = open my $out,'-|') or die "Can't fork: $!\n";
>  		if (!$pid) {
>

It does look more correct though I don't get the same sha1 sums with  
your patch.
Actually here is what happens:
At revision N, b0rken symlinks are added in the SVN repos.  Up to  
this revision, I get the same sha1 sums.
At N+1, the symlinks are removed from the SVN, and sha1 sums start to  
differ, for some reason.
I expected them to be either identical all the way through or to  
differ at N, but not at N+1.

In both cases the repository seem usable and I couldn't notice any  
other difference than the sha1 sums.

Cheers,

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-22-401237239
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFGn6IzwwE67wC8PUkRAtvaAKDHpqIBAwsbM+2kW0JcRlZYIJ/UyACdH8j8
PTIt8RIPcZHM2eCbdaraKfk=
=g2tn
-----END PGP SIGNATURE-----

--Apple-Mail-22-401237239--

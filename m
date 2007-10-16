From: Benoit SIGOURE <tsuna@lrde.epita.fr>
Subject: Re: [PATCH 1/5] Add a generic tree traversal to fetch SVN properties.
Date: Tue, 16 Oct 2007 11:35:09 +0200
Message-ID: <07B09A42-73DD-4565-975F-A4E40BF862AC@lrde.epita.fr>
References: <1192462506-3783-1-git-send-email-tsuna@lrde.epita.fr> <20071016074310.GA32254@soma>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-34--528255540"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Oct 16 11:36:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhiqH-0007U0-6Z
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 11:36:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757523AbXJPJft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 05:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757568AbXJPJft
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 05:35:49 -0400
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:40591 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755505AbXJPJfr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 05:35:47 -0400
Received: from tsunaxbook.lrde.epita.fr ([192.168.101.162])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1Ihiq2-0000F4-3K; Tue, 16 Oct 2007 11:35:46 +0200
In-Reply-To: <20071016074310.GA32254@soma>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61128>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-34--528255540
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On Oct 16, 2007, at 9:43 AM, Eric Wong wrote:

> Benoit Sigoure <tsuna@lrde.epita.fr> wrote:
>> 	* git-svn.perl (&traverse_ignore): Remove.
>> 	(&prop_walk): New.
>> 	(&cmd_show_ignore): Use prop_walk.
>>
>> Signed-off-by: Benoit Sigoure <tsuna@lrde.epita.fr>
>
> Although I myself have never needed this functionality, this series
> looks pretty good in general.

I heavily script Git with my own wrappers and having this sort if  
functionality does enhance the scriptability of git-svn.

>
> Thanks.

You're welcome :)

>
> One comment below about property selection (whitelist vs blacklist).
>
>
> It would be possible to get identical information out of  
> unhandled.log,
> but older repositories may not have complete information...  Maybe  
> some
> local option would be good for people with complete unhandled.log  
> files;
> but it could be really incomplete/insufficient.
>

In order to avoid using SVN::Ra and avoid access to the SVN repo?   
Hmm, clever, I didn't think about this.  Maybe we can provide both,  
the default would check unhandled.log and an option would enable  
direct access to the SVN repo?

>
> I'm not sure about 5/5, it's purely a style issue, however I don't
> really feel strongly about a trailing "\n" either way...   
> Nevertheless,
> it is definitely not part of this series and should be treated
> independently.
>

Indeed.

>
> Coding style
>
> Other than that, I prefer to keep braces on the same line as foreach,
> if, else statements.  I generally follow the git and Linux coding
> style for C in my Perl code.
>
> One exception that I make for Perl (but not C) is that I keep the "{"
> for subs on the same line (since subs can be nested and anonymous ones
> passed as arguments and such); unlike their C counterparts[1]

Indeed, sorry, I started correctly but then completely forgot to  
follow the existing Coding Style.  The CS I use daily is totally  
different, sorry ;)
Shall I resend the patch series with corrected CS?

>
> [1] - well, nesting functions is allowed in C99 or GNU C, I can't
>       remember which or both...
>

GNU C, AFAIR.

>> ---
>>  git-svn.perl |   66 +++++++++++++++++++++++++++++++++++++++ 
>> +-----------------
>>  1 files changed, 46 insertions(+), 20 deletions(-)
>>
>> diff --git a/git-svn.perl b/git-svn.perl
>> index 777e436..abc83ec 100755
>> --- a/git-svn.perl
>> +++ b/git-svn.perl
[...]
>
> How about having a blacklist (for the author, date, log, uuid?)  
> instead
> of a whitelist?  I can't remember all of them that should be  
> blacklisted,
>  but maybe it's just author, date and log)..
>
>> +	my $interesting_props = 0;
>> +	foreach(keys %{$props})
>> +	{
>> +		# If it doesn't start with `svn:', it must be a
>> +		# user-defined property.
>> +		++$interesting_props and next if $_ !~ /^svn:/;
>> +		# FIXME: Fragile, if SVN adds new public properties,
>> +		# this needs to be updated.
>> +		++$interesting_props if /^svn:(?:ignore|keywords|executable
>> +		                                 |eol-style|mime-type
>> +						 |externals|needs-lock)$/x;
>> +	}

Why not.  I thought that the SVN internals were more subject to  
change than the public "interface", hence the check.

>> +	&$sub($self, $p, $props) if $interesting_props;
>> +

PS: For some reason, the introduction message didn't make its way to  
the ML.  I made a mistake when sending it because I first ran git  
send-email --compose, then noticed that it sent only one mail, and  
ran git send-email *.patch afterwards.  Weird.

Cheers,

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-34--528255540
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHFIXNwwE67wC8PUkRArXyAJ90kxQac3i0mbtAWzOYWmbUavgXOwCgqMLK
yUkdFMDqf9HgBhhPVffDbwk=
=KTaw
-----END PGP SIGNATURE-----

--Apple-Mail-34--528255540--

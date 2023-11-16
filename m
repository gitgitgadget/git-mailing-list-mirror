Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dALjCuwc"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908C390
	for <git@vger.kernel.org>; Thu, 16 Nov 2023 11:30:28 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 227821D273;
	Thu, 16 Nov 2023 14:30:28 -0500 (EST)
	(envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=iq5EXVEDeR5URGjBSCg6uxbeD
	A/Uza5qcTpWH0uV/bQ=; b=dALjCuwcBbQ9ZBDUEybB/Uk2LJHOskpawOu2GcdIz
	YhGV99vTYgplC4NUT2JYVInxYgWvNgkHXha63aqLUf1SotLNCOv2hHmHoIdsAGFG
	d42SiIiMw8gVYYU+KRbXsTpEwIPpuxpuio/A2QyH6OcvRWt6i4JM0AMmKBeuYv9U
	EU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1A99B1D272;
	Thu, 16 Nov 2023 14:30:28 -0500 (EST)
	(envelope-from tmz@pobox.com)
Received: from morphine.paradise.teonanacatl.net (unknown [47.204.171.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DB9491D265;
	Thu, 16 Nov 2023 14:30:22 -0500 (EST)
	(envelope-from tmz@pobox.com)
From: Todd Zullinger <tmz@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	=?UTF-8?q?Ond=C5=99ej=20Poho=C5=99elsk=C3=BD?= <opohorel@redhat.com>
Subject: [PATCH v3 0/2] send-email: avoid duplicate specification warnings
Date: Thu, 16 Nov 2023 14:30:09 -0500
Message-ID: <20231116193014.470420-1-tmz@pobox.com>
X-Mailer: git-send-email 2.43.0.rc2
In-Reply-To: <xmqq4jhmthtg.fsf@gitster.g>
References: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 9637A052-84B6-11EE-862A-F515D2CDFF5E-09356542!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> Todd Zullinger <tmz@pobox.com> writes:
[...]
>> A little history:
>>
>>   Support for the '--no-' prefix was added in Getopt::Long >=3D 2.33, =
in
>>   commit 8ca8b48 (Negatable options (with "!") now also support the
>>   "no-" prefix., 2003-04-04).  Getopt::Long 2.34 was included in
>>   perl-5.8.1 (2003-09-25), per Module::CoreList[1].
>>  =20
>>   We list perl-5.8 as the minimum version in INSTALL.  This would leav=
e
>>   users with perl-5.8.0 (2002-07-18) with non-working arguments for
>>   options where we're removing the explicit 'no-' variant.
>>  =20
>>   The explicit 'no-' opts were added in f471494303 (git-send-email.per=
l:
>>   support no- prefix with older GetOptions, 2015-01-30), specifically =
to
>>   support perl-5.8.0 which includes the older Getopt::Long.
>=20
> These are all very much relevant and deserve to be in the log
> message, not hidden under the three-dash line, I would think.
> Thanks for digging the history.  The first paragraph was a bit hard
> to read as it wasn't clear "support" on which side is being
> discussed, though.  If it were written perhaps like so:
>=20
>    Getopt::Long >=3D 2.33 started supporting the '--no-' prefix
>    natively by appending '!' to the option specification string,
>    which was shipped with perl-5.8.1 and not present in perl-5.8.0
>=20
> it would have been clear that it was talking about the support
> given by Getopt module, not on our side.

That is much better.  I've adjusted the commit message similarly and
hopefully kept your improved wording largely intact.

>> It may be time to bump the Perl requirement to 5.8.1 (2003-09-25) or
>> even 5.10.0 (2007-12-18).  We last bumped the requirement from 5.6 to
>> 5.8 in d48b284183 (perl: bump the required Perl version to 5.8 from
>> 5.6.[21], 2010-09-24).
>
> Isn't the position this patch takes a lot stronger than "It may be
> time"?  If we applied this patch, it drops the support for folks
> with Perl 5.8.0 (which I do not think is a bad thing, by the way).

Indeed it is.  I should have mentioned that more explicitly.  I added
the RFC tag to this round because I was unsure whether we'd want to go
the route of bumping the Perl requirement.  But I managed to not
actually say as much.

> This sounds like something that is worth describing in the log
> message (and Release Notes).

I think the new commit messages describe the changes better.  I didn't
include anything in RelNotes as I was presuming we'd leave this for
2.44 rather than risk causing any problems this late in the 2.43 cycle.
If you think the risk is low and/or the benefit is high, I can add it to
the 2.43.0 RelNotes.

>> diff --git a/git-send-email.perl b/git-send-email.perl
>> index cacdbd6bb2..94046e0fb7 100755
>> --- a/git-send-email.perl
>> +++ b/git-send-email.perl
>> @@ -119,13 +119,16 @@ sub completion_helper {
>> =20
>>      foreach my $key (keys %$original_opts) {
>>              unless (exists $not_for_completion{$key}) {
>> -                    $key =3D~ s/!$//;
>> +                    my $negate =3D ($key =3D~ s/!$//);
>=20
> A very minor nit, but I'd call this $negatable if I were doing this
> patch.

Sounds good.

> Just to make sure I did not misunderstand what you said below the
> three-dash line, if we were to take the other option that allows us
> to live with 5.8.0, we would make this hunk ...
>=20
>>                  "chain-reply-to!" =3D> \$chain_reply_to,
>> -                "no-chain-reply-to" =3D> sub {$chain_reply_to =3D 0},
>=20
> ... look more like this?
>=20
>> -                "chain-reply-to!" =3D> \$chain_reply_to,
>> +                "chain-reply-to" =3D> \$chain_reply_to,
>>                  "no-chain-reply-to" =3D> sub {$chain_reply_to =3D 0},
>> +                "nochain-reply-to" =3D> sub {$chain_reply_to =3D 0},
>=20
> That is, by removing the "!" suffix, we reject the native support of
> "--no-*" offered by Getopt::Long, and implement the negated variants
> ourselves?

Exactly.  We could bundle the two no* options together, but that's a
trivial style issue, i.e.:

> -                "chain-reply-to!" =3D> \$chain_reply_to,
> -                "no-chain-reply-to" =3D> sub {$chain_reply_to =3D 0},
> +                "chain-reply-to" =3D> \$chain_reply_to,
> +                "no-chain-reply-to|nochain-reply-to" =3D> sub {$chain_=
reply_to =3D 0},

Thanks for a very helpful review, as always.

Todd Zullinger (2):
  perl: bump the required Perl version to 5.8.1 from 5.8.0
  send-email: avoid duplicate specification warnings

 Documentation/CodingGuidelines          |  2 +-
 INSTALL                                 |  2 +-
 contrib/diff-highlight/DiffHighlight.pm |  2 +-
 contrib/mw-to-git/Git/Mediawiki.pm      |  2 +-
 git-archimport.perl                     |  2 +-
 git-cvsexportcommit.perl                |  2 +-
 git-cvsimport.perl                      |  2 +-
 git-cvsserver.perl                      |  2 +-
 git-send-email.perl                     | 23 ++++++++---------------
 git-svn.perl                            |  2 +-
 gitweb/INSTALL                          |  2 +-
 gitweb/gitweb.perl                      |  2 +-
 perl/Git.pm                             |  2 +-
 perl/Git/I18N.pm                        |  2 +-
 perl/Git/LoadCPAN.pm                    |  2 +-
 perl/Git/LoadCPAN/Error.pm              |  2 +-
 perl/Git/LoadCPAN/Mail/Address.pm       |  2 +-
 perl/Git/Packet.pm                      |  2 +-
 t/t0202/test.pl                         |  2 +-
 t/t5562/invoke-with-content-length.pl   |  2 +-
 t/t9700/test.pl                         |  2 +-
 t/test-terminal.perl                    |  2 +-
 22 files changed, 29 insertions(+), 36 deletions(-)

Range-diff against v2:
-:  ---------- > 1:  b276216a53 perl: bump the required Perl version to 5=
.8.1 from 5.8.0
1:  59e2c79085 ! 2:  e076a2ede5 send-email: avoid duplicate specification=
 warnings
    @@ Metadata
      ## Commit message ##
         send-email: avoid duplicate specification warnings
    =20
    -    With perl-Getopt-Long >=3D 2.55 a warning is issued for options =
which are
    -    specified more than once.  In addition to causing users to see w=
arnings,
    -    this results in test failures which compare the output.  An exam=
ple,
    -    from t9001-send-email.37:
    +    A warning is issued for options which are specified more than on=
ce
    +    beginning with perl-Getopt-Long >=3D 2.55.  In addition to causi=
ng users
    +    to see warnings, this results in test failures which compare the=
 output.
    +    An example, from t9001-send-email.37:
    =20
           | +++ diff -u expect actual
           | --- expect      2023-11-14 10:38:23.854346488 +0000
    @@ Commit message
           | error: last command exited with $?=3D1
           | not ok 37 - reject long lines
    =20
    -    Remove the duplicate option specs.
    +    Remove the duplicate option specs.  These are primarily the expl=
icit
    +    '--no-' prefix opts which were added in f471494303 (git-send-ema=
il.perl:
    +    support no- prefix with older GetOptions, 2015-01-30).  This was=
 done
    +    specifically to support perl-5.8.0 which includes Getopt::Long 2=
.32[1].
    +
    +    Getopt::Long 2.33 added support for the '--no-' prefix natively =
by
    +    appending '!' to the option specification string, which was incl=
uded in
    +    perl-5.8.1 and is not present in perl-5.8.0.  The previous commi=
t bumped
    +    the minimum supported Perl version to 5.8.1 so we no longer need=
 to
    +    provide the '--no-' variants for negatable options manually.
    =20
         Teach `--git-completion-helper` to output the '--no-' options.  =
They are
         not included in the options hash and would otherwise be lost.
    =20
         Signed-off-by: Todd Zullinger <tmz@pobox.com>
    =20
      ## git-send-email.perl ##
     @@ git-send-email.perl: sub completion_helper {
     =20
      	foreach my $key (keys %$original_opts) {
      		unless (exists $not_for_completion{$key}) {
     -			$key =3D~ s/!$//;
    -+			my $negate =3D ($key =3D~ s/!$//);
    ++			my $negatable =3D ($key =3D~ s/!$//);
     =20
      			if ($key =3D~ /[:=3D][si]$/) {
      				$key =3D~ s/[:=3D][si]$//;
      				push (@send_email_opts, "--$_=3D") foreach (split (/\|/, $key))=
;
      			} else {
      				push (@send_email_opts, "--$_") foreach (split (/\|/, $key));
    -+				if ($negate) {
    ++				if ($negatable) {
     +					push (@send_email_opts, "--no-$_") foreach (split (/\|/, $key)=
);
     +				}
      			}
2:  c1f37d4395 < -:  ---------- send-email: remove stray characters from =
usage
--=20
2.43.0.rc2


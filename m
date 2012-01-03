From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 1/2] git-svn, perl/Git.pm: add central method for
 prompting passwords honoring GIT_ASKPASS and SSH_ASKPASS
Date: Tue, 3 Jan 2012 11:17:10 +0100
Message-ID: <CACBZZX7P9PEq0wZp0d3dSwDjF6J6Z3cO4VtWc9_frBengtqPLw@mail.gmail.com>
References: <4EC52508.9070907@tu-clausthal.de> <CABPQNSZ0iPAE+BnDU6Nz8_PkrAtPbjL4RoJuQS=Um2wxPt-2DQ@mail.gmail.com>
 <4EC65DE4.90005@tu-clausthal.de> <CABPQNSbfM0JRVPk3fxfSEq7QaO-fynHM8FBGpPribdgeRqpZKA@mail.gmail.com>
 <4ED0CE8B.70205@tu-clausthal.de> <20111130064401.GC5317@sigill.intra.peff.net>
 <4EF907F1.1030801@tu-clausthal.de> <m3d3baf5kd.fsf@localhost.localdomain>
 <4EF9D8B9.9060106@tu-clausthal.de> <4EF9EBF4.7070200@tu-clausthal.de>
 <4EF9ED58.8080205@tu-clausthal.de> <7vd3b967ql.fsf@alter.siamese.dyndns.org>
 <7vty4l4rr8.fsf@alter.siamese.dyndns.org> <4EFA5EB3.4000802@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: git-owner@vger.kernel.org Tue Jan 03 11:17:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ri1R4-0002DE-UO
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 11:17:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752181Ab2ACKRe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Jan 2012 05:17:34 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42106 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347Ab2ACKRc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jan 2012 05:17:32 -0500
Received: by eaad14 with SMTP id d14so8530265eaa.19
        for <git@vger.kernel.org>; Tue, 03 Jan 2012 02:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=z/pnGxkz+WqVWNQ0uercueq0uSMZqmWqgADB+KrHTLo=;
        b=br3Lica/P75FMc4Qj45mGwnn7lNIF7+Ymz6Q/tzxVXiHruAst/Wz++4RLzt69g81Gc
         fE5Rj7Ajbm2I6fCLo9HFuchBFeHydNC14oSBz+iellS7X45pYPFVuD4+d8DUpXRHgN17
         aBTgjBIXT6ZPaW4xxKiqf9xdLNGsRGZ+WU7vA=
Received: by 10.205.126.18 with SMTP id gu18mr11349481bkc.79.1325585851281;
 Tue, 03 Jan 2012 02:17:31 -0800 (PST)
Received: by 10.205.112.16 with HTTP; Tue, 3 Jan 2012 02:17:10 -0800 (PST)
In-Reply-To: <4EFA5EB3.4000802@tu-clausthal.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187856>

On Wed, Dec 28, 2011 at 01:11, Sven Strickroth
<sven.strickroth@tu-clausthal.de> wrote:

Nom nom, some Perl. Thanks for tackling this. Reviewing it as
requested by Junio.

> diff --git a/git-svn.perl b/git-svn.perl
> index eeb83d3..bcee8aa 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -4415,25 +4415,7 @@ sub username {
>
> =C2=A0sub _read_password {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0my ($prompt, $realm) =3D @_;
> - =C2=A0 =C2=A0 =C2=A0 my $password =3D '';
> - =C2=A0 =C2=A0 =C2=A0 if (exists $ENV{GIT_ASKPASS}) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 open(PH, "-|", $EN=
V{GIT_ASKPASS}, $prompt);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $password =3D <PH>=
;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $password =3D~ s/[=
\012\015]//; # \n\r
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 close(PH);
> - =C2=A0 =C2=A0 =C2=A0 } else {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print STDERR $prom=
pt;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 STDERR->flush;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 require Term::Read=
Key;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Term::ReadKey::Rea=
dMode('noecho');
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 while (defined(my =
$key =3D Term::ReadKey::ReadKey(0))) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 last if $key =3D~ /[\012\015]/; # \n\r
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 $password .=3D $key;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Term::ReadKey::Rea=
dMode('restore');
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print STDERR "\n";
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 STDERR->flush;
> - =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 my $password =3D Git->prompt($prompt);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$password;
> =C2=A0}
>
> diff --git a/perl/Git.pm b/perl/Git.pm
> index f7ce511..b1c7c50 100644
> --- a/perl/Git.pm
> +++ b/perl/Git.pm
> @@ -58,7 +58,7 @@ require Exporter;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 command_outpu=
t_pipe command_input_pipe command_close_pipe
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 command_bidi_=
pipe command_close_bidi_pipe
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 version exec_=
path html_path hash_object git_cmd_try
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0remote_refs
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0remote_refs =
prompt
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 temp_acquire =
temp_release temp_reset temp_path);
>
>
> @@ -512,6 +512,55 @@ C<git --html-path>). Useful mostly only internal=
ly.
> =C2=A0sub html_path { command_oneline('--html-path') }
>
>
> +=3Ditem prompt ( PROMPT )
> +
> +Query user C<PROMPT> and return answer from user.
> +
> +Check if GIT_ASKPASS or SSH_ASKPASS is set, use first matching for q=
uerying
> +user and return answer. If no *_ASKPASS variable is set, the variabl=
e is
> +empty or an error occoured, the terminal is tried as a fallback.
> +
> +=3Dcut
> +
> +sub prompt {
> + =C2=A0 =C2=A0 =C2=A0 my ($self, $prompt) =3D _maybe_self(@_);
> + =C2=A0 =C2=A0 =C2=A0 my $ret;
> + =C2=A0 =C2=A0 =C2=A0 if (exists $ENV{'GIT_ASKPASS'}) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $ret =3D _prompt($=
ENV{'GIT_ASKPASS'}, $prompt);
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 if (!defined $ret && exists $ENV{'SSH_ASKPASS'=
}) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $ret =3D _prompt($=
ENV{'SSH_ASKPASS'}, $prompt);
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 if (!defined $ret) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print STDERR $prom=
pt;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 STDERR->flush;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 require Term::Read=
Key;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Term::ReadKey::Rea=
dMode('noecho');
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 while (defined(my =
$key =3D Term::ReadKey::ReadKey(0))) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 last if $key =3D~ /[\012\015]/; # \n\r
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 $ret .=3D $key;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Term::ReadKey::Rea=
dMode('restore');
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print STDERR "\n";
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 STDERR->flush;
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 return $ret;
> +}

Personally I prefer not to write code I don't have to write. Here
you're doing:

    my ($self, $prompt) =3D _maybe_self(@_);

And then never using $self, so there's actually no reason for this to
be an object/class function. It could just be called as:

    my $password =3D Git::prompt($prompt);

Instead of:

    my $password =3D Git->prompt($prompt);

Which means you could change the first line to just:

    my ($prompt) =3D @_;

Which wouldn't leave the reader wondering why this needs to maybe
construct an object just to throw it away.

> +sub _prompt {
> + =C2=A0 =C2=A0 =C2=A0 my ($askpass, $prompt) =3D @_;
> + =C2=A0 =C2=A0 =C2=A0 unless ($askpass) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return undef;
> + =C2=A0 =C2=A0 =C2=A0 }

The empty list is false in Perl, so explicitly returning undef is
usually the wrong thing. It means that in list context you'll return a
true list (consisting of one undef element), instead of an empty false
one.

    $ perl -MData::Dump=3Ddump -wle 'sub a { return } sub b { return
undef }; my @lists =3D ([a()], [b()]); for (@lists) { print @$_ ? "true=
"
: "false" }'
    false
    true

You're not running into that error here since you always use scalar
context. But it's better just to do:

    if (xyz) {
        return;
    }

Unless you want this behavior.

But aside from that I find this code a bit bizarre. The caller is
doing:

    if (exists $ENV{'GIT_ASKPASS'}) {
    =C2=A0 =C2=A0 =C2=A0 =C2=A0 $ret =3D _prompt($ENV{'GIT_ASKPASS'}, $=
prompt);
    }
    if (!defined $ret && exists $ENV{'SSH_ASKPASS'}) {
    =C2=A0 =C2=A0 =C2=A0 =C2=A0 $ret =3D _prompt($ENV{'SSH_ASKPASS'}, $=
prompt);
    }

Which means we check whether *_ASKPASS *exists* in the env hash, and
then the function checks whether that value is true or not.

Which means the code implicitly depends on Perl's idea of true/false
values for the names of those commands. E.g. you can't create a
command called "0" and put it in your $PATH.

I suppose the case you actually care about is someone being able to do:

    export GIT_ASKPASS=3D

Instead of the better:

    unset GIT_ASKPASS

> + =C2=A0 =C2=A0 =C2=A0 my $ret;
> + =C2=A0 =C2=A0 =C2=A0 open my $fh, "-|", $askpass, $prompt || return=
 undef;

As pointed out already this is a logic error due to the ||.

But even if that worked I think this behavior is a bit
questionable. Why don't we just throw an error at this point? The way
I'd write this would be something like:

    my $pass =3D _prompt('GIT_ASKPASS', $prompt);

And then:

    sub _prompt {
        my ($env_var, $prompt) =3D @_;

        # or exists(), depending on whether we insist on "unset"
        return unless length $ENV{$env_var};

        my $command =3D $ENV{$env_var};
        open my $fh, "-|", $command or die "We can't get your password
from `$command' given in $env_var: $!";
        chomp(my $password =3D <$fh>);
        close $fh or die "We can't close() `$command' given in $env_var=
: $!";

        return $password;
    }

Which would give the user an error if his GIT_ASKPASS command
failed. Check the return value of close() too, and re-structure the
passing around of the env variable so we could give a sensible error
message.

> + =C2=A0 =C2=A0 =C2=A0 $ret =3D <$fh>;
> + =C2=A0 =C2=A0 =C2=A0 $ret =3D~ s/[\012\015]//g; # strip \n\r, chomp=
 does not work on all systems (i.e. windows) as expected

Urm yes it does. \n in Perl is magical and doesn't mean \012 like it
does in some languages. It means "The Platform's Native
Newline".

Which is \012 on Unix, \015\012 on Windows, and was \015 on Mac OS
until support for it was removed. This is covered in the second
section of "perldoc perlport".

Can you show me a case where it fails, and under what environment
exactly? Maybe it's e.g.s some Cygwin-specific peculiarity, in which
case we could check for that platform specifically.

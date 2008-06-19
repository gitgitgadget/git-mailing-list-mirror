From: avar@cpan.org (=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason)
Subject: Re: [PATCH] Authentication support for pserver
Date: Thu, 19 Jun 2008 17:38:32 +0000
Message-ID: <861w2tjpev.fsf@cpan.org>
References: <87wsrhex4c.fsf@cpan.org>
	<7vd4t9x2lw.fsf@gitster.siamese.dyndns.org> <87mysdepeh.fsf@cpan.org>
	<7vir31u210.fsf@gitster.siamese.dyndns.org> <877ijhm1b5.fsf@cpan.org>
	<46a038f90712180141x2f27e6cei5ef53339fd3f90dc@mail.gmail.com>
	<86r6ens6k5.fsf@cpan.org> <86iqzyse9u.fsf@cpan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	martyn@catalyst.net.nz, martin@catalyst.net.nz, avar@cpan.org
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 20:08:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9OYn-0003DV-0z
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 20:08:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752290AbYFSSHh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Jun 2008 14:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752294AbYFSSHh
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 14:07:37 -0400
Received: from u.nix.is ([208.78.101.240]:37893 "EHLO t"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752277AbYFSSHf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jun 2008 14:07:35 -0400
X-Greylist: delayed 1717 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Jun 2008 14:07:35 EDT
Received: from localhost
	([127.0.0.1] helo=t.cpan.org ident=avar)
	by t with esmtp (Exim 4.63)
	(envelope-from <avar@cpan.org>)
	id 1K9O5i-0001O1-Tx; Thu, 19 Jun 2008 17:38:34 +0000
In-Reply-To: <86iqzyse9u.fsf@cpan.org> (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?=
 Bjarmason"'s message of
	"Fri, 07 Mar 2008 16:13:49 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85500>

avar@cpan.org (=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason) writes:

> avar@cpan.org (=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason) writes:
>
>> Better late than never, here's a more complete and hopefully final p=
atch
>> to add authentication support to CVS. Thanks to Sam Vilain for
>> contributing and kicking me into action.
>>
>> Now you specify a user:password authentication database in the [gitc=
vs]
>> section. The passwords are crypt()-ed and can be produced by htpassw=
d,
>> example config file:
>>    =20
>>     [gitcvs]
>>         enabled =3D 1
>>         authdb =3D /tmp/authdb.htpasswd
>>    =20
>> The patch can be pulled from git://git.nix.is/avar/git
>>
>> It's also produced below:
>
> The patch needed a small fix, I didn't exit(1) after an error
> condition[1]. This can also be got at git://git.nix.is/avar/git and i=
s
> produced in full below:
>
>
> From 5900732b52c3a693bfb36c0bf56e3c5eb83ef65e Mon Sep 17 00:00:00 200=
1
> From: =3D?utf-8?q?=3DC3=3D86var=3D20Arnfj=3DC3=3DB6r=3DC3=3DB0=3D20Bj=
armason?=3D <avar@cpan.org>
> Date: Fri, 14 Dec 2007 08:08:46 +0000
> Subject: [PATCH] git-cvsserver: authentication support for pserver
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3Dutf-8
> Content-Transfer-Encoding: 8bit
>
> Allow git-cvsserver to use authentication over pserver mode.  The
> pserver user/password database is stored in the config file for each
> repository.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar@cpan.org>
> Worriedly-Acked-by: Martin Langhoff <martin.langhoff@gmail.com>
> ---
>  Documentation/git-cvsserver.txt |   21 +++++++++--
>  git-cvsserver.perl              |   74 +++++++++++++++++++++++++++++=
+++++----
>  2 files changed, 83 insertions(+), 12 deletions(-)
>
> diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvss=
erver.txt
> index d3e9993..98183d4 100644
> --- a/Documentation/git-cvsserver.txt
> +++ b/Documentation/git-cvsserver.txt
> @@ -69,9 +69,6 @@ plugin. Most functionality works fine with both of =
these clients.
>  LIMITATIONS
>  -----------
> =20
> -Currently cvsserver works over SSH connections for read/write client=
s, and
> -over pserver for anonymous CVS access.
> -
>  CVS clients cannot tag, branch or perform GIT merges.
> =20
>  git-cvsserver maps GIT branches to CVS modules. This is very differe=
nt
> @@ -81,7 +78,7 @@ one or more directories.
>  INSTALLATION
>  ------------
> =20
> -1. If you are going to offer anonymous CVS access via pserver, add a=
 line in
> +1. If you are going to offer CVS access via pserver, add a line in
>     /etc/inetd.conf like
>  +
>  --
> @@ -98,6 +95,22 @@ looks like
>     cvspserver stream tcp nowait nobody /usr/bin/git-cvsserver git-cv=
sserver pserver
> =20
>  ------
> +
> +Only anonymous access is provided by pserve by default. To commit yo=
u
> +will have to create pserver accounts, simply add a [gitcvs.users]
> +section to the repositories you want to access, for example:
> +
> +------
> +  =20
> +   [gitcvs.users]
> +        someuser =3D somepassword
> +        otheruser =3D otherpassword
> +  =20
> +------
> +Then provide your password via the pserver method, for example:
> +------
> +   cvs -d:pserver:someuser:somepassword <at> server/path/repo.git co=
 <HEAD_name>
> +------
>  No special setup is needed for SSH access, other than having GIT too=
ls
>  in the PATH. If you have clients that do not accept the CVS_SERVER
>  environment variable, you can rename git-cvsserver to cvs.
> diff --git a/git-cvsserver.perl b/git-cvsserver.perl
> index afe3d0b..9bc2ff5 100755
> --- a/git-cvsserver.perl
> +++ b/git-cvsserver.perl
> @@ -150,12 +150,35 @@ if ($state->{method} eq 'pserver') {
>         exit 1;
>      }
>      $line =3D <STDIN>; chomp $line;
> -    unless ($line eq 'anonymous') {
> -       print "E Only anonymous user allowed via pserver\n";
> -       print "I HATE YOU\n";
> -       exit 1;
> +    my $user =3D $line;
> +    $line =3D <STDIN>; chomp $line;
> +    my $password =3D $line;
> +
> +    unless ($user eq 'anonymous') {
> +        # Trying to authenticate a user
> +        if (not exists $cfg->{gitcvs}->{users}) {
> +            print "E the repo config file needs a [gitcvs.users] sec=
tion with user/password key-value pairs\n";
> +            print "I HATE YOU\n";
> +            exit 1;
> +        } elsif (exists $cfg->{gitcvs}->{users} and not exists $cfg-=
>{gitcvs}->{users}->{$user}) {
> +            #print "E the repo config file has a [gitcvs.users] sect=
ion but the user $user is not defined in it\n";
> +            print "I HATE YOU\n";
> +            exit 1;
> +        } else {
> +            my $descrambled_password =3D descramble($password);
> +            my $cleartext_password =3D $cfg->{gitcvs}->{users}->{$us=
er};
> +            if ($descrambled_password ne $cleartext_password) {
> +                #print "E The password supplied for user $user was i=
ncorrect\n";
> +                print "I HATE YOU\n";
> +                exit 1;
> +            }
> +            # else fall through to LOVE
> +        }
>      }
> -    $line =3D <STDIN>; chomp $line;    # validate the password?
> +
> +    # For checking whether the user is anonymous on commit
> +    $state->{user} =3D $user;
> +
>      $line =3D <STDIN>; chomp $line;
>      unless ($line eq "END $request REQUEST") {
>         die "E Do not understand $line -- expecting END $request REQU=
EST\n";
> @@ -273,7 +296,7 @@ sub req_Root
>      }
>      foreach my $line ( @gitvars )
>      {
> -        next unless ( $line =3D~ /^(gitcvs)\.(?:(ext|pserver)\.)?([\=
w-]+)=3D(.*)$/ );
> +        next unless ( $line =3D~ /^(gitcvs)\.(?:(ext|pserver|users)\=
=2E)?([\w-]+)=3D(.*)$/ );
>          unless ($2) {
>              $cfg->{$1}{$3} =3D $4;
>          } else {
> @@ -1176,9 +1199,9 @@ sub req_ci
> =20
>      $log->info("req_ci : " . ( defined($data) ? $data : "[NULL]" ));
> =20
> -    if ( $state->{method} eq 'pserver')
> +    if ($state->{method} eq 'pserver' and $state->{user} eq 'anonymo=
us')
>      {
> -        print "error 1 pserver access cannot commit\n";
> +        print "error 1 anonymous user cannot commit via pserver\n";
>          exit;
>      }
> =20
> @@ -2107,6 +2130,41 @@ sub kopts_from_path
>      }
>  }
> =20
> +
> +sub descramble
> +{
> +    # This table is from src/scramble.c in the CVS source
> +    my @SHIFTS =3D (
> +        0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 1=
5,
> +        16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, =
31,
> +        114,120, 53, 79, 96,109, 72,108, 70, 64, 76, 67,116, 74, 68,=
 87,
> +        111, 52, 75,119, 49, 34, 82, 81, 95, 65,112, 86,118,110,122,=
105,
> +        41, 57, 83, 43, 46,102, 40, 89, 38,103, 45, 50, 42,123, 91, =
35,
> +        125, 55, 54, 66,124,126, 59, 47, 92, 71,115, 78, 88,107,106,=
 56,
> +        36,121,117,104,101,100, 69, 73, 99, 63, 94, 93, 39, 37, 61, =
48,
> +        58,113, 32, 90, 44, 98, 60, 51, 33, 97, 62, 77, 84, 80, 85,2=
23,
> +        225,216,187,166,229,189,222,188,141,249,148,200,184,136,248,=
190,
> +        199,170,181,204,138,232,218,183,255,234,220,247,213,203,226,=
193,
> +        174,172,228,252,217,201,131,230,197,211,145,238,161,179,160,=
212,
> +        207,221,254,173,202,146,224,151,140,196,205,130,135,133,143,=
246,
> +        192,159,244,239,185,168,215,144,139,165,180,157,147,186,214,=
176,
> +        227,231,219,169,175,156,206,198,129,164,150,210,154,177,134,=
127,
> +        182,128,158,208,162,132,167,209,149,241,153,251,237,236,171,=
195,
> +        243,233,253,240,194,250,191,155,142,137,245,235,163,242,178,=
152
> +    );
> +    my ($str) =3D @_;
> +
> +    # This should never happen, the same password format (A) bas bee=
n
> +    # used by CVS since the beginning of time
> +    $str =3D~ s/^(.)//;
> +    die "invalid password format $1" unless $1 eq 'A';
> +
> +    $str =3D~ s/(.)/chr $SHIFTS[ord $1]/ge;
> +
> +    return $str;
> +}
> +
> +
>  package GITCVS::log;
> =20
>  ####
> --=20
> 1.5.3.rc3.120.g68d422
>
>
> From f59c255ed14c5b80d5328f94f6934461cfe454da Mon Sep 17 00:00:00 200=
1
> From: Sam Vilain <sam.vilain@catalyst.net.nz>
> Date: Fri, 7 Mar 2008 11:03:14 +1300
> Subject: [PATCH] git-cvsserver: use a password file cvsserver pserver
>
> If a git repository is shared via HTTP, the config file is typically
> visible.  Use an external file instead.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar@cpan.org>
> ---
>  Documentation/git-cvsserver.txt |   21 ++++++++++++++++-----
>  git-cvsserver.perl              |   27 ++++++++++++++-------------
>  2 files changed, 30 insertions(+), 18 deletions(-)
>
> diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvss=
erver.txt
> index 98183d4..c642f12 100644
> --- a/Documentation/git-cvsserver.txt
> +++ b/Documentation/git-cvsserver.txt
> @@ -97,16 +97,27 @@ looks like
>  ------
> =20
>  Only anonymous access is provided by pserve by default. To commit yo=
u
> -will have to create pserver accounts, simply add a [gitcvs.users]
> -section to the repositories you want to access, for example:
> +will have to create pserver accounts, simply add a gitcvs.authdb
> +setting in the config file of the repositories you want the cvsserve=
r
> +to allow writes to, for example:
> =20
>  ------
>    =20
> -   [gitcvs.users]
> -        someuser =3D somepassword
> -        otheruser =3D otherpassword
> +   [gitcvs]
> +        authdb =3D /etc/cvsserver/passwd
>    =20
>  ------
> +The format of these files is username followed by the crypted passwo=
rd,
> +for example:
> +
> +------
> +   myuser:$1Oyx5r9mdGZ2
> +   myuser:$1$BA)@$vbnMJMDym7tA32AamXrm./
> +------
> +You can use the 'htpasswd' facility that comes with Apache to make t=
hese
> +files, but Apache's MD5 crypt method differs from the one used by mo=
st C
> +library's crypt() function, so don't use the -m option.
> +
>  Then provide your password via the pserver method, for example:
>  ------
>     cvs -d:pserver:someuser:somepassword <at> server/path/repo.git co=
 <HEAD_name>
> diff --git a/git-cvsserver.perl b/git-cvsserver.perl
> index 9bc2ff5..e54cbcd 100755
> --- a/git-cvsserver.perl
> +++ b/git-cvsserver.perl
> @@ -156,24 +156,25 @@ if ($state->{method} eq 'pserver') {
> =20
>      unless ($user eq 'anonymous') {
>          # Trying to authenticate a user
> -        if (not exists $cfg->{gitcvs}->{users}) {
> -            print "E the repo config file needs a [gitcvs.users] sec=
tion with user/password key-value pairs\n";
> +        if (not exists $cfg->{gitcvs}->{authdb}) {
> +            print "E the repo config file needs a [gitcvs.authdb] se=
ction with a filename\n";
>              print "I HATE YOU\n";
>              exit 1;
> -        } elsif (exists $cfg->{gitcvs}->{users} and not exists $cfg-=
>{gitcvs}->{users}->{$user}) {
> -            #print "E the repo config file has a [gitcvs.users] sect=
ion but the user $user is not defined in it\n";
> +        }
> +	my $auth_ok;
> +	open PASSWD, "<$cfg->{gitcvs}->{authdb}" or die $!;
> +	while(<PASSWD>) {
> +	    if (m{^\Q$user\E:(.*)}) {
> +		if (crypt($user, $1) eq $1) {
> +		    $auth_ok =3D 1;
> +		}
> +	    };
> +	}
> +	unless ($auth_ok) {
>              print "I HATE YOU\n";
>              exit 1;
> -        } else {
> -            my $descrambled_password =3D descramble($password);
> -            my $cleartext_password =3D $cfg->{gitcvs}->{users}->{$us=
er};
> -            if ($descrambled_password ne $cleartext_password) {
> -                #print "E The password supplied for user $user was i=
ncorrect\n";
> -                print "I HATE YOU\n";
> -                exit 1;
> -            }
> -            # else fall through to LOVE
>          }
> +        # else fall through to LOVE
>      }
> =20
>      # For checking whether the user is anonymous on commit
> --=20
> 1.5.3.rc3.120.g68d422
>
>
> From e8b69f313888900447f45ac3a8dceb38bd5c261e Mon Sep 17 00:00:00 200=
1
> From: =3D?utf-8?q?=3DC3=3D86var=3D20Arnfj=3DC3=3DB6r=3DC3=3DB0=3D20Bj=
armason?=3D <avar@cpan.org>
> Date: Thu, 6 Mar 2008 23:43:13 +0000
> Subject: [PATCH] Indent the last commit to fit with the rest of the c=
ode.
>
> Use lexical filehandles instead of global globs
>
> Close the filehandle after the password database has been read
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar@cpan.org>
> ---
>  git-cvsserver.perl |   23 +++++++++++++----------
>  1 files changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/git-cvsserver.perl b/git-cvsserver.perl
> index e54cbcd..f956ac9 100755
> --- a/git-cvsserver.perl
> +++ b/git-cvsserver.perl
> @@ -161,16 +161,19 @@ if ($state->{method} eq 'pserver') {
>              print "I HATE YOU\n";
>              exit 1;
>          }
> -	my $auth_ok;
> -	open PASSWD, "<$cfg->{gitcvs}->{authdb}" or die $!;
> -	while(<PASSWD>) {
> -	    if (m{^\Q$user\E:(.*)}) {
> -		if (crypt($user, $1) eq $1) {
> -		    $auth_ok =3D 1;
> -		}
> -	    };
> -	}
> -	unless ($auth_ok) {
> +
> +        my $auth_ok;
> +        open my $passwd, "<", $cfg->{gitcvs}->{authdb} or die $!;
> +        while (<$passwd>) {
> +            if (m{^\Q$user\E:(.*)}) {
> +                if (crypt($user, $1) eq $1) {
> +                    $auth_ok =3D 1;
> +                }
> +            };
> +        }
> +        close $passwd;
> +
> +        unless ($auth_ok) {
>              print "I HATE YOU\n";
>              exit 1;
>          }
> --=20
> 1.5.3.rc3.120.g68d422
>
>
> From 90d3468556b46fc649a9408af42ff24ed2e50455 Mon Sep 17 00:00:00 200=
1
> From: =3D?utf-8?q?=3DC3=3D86var=3D20Arnfj=3DC3=3DB6r=3DC3=3DB0=3D20Bj=
armason?=3D <avar@cpan.org>
> Date: Fri, 7 Mar 2008 00:06:52 +0000
> Subject: [PATCH] Produce an error if the user tries to supply a passw=
ord for anonymous
>
> Clarify the error message produced when there's no [gitcvs.authdb]
>
> Produce an E error if the authdb doesn't exist instead of spewing $!
> to the user
>
> do crypt($user, descramble($pass)) eq $hash; crypt($user, $hash) eq
> $hash would accept any password
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar@cpan.org>
> ---
>  git-cvsserver.perl |   28 +++++++++++++++++++++++-----
>  1 files changed, 23 insertions(+), 5 deletions(-)
>
> diff --git a/git-cvsserver.perl b/git-cvsserver.perl
> index f956ac9..aa0299e 100755
> --- a/git-cvsserver.perl
> +++ b/git-cvsserver.perl
> @@ -154,19 +154,36 @@ if ($state->{method} eq 'pserver') {
>      $line =3D <STDIN>; chomp $line;
>      my $password =3D $line;
> =20
> -    unless ($user eq 'anonymous') {
> +    if ($user eq 'anonymous') {
> +        # "A" will be 1 byte, use length instead in case the
> +        # encryption method ever changes (yeah, right!)
> +        if (length($password) > 1 ) {
> +            print "E Don't supply a password for the `anonymous' use=
r\n";
> +            print "I HATE YOU\n";
> +        }
> +
> +        # Fall through to LOVE
> +    } else {
>          # Trying to authenticate a user
>          if (not exists $cfg->{gitcvs}->{authdb}) {
> -            print "E the repo config file needs a [gitcvs.authdb] se=
ction with a filename\n";
> +            print "E the repo config file needs a [gitcvs] section w=
ith an 'authdb' parameter set to the filename of the authentication dat=
abase\n";
> +            print "I HATE YOU\n";
> +            exit 1;
> +        }
> +
> +        my $authdb =3D $cfg->{gitcvs}->{authdb};
> +
> +        unless (-e $authdb) {
> +            print "E The authentication database specified in [gitcv=
s.authdb] does not exist\n";
>              print "I HATE YOU\n";
>              exit 1;
>          }
> =20
>          my $auth_ok;
> -        open my $passwd, "<", $cfg->{gitcvs}->{authdb} or die $!;
> +        open my $passwd, "<", $authdb or die $!;
>          while (<$passwd>) {
>              if (m{^\Q$user\E:(.*)}) {
> -                if (crypt($user, $1) eq $1) {
> +                if (crypt($user, descramble($password)) eq $1) {
>                      $auth_ok =3D 1;
>                  }
>              };
> @@ -177,7 +194,8 @@ if ($state->{method} eq 'pserver') {
>              print "I HATE YOU\n";
>              exit 1;
>          }
> -        # else fall through to LOVE
> +
> +        # Fall through to LOVE
>      }
> =20
>      # For checking whether the user is anonymous on commit
> --=20
> 1.5.3.rc3.120.g68d422
>
>
> From a55dfa2667da1473199ee70ca6cfd53094001119 Mon Sep 17 00:00:00 200=
1
> From: =3D?utf-8?q?=3DC3=3D86var=3D20Arnfj=3DC3=3DB6r=3DC3=3DB0=3D20Bj=
armason?=3D <avar@cpan.org>
> Date: Fri, 7 Mar 2008 00:09:14 +0000
> Subject: [PATCH] document a perl snippet to produce passwords for tho=
se that don't have htpasswd
>
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar@cpan.org>
> ---
>  Documentation/git-cvsserver.txt |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvss=
erver.txt
> index c642f12..d410a11 100644
> --- a/Documentation/git-cvsserver.txt
> +++ b/Documentation/git-cvsserver.txt
> @@ -118,6 +118,11 @@ You can use the 'htpasswd' facility that comes w=
ith Apache to make these
>  files, but Apache's MD5 crypt method differs from the one used by mo=
st C
>  library's crypt() function, so don't use the -m option.
> =20
> +Alternatively you can produce the password with perl's crypt() opera=
tor:
> +-----
> +   perl -e 'my ($user, $pass) =3D @ARGV; printf "%s:%s\n", $user, cr=
ypt($user, $pass)' $USER password
> +-----
> +
>  Then provide your password via the pserver method, for example:
>  ------
>     cvs -d:pserver:someuser:somepassword <at> server/path/repo.git co=
 <HEAD_name>
> --=20
> 1.5.3.rc3.120.g68d422
>
>
> From 60f893bd9fe329bd5cf8ec513d10ec00e85feb2c Mon Sep 17 00:00:00 200=
1
> From: =3D?utf-8?q?=3DC3=3D86var=3D20Arnfj=3DC3=3DB6r=3DC3=3DB0=3D20Bj=
armason?=3D <avar@cpan.org>
> Date: Fri, 7 Mar 2008 16:06:31 +0000
> Subject: [PATCH] exit after producing the error about anonymous havin=
g a password
>
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar@cpan.org>
> ---
>  git-cvsserver.perl |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/git-cvsserver.perl b/git-cvsserver.perl
> index aa0299e..da48ebd 100755
> --- a/git-cvsserver.perl
> +++ b/git-cvsserver.perl
> @@ -160,6 +160,7 @@ if ($state->{method} eq 'pserver') {
>          if (length($password) > 1 ) {
>              print "E Don't supply a password for the `anonymous' use=
r\n";
>              print "I HATE YOU\n";
> +            exit 1;
>          }
> =20
>          # Fall through to LOVE
> --=20
> 1.5.3.rc3.120.g68d422
>
>
>
> 1. http://git.nix.is/?p=3Davar/git;a=3Dcommitdiff;h=3D60f893bd9fe329b=
d5cf8ec513d10ec00e85feb2c

It has been over 3 months since I submitted this patch without anyone
acting on it. In absence of comment from the Mart[yi]ns could this
please applied anyway?

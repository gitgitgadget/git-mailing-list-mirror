From: "Tom G. Christensen" <tgc@statsbiblioteket.dk>
Subject: Re: [PATCH/RFC] perl: bump the required Perl version to 5.8 from
 5.6.[21]
Date: Mon, 27 Sep 2010 09:36:32 +0200
Message-ID: <4CA04980.3070300@statsbiblioteket.dk>
References: <AANLkTikp0mkFHYCdgqThfoFr3VkVECDmW6qE3+DSSHaq@mail.gmail.com> <1285358453-19292-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Tor Arntsen <tor@spacetec.no>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 27 09:46:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P08Q8-00046H-AV
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 09:46:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758903Ab0I0Hqj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Sep 2010 03:46:39 -0400
Received: from sbexch03.sb.statsbiblioteket.dk ([130.225.24.68]:50991 "EHLO
	sbexch03.sb.statsbiblioteket.dk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755201Ab0I0Hqj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Sep 2010 03:46:39 -0400
X-Greylist: delayed 604 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Sep 2010 03:46:38 EDT
Received: from [130.225.25.159] (130.225.25.159) by
 sbexch03.sb.statsbiblioteket.dk (130.225.24.68) with Microsoft SMTP Server id
 8.1.436.0; Mon, 27 Sep 2010 09:36:32 +0200
User-Agent: Thunderbird 2.0.0.24 (X11/20100916)
In-Reply-To: <1285358453-19292-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157316>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> Formalize our dependency on perl 5.8, bumped from 5.6.[12]. We alread=
y
> used the three-arg form of open() which was introduced in 5.6.1, but
> t/t9700/test.pl explicitly depended on 5.6.2.
>=20
> However git-add--interactive.pl has been failing on the 5.6 line sinc=
e
> it was introduced in v1.5.0-rc0~12^2~2 back in 2006 due to this open
> syntax:
>=20
>     sub run_cmd_pipe {
>            my $fh =3D undef;
>            open($fh, '-|', @_) or die;
>            return <$fh>;
>     }
>=20
This issue and possible solutions was previously discussed in-depth her=
e:
http://article.gmane.org/gmane.comp.version-control.git/94394

> Which when executed dies on "Can't use an undefined value as
> filehandle reference". Several of our tests also fail on 5.6 (even
> more when compiled with NO_PERL_MAKEMAKER=3D1):
>=20
>     t2016-checkout-patch.sh
>     t3904-stash-patch.sh
>     t3701-add-interactive.sh
>     t7105-reset-patch.sh
>     t7501-commit.sh
>     t9700-perl-git.sh
>=20
> Our code is bitrotting on 5.6 with no-one interested in fixing it, an=
d
> pinning us to such an ancient release of Perl is keeping us from usin=
g
> useful features introduced in the 5.8 release.
>=20
=46WIW I build rpms and run git on RHEL 2.1 with perl 5.6.1.

These are the settings I use:
NO_CURL=3D1 (curl 7.8.1 is too old)
NO_TCLTK=3D1 (tcl/tk 8.3 is too old)
NO_NSEC=3D1
NO_EXTERNAL_GREP=3D1 (GNU grep 2.4.2 is apparently too old)
NO_REGEX=3D1 (glibc regex breaks t7008.11, also needed for el3)
NO_PERL_MAKEMAKER=3D1 (ExtUtils::MakeMaker is too old)

GIT_SKIP_TESTS=3D"t2016 t3701 t3904 t7105 t7501.21"

Additionally to fix NO_PERL_MAKEMAKER I use this patch:
http://article.gmane.org/gmane.comp.version-control.git/130159

To build with OpenSSL 0.9.6 I also add this in git-compat-util.h:
# if SSLEAY_VERSION_NUMBER < 0x00907000L
# define HMAC_CTX_cleanup    HMAC_cleanup
# endif

With these settings I have zero testsuite failures (just verified with=20
1.7.3).
t9700 is automatically skipped because Test::More is not available in=20
perl 5.6.1. gitweb requires 5.8 and is also skipped automatically.
I do not have subversion available on RHEL 2.1 so those tests are also=20
skipped.
CVS server/import tests are skipped because I do not have cvsps and=20
perl-SQLite available.

IIRC there has been no change in the functionality with perl 5.6.1 sinc=
e=20
the last time the 'open syntax' issue was discussed.

Having the specific parts known not to work with perl 5.6.x fail=20
gracefully at runtime would be an improvement.

-tgc

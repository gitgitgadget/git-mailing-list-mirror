From: Jan Viktorin <viktorin@rehivetech.com>
Subject: Re: [PATCH v2] send-email: provide whitelist of SMTP AUTH
 mechanisms
Date: Wed, 5 Aug 2015 09:17:47 +0200
Organization: RehiveTech, spol. s r.o.
Message-ID: <20150805091747.242e8fa1@jvn>
References: <1438533769-17460-1-git-send-email-viktorin@rehivetech.com>
	<CAPig+cQwFxVtO1C_RAumGP6_et21ggORB4jhpcUtBYNznNH1qA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 09:18:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMsxl-0006z2-Pi
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 09:18:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbbHEHSE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2015 03:18:04 -0400
Received: from w-smtp-out-7.wedos.net ([46.28.106.5]:58170 "EHLO
	we2-f167.wedos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750735AbbHEHSD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2015 03:18:03 -0400
Received: from ([109.81.211.51])
        by we2-f167.wedos.net (WEDOS Mail Server mail2) with ASMTP id STW00157;
        Wed, 05 Aug 2015 09:17:57 +0200
In-Reply-To: <CAPig+cQwFxVtO1C_RAumGP6_et21ggORB4jhpcUtBYNznNH1qA@mail.gmail.com>
X-Mailer: Claws Mail 3.12.0 (GTK+ 2.24.28; x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275352>

Hello Eric, all,

thanks for comments, the coding style will be fixed
in the next version (I cannot find a way how to set
vim to help me with those if<SPACE>( issues. I always/often
forget it when writing so I never do it to be consistent.).

Do I understand well that you are complaining about too
narrow commmit message?

I am trying to figure out how to write a test. It is
not very clear to me, what the testing suite does. My
attempt looks this way at the moment:

1657 do_smtp_auth_test() {
1658         git send-email \
1659                 --from="Example <nobody@example.com>" \
1660                 --to=someone@example.com \
1661                 --smtp-server="$(pwd)/fake.sendmail" \
1662                 --smtp-auth="$1" \
1663                 -v \
1664                 0001-*.patch \
1665                 2>errors >out
1666 }
1667 
1668 test_expect_success $PREREQ 'accepts SMTP AUTH mechanisms (see RFC-4422, p. 8)' '
1669         do_smtp_auth_test "PLAIN LOGIN CRAM-MD5 DIGEST-MD5 GSSAPI EXTERNAL ANONYMOUS" &&
1670         do_smtp_auth_test "ABCDEFGHIKLMNOPQRSTUVWXYZ 0123456789_-"
1671 '
1672 
1673 test_expect_success $PREREQ 'does not accept non-RFC-4422 strings for SMTP AUTH' '
1674         test_must_fail do_smtp_auth_test "../ATTACK" &&
1675         test_must_fail do_smtp_auth_test "TOO-LONG-BUT-VALID-STRING" &&
1676         test_must_fail do_smtp_auth_test "no-lower-case-sorry"
1677 '

* I do not know yet, what to check after each do_smtp_auth_test call.
* Perhaps, each case should have its own test_expect_success call?
* Why send-email -v does not generate any output?
  (I found a directory 'trash directory.t9001-send-email', however, the
  errors file is always empty.)
* Is there any other place where the files out, errors are placed?
* I have no idea what the fake.sendmail does (I could see its contents
  but still...). Is it suitable for my tests?
* Should I check the behaviour '--smtp-auth overrides
  sendemail.smtpAuth'?

Regards
Jan

On Sun, 2 Aug 2015 14:57:19 -0400
Eric Sunshine <sunshine@sunshineco.com> wrote:

> On Sun, Aug 2, 2015 at 12:42 PM, Jan Viktorin
> <viktorin@rehivetech.com> wrote:
> > When sending an e-mail, the client and server must
> > agree on an authentication mechanism. Some servers
> > (due to misconfiguration or a bug) deny valid
> > credentials for certain mechanisms. In this patch,
> > a new option --smtp-auth and configuration entry
> > smtpauth are introduced. If smtp_auth is defined,
> > it works as a whitelist of allowed mechanisms for
> > authentication selected from the ones supported by
> > the installed SASL perl library.
> 
> Nit: This would read a bit more nicely if wrapped to 70-72 columns.
> 
> > Signed-off-by: Jan Viktorin <viktorin@rehivetech.com>
> > ---
> > diff --git a/Documentation/git-send-email.txt
> > b/Documentation/git-send-email.txt index 7ae467b..c237c80 100644
> > --- a/Documentation/git-send-email.txt
> > +++ b/Documentation/git-send-email.txt
> > @@ -171,6 +171,14 @@ Sending
> > +--smtp-auth=<mechs>::
> > +       Specify allowed SMTP-AUTH mechanisms. This setting forces
> > using only
> > +       the listed mechanisms. Separate allowed mechanisms by a
> > whitespace.
> 
> Perhaps:
> 
>     Whitespace-separated list of allowed SMTP-AUTH mechanisms.
> 
> > +       Example: PLAIN LOGIN GSSAPI. If at least one of the
> > specified mechanisms
> > +       matchs those advertised by the SMTP server and it is
> > supported by the SASL
> 
> s/matchs/matches/
> 
> > +       library we use, it is used for authentication. If neither
> > of 'sendemail.smtpAuth'
> > +       or '--smtp-auth' is specified, all mechanisms supported on
> > client can be used.
> 
> s/neither of/neither/
> s/or/nor/
> 
> > diff --git a/git-send-email.perl b/git-send-email.perl
> > index ae9f869..ebc1e90 100755
> > --- a/git-send-email.perl
> > +++ b/git-send-email.perl
> > @@ -75,6 +75,9 @@ git send-email [options] <file | directory |
> > rev-list options > Pass an empty string to disable certificate
> >                                       verification.
> >      --smtp-domain           <str>  * The domain name sent to
> > HELO/EHLO handshake
> > +    --smtp-auth             <str>  * Space separated list of
> > allowed AUTH methods.
> 
> s/Space separated/Space-separated/
> 
> > +                                     This setting forces to use
> > one of the listed methods.
> > +                                     Supported: PLAIN LOGIN
> > CRAM-MD5 DIGEST-MD5.
> 
> Since you're no longer checking explicitly for these mechanisms, you
> probably want to drop the "Supported:" line.
> 
> >      --smtp-debug            <0|1>  * Disable, enable Net::SMTP
> > debug.
> >
> >    Automating:
> > @@ -1136,6 +1141,10 @@ sub smtp_auth_maybe {
> >                 Authen::SASL->import(qw(Perl));
> >         };
> >
> > +       if($smtp_auth !~ /^(\b[A-Z0-9-_]{1,20}\s*)*$/) {
> > +               die "invalid smtp auth: '${smtp_auth}'";
> > +       }
> 
> Style: space after 'if'
> 
> >         # TODO: Authentication may fail not because credentials were
> >         # invalid but due to other reasons, in which we should not
> >         # reject credentials.
> > @@ -1148,6 +1157,20 @@ sub smtp_auth_maybe {
> >                 'password' => $smtp_authpass
> >         }, sub {
> >                 my $cred = shift;
> > +
> > +               if($smtp_auth) {
> 
> Style: space after 'if'
> 
> > +                       my $sasl = Authen::SASL->new(
> > +                               mechanism => $smtp_auth,
> > +                               callback => {
> > +                                       user => $cred->{'username'},
> > +                                       pass => $cred->{'password'},
> > +                                       authname =>
> > $cred->{'username'},
> > +                               }
> > +                       );
> > +
> > +                       return !!$smtp->auth($sasl);
> > +               }
> > +
> >                 return !!$smtp->auth($cred->{'username'},
> > $cred->{'password'}); });
> >
> > --
> > 2.5.0



-- 
  Jan Viktorin                E-mail: Viktorin@RehiveTech.com
  System Architect            Web:    www.RehiveTech.com
  RehiveTech                  Phone: +420 606 201 868
  Brno, Czech Republic

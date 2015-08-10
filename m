From: Jan Viktorin <viktorin@rehivetech.com>
Subject: Re: [PATCH v2] send-email: provide whitelist of SMTP AUTH
 mechanisms
Date: Mon, 10 Aug 2015 12:06:42 +0200
Organization: RehiveTech, spol. s r.o.
Message-ID: <20150810120642.2a0baac2@jvn>
References: <1438533769-17460-1-git-send-email-viktorin@rehivetech.com>
	<CAPig+cQwFxVtO1C_RAumGP6_et21ggORB4jhpcUtBYNznNH1qA@mail.gmail.com>
	<20150805091747.242e8fa1@jvn>
	<CAPig+cQ0fSc+rjzgDyaw4xvCPCswJLDcQSmbxXnxG-uc6zB0qA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 12:07:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOjzC-0003hC-Uc
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 12:07:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754802AbbHJKHO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 06:07:14 -0400
Received: from w-smtp-out-7.wedos.net ([46.28.106.5]:44233 "EHLO
	we2-f167.wedos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754697AbbHJKG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 06:06:57 -0400
Received: from ([109.81.211.201])
        by we2-f167.wedos.net (WEDOS Mail Server mail2) with ASMTP id XWQ00051;
        Mon, 10 Aug 2015 12:06:51 +0200
In-Reply-To: <CAPig+cQ0fSc+rjzgDyaw4xvCPCswJLDcQSmbxXnxG-uc6zB0qA@mail.gmail.com>
X-Mailer: Claws Mail 3.12.0 (GTK+ 2.24.28; x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275604>

On Sun, 9 Aug 2015 14:13:33 -0400
Eric Sunshine <sunshine@sunshineco.com> wrote:

> On Wed, Aug 5, 2015 at 3:17 AM, Jan Viktorin
> <viktorin@rehivetech.com> wrote:
> > Do I understand well that you are complaining about too
> > narrow commmit message?
> 
> Yes, I'm a complainer. ;-) It's minor, though, not a big deal, and
> certainly not worth a re-roll if that was the only issue. In fact,
> other than the undesirable "Supported:" line in the documentation, all
> comments on v2 were minor and not demanding of a re-roll.

:)

> 
> > I am trying to figure out how to write a test. It is
> > not very clear to me, what the testing suite does. My
> > attempt looks this way at the moment:
> >
> > 1657 do_smtp_auth_test() {
> > 1658         git send-email \
> > 1659                 --from="Example <nobody@example.com>" \
> > 1660                 --to=someone@example.com \
> > 1661                 --smtp-server="$(pwd)/fake.sendmail" \
> > 1662                 --smtp-auth="$1" \
> > 1663                 -v \
> > 1664                 0001-*.patch \
> > 1665                 2>errors >out
> > 1666 }
> > 1667
> > 1668 test_expect_success $PREREQ 'accepts SMTP AUTH mechanisms (see
> > RFC-4422, p. 8)' ' 1669         do_smtp_auth_test "PLAIN LOGIN
> > CRAM-MD5 DIGEST-MD5 GSSAPI EXTERNAL ANONYMOUS" && 1670
> > do_smtp_auth_test "ABCDEFGHIKLMNOPQRSTUVWXYZ 0123456789_-"
> 
> Wouldn't this one fail the regex check you added which limits the
> length to 20 characters?

Yes, it would fail. But it does not work anyway...

> 
> > 1671 '
> > 1672
> > 1673 test_expect_success $PREREQ 'does not accept non-RFC-4422
> > strings for SMTP AUTH' ' 1674         test_must_fail
> > do_smtp_auth_test "../ATTACK" && 1675         test_must_fail
> > do_smtp_auth_test "TOO-LONG-BUT-VALID-STRING" && 1676
> > test_must_fail do_smtp_auth_test "no-lower-case-sorry" 1677 '
> >
> > * I do not know yet, what to check after each do_smtp_auth_test
> > call.
> 
> If you were able somehow to capture the interaction with
> Auth::SASL::Perl, then you'd probably want to test if it received the
> whitelisted mechanisms specified via --smtp-auth, however... (see
> below)

--smtp-debug

> 
> > * Perhaps, each case should have its own test_expect_success call?
> 
> The grouping seems okay as-is.
> 
> > * Why send-email -v does not generate any output?
> 
> As far as I know, git-send-email doesn't accept a -v flag.

True, I confused it with --smtp-debug. However, what I did not
understand was the testing framework. The TAP harness discards
everything (I expected some automatic redirection to a file for each
test.). Later I found the --verbose option that allows to see some
output from tests.

> 
> >   (I found a directory 'trash directory.t9001-send-email', however,
> > the errors file is always empty.)
> 
> Was it empty even for the cases which should have triggered the
> validation regex to invoke die()?
> 
> > * Is there any other place where the files out, errors are placed?
> 
> No.
> 
> > * I have no idea what the fake.sendmail does (I could see its
> > contents but still...). Is it suitable for my tests?
> 
> It dumps its command-line arguments to one file ("commandline") and
> its stdin to another ("msgtxt"), but otherwise does no work. This is
> useful for tests which need to make sure that the command-line and/or
> message content gets augmented in some way, but won't help your case
> since it can't capture the script's interaction with
> Authen::SASL::Perl.

I can see it now. Either Perl implementation or a sendmail binary is
used. Unfortunately, this is very unfriendly for such testing.

> 
> > * Should I check the behaviour '--smtp-auth overrides
> >   sendemail.smtpAuth'?
> 
> That would be nice, but there doesn't seem to be a good way to do it
> via an existing testing mechanism since you can't check the
> git-sendemail's interaction with Auth::SASL::Perl. The same holds for
> your question above about what to check after each do_smtp_auth_test()
> call.
> 
> One possibility which comes to mind is to create a fake
> Authen::SASL::Perl which merely dumps its input mechanisms to a file,
> and arrange for the Perl search path to find the fake one instead. You
> could then check the output file to see if it reflects your
> expectations. However, this may be overkill and perhaps not worth the
> effort (especially if you're not a Perl programmer).

I think that Authen::SASL::Perl mock would not help. I wanted to create
some fake sendmail (but this is impossible as stated above because
then the perl modules are not used). So the only way would be to
provide some fake socket with a static content on the other side. This
is really an overkill to just test the few lines of code.

So, what more can I do for this feature?

I think that the basic regex test is OK. It can accept lowercase
letters and do an explicit uppercase call. I do not like to rely on
internals of the SASL library. As you could see, the SASL::Perl does
not check its inputs in a very good way and its code is quite unclear
(strange for a library providing security features).

-- 
  Jan Viktorin                E-mail: Viktorin@RehiveTech.com
  System Architect            Web:    www.RehiveTech.com
  RehiveTech                  Phone: +420 606 201 868
  Brno, Czech Republic

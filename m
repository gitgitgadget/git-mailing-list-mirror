From: Jan Viktorin <viktorin@rehivetech.com>
Subject: Re: [PATCH v1] send-email: provide whitelist of SMTP AUTH
 mechanisms
Date: Sun, 2 Aug 2015 18:43:53 +0200
Organization: RehiveTech, spol. s r.o.
Message-ID: <20150802184353.2a5da936@jvn>
References: <1438385617-29159-1-git-send-email-viktorin@rehivetech.com>
	<CAPig+cT842GAFFM-wfjSU1ZiOevDCOPNDWxux6-vqtdr=3F4qw@mail.gmail.com>
	<20150801201950.5d8c1951@jvn>
	<CAPig+cQwgYYYYsszaRdJDwFLLB0PmiDQ_WTa+Nzzoq0U1zuMiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Aug 02 18:44:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLwMv-0001jU-9B
	for gcvg-git-2@plane.gmane.org; Sun, 02 Aug 2015 18:44:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752045AbbHBQoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Aug 2015 12:44:06 -0400
Received: from w-smtp-out-7.wedos.net ([46.28.106.5]:39768 "EHLO
	we2-f167.wedos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751602AbbHBQoE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Aug 2015 12:44:04 -0400
Received: from ([109.81.211.51])
        by we2-f167.wedos.net (WEDOS Mail Server mail2) with ASMTP id PCU00002;
        Sun, 02 Aug 2015 18:44:02 +0200
In-Reply-To: <CAPig+cQwgYYYYsszaRdJDwFLLB0PmiDQ_WTa+Nzzoq0U1zuMiA@mail.gmail.com>
X-Mailer: Claws Mail 3.12.0 (GTK+ 2.24.28; x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275144>

Authen::SASL gives:

No SASL mechanism found
 at /usr/share/perl5/vendor_perl/Authen/SASL.pm line 77.
 at /usr/share/perl5/core_perl/Net/SMTP.pm line 207.

The SASL library does not check validity of mechanisms'
names (or I did not find it). It just tries to load one
that matches both the ours and the server side ones.

I can see one possible weakness of this, however I doubt
whether there exists a successful attack vector. Imagine
that somebody gives me a malicious .gitconfig with
smtpauth = ~/ATTACK and redirects me to a fake mail
server that advertises ~/ATTACK as a working mechanism.
This might lead to an unwanted execution of ~/ATTACK.pm.
Should we consider this to be a threat?

Another thing that confuses me (I mentioned it in the
previous e-mail). I forced to use CRAM-MD5, however, it
dies with the above errors. The CRAM-MD5 is installed:

/usr/share/perl5/vendor_perl/Authen/SASL/CRAM_MD5.pm
/usr/share/perl5/vendor_perl/Authen/SASL/Perl/CRAM_MD5.pm

The same for DIGEST-MD5. On different PC with the same
set of libraries, OS, the CRAM-MD5 just works. Why? LOGIN
and PLAIN are OK. Environment? (I doubt.)

I would like to include the regex check based on RFC 4422
as I've already mentioned. at least, it filters out the
unwanted characters like '/', '.', etc.

Regards
Jan

On Sun, 2 Aug 2015 05:41:29 -0400
Eric Sunshine <sunshine@sunshineco.com> wrote:

> On Sat, Aug 1, 2015 at 2:19 PM, Jan Viktorin
> <viktorin@rehivetech.com> wrote:
> > On Sat, 1 Aug 2015 05:33:28 -0400 Eric Sunshine
> > <sunshine@sunshineco.com> wrote:
> >> On Fri, Jul 31, 2015 at 7:33 PM, Jan Viktorin
> >> <viktorin@rehivetech.com> wrote:
> >> At the very least, you will also want to update the documentation
> >> (Documentation/git-send-email.txt) and, if possible, add new tests
> >> (t/t9001-send-email.sh).
> >
> > I will update the documentation when it is clear, how the smtp-auth
> > works.
> >
> > I have no idea, how to test the feature. I can see something like
> > fake.sendmail in the file. How does it work? I can image a test
> > whether user inserts valid values. What more?
> 
> That's what I was thinking. You could test if the die() is triggered
> or if it emits warnings for bad values (assuming you implement that
> feature). As for testing the actual authentication, I'm not sure you
> can (and don't see any such testing in the script).
> 
> >> > diff --git a/git-send-email.perl b/git-send-email.perl
> >> > index ae9f869..b00ed9d 100755
> >> > --- a/git-send-email.perl
> >> > +++ b/git-send-email.perl
> >> > @@ -1129,6 +1134,16 @@ sub smtp_auth_maybe {
> >> >                 return 1;
> >> >         }
> >> >
> >> > +       # Do not allow arbitrary strings.
> >>
> >> Can you explain why this restriction is needed. What are the
> >> consequences of not limiting the input to this "approved" list?
> >
> > This is more a check of an arbitrary user input then a check
> > of an "approved list". It should be also used to inform user
> > about invalid methods (however, I didn't implemented it yet).
> 
> What I was really asking was whether this sort of checking really
> belongs in git-send-email or if it is better left to Net::SMTP (and
> Authen::SASL) to do so since they are in better positions to know what
> is valid and what is not. If the Perl module(s) generate suitable
> diagnostics for bad input, then it makes sense to leave the checking
> to them. If not, then I can understand your motivation for
> git-send-email doing the checking instead in order to emit
> user-friendly diagnostics.
> 
> So, that's what I meant when I asked 'What are the consequences of not
> limiting the input to this "approved" list?'.
> 
> The other reason I asked was that it increases maintenance costs for
> us to maintain a list of "approved" mechanisms, since the list needs
> to be updated when new ones are implemented (and, as brian pointed
> out, some may already exist which are not in your list).
>
> (...)
>
> >> Also, don't you want to warn the user about tokens that don't match
> >> one of the accepted (PLAIN, LOGIN, CRAM-MD5, DIGEST-MD5), rather
> >> than dropping them silently?
> >
> > Yes, this would be great (as I've already mentioned). It's a
> > question whether to include the check for the mechanisms or whether
> > to leave the $smtp_auth variable as it is... Maybe just validate by
> > a regex?
> >
> > The naming rules are defiend here:
> >  https://tools.ietf.org/html/rfc4422#page-8
> > So, this looks to me as a better way.
> 
> Maybe. This leads back to my original question of whether it's really
> git-send-email's responsibility to do validation or if that can be
> left to Net::SMTP/Authen::SASL. If the Perl module(s) emit suitable
> diagnostics for bad input, then validation can be omitted from
> git-send-email.



-- 
  Jan Viktorin                E-mail: Viktorin@RehiveTech.com
  System Architect            Web:    www.RehiveTech.com
  RehiveTech                  Phone: +420 606 201 868
  Brno, Czech Republic

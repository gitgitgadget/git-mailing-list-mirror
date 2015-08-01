From: Jan Viktorin <viktorin@rehivetech.com>
Subject: Re: [PATCH v1] send-email: provide whitelist of SMTP AUTH
 mechanisms
Date: Sat, 1 Aug 2015 20:19:50 +0200
Organization: RehiveTech, spol. s r.o.
Message-ID: <20150801201950.5d8c1951@jvn>
References: <1438385617-29159-1-git-send-email-viktorin@rehivetech.com>
	<CAPig+cT842GAFFM-wfjSU1ZiOevDCOPNDWxux6-vqtdr=3F4qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Aug 01 20:20:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLbOb-0004H7-Ma
	for gcvg-git-2@plane.gmane.org; Sat, 01 Aug 2015 20:20:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbbHASUG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Aug 2015 14:20:06 -0400
Received: from w-smtp-out-7.wedos.net ([46.28.106.5]:41515 "EHLO
	we2-f167.wedos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751247AbbHASUE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Aug 2015 14:20:04 -0400
Received: from ([109.81.211.51])
        by we2-f167.wedos.net (WEDOS Mail Server mail2) with ASMTP id OEV00101;
        Sat, 01 Aug 2015 20:20:01 +0200
In-Reply-To: <CAPig+cT842GAFFM-wfjSU1ZiOevDCOPNDWxux6-vqtdr=3F4qw@mail.gmail.com>
X-Mailer: Claws Mail 3.12.0 (GTK+ 2.24.28; x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275124>

Hello Eric,

thanks for comments. I've described the orignal problem before I tried
to fix it:

 https://groups.google.com/forum/#!topic/git-users/PxtiVxAapUU

So, *this patch* was necessary to apply for me to send *this patch* to
the mailing list.

Later, I've tried git-send-email (without this patch) on two different
PCs with the same distro, same architecture, same git, same perl, same
perl libraries. The result was that on the first, it auto-selected
DIGEST-MD5 (didn't work) and on the second one, it selected PLAIN
(worked). I don't understand it.

More below...

On Sat, 1 Aug 2015 05:33:28 -0400
Eric Sunshine <sunshine@sunshineco.com> wrote:

> On Fri, Jul 31, 2015 at 7:33 PM, Jan Viktorin
> <viktorin@rehivetech.com> wrote:
> > When sending an e-mail, the client and server must
> > agree on an authentication mechanism. Some servers
> > (due to misconfiguration or a bug) denies valid
> 
> s/denies/deny/
> 
> > credentials for certain mechanisms. In this patch,
> > a new option --smtp-auth and configuration entry
> > smtpauth are introduced.
> >
> > If smtp_auth is defined, it works as a whitelist
> > of allowed mechanisms for authentication. There
> > are four mechanisms supported: PLAIN, LOGIN,
> > CRAM-MD5, DIGEST-MD5. However, their availability
> > depends on the installed SASL library.
> >
> > Signed-off-by: Jan Viktorin <viktorin@rehivetech.com>
> > ---
> >  git-send-email.perl | 31 ++++++++++++++++++++++++++++++-
> >  1 file changed, 30 insertions(+), 1 deletion(-)
> 
> At the very least, you will also want to update the documentation
> (Documentation/git-send-email.txt) and, if possible, add new tests
> (t/t9001-send-email.sh).

I will update the documentation when it is clear, how the smtp-auth
works.

I have no idea, how to test the feature. I can see something like
fake.sendmail in the file. How does it work? I can image a test whether
user inserts valid values. What more?

> 
> More below.
> 
> > diff --git a/git-send-email.perl b/git-send-email.perl
> > index ae9f869..b00ed9d 100755
> > --- a/git-send-email.perl
> > +++ b/git-send-email.perl
> > @@ -1129,6 +1134,16 @@ sub smtp_auth_maybe {
> >                 return 1;
> >         }
> >
> > +       # Do not allow arbitrary strings.
> 
> Can you explain why this restriction is needed. What are the
> consequences of not limiting the input to this "approved" list?

This is more a check of an arbitrary user input then a check
of an "approved list". It should be also used to inform user
about invalid methods (however, I didn't implemented it yet).

> 
> > +       my ($filtered_auth) = "";
> 
> Style: unnecessary parentheses
> 
> > +       foreach ("PLAIN", "LOGIN", "CRAM-MD5", "DIGEST-MD5") {
> 
> This might read more nicely and be easier to maintain if written as:
> 
>     foreach (qw/PLAIN LOGIN CRAM-MD5 DIGEST-MD5/) {
> 
> > +               if($smtp_auth && $smtp_auth =~ /\b\Q$_\E\b/i) {
> 
> Style: space after 'if'
> 
> Also, why not lift the 'if ($smtp_auth)' check outside the loop since
> its value never changes and there's no need to iterate over the list
> if $smtp_auth is empty.

Sure. I just wanted to avoid another indentation level. I think, there
is no need for optimization at this place. I can rework it, no
problem...

> 
> > +                       $filtered_auth .= $_ . " ";
> 
> Style question: Would this be more naturally expressed with
> 'filtered_auth' as an array onto which items are pushed, rather than
> as a string? At the point of use, the string can be recreated via
> join().
> 
> Not a big deal; just wondering.

I am not a Perl programmer. Yesterday, I've discovered for the first
time that Perl uses a dot for concatenation... I have no idea what
happens when passing an array to Authen::SASL->new(). Moreover, the
Perl arrays syntax rules scare me a bit ;).

> 
> > +               }
> > +       }
> > +
> > +       die "Invalid SMTP AUTH." if length $smtp_auth && !length
> > $filtered_auth;
> 
> Style: drop capitalization: "invalid..."
> Style: drop period at end

Agree.

> Style: add "\n" at end in order to suppress printing of the
>     perl line number and input line number which aren't
>     very meaningful for a user error

Another hidden Perl suprise, I guess...

> 
> (Existing style in the script is not very consistent, but new code
> probably should adhere the above suggestions.)

(Agree.)

> 
> Also, don't you want to warn the user about tokens that don't match
> one of the accepted (PLAIN, LOGIN, CRAM-MD5, DIGEST-MD5), rather than
> dropping them silently?

Yes, this would be great (as I've already mentioned). It's a question
whether to include the check for the mechanisms or whether to leave
the $smtp_auth variable as it is... Maybe just validate by a regex?

The naming rules are defiend here:

 https://tools.ietf.org/html/rfc4422#page-8

So, this looks to me as a better way.

Note that, the current implementation does not force the user to use
only the listed mechanisms. If the $smtp_auth is empty, the original
behaviour is preserved...

> 
> >         # Workaround AUTH PLAIN/LOGIN interaction defect
> >         # with Authen::SASL::Cyrus
> >         eval {
> > @@ -1148,6 +1163,20 @@ sub smtp_auth_maybe {
> >                 'password' => $smtp_authpass
> >         }, sub {
> >                 my $cred = shift;
> > +
> > +               if($filtered_auth) {
> 
> Style: space after 'if'
> 
> > +                       my $sasl = 
> > +                               mechanism => $filtered_auth,
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

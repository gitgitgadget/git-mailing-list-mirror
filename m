From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: [PATCH] make git-send-email.perl handle email addresses with
	no names when Email::Valid is present
Date: Thu, 9 Aug 2007 14:28:59 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070809122859.GA5130@cassiopeia>
References: <20070713041749.GA28824@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Greg KH <greg@kroah.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 14:29:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJ78Y-0000o6-Qv
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 14:29:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765682AbXHIM3H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 9 Aug 2007 08:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756385AbXHIM3G
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 08:29:06 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:63448 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760467AbXHIM3F (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Aug 2007 08:29:05 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1IJ78R-0005nU-OE; Thu, 09 Aug 2007 14:29:03 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l79CT1r2013402;
	Thu, 9 Aug 2007 14:29:01 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l79CT0bJ013401;
	Thu, 9 Aug 2007 14:29:00 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Greg KH <greg@kroah.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070713041749.GA28824@kroah.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55445>

Hello,

Greg KH wrote:
> When using git-send-email.perl on a changeset that has:
> 	Cc: <stable@kernel.org>
> in the body of the description, and the Email::Valid perl module is
> installed on the system, the email address will be deemed "invalid" f=
or
> some reason (Email::Valid isn't smart enough to handle this?) and
> complain and not send the address the email.
The reason is probably that it is indeed invalid.  From rfc822:

mailbox		=3D addr-spec / phrase route-addr
addr-spec	=3D local-part "@" domain
phrase		=3D 1*word
word		=3D atom / quoted-string
atom		=3D 1*<any CHAR except specials, SPACE and CTLs>
quoted-string	=3D <"> *(qtext/quoted-pair) <">
route-addr	=3D "<" [route] addr-spec ">"
=2E..

where 1* means "at least one of".

That is, either you must not use <...> or you need a non-empty phrase.

Actually this grammar looks wrong, because as I read it it would not
allow spaces between words in phrase.  But that's another issue.

BTW: Outlook depends on this, because if you use Cc:
<stable@kernel.org>, it doesn't show anything in the Cc: line---at leas=
t
in the default configuration.

So I suggest the following:

---- >8 ----
send-email: rfc822 forbids using <address@domain> without a non-empty "=
phrase"

Email::Valid does respect this considering such a mailbox specification
invalid.  b06c6bc831cbb9e9eb82fd3ffd5a2b674cd940d0 addressed the issue,=
 but
only if Email::Valid is available.

Signed-off-by: Uwe Kleine-K=F6nig <ukleinek@informatik.uni-freiburg.de>
---
 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 39e433b..a02ab96 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -408,8 +408,8 @@ sub extract_valid_address {
 	# check for a local address:
 	return $address if ($address =3D~ /^($local_part_regexp)$/);
=20
+	$address =3D~ s/^\s*<(.*)>\s*$/$1/;
 	if ($have_email_valid) {
-		$address =3D~ s/^\s*<(.*)>\s*$/$1/;
 		return scalar Email::Valid->address($address);
 	} else {
 		# less robust/correct than the monster regexp in Email::Valid,
--=20
1.5.3.rc3.943.g14c81

--=20
Uwe Kleine-K=F6nig

If a lawyer and an IRS agent were both drowning, and you could only sav=
e
one of them, would you go to lunch or read the paper?

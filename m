From: l.stelmach@samsung.com (=?utf-8?Q?=C5=81ukasz?= Stelmach)
Subject: Re: [PATCH] send-email: support NNTP
Date: Wed, 24 Apr 2013 10:42:44 +0200
Message-ID: <87bo94720r.fsf@samsung.com>
References: <1366715634-21790-1-git-send-email-l.stelmach@samsung.com>
	<87zjwofken.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 24 10:43:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUvII-0000aN-VT
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 10:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758175Ab3DXIm7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Apr 2013 04:42:59 -0400
Received: from plane.gmane.org ([80.91.229.3]:51183 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757748Ab3DXImy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 04:42:54 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UUvHw-0000CP-Kz
	for git@vger.kernel.org; Wed, 24 Apr 2013 10:42:52 +0200
Received: from 217-67-201-162.itsa.net.pl ([217.67.201.162])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 10:42:52 +0200
Received: from l.stelmach by 217-67-201-162.itsa.net.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 10:42:52 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 217-67-201-162.itsa.net.pl
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
Cancel-Lock: sha1:56oRrL+rm46/t5FFZVDFhzRgBgk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222240>

It was <2013-04-24 =C5=9Bro 09:38>, when Thomas Rast wrote:
> =C5=81ukasz Stelmach <l.stelmach@samsung.com> writes:
>
>> Enable sending patches to NNTP servers (Usenet, Gmane).
>
> I'm surprised Junio didn't mention this: your patch lacks the
> Signed-off-by.
>
>> +	if ($email_protocol eq 'nntp') {
>> +		$header =3D "Newsgroups: $to\n" . $header;
>> +	} else {
>> +		$header =3D "To: $to${ccline}\n" . $header;
>> +	}
>
> Are you silently ignoring any Ccs that have been set if you're in NNT=
P
> mode?

Yes.

> Would it be possible to instead send the Ccs by mail as usual, and on=
ly
> the main message over NNTP?  (You don't need to run off and implement
> this, but I'm curious how hard you think it would be.)

Currently you choose a code path with --protocol. The message is sent
only once. It is possible to iterate over To/Cc/Bcc/Newsgroups and
choose send it more than once. There are some tiny nasty bits though, I
don't know how to handle. For example:

--8<---------------cut here---------------start------------->8---
@@ -761,12 +807,21 @@ if (!defined $sender) {
 }
=20
 my $prompting =3D 0;
-if (!@initial_to && !defined $to_cmd) {
+
+if ($email_protocol eq 'smtp' && !@initial_to && !defined $to_cmd) {
 	my $to =3D ask("Who should the emails be sent to (if any)? ",
 		     default =3D> "",
 		     valid_re =3D> qr/\@.*\./, confirm_only =3D> 1);
 	push @initial_to, parse_address_line($to) if defined $to; # sanitized=
/validated later
 	$prompting++;
+} elsif ($email_protocol eq 'nntp' &&
+	 !@initial_newsgroups &&
+	 !defined $newsgroups_cmd) {
+	my $newsgroup =3D ask("Which newsgroups should the message be sent to=
 (if any)? ",
+		     default =3D> "",
+		     valid_re =3D> qr/[\x20-\x7f]+/, confirm_only =3D> 1);
+	push @initial_newsgroups, $newsgroup if defined $newsgroup; # sanitiz=
ed/validated later
+	$prompting++;
 }
--8<---------------cut here---------------end--------------->8---

How to ask interactively where to send the message? With protocol set
early it is clear what we are trying to do. Any suggestions?

The other issue is that I am not sure (RFC?) if it is OK to send
To/Cc/Bcc headers in a NNTP message. Theoretically they should not brea=
k
things but...

> At least in the git@vger world with a lot of etiquette surrounding th=
e
> use of Ccs, NNTP mode isn't very useful if you can't also send Ccs.  =
But
> maybe you have another use-case where that is not a problem?

I've sent this patch vi NNTP :) You've got it.

--=20
=C5=81ukasz Stelmach
Software wizzard
Samsung Poland R&D Center

From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH RFC3.5 02/12] send-email: No longer repeatedly test if 
	$smtp_server is a command
Date: Sun, 19 Apr 2009 21:37:23 -0500
Message-ID: <b4087cc50904191937x55f94dc3sb6fbda27f380b105@mail.gmail.com>
References: <1240074128-16132-1-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-2-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-3-git-send-email-mfwitten@gmail.com>
	 <7veivop0dx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 04:39:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvjPQ-0002Ri-Bd
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 04:39:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752862AbZDTCh0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Apr 2009 22:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752486AbZDTCh0
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Apr 2009 22:37:26 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:5676 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752085AbZDTChZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Apr 2009 22:37:25 -0400
Received: by qw-out-2122.google.com with SMTP id 5so764880qwd.37
        for <git@vger.kernel.org>; Sun, 19 Apr 2009 19:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bVYKwUyIQ3L0Yo8hP78OsKPSIgMCzdlRidZE/tPWZ28=;
        b=B2Z6uO4+BO1D0LIzTx70LEwXQxYhl3P/Yg+b3WN+TMgTcpaVD+YERN/Dgwb5G+P7MV
         lhkiSuRKloNRkhoHsrv67ifmWBQBZKw08/UE5djPzU6IUcA/D/ceNBbcgogfehctmtNG
         oCZVYhAaOFL9/QKWrdYhAg0nx5387GB8+SE8g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hhJfXKLY0Wvkt68OBKrx8J59pKA/dDTqG3JaJ5gAwzHlS/7W4SYaErZey3GrFPN42K
         qwTDGjIHeLd/N/BK+q+vrSd9NEysyeMK1sNB/0zDfL7i3DpKRrSdobSsQRNQ0QK+M36n
         AXsOGGJt/UGQvSsAejGrWPYEybcH7lvmcwZ+w=
Received: by 10.224.19.194 with SMTP id c2mr5704167qab.27.1240195043892; Sun, 
	19 Apr 2009 19:37:23 -0700 (PDT)
In-Reply-To: <7veivop0dx.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116926>

On Sun, Apr 19, 2009 at 20:41, Junio C Hamano <gitster@pobox.com> wrote=
:
> Michael Witten <mfwitten@gmail.com> writes:
>
>> This is a minor change, but it's cleaner, and it sets up the
>> $smtp_server initialization code for future improvements.
>> ...
>> -if (!defined $smtp_server) {
>> +if (defined $smtp_server) {
>> +
>> + =A0 =A0 $smtp_server_is_a_command =3D ($smtp_server =3D~ m{^/});
>> +
>> +} else { # use a default:
>> +
>> =A0 =A0 =A0 foreach (qw( /usr/sbin/sendmail /usr/lib/sendmail )) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (-x $_) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $smtp_server =3D $_;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $smtp_server_is_a_command =
=3D 1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 last;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 }
>> - =A0 =A0 $smtp_server ||=3D 'localhost'; # could be 127.0.0.1, too.=
=2E. *shrug*
>> +
>> + =A0 =A0 $smtp_server =3D 'localhost'; # 127.0.0.1 is not compatibl=
e with IPv6
>> + =A0 =A0 =A0 =A0 =A0 =A0 unless $smtp_server_is_a_command;
>
> Nobody suggests to use 127.0.0.1 anymore with this change, so why not=
 just
> get rid of that comment?

=46ine with me.

> Also the new statement looks wrong.
>
> =A0(1) you have ';' after assignment before the statement modifier "u=
nless";
> =A0 =A0 I do not think you meant it. =A0I generally *dis*like stateme=
nt
> =A0 =A0 modifiers, but if you use it, at least please use it correctl=
y.

How embarassing. That's actually been fixed on my end since I sent
that patch; for some reason, I forget to send the update; sorry for
wasting your time.

> =A0(2) earlier, when $smtp_server is defined (say, the name of your s=
mtp
> =A0 =A0 host) but is not a command, we did not set smtp_server to
> =A0 =A0 'localhost', but kept the value given by the user. =A0Now you=
 seem to
> =A0 =A0 kill the user's wish with this change.

I think you misread the code (with the exception of the error on my
part). The code could be read:

	if $smtp_server is already defined {
		determine whether it is a command;
	} else {
		find a suitable default for it;
	}

> I think a genuine improvement would be something like:
>
> =A0 =A0 =A0 =A0if (!defined $smtp_server) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$smtp_server =3D 'localhost';
> =A0 =A0 =A0 =A0}

You don't care to search for a possible sendmail?

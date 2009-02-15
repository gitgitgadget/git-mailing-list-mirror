From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make repack less likely to corrupt repository
Date: Sun, 15 Feb 2009 12:09:58 -0800
Message-ID: <7vvdrbjwbt.fsf@gitster.siamese.dyndns.org>
References: <1234140299-29785-1-git-send-email-robin.rosenberg@dewire.com>
 <200902151715.19351.robin.rosenberg.lists@dewire.com>
 <alpine.DEB.1.00.0902151745270.10279@pacific.mpi-cbg.de>
 <200902151942.15055.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, spearce@spearce.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sun Feb 15 21:12:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYnLF-0000I4-CW
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 21:11:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723AbZBOUKO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Feb 2009 15:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbZBOUKO
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 15:10:14 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51624 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019AbZBOUKM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Feb 2009 15:10:12 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0722D9A76E;
	Sun, 15 Feb 2009 15:10:10 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 270EB9A76B; Sun,
 15 Feb 2009 15:10:01 -0500 (EST)
In-Reply-To: <200902151942.15055.robin.rosenberg.lists@dewire.com> (Robin
 Rosenberg's message of "Sun, 15 Feb 2009 19:42:14 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A570601C-FB9C-11DD-9839-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110052>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:

> s=C3=B6ndag 15 februari 2009 17:46:59 skrev Johannes Schindelin:
>> Hi,
>>=20
>> On Sun, 15 Feb 2009, Robin Rosenberg wrote:
>> > -	exit 1
>> > +	echo >&2 "INFO: We recovered from the repack error, but your rep=
o"
>> > +	echo >&2 "INFO: is probably suboptimally packed. You may try to =
repack"
>> > +	echo >&2 "INFO: later. A common reason for repacking failure is =
that"
>> > +	echo >&2 "INFO: a Windows program was locking one of the old pac=
k files."
>> > +	echo >&2 "INFO: To repack successfully you may have to close tha=
t program"
>> > +	echo >&2 "INFO: before repacking."
>>=20
>> cat >&2 << EOF?
>
> Yeah, but I followed the pattern from the warnings just prior to thes=
e messages.
>
>> > +	exit
>>=20
>> You lose the error condition here, but I cannot find a convincing ar=
gument=20
>> about that in the commit message.
>
> I was thinking of my patch as an ammendment to Junios patch. In that =
context.
>
> "Exit success if rollback fails after failing to rename old packs." D=
oesn't this
> count?

No, it does not count, because that sentence is just a statement about
_what_ your change does, and does not explain _why_ it is better to rep=
ort
success, other than an unstated "because I think that is more appropria=
te."

I think your "INFO:" lines are good to give additional useful cue for
the human operators, though.

If we wanted to move away old ones to replace them with new ones, and w=
e
failed to comply with what the user wished for because the preparatory
step of moving-them-away failed, it _is_ a failure, and for this reason=
,
it should be reported as such.  That would be my counter-statement that
explains _why_.

If you were arguing for using a different but still non-zero exit statu=
s
to signal the "you asked us to repack but I refused to do so because I
couldn't move the in-use packs away; by the way I did not corrupt your
repository because I successfully rolled back everything I did, so do n=
ot
worry to much about it" case, I agree that such a change would be bette=
r
than what we have.  It would allow an automated process to tell a more
grave repository error and "I need to kill the git object server that i=
s
pinning some of the packfiles open and re-run the repack" situation apa=
rt.

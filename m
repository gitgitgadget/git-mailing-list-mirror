From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Teach Git about the patience diff algorithm
Date: Thu, 08 Jan 2009 22:54:32 -0800
Message-ID: <7v7i552clz.fsf@gitster.siamese.dyndns.org>
References: <20090108195511.GA8734@chistera.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Clemens Buchacher <drizzd@aon.at>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>, davidel@xmailserver.org,
	Francis Galiegue <fg@one2team.net>,
	Git ML <git@vger.kernel.org>
To: Adeodato =?utf-8?Q?Sim=C3=B3?= <dato@net.com.org.es>
X-From: git-owner@vger.kernel.org Fri Jan 09 07:56:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLBHt-0002uv-Mu
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 07:56:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753375AbZAIGys convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Jan 2009 01:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753285AbZAIGyr
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 01:54:47 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60236 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751930AbZAIGyq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jan 2009 01:54:46 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B0FEC8E406;
	Fri,  9 Jan 2009 01:54:44 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E85D38E3FC; Fri,
  9 Jan 2009 01:54:34 -0500 (EST)
In-Reply-To: <20090108195511.GA8734@chistera.yi.org> (Adeodato =?utf-8?Q?S?=
 =?utf-8?Q?im=C3=B3's?= message of "Thu, 8 Jan 2009 20:55:11 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 65A9C7C4-DE1A-11DD-A840-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104983>

Adeodato Sim=C3=B3 <dato@net.com.org.es> writes:

> * Linus Torvalds [Fri, 02 Jan 2009 08:42:04 -0800]:
>
>> Yes, this one is a real patience diff change, but it's also the same=
 one=20
>> that I've seen in the google fanboi findings. What google did _not_ =
show=20
>> was any real-life examples, or anybody doing any critical analysis.
>
> This comes a bit late and maybe it's redundant, but somebody just sen=
t
> to a Debian mailing list a patch that was hard to read, and patience
> improved it. (I realize it's quite similar in spirit to the "toy
> patience example" that google returns, but this at list is a *real*
> example where patience helped me read a patch.)
>
> I'm also attaching bzr diff output, because it's still more readable
> IMHO. (I realize that's independent of patience, as you explained, bu=
t
> I'm making a point that it'd be nice to have this addressed by somebo=
dy
> knowledgeable.)

I found thd difference between the Bzr diff and Dscho diff somewhat
interesting.  It shows that sometimes it makes the results easier to re=
ad
to consider blank lines (and lines with only punctuation marks) that ma=
tch
to be non-matching when they appear inside a block of other consecutive
non-matching lines, even though the result may become larger.

The part Bzr gives this result:

> +/*******************************************************************=
*********
>   Write data to a fd.
>  ********************************************************************=
********/
> =20
>  ssize_t write_data(int fd, const char *buffer, size_t N)
>  {
> -	size_t total=3D0;
>  	ssize_t ret;
> -	char addr[INET6_ADDRSTRLEN];
> ... all "removed"
> -	while (total < N) {
> -		total +=3D ret;
> -	}
> -	return (ssize_t)total;
> +	struct iovec iov;
> +
> +	iov.iov_base =3D CONST_DISCARD(char *, buffer);
> ... all "added"
> +
> +
> +	return -1;
>  }
> =20
>  /*******************************************************************=
*********

is shown by the Dscho git-diff like this:

>   Write data to a fd.
>  ********************************************************************=
********/
> =20
>  ssize_t write_data(int fd, const char *buffer, size_t N)
>  {
> -	size_t total=3D0;
>  	ssize_t ret;
> -	char addr[INET6_ADDRSTRLEN];
> +	struct iovec iov;
> =20
> -	while (total < N) {
> -		ret =3D sys_write(fd,buffer + total,N - total);
> +	iov.iov_base =3D CONST_DISCARD(char *, buffer);
> +	iov.iov_len =3D N;
> =20
> -		if (ret =3D=3D -1) {
> -			if (fd =3D=3D get_client_fd()) {
> ... all "removed"
> -
> -		if (ret =3D=3D 0) {
> -			return total;
> -		}
> +	ret =3D write_data_iov(fd, &iov, 1);
> +	if (ret >=3D 0) {
> +		return ret;
> +	}
> =20
> -		total +=3D ret;
> +	if (fd =3D=3D get_client_fd()) {
> +		char addr[INET6_ADDRSTRLEN];
> ... all "added"
> +		DEBUG(0,("write_data: write failure. Error =3D %s\n",
> +			 strerror(errno) ));
>  	}
> -	return (ssize_t)total;
> +
> +	return -1;
>  }

If we find the "common" context lines that have only blank and punctuat=
ion
letters in Dscho output, turn each of them into "-" and "+", and rearra=
nge
them so that all "-" are together followed by "+", it will match Bzr
output.

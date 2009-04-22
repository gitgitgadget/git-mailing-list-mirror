From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] Improve progress display in kB range.
Date: Wed, 22 Apr 2009 12:44:05 -0700
Message-ID: <7vljps324a.fsf@gitster.siamese.dyndns.org>
References: <cover.1240115957.git.cloos@jhcloos.com>
 <d03620ac4d99f3280df31708032a072a4a6cd96e.1240115957.git.cloos@jhcloos.com>
 <alpine.LFD.2.00.0904210054190.6741@xanadu.home>
 <m3skk2szgv.fsf@lugabout.jhcloos.org>
 <alpine.LFD.2.00.0904211319570.6741@xanadu.home>
 <m3d4b5oj76.fsf@lugabout.jhcloos.org> <m34owgoj08.fsf@lugabout.jhcloos.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: James Cloos <cloos@jhcloos.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 21:45:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwiOA-0006cx-Q4
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 21:45:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753995AbZDVToN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Apr 2009 15:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753624AbZDVToN
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 15:44:13 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58283 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752220AbZDVToM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Apr 2009 15:44:12 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4E6731144D;
	Wed, 22 Apr 2009 15:44:11 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 71AB81144C; Wed,
 22 Apr 2009 15:44:07 -0400 (EDT)
In-Reply-To: <m34owgoj08.fsf@lugabout.jhcloos.org> (James Cloos's message of
 "Wed, 22 Apr 2009 10:33:19 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F3A5FA8C-2F75-11DE-9066-D766E3C8547C-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117241>

James Cloos <cloos@jhcloos.com> writes:

> |> Therefore, in practice =E2=80=94 and as I have witnessed several t=
housand times
> |> without ever having seen a contrary example =E2=80=94 display_thro=
ughput() is
> |> called *durring* a download only when total & 0xFFF =3D=3D 0xFFF.
>
> Another possibility is an off-by-one error.  The relevant part of fil=
l()
> looks like:
>
> ,----< excerpt from index-pack.c:fill() >
> |   do {
> |     ssize_t ret =3D xread(input_fd, input_buffer + input_len,
> |                         sizeof(input_buffer) - input_len);
> |     if (ret <=3D 0) {
> |       if (!ret)
> |         die("early EOF");
> |       die("read error on input: %s", strerror(errno));
> |     }
> |     input_len +=3D ret;
> |     if (from_stdin)
> |       display_throughput(progress, consumed_bytes + input_len);
> |   } while (input_len < min);
> |   return input_buffer;
> | }
> `----
>
> if *(input_buffer + ret) is the last read octet rather than the next
> empty octet, that would also explain what I see.

After checking "ret" from xread(), input_len is incremented by that
amount, and the next iteration gives "input_buffer + input_len" to
xread().  If input_buffer[ret] _were_ the last octet read, your loop wo=
uld
be discarding that octet when you call more than one xread() to fill th=
e
buffer.

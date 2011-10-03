From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] daemon: print "access denied" if a service does not work
Date: Mon, 03 Oct 2011 12:57:08 -0700
Message-ID: <7vsjn9etm3.fsf@alter.siamese.dyndns.org>
References: <20111003111331.GA12707@elie>
 <1317670109-16919-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 03 21:57:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAodr-0001LR-DV
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 21:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757493Ab1JCT5W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Oct 2011 15:57:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54218 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757467Ab1JCT5O convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Oct 2011 15:57:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 141FD5D99;
	Mon,  3 Oct 2011 15:57:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=zoTU/EpelBca
	O/yuzAps/Tpe3H8=; b=l1OkvR3rupctjVX8khkwdvvFYbgNjJbNxtkyAn4NromC
	E1TlutYr3yNZqf741H+J0+JP5HIB03tzplOXVGinGdJHz32cVTOetPVs659HiFaR
	4onU8kjDaCOTQaNogkaYKx8AHA+ol3f4920px45CrvZKRUAoIIUEJQT8ztsBIcM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=jN98XC
	m+nj4a15xzpdFLYuxcnB9A4NyqFnlsS3pG1OeDLjZlcHhW1AQ93p7ilskcZBwydg
	tfeYToS9be9CdFv4GihIsJV8gR3N9eZOiX3Vat+CQ6Xv0RoJGMaL3mosHrh6st7E
	9YY3sZlfLy8g3kjcWwVy3LtiYokNy2TIZ2k3c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 09D815D98;
	Mon,  3 Oct 2011 15:57:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9AE525D34; Mon,  3 Oct 2011
 15:57:10 -0400 (EDT)
In-Reply-To: <1317670109-16919-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 4 Oct
 2011 06:28:29 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E1778C82-EDF9-11E0-91C0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182709>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Note that if a service fails, then "access denied" is printed too.

After run_service() returns with a failure, it is simply irresponsible =
to
append an "ERR" packet to the output channel without knowing what the
state of that channel is (e.g. it might be that the service wrote only
half a pkt_line it wanted to write, and you may be appending to it).

I think the earlier patch from Peff makes the division of responsibilit=
y
clearer. If the daemon's dispatch code notices it does not want to run =
it,
it is the daemon's job to report it. Otherwise the service can and shou=
ld
report what it does, and after it starts running, the channel belongs t=
o
the service.

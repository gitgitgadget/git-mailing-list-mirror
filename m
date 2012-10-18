From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] status: refactor output format to represent "default"
 and add --long
Date: Thu, 18 Oct 2012 14:16:11 -0700
Message-ID: <7vtxtrlbvo.fsf@alter.siamese.dyndns.org>
References: <20121018020308.GA24484@sigill.intra.peff.net>
 <1350569750-26304-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 18 23:16:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOxS6-0005fZ-AC
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 23:16:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755769Ab2JRVQP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Oct 2012 17:16:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39482 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752267Ab2JRVQO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Oct 2012 17:16:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8543A82AF;
	Thu, 18 Oct 2012 17:16:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=cUV4bJUIdKZ0
	8hCMBoAup5rxYEs=; b=oIgrcBQ/WQEQoMiHxEsuYS2/U4A02nO2YtFDWtIpB6Uh
	h3MYUjPYZ3PnyweTuovuUanWLjdvHP9xbgReT5OY+XI/U9Aj6VCZRO8CVp422oba
	YPq156m79NbDiujHGTvGkOZMUFPn5ow3czuIDyy3FSSucF/ylJxahb3QZlniH34=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=xlKYfU
	cCHDJ0AotXpqZWx7span2kdaNjCS1HdyVgbVNaHkKoKKKBlGLg498JAuHW09TvWk
	mTW5vCDsctkddMQ0TLlpJLaT5flxytkYOwduSt2iv5wmLY7m/jZCDau151c/nsH9
	qKtHCH8vCYoIo9rUHWS/YaCcXzxusPaSwYRgE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7144382AE;
	Thu, 18 Oct 2012 17:16:13 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B7ECC82AC; Thu, 18 Oct 2012
 17:16:12 -0400 (EDT)
In-Reply-To: <1350569750-26304-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 18 Oct
 2012 21:15:50 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0B5F9D3C-1969-11E2-85DA-9A8C2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208019>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> From: Jeff King <peff@peff.net>
>
> When deciding which output format to use, we default an internal enum
> to STATUS_FORMAT_LONG and modify it if "--porcelain" or "--short" is
> given. If this enum is set to LONG, then we know the user has not
> specified any format, and we can kick in default behaviors. This work=
s
> because there is no "--long" which they could use to explicitly
> specify LONG.
>
> Let's expand the enum to have an explicit STATUS_FORMAT_NONE, in
> preparation for adding "--long", which can be used to override --shor=
t
> or --porcelain. Then we can distinguish between LONG and NONE when
> setting other defaults. There are two such cases:
>
>   1. The user has asked for NUL termination. With NONE, we
>      currently default to turning on the porcelain mode.
>      With an explicit --long, we would in theory use NUL
>      termination with the long mode, but it does not support
>      it. So we can just complain and die.
>
>   2. When an output format is given to "git commit", we
>      default to "--dry-run". This behavior would now kick in
>      when "--long" is given, too.
>
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  On Thu, Oct 18, 2012 at 9:03 AM, Jeff King <peff@peff.net> wrote:
>  > I think that is fine to split it like this, but you would want to =
update
>  > the commit message above. Probably just remove those two cases and=
 say
>  > something like:
>  >
>  >   Note that you cannot actually trigger STATUS_FORMAT_LONG, as we =
do
>  >   not yet have "--long"; that will come in a follow-on patch.
>  >
>  > And then move the reasoning for how "--long" works with each case =
into
>  > the commit message of the next patch.
>
>  Nope, it's hard to split the explanation in two (at least to me),
>  which may mean that the split does not make sense.

I guess combining both is fine, but then the commit is no longer "in
preparation for adding" the option, but it already adds "--long", I
would think.

Will queue.

Thanks.

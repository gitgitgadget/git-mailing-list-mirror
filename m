From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] http: clear POSTFIELDS when initializing a slot
Date: Tue, 26 Apr 2011 09:18:17 -0700
Message-ID: <BANLkTinvhJ3T0aQsosx4u_TYEgYn9TNvxg@mail.gmail.com>
References: <7v39l5ghgj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 18:18:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEkyK-0001sS-NW
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 18:18:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218Ab1DZQSi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Apr 2011 12:18:38 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:64246 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751021Ab1DZQSi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2011 12:18:38 -0400
Received: by qwk3 with SMTP id 3so350494qwk.19
        for <git@vger.kernel.org>; Tue, 26 Apr 2011 09:18:37 -0700 (PDT)
Received: by 10.229.49.133 with SMTP id v5mr748865qcf.165.1303834717101; Tue,
 26 Apr 2011 09:18:37 -0700 (PDT)
Received: by 10.229.248.9 with HTTP; Tue, 26 Apr 2011 09:18:17 -0700 (PDT)
In-Reply-To: <7v39l5ghgj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172104>

On Tue, Apr 26, 2011 at 08:28, Junio C Hamano <gitster@pobox.com> wrote=
:
> After posting a short request using CURLOPT_POSTFIELDS, if the slot
> is reused for posting a large payload, the slot ends up having both
> POSTFIELDS (which now points at a random garbage) and READFUNCTION,
> in which case the curl library tries to use the stale POSTFIELDS.
>
> Clear it as part of the general slot initialization in get_active_slo=
t().
>
> Heavylifting-by: Shawn Pearce <spearce@spearce.org>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Acked-by: Shawn Pearce <spearce@spearce.org>

=46WIW, this bug exists since Git 1.6.6, when smart HTTP was first
introduced. We just get lucky most of the time up until 1.7.4, and
usually never have a failure, as fetch-pack/upload-pack negotiation
packets are almost always smaller than the http.postbuffer size.
Between 1.6.6 and 1.7.4, if it exceeds the postbuffer size, it may not
be possible to fetch because the prior POSTFIELDS will be sent, which
means the client will never transmit "done" and get a pack.

In 1.7.5 smart HTTP push is horribly broken without this patch.

> =A0* This came up while Shawn was looking at the smart HTTP code agai=
n. =A0It
> =A0 makes me wonder why we do not use curl_easy_reset() in this funct=
ion,
> =A0 though...

Yea, makes me wonder too. :-)

> diff --git a/http.c b/http.c
> index ed6414a..b642eac 100644
> --- a/http.c
> +++ b/http.c
> @@ -494,6 +494,7 @@ struct active_request_slot *get_active_slot(void)
> =A0 =A0 =A0 =A0curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, NU=
LL);
> =A0 =A0 =A0 =A0curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, NUL=
L);
> =A0 =A0 =A0 =A0curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, NU=
LL);
> + =A0 =A0 =A0 curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDS, NULL);
> =A0 =A0 =A0 =A0curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 0);
> =A0 =A0 =A0 =A0curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);

--=20
Shawn.

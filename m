From: Mika Fischer <mika.fischer@zoopnet.de>
Subject: Re: [PATCH v3 2/3] http.c: Use timeout suggested by curl instead of
 fixed 50ms timeout
Date: Fri, 4 Nov 2011 18:47:44 +0100
Message-ID: <CAOs=hRKxc9SdE_HTnfs+WdnxZEY6yF9MBV_K1FX2=7B7xtj7-w@mail.gmail.com>
References: <1320265288-12647-1-git-send-email-mika.fischer@zoopnet.de>
 <1320416367-28843-1-git-send-email-mika.fischer@zoopnet.de>
 <1320416367-28843-3-git-send-email-mika.fischer@zoopnet.de> <7vehxndd4q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, daniel@haxx.se, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 04 18:48:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMNsD-0007Ta-TY
	for gcvg-git-2@lo.gmane.org; Fri, 04 Nov 2011 18:48:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932553Ab1KDRsJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Nov 2011 13:48:09 -0400
Received: from trillian.zoopnet.de ([85.214.111.199]:49844 "EHLO
	trillian.zoopnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932322Ab1KDRsI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Nov 2011 13:48:08 -0400
Received: from mail-gx0-f174.google.com (mail-gx0-f174.google.com [209.85.161.174])
	by trillian.zoopnet.de (Postfix) with ESMTPSA id 14131249C2BC
	for <git@vger.kernel.org>; Fri,  4 Nov 2011 18:48:06 +0100 (CET)
Received: by ggnb2 with SMTP id b2so2731942ggn.19
        for <git@vger.kernel.org>; Fri, 04 Nov 2011 10:48:05 -0700 (PDT)
Received: by 10.236.22.33 with SMTP id s21mr22512948yhs.70.1320428885111; Fri,
 04 Nov 2011 10:48:05 -0700 (PDT)
Received: by 10.236.60.135 with HTTP; Fri, 4 Nov 2011 10:47:44 -0700 (PDT)
In-Reply-To: <7vehxndd4q.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184789>

On Fri, Nov 4, 2011 at 18:13, Junio C Hamano <gitster@pobox.com> wrote:
> I'm inclined to squash in the following to narrow the scope of
> curl_timeout, though.
>
> diff --git a/http.c b/http.c
> index 5cb0fb6..924be52 100644
> --- a/http.c
> +++ b/http.c
> @@ -636,9 +636,6 @@ void run_active_slot(struct active_request_slot *=
slot)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fd_set excfds;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int max_fd;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct timeval select_timeout;
> -#if LIBCURL_VERSION_NUM >=3D 0x070f04
> - =C2=A0 =C2=A0 =C2=A0 long curl_timeout;
> -#endif
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int finished =3D 0;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0slot->finished =3D &finished;
> @@ -655,6 +652,7 @@ void run_active_slot(struct active_request_slot *=
slot)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (slot->in_u=
se && !data_received) {
> =C2=A0#if LIBCURL_VERSION_NUM >=3D 0x070f04
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 long curl_timeout;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0curl_multi_timeout(curlm, &curl_timeout);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (curl_timeout =3D=3D 0) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue;

Ah yes, that's good. I would have done it this way in C++, but I
wasn't sure whether C99 is OK for git.

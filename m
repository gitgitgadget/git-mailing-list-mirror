From: Mika Fischer <mika.fischer@zoopnet.de>
Subject: Re: [PATCH] http.c: Use curl_multi_fdset to select on curl fds
 instead of just sleeping
Date: Sun, 30 Oct 2011 08:19:23 +0100
Message-ID: <CAOs=hR+YuF+HP0n0132Ktm3RdeWsnVp0Bgt89LNn+VyT6W0mcw@mail.gmail.com>
References: <1319901621-482-1-git-send-email-mika.fischer@zoopnet.de> <alpine.DEB.2.00.1110292230500.28196@tvnag.unkk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Daniel Stenberg <daniel@haxx.se>
X-From: git-owner@vger.kernel.org Sun Oct 30 08:20:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKPhN-0007wm-9B
	for gcvg-git-2@lo.gmane.org; Sun, 30 Oct 2011 08:20:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752830Ab1J3HTs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Oct 2011 03:19:48 -0400
Received: from trillian.zoopnet.de ([85.214.111.199]:49353 "EHLO
	trillian.zoopnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625Ab1J3HTr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Oct 2011 03:19:47 -0400
Received: from mail-gy0-f174.google.com (mail-gy0-f174.google.com [209.85.160.174])
	by trillian.zoopnet.de (Postfix) with ESMTPSA id BD3D626E42FD
	for <git@vger.kernel.org>; Sun, 30 Oct 2011 08:19:45 +0100 (CET)
Received: by gyb13 with SMTP id 13so4897782gyb.19
        for <git@vger.kernel.org>; Sun, 30 Oct 2011 00:19:44 -0700 (PDT)
Received: by 10.236.176.199 with SMTP id b47mr11022532yhm.104.1319959184287;
 Sun, 30 Oct 2011 00:19:44 -0700 (PDT)
Received: by 10.236.60.135 with HTTP; Sun, 30 Oct 2011 00:19:23 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1110292230500.28196@tvnag.unkk.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184467>

On Sat, Oct 29, 2011 at 22:33, Daniel Stenberg <daniel@haxx.se> wrote:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 curl_multi_fdset(curlm, &readfds, &writefds,
>> &excfds, &max_fd);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 select(max_fd+1, &readfds, &writefds, &excfds,
>> &select_timeout);
>
> At times, curl_multi_fdset() might return -1 in max_fd, as when there=
's no
> internal socket around to provide to the application to wait for.
>
> Calling select() with max_fd+1 (=3D=3D 0) will then not be appreciate=
d by all
> implementations of select() so that case should probably also be cove=
red by
> the 50ms sleep approach...

Actually, the 50ms sleep was also implemented using select(0, ...)
before the patch. I tried to keep the previous behavior when curl does
not give us any information.
I assumed that the select(0, ...) was some portable way to sleep with
microsecond granularity.
Is there some other way to tell select not to check any fds, or should
I just call select(1, ...)?

Best,
 Mika

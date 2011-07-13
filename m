From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: With errno fix: [PATCH] Do not log unless all connect() attempts fail
Date: Wed, 13 Jul 2011 20:47:24 +0200
Message-ID: <CABPQNSYWKVngfoj4AqTCbWixENSmgnbdDBGBt+EpWnBgbqpofg@mail.gmail.com>
References: <7276ACEE-EF52-49DF-83EA-642DE504B3EA@apple.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Dave Zarzycki <zarzycki@apple.com>
X-From: git-owner@vger.kernel.org Wed Jul 13 20:48:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qh4Tm-0002iz-PA
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 20:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752723Ab1GMSsH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jul 2011 14:48:07 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:62450 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752410Ab1GMSsG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2011 14:48:06 -0400
Received: by pzk9 with SMTP id 9so4992904pzk.19
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 11:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=1IQIDSJWJB1vol78VOTEy4rFgXybBBCAb/QQ0kg75nA=;
        b=PyTWDgye1SnPO8EUBtQ4BAG3wXKzWjutKAZLOTXPWM3w0/bxyk2T1fJWMkk0Fe949c
         VLemihsBYxxm34dw0d5j8Wak1b9Dxi0F9xKK/wSLeOyh2LDW7NAEC+ueiy6cEkz0YwbJ
         6zJ42UI/sgZkIOy3XW2tsk5cR6bzJRORR6RUc=
Received: by 10.68.48.74 with SMTP id j10mr1628902pbn.37.1310582885068; Wed,
 13 Jul 2011 11:48:05 -0700 (PDT)
Received: by 10.68.48.130 with HTTP; Wed, 13 Jul 2011 11:47:24 -0700 (PDT)
In-Reply-To: <7276ACEE-EF52-49DF-83EA-642DE504B3EA@apple.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177068>

On Wed, Jul 13, 2011 at 6:28 PM, Dave Zarzycki <zarzycki@apple.com> wro=
te:
> IPv6 hosts are often unreachable on the primarily IPv4 Internet and
> therefore we shouldn't print an error if there are still other hosts =
we
> can try to connect() to. This helps "git fetch --quiet" stay quiet.
>
> Signed-off-by: Dave Zarzycki <zarzycki@apple.com>
> ---
> =A0connect.c | =A0 15 +++++++++------
> =A01 files changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/connect.c b/connect.c
> index 2119c3f..87b2e3f 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -192,6 +192,7 @@ static const char *ai_name(const struct addrinfo =
*ai)
> =A0*/
> =A0static int git_tcp_connect_sock(char *host, int flags)
> =A0{
> + =A0 =A0 =A0 struct strbuf error_message =3D STRBUF_INIT;
> =A0 =A0 =A0 =A0int sockfd =3D -1, saved_errno =3D 0;
> =A0 =A0 =A0 =A0const char *port =3D STR(DEFAULT_GIT_PORT);
> =A0 =A0 =A0 =A0struct addrinfo hints, *ai0, *ai;
> @@ -217,6 +218,11 @@ static int git_tcp_connect_sock(char *host, int =
flags)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fprintf(stderr, "done.\nConnecting to =
%s (port %s) ... ", host, port);
>
> =A0 =A0 =A0 =A0for (ai0 =3D ai; ai; ai =3D ai->ai_next) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (saved_errno) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 strbuf_addf(&error_mess=
age, "%s[%d: %s]: errno=3D%s\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host, c=
nt, ai_name(ai), strerror(saved_errno));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 saved_errno =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }

Uhm, this will still fail to report errors for the very last entry,
no? When socket returns -1 in the last iteration (and errno gets
saved), there's no code that reports it...

From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] Do not log unless all connect() attempts fail
Date: Wed, 13 Jul 2011 11:23:33 +0200
Message-ID: <CABPQNSaPXmHE1qECUbG9oWU43HbAXxAY42T1P=MNHgkkWM936w@mail.gmail.com>
References: <1EC2718A-A993-443C-8D7C-DEBD7C424EB9@apple.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Dave Zarzycki <zarzycki@apple.com>
X-From: git-owner@vger.kernel.org Wed Jul 13 11:24:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qgvg6-0007Pl-4b
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 11:24:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965142Ab1GMJYO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jul 2011 05:24:14 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:46211 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965133Ab1GMJYN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2011 05:24:13 -0400
Received: by pvg12 with SMTP id 12so4542298pvg.19
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 02:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=qLR9ikf+X4dFOzhu2mfKDDHJ/SPdf/0qI4SuW0qa6HE=;
        b=ebafhcNZCltR4bDwWxvhcUJLGdEWyeDnMpQtPuo9VF2pqg+eRYlWv5t6y7PN3YrxuW
         HKpTpIVOe1NevDrMYLcXLHpnYniyuSdrXXmVEO+VTWd2zTOORrPKl65oqxsHroSoSK+0
         pwzDscrmU4FMvYh2aFpdhT5lAHEs8UAnD3vXk=
Received: by 10.68.27.100 with SMTP id s4mr1181286pbg.491.1310549053093; Wed,
 13 Jul 2011 02:24:13 -0700 (PDT)
Received: by 10.68.59.104 with HTTP; Wed, 13 Jul 2011 02:23:33 -0700 (PDT)
In-Reply-To: <1EC2718A-A993-443C-8D7C-DEBD7C424EB9@apple.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177019>

On Tue, Jul 12, 2011 at 6:28 PM, Dave Zarzycki <zarzycki@apple.com> wro=
te:
> IPv6 hosts are often unreachable on the primarily IPv4 Internet and
> therefore we shouldn't print an error if there are still other hosts =
we
> can try to connect() to. This helps "git fetch --quiet" stay quiet.
>
> Signed-off-by: Dave Zarzycki <zarzycki@apple.com>
> ---
> =A0connect.c | =A0 12 ++++++------
> =A01 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/connect.c b/connect.c
> index 2119c3f..8eb9f44 100644
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
> @@ -225,11 +226,8 @@ static int git_tcp_connect_sock(char *host, int =
flags)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (connect(sockfd, ai->ai_addr, ai->a=
i_addrlen) < 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0saved_errno =3D errno;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fprintf(stderr, "%s[%d:=
 %s]: errno=3D%s\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cnt,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ai_name=
(ai),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 strerro=
r(saved_errno));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 strbuf_addf(&error_mess=
age, "%s[%d: %s]: errno=3D%s\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host, c=
nt, ai_name(ai), strerror(saved_errno));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0close(sockfd);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sockfd =3D -1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;
> @@ -242,11 +240,13 @@ static int git_tcp_connect_sock(char *host, int=
 flags)
> =A0 =A0 =A0 =A0freeaddrinfo(ai0);
>
> =A0 =A0 =A0 =A0if (sockfd < 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("unable to connect a socket (%s)", =
strerror(saved_errno));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("unable to connect to %s:\n%s", hos=
t, error_message.buf);
>

This kills the output from the case where "sockfd < 0" evaluates to
true for the last entry in ai, no (just above your second hunk), no?
In that case errno gets copied to saved_errno, and the old output
would do strerror(old_errno), but now you just print the log you've
gathered, and don't even look at saved_errno.

If this is intentional then you should probably kill the saved_errno
variable also, it's rendered pointless by this patch.

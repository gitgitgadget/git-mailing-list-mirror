From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: With errno fix: [PATCH] Do not log unless all connect() attempts fail
Date: Thu, 14 Jul 2011 00:38:20 +0200
Message-ID: <CABPQNSZj7P6XUMgChgZ6XYEZVtVNmXmVM27_Ms=mXV1c1an6KQ@mail.gmail.com>
References: <7276ACEE-EF52-49DF-83EA-642DE504B3EA@apple.com>
 <CABPQNSYWKVngfoj4AqTCbWixENSmgnbdDBGBt+EpWnBgbqpofg@mail.gmail.com> <7vtyap6gox.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dave Zarzycki <zarzycki@apple.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 14 00:39:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qh85D-0000x6-3z
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 00:39:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752631Ab1GMWjB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jul 2011 18:39:01 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:54447 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752612Ab1GMWjA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2011 18:39:00 -0400
Received: by pvg12 with SMTP id 12so5103800pvg.19
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 15:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=12/cxBcgsuhUuWjfq/bJ669q74RCuSRw7T37Ok6Ta9s=;
        b=m5xhYUcELgEGwHUrUSYqDzDg6tme9HF4F+6zQG1E+SNWobxSo9JFjlvaDrTa3UxR8S
         YK7tTJjQF0hLGW1+rus+EsRw+YqMAWg/NHc9yiKksSt/1hkOCmq+PrAxtuUl0qDJH9zP
         IEkIK4OW5OX8D8a93IAlaGpmdDfiJD6h4ZJdQ=
Received: by 10.68.48.74 with SMTP id j10mr1822047pbn.37.1310596740059; Wed,
 13 Jul 2011 15:39:00 -0700 (PDT)
Received: by 10.68.48.130 with HTTP; Wed, 13 Jul 2011 15:38:20 -0700 (PDT)
In-Reply-To: <7vtyap6gox.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177090>

On Wed, Jul 13, 2011 at 10:58 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> Uhm, this will still fail to report errors for the very last entry,
>> no? When socket returns -1 in the last iteration (and errno gets
>> saved), there's no code that reports it...
>
> I guess the fix should look something like this.
>
> By the way, is anybody interested in fixing the other side of the ifd=
ef
> that is compiled on IPv4-only installations?
>
> =A0connect.c | =A0 15 ++++++---------
> =A01 files changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/connect.c b/connect.c
> index 8eb9f44..844107e 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -193,7 +193,7 @@ static const char *ai_name(const struct addrinfo =
*ai)
> =A0static int git_tcp_connect_sock(char *host, int flags)
> =A0{
> =A0 =A0 =A0 =A0struct strbuf error_message =3D STRBUF_INIT;
> - =A0 =A0 =A0 int sockfd =3D -1, saved_errno =3D 0;
> + =A0 =A0 =A0 int sockfd =3D -1;
> =A0 =A0 =A0 =A0const char *port =3D STR(DEFAULT_GIT_PORT);
> =A0 =A0 =A0 =A0struct addrinfo hints, *ai0, *ai;
> =A0 =A0 =A0 =A0int gai;
> @@ -220,15 +220,12 @@ static int git_tcp_connect_sock(char *host, int=
 flags)
> =A0 =A0 =A0 =A0for (ai0 =3D ai; ai; ai =3D ai->ai_next) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sockfd =3D socket(ai->ai_family,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ai->ai=
_socktype, ai->ai_protocol);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (sockfd < 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 saved_errno =3D errno;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (connect(sockfd, ai->ai_addr, ai->ai=
_addrlen) < 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 saved_errno =3D errno;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((sockfd < 0) ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (connect(sockfd, ai->ai_addr, a=
i->ai_addrlen) < 0)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0strbuf_addf(&error_mes=
sage, "%s[%d: %s]: errno=3D%s\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host, c=
nt, ai_name(ai), strerror(saved_errno));
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 close(sockfd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 host, cnt, ai_name(ai), strerror(errno));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (0 <=3D sockfd)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 close(s=
ockfd);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sockfd =3D -1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>

Yeah, this looks like sensible to me.

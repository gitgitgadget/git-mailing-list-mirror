From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] Do not log unless all connect() attempts fail
Date: Thu, 14 Jul 2011 00:29:11 +0200
Message-ID: <CABPQNSazGsgqcZZ=q9VJ+2u=O32ePeRAjqo4+FuyVwCkX4y4nQ@mail.gmail.com>
References: <1EC2718A-A993-443C-8D7C-DEBD7C424EB9@apple.com>
 <CABPQNSaPXmHE1qECUbG9oWU43HbAXxAY42T1P=MNHgkkWM936w@mail.gmail.com> <20110713210636.GF31965@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dave Zarzycki <zarzycki@apple.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 14 00:29:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qh7wL-0005Ih-Im
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 00:29:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752368Ab1GMW3w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jul 2011 18:29:52 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:36243 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877Ab1GMW3v convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2011 18:29:51 -0400
Received: by pvg12 with SMTP id 12so5098833pvg.19
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 15:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=uqURHtPShkVV5trbfbCrdWDvS2s+vwCT5m3JrwACa5Y=;
        b=iMoRuZlhyZncWXvN4F3ihApgCyVn7GhVtsatcE/fkVJ5mUnfETk9hH77EzQM7DxV0/
         5MrYm6b1Ao8veO/ECgFA4B8U6uDCJGXpVc16ZMYQardlXt9CQ++XxPct8rClGul1NwVd
         o3legigMaAvGuMUBeAIFVMMIucxyGBvNr6tTU=
Received: by 10.68.12.133 with SMTP id y5mr2068563pbb.104.1310596191092; Wed,
 13 Jul 2011 15:29:51 -0700 (PDT)
Received: by 10.68.48.130 with HTTP; Wed, 13 Jul 2011 15:29:11 -0700 (PDT)
In-Reply-To: <20110713210636.GF31965@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177089>

On Wed, Jul 13, 2011 at 11:06 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Jul 13, 2011 at 11:23:33AM +0200, Erik Faye-Lund wrote:
>
>> > =A0static int git_tcp_connect_sock(char *host, int flags)
>> > =A0{
>> > + =A0 =A0 =A0 struct strbuf error_message =3D STRBUF_INIT;
>> > =A0 =A0 =A0 =A0int sockfd =3D -1, saved_errno =3D 0;
>> > =A0 =A0 =A0 =A0const char *port =3D STR(DEFAULT_GIT_PORT);
>> > =A0 =A0 =A0 =A0struct addrinfo hints, *ai0, *ai;
>> > @@ -225,11 +226,8 @@ static int git_tcp_connect_sock(char *host, i=
nt flags)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (connect(sockfd, ai->ai_addr, ai=
->ai_addrlen) < 0) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0saved_errno =3D err=
no;
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fprintf(stderr, "%s[=
%d: %s]: errno=3D%s\n",
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host=
,
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cnt,
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ai_n=
ame(ai),
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 stre=
rror(saved_errno));
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 strbuf_addf(&error_m=
essage, "%s[%d: %s]: errno=3D%s\n",
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host=
, cnt, ai_name(ai), strerror(saved_errno));
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0close(sockfd);
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sockfd =3D -1;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;
>> > @@ -242,11 +240,13 @@ static int git_tcp_connect_sock(char *host, =
int flags)
>> > =A0 =A0 =A0 =A0freeaddrinfo(ai0);
>> >
>> > =A0 =A0 =A0 =A0if (sockfd < 0)
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("unable to connect a socket (%s)=
", strerror(saved_errno));
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("unable to connect to %s:\n%s", =
host, error_message.buf);
>> >
>>
>> This kills the output from the case where "sockfd < 0" evaluates to
>> true for the last entry in ai, no (just above your second hunk), no?
>> In that case errno gets copied to saved_errno, and the old output
>> would do strerror(old_errno), but now you just print the log you've
>> gathered, and don't even look at saved_errno.
>
> But that's OK, because the value of that saved_errno is in the gather=
ed
> log, isn't it?

No, it's not. In the case where socket fails, we assign errno to
saved_errno and _continue_. So nothing gets logged about the error. If
there's only one entry in the address list, we don't end up reporting
anything; the strbuf is empty. We used to at least report
strerror(errno) in that case.

From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v4 11/15] daemon: report connection from root-process
Date: Sun, 17 Oct 2010 12:18:54 +0200
Message-ID: <AANLkTin9cCW0c43kPGu9nBOO092+LEHR+XfY_KFeSyk6@mail.gmail.com>
References: <1286833829-5116-1-git-send-email-kusmabite@gmail.com>
 <1286833829-5116-12-git-send-email-kusmabite@gmail.com> <7vlj61hfe7.fsf@alter.siamese.dyndns.org>
 <AANLkTinXNPWaGj2BUaSOJypzv-Sqts-zEdG886oT2YJB@mail.gmail.com> <7v8w1x5sz7.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org,
	avarab@gmail.com, sunshine@sunshineco.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 17 12:19:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7QKn-0002j0-Dx
	for gcvg-git-2@lo.gmane.org; Sun, 17 Oct 2010 12:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353Ab0JQKTQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Oct 2010 06:19:16 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49747 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932234Ab0JQKTP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Oct 2010 06:19:15 -0400
Received: by fxm4 with SMTP id 4so1441586fxm.19
        for <git@vger.kernel.org>; Sun, 17 Oct 2010 03:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=06eI9W3Fm79syI8/IpnwdxtnwHauIUFx09mZ16Qni3o=;
        b=vS6qUbjlwlen5KkwQcCleHlnL4l9GPJTdiALO0VM5EPlCrXkOXzqEYCNv3KhsqZsaZ
         h6Af25KTWK7XwODefqA16pNpFsn+ZYkbIz5W2DiHq3vimRslZeII/IisM6YGh9i6rlAZ
         SzDCbPlf6fPAwvAliEEtohQI0vB1uyJzIgk2E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=tLdwsKLcmHOKXDafaPPgb89RsI8C1Pheei8QnXWnASdIbuhlkfraMdCqUEZ7HbM2iL
         rshVgBrjGBYD6xVRgGUBgEpnT7vEXQ/DTHePnE3peYsTG4k6dRbfa/izQKKxMwjUvoLF
         88HixDGGbmz93OLzBzm+d9zglyjXRC1XbYxPU=
Received: by 10.223.96.193 with SMTP id i1mr16323fan.134.1287310754241; Sun,
 17 Oct 2010 03:19:14 -0700 (PDT)
Received: by 10.223.112.146 with HTTP; Sun, 17 Oct 2010 03:18:54 -0700 (PDT)
In-Reply-To: <7v8w1x5sz7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159201>

On Sun, Oct 17, 2010 at 6:43 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>>> Hmm, loginfo() calls logreport() and adds the process information a=
s
>>> necessary to the output. =A0Wouldn't this patch give the pid inform=
ation
>>> twice?
>>>
>>
>> Close, but not quite. logreport() reports the current PID, while thi=
s
>> call to loginfo reports the PID of the child process. So two
>> non-identical PIDs are reported.
>
> I know that; I was questioning if that change to the log output is re=
ally
> what we want. =A0I do not deeply care myself, but people with scripts=
 that
> read logs might.
>

I could do something like this, but then we lose the port information.
Perhaps I could add a REMOTE_PORT environment variable to solve that?

diff --git a/daemon.c b/daemon.c
index 589bd04..3d18899 100644
--- a/daemon.c
+++ b/daemon.c
@@ -522,6 +522,10 @@ static int execute(void)
 {
 	static char line[1000];
 	int pktlen, len, i;
+	char *addr =3D getenv("REMOTE_ADDR");
+
+	if (addr)
+		loginfo("Connection from %s", addr);

 	alarm(init_timeout ? init_timeout : timeout);
 	pktlen =3D packet_read_line(0, line, sizeof(line));
@@ -702,11 +706,8 @@ static void handle(int incoming, struct sockaddr
*addr, socklen_t addrlen)

 	if (start_command(&cld))
 		logerror("unable to fork");
-	else {
-		loginfo("[%"PRIuMAX"] Connection from %s:%d",
-		    (uintmax_t)cld.pid, addrstr, port);
+	else
 		add_child(&cld, addr, addrlen);
-	}
 	close(incoming);
 }

From: Noam Postavsky <npostavs@users.sourceforge.net>
Subject: Re: git-credential-cache--daemon quits on SIGHUP, can we change it to
 ignore instead?
Date: Tue, 20 Oct 2015 22:35:46 -0400
Message-ID: <CAM-tV-8VXtB5uRgqP9dFpww6AaLzasPV46tCiquz=nz=ksBNng@mail.gmail.com>
References: <CAM-tV-_JPazYxeDYogtQTRfBxONpSZwb3u5pPanB=F9XnLnZyg@mail.gmail.com>
	<CAM-tV-_eOgnhqsTFN6kKW=tcS7gAPYaxskBaxnJZo3bsx02HZg@mail.gmail.com>
	<xmqqfv18awj4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=089e0122ec88611b760522943c1b
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 04:36:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZojFs-0005kC-Fo
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 04:35:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753203AbbJUCft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2015 22:35:49 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:37786 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753201AbbJUCfs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2015 22:35:48 -0400
Received: by wicfv8 with SMTP id fv8so54535705wic.0
        for <git@vger.kernel.org>; Tue, 20 Oct 2015 19:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=qHQQYRL+0Nti9HWBhpaPkQoM2MQPnAyS2qtT81NgNdg=;
        b=tYz4l6ADMCdLmo92k2eF6jBkjYI7Ho+mG3vS64r7OJvjTSK8Q8BrIMiirEXK75Sra7
         TRbMVqYxuizldvZCuHkltogaL8mLmkwZwm2GYI497hV1RMP3JUdE1hBtEb2jTcG8N9+A
         jTytAryLZFtG9qXtVX/bBCPBXA9Bbeqqqk8ltwNHDfjJBi8GIzqAYvwF3h5MTW4ZSsAO
         QwExW409jmJe744xP06U1J0vuJmcqCccNV3xPUYpu0hCHgvY14Z6z+s1FkQCzMvAbSJQ
         VqUuxh0L6g8OSMdcrlsgjZNi7Pt7C0U4MP9nPxnwtiZMfERABkBJF+tXQFBkGJErS3BR
         dREw==
X-Received: by 10.194.171.199 with SMTP id aw7mr8606684wjc.32.1445394947007;
 Tue, 20 Oct 2015 19:35:47 -0700 (PDT)
Received: by 10.28.29.87 with HTTP; Tue, 20 Oct 2015 19:35:46 -0700 (PDT)
In-Reply-To: <xmqqfv18awj4.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: iZoVDfSCmzKLADxzwmzDWqpwX0k
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279961>

--089e0122ec88611b760522943c1b
Content-Type: text/plain; charset=UTF-8

On Sun, Oct 18, 2015 at 1:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I cannot speak for the person who was primarily responsible for
> designing this behaviour, but I happen to agree with the current
> behaviour in the situation where it was designed to be used.  Upon
> the first use in your session, the "daemon" is auto-spawned, you can
> keep talking with that same instance during your session, and you do
> not have to do anything special to shut it down when you log out.
> Isn't that what happens here?

After looking at this some more, I've discovered this is NOT what
actually happens here. If I "git push" from a shell and then log out
and log in again, another "git push" does NOT ask me for a password.
In other words, the daemon is NOT shut down automatically when I log
out. Given that, does it make sense to change the daemon to ignore
SIGHUP, or is there some way to change it so that it does exit on
logout?

---------------------

I don't understand why this happens, but the attached self-contained
pair of programs demonstrate the behaviour:

If I do

   make call-note-sighup note-sighup
   urxvt -e ./call-note-sighup ; cat note-sighup

sighup.log DOES contain "got sighup", but if I instead do

   make call-note-sighup note-sighup
   ./call-note-sighup ; exit

afterwards sighup.log does NOT contain "got sighup" (and I must do
"pkill note-sighup" to get rid of the lingering note-sighup process).

--089e0122ec88611b760522943c1b
Content-Type: text/x-csrc; charset=US-ASCII; name="call-note-sighup.c"
Content-Disposition: attachment; filename="call-note-sighup.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ig06fmzd0

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KCmludCBtYWluKHZvaWQpIHsK
CiAgICByZW1vdmUoInNpZ2h1cC5sb2ciKTsKCiAgICBpbnQgcGlkID0gZm9yaygpOwogICAgaWYg
KHBpZCA8IDApIHsKICAgICAgICBwZXJyb3IoImZvcmsiKTsKICAgICAgICByZXR1cm4gMTsKICAg
IH0gZWxzZSBpZiAocGlkID09IDApIHsKICAgICAgICBleGVjbCgiLi9ub3RlLXNpZ2h1cCIsICIu
L25vdGUtc2lnaHVwIiwgTlVMTCk7CiAgICAgICAgcGVycm9yKCJleGVjbCguL25vdGUtc2lnaHVw
KSIpOwogICAgICAgIHJldHVybiAxOwogICAgfSBlbHNlIHsKICAgICAgICBmcHJpbnRmKHN0ZGVy
ciwgIndhaXRpbmcgZm9yIHNpZ3VwLmxvZyB0byBhcHBlYXJcbiIpOwogICAgICAgIHdoaWxlICgh
YWNjZXNzKCJzaWdodXAubG9nIiwgRl9PSykpIHsKICAgICAgICB9CiAgICAgICAgZnByaW50Zihz
dGRlcnIsICJva2F5LCBub3RlLXNpZ2h1cC5sb2cgaGFzIGFycml2ZWQsIGV4aXRpbmcgaW4gNSBz
ZWNvbmRzLi4uXG4iKTsKICAgICAgICBzbGVlcCg1KTsKICAgIH0KCiAgICByZXR1cm4gMDsKfQo=
--089e0122ec88611b760522943c1b
Content-Type: text/x-csrc; charset=US-ASCII; name="note-sighup.c"
Content-Disposition: attachment; filename="note-sighup.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ig06fmzw1

I2luY2x1ZGUgPHVuaXN0ZC5oPgojaW5jbHVkZSA8c3RkaW8uaD4KI2luY2x1ZGUgPHN0cmluZy5o
PgojaW5jbHVkZSA8c2lnbmFsLmg+CgpzdGF0aWMgdm9sYXRpbGUgaW50IGdvdF9zaWdodXAgPSAw
OwoKdm9pZCBzaWdodXBfaGFuZGxlcihpbnQgc2lnKSB7CiAgICBnb3Rfc2lnaHVwID0gMTsKfQoK
aW50IG1haW4odm9pZCkgewoKICAgIHN0cnVjdCBzaWdhY3Rpb24gYWN0OwogICAgbWVtc2V0KCZh
Y3QsIDAsIHNpemVvZiBhY3QpOwogICAgYWN0LnNhX2hhbmRsZXIgPSBzaWdodXBfaGFuZGxlcjsK
ICAgIHNpZ2FjdGlvbihTSUdIVVAsICZhY3QsIE5VTEwpOwoKICAgIEZJTEUqIG91dCA9IGZvcGVu
KCJzaWdodXAubG9nIiwgInciKTsKICAgIHNldGJ1ZihvdXQsIE5VTEwpOwogICAgZnByaW50Zihv
dXQsICJzdGFydGluZyBub3RlLXNpZ2h1cFxuIik7CgogICAgZm9yICg7OykgewogICAgICAgIHNs
ZWVwKDEwMDApOwogICAgICAgIGlmIChnb3Rfc2lnaHVwKSB7CiAgICAgICAgICAgIGdvdF9zaWdo
dXAgPSAwOwogICAgICAgICAgICBmcHJpbnRmKG91dCwgImdvdCBzaWdodXBcbiIpOwogICAgICAg
IH0KICAgIH0KCiAgICByZXR1cm4gMDsKfQo=
--089e0122ec88611b760522943c1b--

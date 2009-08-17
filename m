From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: git http-push and MKCOL error (22/409)
Date: Mon, 17 Aug 2009 12:58:25 +0800
Message-ID: <be6fef0d0908162158y429c4b5fgb9138151446e39ef@mail.gmail.com>
References: <200908161557.26962.thomas.schlichter@web.de>
	 <be6fef0d0908160727r7dfa9b46l4d493e3954c21de3@mail.gmail.com>
	 <7veirb5z9a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Schlichter <thomas.schlichter@web.de>,
	willievu <willievu@dev.java.net>,
	Sean Davis <sdavis2@mail.nih.gov>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 07:05:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McuPU-0002Kc-5u
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 07:05:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbZHQFFY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Aug 2009 01:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbZHQFFX
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 01:05:23 -0400
Received: from mail-yx0-f175.google.com ([209.85.210.175]:45184 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297AbZHQFFX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Aug 2009 01:05:23 -0400
Received: by yxe5 with SMTP id 5so3353516yxe.33
        for <git@vger.kernel.org>; Sun, 16 Aug 2009 22:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ahz/wfSKbC3IS2BW1wjjGeQrNJhDK8KjDXVNPwEtubQ=;
        b=BJXgmoo1Y5sy62+1UJVToMRL//gZ6z/ehSJa9Bfl4OXv4GDaGEolbPq2080BB4uXdU
         pl1hX5H4Z8UkfYc38/QALOZTC9HpOT2C7nmWmtkB4vpFjMCWolYR3xy5g5W1FTYglNlZ
         x0jepew8dWL7mOtLKqBbvGo5m5kjHeDl/hmng=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=eiwEo8gTh/OUYNHrXZZW2jD5xNK0qdQhUTXuIRtt94cmRsyvNtDHudqxq11jgGBB9f
         MHuxKvyHxeVWO75u8GzRP1gNdWxmjQWZ+puHY9Y0re0B8Odhx3AglqglPQDwclILLGOH
         MwWq7HP8t5B+MvIlapFWqGNwXyhADYNGzGs6Y=
Received: by 10.231.12.10 with SMTP id v10mr2237058ibv.4.1250485105109; Sun, 
	16 Aug 2009 21:58:25 -0700 (PDT)
In-Reply-To: <7veirb5z9a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126116>

Hi,

On Mon, Aug 17, 2009 at 3:34 AM, Junio C Hamano<gitster@pobox.com> wrot=
e:
> The report said:
>
> =A0 =A0MKCOL 98fd7fb8f32843c1bb40bd195a2f1cd6cab0751d failed, abortin=
g (22/409)
>
> As far as I can see you are trying (in http-push.c::start_mkcol()) to
> create the two-hexdigit fan-out directory (i.e. "98" for this example=
); it
> is strange to see a request to create the full 40-hexdigit collection=
 in
> the first place.

Yes, you're right, but git prints out the full SHA-1 hash even though
it is actually referring to the 2-hexdigit directory that it failed to
create/verify, for whatever reason.

> In another thread you responded to earlier:
>
> =A0 =A0http://thread.gmane.org/gmane.comp.version-control.git/125933/=
focus=3D125972
>
> the original report did not give the exact error message, but in that=
 one,
> instead of failing to create 40-hexdigit collection like this, I am
> guessing that it fails with something like "MKCOL 'refs' failed".

I guess by "original report" you refer to Thomas' initial email: yes,
he (unwittingly) did provide theerror code in the subject line, the
part which says (22/409). It actually means (<curl return code>/<http
return code>). Referring again to
http://www.webdav.org/specs/rfc4918.html#rfc.section.9.3.1:

  409 (Conflict) - A collection cannot be made at the Request-URI until
  one or more intermediate collections have been created. The server
  must not create those intermediate collections automatically.

meaning one or more parent directories weren't created.

Based on this and his procedure, I'm guessing that there's something
wrong with his setup.

> *1* Not necessarily in the sense the client is broken but in the sens=
e
> that the server-client combination does not work for the reporter.

Indeed.

--=20
Cheers,
Ray Chuan

From: Tarmigan <tarmigan+git@gmail.com>
Subject: Re: [PATCH] http-backend: Fix bad treatment of uintmax_t in 
	Content-Length
Date: Sat, 14 Nov 2009 13:49:55 -0800
Message-ID: <905315640911141349t7121baa8vc0b2be59fa348512@mail.gmail.com>
References: <7vzl6wz36r.fsf@alter.siamese.dyndns.org> <905315640911100910r5116779eh24796fa5788f4aef@mail.gmail.com> 
	<20091112044240.GP11919@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Nov 14 22:50:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9QVj-0007Rd-4j
	for gcvg-git-2@lo.gmane.org; Sat, 14 Nov 2009 22:50:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbZKNVuK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Nov 2009 16:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbZKNVuK
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Nov 2009 16:50:10 -0500
Received: from mail-pz0-f171.google.com ([209.85.222.171]:48212 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426AbZKNVuJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Nov 2009 16:50:09 -0500
Received: by pzk1 with SMTP id 1so2014425pzk.33
        for <git@vger.kernel.org>; Sat, 14 Nov 2009 13:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=1wpVNKS7ASbFZJuqWJPBZ+4Vfb6aAHLyHh4HtoWyXvI=;
        b=Bz61LEiP4TKt1CEC3pzo+wQ3kH2cmCxovt0+yWEm0hr6fo3q2chrnHL3Cb0k0g8q0v
         yFpnq6TMaR/Shh8xdAQD9A7a5FgNpdkAJTktlZLyI6EaBfpk64ncFqDGXt/rJFzy+Ed7
         YCtweeckv8ekCSvxvmMY4CRwzpF4Q8WXEYkaA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=m0GYYQTLj9iPH9egwW5wCJATCs5YBPDigSagcQuWuScaXcfxqyybr+h1wvsQEkOLMw
         bIENUhDVb0rep+UbmwLxyzQyjlCH39cmtaHH/pXhEKw1IPLlijuK6adnoo6zfbiYhMfr
         DbGXgf/CHqgJfC4jxX1yHmbefTKrWjIxrXjDk=
Received: by 10.142.60.11 with SMTP id i11mr656417wfa.270.1258235415072; Sat, 
	14 Nov 2009 13:50:15 -0800 (PST)
In-Reply-To: <20091112044240.GP11919@spearce.org>
X-Google-Sender-Auth: fe475eca9d39b6d6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132891>

On Wed, Nov 11, 2009 at 8:42 PM, Shawn O. Pearce <spearce@spearce.org> =
wrote:
> Our Content-Length needs to report an off_t, which could be larger
> precision than size_t on this system (e.g. 32 bit binary built with
> 64 bit large file support).
>
> We also shouldn't be passing a size_t parameter to printf when
> we've used PRIuMAX as the format specifier.
>
> Fix both issues by using uintmax_t for the hdr_int() routine,
> allowing strbuf's size_t to automatically upcast, and off_t to
> always fit.
>
> Also fixed the copy loop we use inside of send_local_file(), we never
> actually updated the size variable so we might as well not use it.
>
> Reported-by: Tarmigan <tarmigan+git@gmail.com>

Tested-by: Tarmigan <tarmigan+git@gmail.com>

> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
>
> =A0Tarmigan <tarmigan+git@gmail.com> wrote:
> =A0> unhappy. =A0Curl returns 18 (CURLE_PARTIAL_FILE), the test takes=
 a long
> =A0> time to fail, and the "out" file looks OK (compared to a linux m=
achine
> =A0> where the test passes) expect for "Content-Length: 3784725181241=
1".
> =A0>
> =A0> Digging into it a bit more with gdb, the call to hdr_int() in
> =A0> http-backend.c looks OK, but then something goes wrong in
> =A0> format_write(). =A0Hmmm it looks like my setup does not like PRI=
uMAX
> =A0> with size_t, which puts some garbage in the upper bytes of
>
> =A0Yup, only the right fix is to keep using PRIuMAX... patch below.

This fix is better than the (uintmax_t) cast that I was thinking about =
posting.

Please also consider the "__attribute__((format(printf,1,2))" patches
that I just posted to the list that would warn about this in the
future.

Thanks,
Tarmigan

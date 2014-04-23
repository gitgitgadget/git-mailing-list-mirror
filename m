From: Greg M <morenzg@gmail.com>
Subject: Re: error: git-remote-https died of signal 13
Date: Wed, 23 Apr 2014 07:49:09 -0400
Message-ID: <CAEHyFQLPYh2b5CsmadazDJG3paHL7JDY4JhT=xf=wHXhLd=EkQ@mail.gmail.com>
References: <CAEHyFQLmu4GWHcd+Xd6MOikf_LJgK0dGM7VXk6h6OLsud+-Wgw@mail.gmail.com>
	<20140423065938.GB20675@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 23 13:49:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wcvfy-0000p7-K0
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 13:49:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889AbaDWLtN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 07:49:13 -0400
Received: from mail-we0-f177.google.com ([74.125.82.177]:47776 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496AbaDWLtL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 07:49:11 -0400
Received: by mail-we0-f177.google.com with SMTP id u57so742136wes.36
        for <git@vger.kernel.org>; Wed, 23 Apr 2014 04:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=xA4jsZv1Eev8ISJtkFHKqVGCn2pSdDL6j2+8rg7Uj38=;
        b=Juw/ntaDtXb+139Btie6FMfvwywPgFACsrqplHW5QGk8YnvrfC6zK8WVv2+YeSv1eG
         ykwOU2nvGq0iXO/S/BaYnbHFAzhMmP1irVQ8DNreviQRYNKtl3yHsdgCLB4tpccwlIvf
         crvUGjQ5J5n/oFNIDkbMIPuGKy3/oF28qr8/Yt+NbqLhQ6oCvd4o64rwdMSOGCfz3BdD
         EQdFwuaCpkt4XJpjcii912BpBuBD/9BGA0yM597APLhh/I1zCF6xylHmYRoTpb4WdPu+
         Xq4AsreEdo/JFO2f0mOq4Lg6XIOVWZ9MGLbIsb+s+d31V/nf0C2ErFWQ/TZISL5c9Wzt
         nUbw==
X-Received: by 10.194.7.196 with SMTP id l4mr59391wja.92.1398253749845; Wed,
 23 Apr 2014 04:49:09 -0700 (PDT)
Received: by 10.227.107.70 with HTTP; Wed, 23 Apr 2014 04:49:09 -0700 (PDT)
In-Reply-To: <20140423065938.GB20675@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246820>

On Wed, Apr 23, 2014 at 2:59 AM, Jeff King <peff@peff.net> wrote:
> On Sun, Apr 20, 2014 at 08:42:15PM -0400, Greg M wrote:
>
>> Using git version 1.9.2 I am getting this error:
>>
>> [normal@laptop tmp]$ git clone https://github.com/mozilla/rust.git
>> Cloning into 'rust'...
>> remote: Reusing existing pack: 296648, done.
>> remote: Counting objects: 80, done.
>> remote: Compressing objects: 100% (77/77), done.
>> remote: Total 296728 (delta 22), reused 9 (delta 3)
>> Receiving objects: 100% (296728/296728), 110.68 MiB | 190.00 KiB/s, done.
>> Resolving deltas: 100% (238828/238828), done.
>> Checking connectivity... done.
>> error: git-remote-https died of signal 13
>
> Thanks for a thorough bug report. I looked through your strace output,
> and this really does look like another case of OpenSSL getting SIGPIPE
> while closing the connection.
>
> It's odd, though, as your curl version has my patches, along with
> similar extra fixes in 854aca5 (multi: ignore sigpipe internally,
> 2014-02-17). But I guess there may be a code path that needs similar
> treatment.
>
> The easiest way to find it is probably to attach a debugger to the
> running git-remote-https, and get a backtrace when it dies from SIGPIPE.
> You'll probably want to install your system's debug packages for curl,
> too.
>

The backtrace:

Program received signal SIGPIPE, Broken pipe.
0x00007fdcfd511a2d in write () from /usr/lib/libpthread.so.0
(gdb) bt
#0  0x00007fdcfd511a2d in write () from /usr/lib/libpthread.so.0
#1  0x00007fdcfd81a0f6 in sock_write () from /usr/lib/libcrypto.so.1.0.0
#2  0x00007fdcfd817edb in BIO_write () from /usr/lib/libcrypto.so.1.0.0
#3  0x00007fdcfc662902 in ssl3_write_pending () from /usr/lib/libssl.so.1.0.0
#4  0x00007fdcfc664b77 in ssl3_dispatch_alert () from /usr/lib/libssl.so.1.0.0
#5  0x00007fdcfc660822 in ssl3_shutdown () from /usr/lib/libssl.so.1.0.0
#6  0x00007fdcfd2e944e in Curl_ossl_close () from /usr/lib/libcurl.so.4
#7  0x00007fdcfd2b6459 in Curl_disconnect () from /usr/lib/libcurl.so.4
#8  0x00007fdcfd2c8131 in curl_multi_cleanup () from /usr/lib/libcurl.so.4
#9  0x000000000040764b in ?? ()
#10 0x0000000000404e4d in ?? ()
#11 0x00007fdcfcf0fb05 in __libc_start_main () from /usr/lib/libc.so.6
#12 0x000000000040552e in ?? ()

> Another possibility is that your curl binary is up-to-date, but you are
> linking against an older version of libcurl that does not have the
> SIGPIPE workarounds.
>
> I'm not sure of the best way to check that, but a hacky way under Linux
> is:
>
>   $ ldd $(git --exec-path)/git-remote-https | grep libcurl
>           libcurl.so.4 => /usr/lib/x86_64-linux-gnu/libcurl.so.4
>   $ strings  /usr/lib/x86_64-linux-gnu/libcurl.so.4 | grep '7\.'
>   CLIENT libcurl 7.36.0
>
> -Peff

Seems to actually be that version of libcurl:

[normal@laptop tmp]$ ldd $(git --exec-path)/git-remote-https | grep libcurl
    libcurl.so.4 => /usr/lib/libcurl.so.4 (0x00007ff1cce5e000)
[normal@laptop tmp]$ strings /usr/lib/libcurl.so.4 | grep '7\.'
7.36f
CLIENT libcurl 7.36.0
CLIENT libcurl 7.36.0
CLIENT libcurl 7.36.0
7.36.0
[normal@laptop tmp]$

Also I don't think I have any other versions to link against:

[normal@laptop tmp]$ ls -l /usr/lib/libcurl*
lrwxrwxrwx 1 root root     16 Mar 26 10:12 /usr/lib/libcurl.so ->
libcurl.so.4.3.0
lrwxrwxrwx 1 root root     16 Mar 26 10:12 /usr/lib/libcurl.so.4 ->
libcurl.so.4.3.0
-rwxr-xr-x 1 root root 443488 Mar 26 10:12 /usr/lib/libcurl.so.4.3.0

Greg

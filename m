From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [msysGit] upload-pack timing issue on windows?
Date: Sat, 6 Feb 2010 13:01:50 +0100
Message-ID: <40aa078e1002060401r1dec3c2ate3ddd4f5f5db1e0c@mail.gmail.com>
References: <40aa078e1002051551o6d116a50uee3f6a32b16adb46@mail.gmail.com>
	 <201002061106.04305.j6t@kdbg.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com, Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Feb 06 13:02:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdjMR-0001If-Oc
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 13:02:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752661Ab0BFMBx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2010 07:01:53 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:39622 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306Ab0BFMBv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2010 07:01:51 -0500
Received: by ewy28 with SMTP id 28so903483ewy.28
        for <git@vger.kernel.org>; Sat, 06 Feb 2010 04:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=AfKa+Pe7t8XoFqXV0pPVk39qZ40G+dCe6pcTr2+IcDY=;
        b=jdp77onShpgO0Z3so88enZk8whcL28SNUfuHQS8j6LZF8YtmBXH5HbPfSnR/1nEEj1
         zTPszGnfhXCxS9UGXHURvgud6XM2kOXsrEfsbgAQjQv0Zw/N60bREV2eX4vOoeWd+Wvb
         sPIHKukhWxoM0IcV89S51wDPGODowQS0iAbJk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=wblFi4cMul7A57xYClG6O8mxJIzY0Nkx/1ApS2lDTGtd0wmbCC7mT0c6Ej+RhQzcjL
         Z5nfcQBsBQy7WfoiJ9IUJpLUGaw8xVK8sRr4tZ+OPnzy+3XtKkJ19pJzPKTei4m/7fE6
         uwa+/KxCZM/LXyKEPaVIPrVB5HeGp4QDyG+kE=
Received: by 10.216.90.196 with SMTP id e46mr2160530wef.194.1265457710234; 
	Sat, 06 Feb 2010 04:01:50 -0800 (PST)
In-Reply-To: <201002061106.04305.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139160>

On Sat, Feb 6, 2010 at 11:06 AM, Johannes Sixt <j6t@kdbg.org> wrote:
> On Samstag, 6. Februar 2010, Erik Faye-Lund wrote:
>> As some of you might know, I've been working on porting git-daemon to
>> Windows for quite some time now. As it stands now, there's really only
>> one known issue that is blocking on my end here:
>>
>> Something weird happens *sometimes* when upload-pack is exiting,
>> leading to a client dying with a "fatal: read error: Invalid
>> argument\nfatal: early EOF"-error. If I place a sleep(1) at some place
>> after exiting the while(1)-loop in create_pack() in upload-pack.c, the
>> symptom goes away. create_pack() contains some async-code, but this
>> doesn't seem to be triggered in my minimal case at all. I've tried
>> flushing stdout and stderr explicitly, no luck.
>
> I've observed timing related issues in upload-pack as well, but only in the
> case where the die() is called from the async thread. This is the reason why
> t5530 does not pass.
>
> But your case seems to be different - i.e. there is no die() involved. Sorry,
> can't help more...
>

Yeah, it's probably not the same case, but I certainly do find it
interesting that we seemingly have two separate timing-related around
here somewhere...

> Perhaps use Procmon to analyse differences among the different successful and
> failing cases.
>

I'm not entirely sure what to look for, but I do see that there's
difference. There's about 3.5k lines of logging from git.exe,
git-daemon.exe and git-upload-pack.exe for the failure case versus
2.5k for the successful case. And the last sequence of TCP Send in the
success case is a send of 8 bytes, followed by a send of 212 bytes,
followed again by a send of 1 byte. In the failure case, there's only
a send of 8 bytes in the end. This sequence is reported as sent by
git-daemon.exe. In fact, all TCP actions are reported from
git-daemon.exe, and apart from the last sequence the lengths are
reported as identical.

> Try hacking fetch-pack so that it does not announce side-band(-64k). Perhaps
> it makes a difference.
>

This didn't make any difference. I removed "side-band" and
"side-band-64k" from capabilities in send_ref() in upload-pack.c, as
well as the "if (server_supports("side-band<...>"-lines in
builtin-fetch-pack.c.

While I was at it, I also tried to disable all other capabilities; no luck.

However, I have tracked down a bit of what goes on in the client.
There's a call to read_in_full, called from pack-write.c, line 246
that fails in the failure-case, but not in the success-case. This is
where the client expects "pack\tSHA-1" or "keep\tSHA-1". There "fatal:
early EOF"-messages seems to originate from index-pack.c, line 197.
This is the first line of code in parse_pack_header(), it's also
AFAICT the first call-site for any read(0, <...>) (though fill()).

-- 
Erik "kusma" Faye-Lund

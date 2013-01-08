From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] wincred: improve compatibility with windows versions
Date: Tue, 8 Jan 2013 21:13:49 +0100
Message-ID: <CABPQNSb7MjTKgmeB9TcUV0+-FfjPZ1sgKPsfVDg6+uaw2f_azQ@mail.gmail.com>
References: <50E73B80.4070105@gmail.com> <CABPQNSYcOrOZJd0vK=4ESC4qPpcj7RRdhVt3R0dAE-ouhOb5YA@mail.gmail.com>
 <50EC473A.6060203@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	Jeff King <peff@peff.net>
To: blees@dcon.de
X-From: git-owner@vger.kernel.org Tue Jan 08 21:14:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsfZT-0007tT-Oa
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 21:14:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752457Ab3AHUOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 15:14:33 -0500
Received: from mail-ia0-f174.google.com ([209.85.210.174]:40893 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791Ab3AHUOa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jan 2013 15:14:30 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so737683iay.19
        for <git@vger.kernel.org>; Tue, 08 Jan 2013 12:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=71K7/AAM3f7u0djBmA4/Nl6kYuJ74Uyqnei6ZsUsSNE=;
        b=lE1iFrAnvb0ofVNeJ2Yrg4V63z8h7iYNgzblCWiXw+e/L4mDTBjUrJYPJ660zD5cr2
         dshQRqwYv3LiiUTsukzcTSH8mYZ/1Lj6STrQ/bASMWREy6yaMUPBXk7BITejC9ER4crb
         ORyhbpMQ6M0C1ABs9cuLnXYzso8D8LwkgkprafZAp24uDXHEhDqbHkeEDTWm0XCM+S0X
         9bY1k4Qe5XsjqGpdFGgq9t66rh7FBgKMY8F8vm2jviOtdpvpQm19i0SbilFSywysm2x7
         7pMNwCWi0OtAUKu88YlKZo2QHhEK5GrPbp7wzGd05MhjCbk1kJIWNSPuJXs6nbta8nwm
         lzNA==
Received: by 10.50.16.210 with SMTP id i18mr10337594igd.53.1357676070329; Tue,
 08 Jan 2013 12:14:30 -0800 (PST)
Received: by 10.64.9.112 with HTTP; Tue, 8 Jan 2013 12:13:49 -0800 (PST)
In-Reply-To: <50EC473A.6060203@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213001>

On Tue, Jan 8, 2013 at 5:20 PM, Karsten Blees <karsten.blees@gmail.com> wrote:
> Am 04.01.2013 22:57, schrieb Erik Faye-Lund:
>> The only reason why I used Cred[Un]PackAuthenticationBuffer, were that
>> I wasn't aware that it was possible any other way. I didn't even know
>> there was a Windows Credential Manager in Windows XP.
>>
>
> I believe the Cred* API was introduced in Win2k. The XP control panel applet supports domain credentials only, but cmdkey.exe from Windows Server 2003 can be used on XP to manage generic credentials.
>

Thanks for the background-info.

>> The credential attributes were because they were convenient, and I'm
>> not sure I understand what you mean about the Win7 credential manager
>> tools. I did test my code with it - in fact, it was a very useful tool
>> for debugging the helper.
>>
>> Are you referring to the credentials not *looking* like normal
>> HTTP-credentials?
>
> No, I was referring to creating / editing git credentials with Windows tools manually. For example, changing your password in control panel removes all credential attributes, so the current wincred won't find them any longer...same for git credentials created e.g. via 'cmdkey /generic:git:http://me@example.com /user:me /pass:secret'.
>
> The 'puzzling' part is that those credentials *look* exactly the same as if created by wincred, but they don't work. And wincred isn't exactly verbose in its error messages :-)
>

Right, thanks for clearing that up.

>> But, if we do any of these changes, does this mean I will lose my
>> existing credentials? It's probably not a big deal, but it's worth a
>> mention, isn't it?
>>
>
> Yes, existing stored credentials are lost after this patch. Will add a note to the commit message.
>
> We _could_ try to detect the old format, but I don't think it's worth the trouble.
>

Nah, I don't think it's worth the trouble. It's a bit unfortunate that
people might get stale credentials clogging up the system, but I don't
really thing this is a big deal.

>>>  static int match_cred(const CREDENTIALW *cred)
>>>  {
>>> -       return (!wusername || !wcscmp(wusername, cred->UserName)) &&
>>> -           match_attr(cred, L"git_protocol", protocol) &&
>>> -           match_attr(cred, L"git_host", host) &&
>>> -           match_attr(cred, L"git_path", path);
>>> +       LPCWSTR target = cred->TargetName;
>>> +       if (wusername && wcscmp(wusername, cred->UserName))
>>> +               return 0;
>>> +
>>> +       return match_part(&target, L"git", L":") &&
>>> +               match_part(&target, protocol, L"://") &&
>>> +               match_part(&target, wusername, L"@") &&
>>> +               match_part(&target, host, L"/") &&
>>> +               match_part(&target, path, L"");
>>>  }
>>>
>>
>> Ugh, it feels a bit wrong to store and verify the username twice. Do
>> we really have to?
>>
>> The target needs to be unique, even if two different usernames are
>> stored for the same site under the same conditions. So probably. It
>> just doesn't feel quite right.
>>
>
> I don't really see why you would need several usernames to connect to the same target. I can imagine different credentials for reading / writing, but then the protocol would usually be different as well, wouldn't it? (e.g. http vs. ssh)
>

I can kind of make up some theoretical reasons, but they are a bit exotic ;)

> One of my interim solutions was to remove the username part from the URL entirely. That enabled me to change credentials in control panel (including the username), and wincred would use them. However, that version failed the 'helper can store multiple users' test, so I ended up with storing / checking username twice.
>

I don't think breaking this is a good idea. It just feels a bit silly,
but I see now that other applications does the same duplication. So
let's just stick to it, even if it's a bit icky ;)

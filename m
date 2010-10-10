From: Eric Sunshine <ericsunshine@gmail.com>
Subject: Re: [PATCH v3 01/14] mingw: add network-wrappers for daemon
Date: Sun, 10 Oct 2010 17:19:09 -0400
Message-ID: <4CB22DCD.8080806@gmail.com>
References: <1286716854-5744-1-git-send-email-kusmabite@gmail.com> <1286716854-5744-2-git-send-email-kusmabite@gmail.com> <4CB216C2.1060608@gmail.com> <AANLkTinP7RKOhLFZs71P5dpmA1p1OsjikSmVv5WkkL1z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org,
	Mike Pape <dotzenlabs@gmail.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Sun Oct 10 23:19:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P53If-0002El-3B
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 23:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868Ab0JJVTP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 17:19:15 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:33441 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642Ab0JJVTO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 17:19:14 -0400
Received: by pwj4 with SMTP id 4so724280pwj.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 14:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=lydC1Qj2iQcLEyMXRfYt76UQ9FVB93rCRqYI2pWlFbQ=;
        b=SBYr6vEWB+G2mcj+4CJAEdbG8ZSB+K2ZmkW4H9NIufy1VpZoBiAR7Q2oh9O/jvkjpP
         cyYNzF6ngA9HtoymhJjvf1tYod/glWHriKTJwm+ClcSXT9D7D0CD0QrPzSK2293RWG2F
         TeKrBrElRMYn2SKu8FddXHw7BqsroXaXrS8Jw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=qC28LLUH6nG1MinONAwQvt0aJ/aL8wS9Blbu0R8pMLDbN44MabGBoDPlcElqfX2fr1
         DvCppBSBkIAdf9V76/9kh5sFth1OuxiTcQGcS6gZEfG2UshQreGce24la9fGyHOhundV
         vuZbLZWrXZJRZGLeJ0Z9t3nSpV+sfiXvz2avA=
Received: by 10.114.132.18 with SMTP id f18mr6140559wad.19.1286745554278;
        Sun, 10 Oct 2010 14:19:14 -0700 (PDT)
Received: from [192.168.1.1] (user-12l2cil.cable.mindspring.com [69.81.50.85])
        by mx.google.com with ESMTPS id c15sm8282077wam.12.2010.10.10.14.19.12
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 10 Oct 2010 14:19:13 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <AANLkTinP7RKOhLFZs71P5dpmA1p1OsjikSmVv5WkkL1z@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158710>

On 10/10/2010 4:20 PM, Erik Faye-Lund wrote:
> On Sun, Oct 10, 2010 at 9:40 PM, Eric Sunshine<ericsunshine@gmail.com>  wrote:
>> On 10/10/2010 9:20 AM, Erik Faye-Lund wrote:
>>>
>>> From: Mike Pape<dotzenlabs@gmail.com>
>>>
>>> git-daemon requires some socket-functionality that is not yet
>>> supported in the Windows-port. This patch adds said functionality,
>>> and makes sure WSAStartup gets called by socket(), since it is the
>>> first network-call in git-daemon. In addition, a check is added to
>>> prevent WSAStartup (and WSACleanup, though atexit) from being
>>> called more than once, since git-daemon calls both socket() and
>>> gethostbyname().
>>>
>>> Signed-off-by: Mike Pape<dotzenlabs@gmail.com>
>>> Signed-off-by: Erik Faye-Lund<kusmabite@gmail.com>
>>> ---
>>> diff --git a/compat/mingw.c b/compat/mingw.c
>>> index 6590f33..563ef1f 100644
>>> --- a/compat/mingw.c
>>> +++ b/compat/mingw.c
>>> +#undef accept
>>> +int mingw_accept(int sockfd1, struct sockaddr *sa, socklen_t *sz)
>>> +{
>>> +       int sockfd2;
>>> +
>>> +       SOCKET s1 = (SOCKET)_get_osfhandle(sockfd1);
>>> +       SOCKET s2 = accept(s1, sa, sz);
>>> +
>>> +       /* convert into a file descriptor */
>>> +       if ((sockfd2 = _open_osfhandle(s2, O_RDWR|O_BINARY))<    0) {
>>> +               closesocket(s2);
>>> +               return error("unable to make a socket file descriptor:
>>> %s",
>>> +                       strerror(errno));
>>
>> Is 'errno' from _open_osfhandle() still valid when handed to strerror() or
>> has it been clobbered by closesocket()?
>>
>> Corollary: Does _open_osfhandle() indeed set 'errno', or is it more
>> appropriate to call WSAGetLastError()? (The documentation I read for
>> _open_osfhandle() did not say anything about how to determine the reason for
>> failure.)
>>
>
> _open_osfhandle seems to set both errno and the winsock-error.
> closesocket() sets the winsock-error but not the CRT. I've just tested
> with a very simple application:
> So, it seems that WSAGetLastError() gets clobbered by closesocket(),
> but not errno.

Thank you for checking. Even if it is not strictly needed in this case, 
for the sake of clarity (and to avoid having this question repeated in 
the future), it might be worthwhile to save 'errno' or the result of 
WSAGetLastError() in a temporary before invoking closesocket(), and then 
pass the temporary to strerror().

-- ES

From: Eric Sunshine <ericsunshine@gmail.com>
Subject: Re: [msysGit] [PATCH v3 02/14] mingw: implement syslog
Date: Sun, 10 Oct 2010 17:28:19 -0400
Message-ID: <4CB22FF3.5070503@gmail.com>
References: <1286716854-5744-1-git-send-email-kusmabite@gmail.com> <1286716854-5744-3-git-send-email-kusmabite@gmail.com> <4CB2190F.6000908@gmail.com> <AANLkTinsqAOj7LtACpbcOrVZfeUApDjmQe2uYLH8npBF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org,
	Mike Pape <dotzenlabs@gmail.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Sun Oct 10 23:28:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P53RW-0006Gc-1Z
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 23:28:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751649Ab0JJV2Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 17:28:25 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:54397 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443Ab0JJV2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 17:28:24 -0400
Received: by pxi16 with SMTP id 16so118040pxi.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 14:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=myBa3cSipPZ37HDi3c3OfsmDcQpKXCyOLl+BAYbhvtA=;
        b=JD5aiLeCP+ernroz+tyklB62D8gbRtE4G9IaHl63mI7hgB0KsncXqwJflOJWjQFP3i
         Sijj0XIWfT9aMQMyMxjNl7P4ZnUd23emc+MqlNjiTT37gKL7hokLEYEKN7Qsqk5Cov0t
         TPWW8f934P470hKsEmqXFYVJjOn+thbPBPG4E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=kZue0sfN8ugvMEYjI0iJ/a9ZQTgjTX9ZpoQEom0aLqUjUIjF3GikDrmjQ38B7qO7dC
         JJWws6t/R8Ut0FIUS8Nb2TE3v6uLDbMT7QMwUphlAUgngklPaTu0fjPqXf/qn6qiKxE7
         D4v2r5evSxt4lgTUG7y1McQ3U/twExgJysLH0=
Received: by 10.114.46.4 with SMTP id t4mr6155788wat.40.1286746104314;
        Sun, 10 Oct 2010 14:28:24 -0700 (PDT)
Received: from [192.168.1.1] (user-12l2cil.cable.mindspring.com [69.81.50.85])
        by mx.google.com with ESMTPS id d2sm11698704wam.2.2010.10.10.14.28.21
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 10 Oct 2010 14:28:23 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <AANLkTinsqAOj7LtACpbcOrVZfeUApDjmQe2uYLH8npBF@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158712>

On 10/10/2010 4:37 PM, Erik Faye-Lund wrote:
> On Sun, Oct 10, 2010 at 9:50 PM, Eric Sunshine<ericsunshine@gmail.com>  wrote:
>> On 10/10/2010 9:20 AM, Erik Faye-Lund wrote:
>>>
>>> From: Mike Pape<dotzenlabs@gmail.com>
>>>
>>> Syslog does not usually exist on Windows, so we implement our own
>>> using Window's ReportEvent mechanism.
>>>
>>> Signed-off-by: Mike Pape<dotzenlabs@gmail.com>
>>> Signed-off-by: Erik Faye-Lund<kusmabite@gmail.com>
>>> ---
>>> +void syslog(int priority, const char *fmt, const char *arg)
>>> +{
>>> +       WORD logtype;
>>> +
>>> +       if (!ms_eventlog)
>>> +               return;
>>> +
>>> +       if (strcmp(fmt, "%s")) {
>>> +               warning("format string of syslog() not implemented");
>>> +               return;
>>> +       }
>>
>> It is not exactly clear what the intention is here. Is this trying to say
>> that no formatting directives are allowed in 'fmt' or what? The simple case
>> it is actually checking (where 'fmt' is solely '%s') could easily be handled
>> manually, as could more complex formats.
>>
>
> This is the result of the feed-back in v1, where we tried to implement
> all format strings.

In retrospect, when thinking more carefully about the conditional 
expression, I suppose the code is self-documenting, though perhaps a 
comment in code or in commit message would help.

> But that turned out to be very complex (due to the
> lack of a portable va_copy()) and since we control all call-sites for
> syslog and already only use "%s" as the format, it should be OK.

Do you mean vsnprintf() rather than va_copy()?

>>> +       /*
>>> +        * ReportEvent() doesn't handle strings containing %n, where n is
>>> +        * an integer. Such events must be reformatted by the caller.
>>> +        */
>>> +       ReportEventA(ms_eventlog,
>>> +           logtype,
>>> +           0,
>>> +           0,
>>> +           NULL,
>>> +           1,
>>> +           0,
>>> +           (const char **)&arg,
>>> +           NULL);
>>
>> The comment about '%n' seems to be warning about a potential problem but
>> does not actually protect against it. Should this issue be handled?
>>
>
> This is again an issue that was discussed in the first round.
> ReportEvent() CANNOT report a string containing "%n" (where n is an
> integer). And while we could probably try to work around it by
> inserting a space or something, and I don't think we ever were able to
> find a case where we could report a string containing "%n" in the
> first place...
>
> Are you suggesting that we report an error when we can't report the
> string correctly? We could do that, but I'm not sure how the end-user
> would benefit from that. ReportEvent is used to report errors (unless
> the --verbose flag has been specified), and reporting that we can't
> present an error message strike me as a bit confusing... Even the
> corrupted error message is probably better :P

I am not suggesting reporting an error. As a first-time reader of the 
code, I was trying to understand the presence of the comment which did 
not really seem to relate to the code. Perhaps adding a "FIXME" to the 
comment saying that the condition should perhaps be handled in the 
future would help to explain the comments presence.

(On the other hand, for the '%s' check above, the code does report a 
warning and then exits, so it is not inconceivable that a '%n' could 
also emit a warning.)

-- ES

From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Silence stderr in parse_commit*() subroutines
Date: Mon, 13 Feb 2012 19:15:01 +0100
Message-ID: <201202131915.01753.jnareb@gmail.com>
References: <5fa08a8b-f0a2-4796-bf0d-06a8f13bf703@b23g2000yqn.googlegroups.com> <201202111402.31684.jnareb@gmail.com> <CA+EqV8xTsavQFWsoijrt+0UcfxSZO2voL=CawrRPvDeB=qHQfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: rajesh boyapati <boyapatisrajesh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 19:15:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx0Qj-0004wj-Vk
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 19:15:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755666Ab2BMSPG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 13:15:06 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:46772 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757443Ab2BMSPF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 13:15:05 -0500
Received: by eekc14 with SMTP id c14so1947140eek.19
        for <git@vger.kernel.org>; Mon, 13 Feb 2012 10:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=5Hbc1rPjBnHLKawiWnm49BVboW96jSlbhM9CqYeR+s0=;
        b=A5vRw8cvdgodliKRLXbPyQ9CcpKVZz2eSP7UIdr16bfaQeNYsjjtZkvqWPnXO6mR50
         8cxZ9qk2/anFvJc5cLH/X861Fu7cp+xumEl8I7qsJ2EC7XklVFJK6q5GGzs4ErBI1Y7k
         xs3gjmxLEQ41x6TJHN+V4X61Q+R0peg7DBe6U=
Received: by 10.14.94.193 with SMTP id n41mr4405253eef.74.1329156903650;
        Mon, 13 Feb 2012 10:15:03 -0800 (PST)
Received: from [192.168.1.13] (aeho143.neoplus.adsl.tpnet.pl. [79.186.196.143])
        by mx.google.com with ESMTPS id a58sm63469068eeb.8.2012.02.13.10.15.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 13 Feb 2012 10:15:02 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <CA+EqV8xTsavQFWsoijrt+0UcfxSZO2voL=CawrRPvDeB=qHQfg@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190641>

On Mon, 13 Feb 2012, rajesh boyapati wrote:
> 2012/2/11 Jakub Narebski <jnareb@gmail.com>
>> On Thu, 9 Feb 2012, Jakub Narebski wrote:
>>> On Wed, 8 Feb 2012, rajesh boyapati wrote:
>>>> 2012/2/8 Jakub Narebski <jnareb@gmail.com>

[...]
>>>> When I applied the above patch and also the patch from your previous
>>>> e-mail, I am getting this error
>>>>>>>>>>>>>>>>>
>>>> [2012-02-08 14:09:58,396] ERROR
>>>> com.google.gerrit.httpd.gitweb.GitWebServlet : CGI: fatal: bad revision
>>>> 'HEAD'
>>>> [2012-02-08 14:10:06,732] ERROR
>>>> com.google.gerrit.httpd.gitweb.GitWebServlet : CGI: fatal: bad revision
>>>> 'HEAD'
>>>> [2012-02-08 14:10:11,404] ERROR
>>>> com.google.gerrit.httpd.gitweb.GitWebServlet : CGI: fatal: bad revision
>>>> 'HEAD'
>>>> [2012-02-08 14:10:15,270] ERROR
>>>> com.google.gerrit.httpd.gitweb.GitWebServlet : CGI: fatal: Not a valid
>>>> object name HEAD
>>>> <<<<<<<<<<<<<<
>>>> With these patches, the previous errors at line numbers are gone.
[...]
>>> This final issue will be a bit harder to fix.  This error message
>>>
>>>   fatal: bad revision 'HEAD'
>>>
>>> comes from git (I think from "git rev-list" command), and not from gitweb.
>>> It is printed on STDERR of git command.  What has to be done to fix it is
>>> to capture stderr of a process, or silence it.
[...]
>> Anyway, here is the patch that should fix those "CGI: fatal: Not a valid
>> object name HEAD" errors for you.
>>
>> I'll resend the all the patches as single patch series for inclusion in
>> git, but I am not sure if this latest patch will be accepted because of
>> drawbacks of its implementation.
>>
>> -->8 ---- ----- ----- ----->8 --
>> From: Jakub Narebski <jnareb@gmail.com>
>> Subject: [PATCH] gitweb: Silence stderr in parse_commit*() subroutines
[...]
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index 1181aeb..081ac45 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -3338,12 +3338,13 @@ sub parse_commit {
>>
>>        local $/ = "\0";
>>
>> -       open my $fd, "-|", git_cmd(), "rev-list",
>> +       open my $fd, "-|", quote_command(
>> +               git_cmd(), "rev-list",
>>                "--parents",
>>                "--header",
>>                "--max-count=1",
>>                $commit_id,
>> -               "--",
>> +               "--") . ' 2>/dev/null',
>>                or die_error(500, "Open git-rev-list failed");
>>        my $commit_text = <$fd>;
>>        %co = parse_commit_text($commit_text, 1)
>> @@ -3363,7 +3364,8 @@ sub parse_commits {
>>
>>        local $/ = "\0";
>>
>> -       open my $fd, "-|", git_cmd(), "rev-list",
>> +       open my $fd, "-|", quote_command(
>> +               git_cmd(), "rev-list",
>>                "--header",
>>                @args,
>>                ("--max-count=" . $maxcount),
>> @@ -3371,7 +3373,7 @@ sub parse_commits {
>>                @extra_options,
>>                $commit_id,
>>                "--",
>> -               ($filename ? ($filename) : ())
>> +               ($filename ? ($filename) : ())) . ' 2>/dev/null'
>>                or die_error(500, "Open git-rev-list failed");
>>        while (my $line = <$fd>) {
>>                my %co = parse_commit_text($line);
>>
> 
> I am getting this error with this patch
>>>>>>>>>>>>>>>>>>>
> [2012-02-13 11:20:19,268] ERROR
> com.google.gerrit.httpd.gitweb.GitWebServlet : CGI: usage: git rev-list
> [OPTION] <commit-id>... [ -- paths... ]
> [2012-02-13 11:20:19,268] ERROR
> com.google.gerrit.httpd.gitweb.GitWebServlet : CGI:   limiting output:
> [2012-02-13 11:20:19,268] ERROR
> com.google.gerrit.httpd.gitweb.GitWebServlet : CGI:     --max-count=nr
[...]
> [2012-02-13 11:20:27,913] ERROR
> com.google.gerrit.httpd.gitweb.GitWebServlet : CGI: fatal: bad flag '--2'
> used after filename
> [2012-02-13 11:20:32,579] ERROR
> com.google.gerrit.httpd.gitweb.GitWebServlet : CGI: fatal: bad flag '--2'
> used after filename
> <<<<<<<<<<<<<<<<<<<

Strange, I cannot reproduce this with non-Gerrit gitweb.  It looks
like it somehow lost in between "... -- 2>/dev/null" at the end of
git-rev-list command, and fails at "--2" which is bad flag.

Are you sure you applied the patch correctly?  Does 'object' view
(take any 'commit' or 'blob' or 'tree' view, and replace action part
by 'object') works correctly in Gerrit's gitweb?

-- 
Jakub Narebski
Poland

From: Andrej Manduch <amanduch@gmail.com>
Subject: Re: [PATCH] git-svn: doublecheck if really file or dir
Date: Sun, 27 Jul 2014 04:46:42 +0200
Message-ID: <53D46812.3020706@gmail.com>
References: <1405657201-32035-1-git-send-email-amanduch@gmail.com> <20140723220414.GA14145@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Jul 27 04:46:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBEUE-0006ND-Td
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jul 2014 04:46:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbaG0Cqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2014 22:46:50 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:61775 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219AbaG0Cqt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2014 22:46:49 -0400
Received: by mail-wi0-f177.google.com with SMTP id ho1so2698394wib.4
        for <git@vger.kernel.org>; Sat, 26 Jul 2014 19:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=yGWzsxPaGSksR8UWGno1EnqG2M9B726eKnseZJqC3tk=;
        b=LkiuMeaL6nG5GkxTC683F2DnJaotGQTf3TNoxMAvB41zaGmhonPhSxkT6wwNcmJH2I
         YPyFx5RyU1HEuF/9RDR+joE01Rbyr3YX0cRhUMZxasM5/gwQIGX53KN1EjwJbfvdRLww
         aZZXS+5H4o1Sk586TZonpJloGhYLoT7EpRpcndsUrVsLrPCE2WnZfAXnfXEfJgX7QbL6
         HQkI6vSwLsvZ9SybAqwYQk0Nlrn7VTL8TEwFvr3/QPdfWIOvXe2SAtFl1fhjmCyGKmq3
         tdxTRYtmpgl4DF/SBhs5Ygthd7mBn+cJlngNpt7LKXDIUC2nraS4N5wqVVXFRB1hkxAX
         qcrQ==
X-Received: by 10.194.91.228 with SMTP id ch4mr34708860wjb.59.1406429208098;
        Sat, 26 Jul 2014 19:46:48 -0700 (PDT)
Received: from [192.168.1.3] ([80.242.44.116])
        by mx.google.com with ESMTPSA id o2sm14016668wij.24.2014.07.26.19.46.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jul 2014 19:46:46 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <20140723220414.GA14145@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254282>

Hi,

On 07/24/2014 12:04 AM, Eric Wong wrote:
> Andrej Manduch <amanduch@gmail.com> wrote:
>> * this fixes 'git svn info `pwd`' buggy behaviour
> 
> Good catch, the commit could use a better description, something like:
> --------------------------- 8< ----------------------------
> Subject: [PATCH] git-svn: "info" checks for dirs more carefully
> 
> This avoids a "Reading from filehandle failed at ..." error when
> running "git svn info `pwd`".
> 
> Signed-off-by: Andrej Manduch <amanduch@gmail.com>
> --------------------------- 8< ----------------------------
> 
> While your patch avoids an error, but the output isn't right, either.
> I tried it running in /home/ew/ruby, the URL field is bogus:
> 
>     ~/ruby$ git svn info `pwd`
>     Path: /home/ew/ruby
>     URL: svn+ssh://svn.ruby-lang.org/ruby/trunk/home/ew/ruby
>     Repository Root: svn+ssh://svn.ruby-lang.org/ruby
>     Repository UUID: b2dd03c8-39d4-4d8f-98ff-823fe69b080e
>     Revision: 46901
>     Node Kind: directory
>     Schedule: normal
>     Last Changed Author: hsbt
>     Last Changed Rev: 46901
>     Last Changed Date: 2014-07-22 19:06:12 +0000 (Tue, 22 Jul 2014)
> 
> The URL should be:
> 
>     URL: svn+ssh://svn.ruby-lang.org/ruby/trunk
> 
> It's better than an error, but it'd be nice if someone who uses
> this command can fix it (*hint* :).

Thx, I missed this. However this bug was not introduced with my patch,
it was there before. If you try use `git svn info full_path` and
directory is not a root dir this bug will occour even wihout my patch.

However I'll try to find some time to fix this too.

On 07/24/2014 12:04 AM, Eric Wong wrote:
> 
>> --- a/git-svn.perl
>> +++ b/git-svn.perl
>> @@ -2029,7 +2029,7 @@ sub find_file_type_and_diff_status {
>>  	my $mode = (split(' ', $ls_tree))[0] || "";
>>  
>>  	return ("link", $diff_status) if $mode eq "120000";
>> -	return ("dir", $diff_status) if $mode eq "040000";
>> +	return ("dir", $diff_status) if $mode eq "040000" or -d $path;
> 
> "or" has a lower precedence than "||", so I would do the following:
> 
> 	return ("dir", $diff_status) if $mode eq "040000" || -d $path;
> 
> The general rule I've learned is to use "||" for conditionals and
> "or" for control flow (e.g. do_something() or die("...") ).
> 
> I can take your patch with the above changes (no need to resend),
> but I'd be happier to see the URL field corrected if you want
> to reroll.

I'll try to fix whis url bug, but it will be different patch 'cause I
think, this is different kind of a problem.

On 07/24/2014 12:04 AM, Eric Wong wrote:
> 
> Thanks.
> 

I thanks to you for great review.

--
Best Regards,
b.

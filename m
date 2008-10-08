From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] gitweb: refactor input parameters parse/validation
Date: Wed, 8 Oct 2008 11:10:23 +0200
Message-ID: <cb7bb73a0810080210s49d1683dj4e2fef8072522abd@mail.gmail.com>
References: <1223054356-17643-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <200810071257.38423.jnareb@gmail.com>
	 <cb7bb73a0810070542v4c8a9820x4d91ea20597ddf01@mail.gmail.com>
	 <200810071639.25324.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 08 11:12:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnV4y-0006Xw-DJ
	for gcvg-git-2@gmane.org; Wed, 08 Oct 2008 11:11:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753610AbYJHJKZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 05:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754259AbYJHJKZ
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 05:10:25 -0400
Received: from wx-out-0506.google.com ([66.249.82.232]:57926 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752257AbYJHJKY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2008 05:10:24 -0400
Received: by wx-out-0506.google.com with SMTP id h27so857446wxd.4
        for <git@vger.kernel.org>; Wed, 08 Oct 2008 02:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=eIesiRHWmb5/ldsVxPhIrCj4jE8Vawf/nIws9tNFz60=;
        b=wghCFIqeI1IOYPAkgxW0aXV0XuMZIqZ4KZ00n7gZZc78i6QuCXUlvF80WJWpRyU+z+
         NgWWiwRW9fLrKjAtZ8sEsNqOLkSp6s9U7vE03EtKHXIUGh9arh5PeH+pFkQTtY8E3+sn
         XmrOULJhhYth36gPv7YGKGpq6L4KH2KFOcgws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=MmJ3w0uMCPod3Rq0a9XErlBh5rXSqsokRYHHv+/Uy6yAV7h8GdjECl26usWewyWo3y
         T1qkvvUQonIQo7uAwQ1jvnNsTSxP07hllgudtVNifOVZDbg5+40HRLPixsSO0lIVQQ8g
         cBe3+bNxNfFiA+h6cd8g8TcWKEsZDTKkTfNaI=
Received: by 10.151.43.19 with SMTP id v19mr2752942ybj.84.1223457023074;
        Wed, 08 Oct 2008 02:10:23 -0700 (PDT)
Received: by 10.150.145.2 with HTTP; Wed, 8 Oct 2008 02:10:23 -0700 (PDT)
In-Reply-To: <200810071639.25324.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97787>

On Tue, Oct 7, 2008 at 4:39 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> Giuseppe Bilotta wrote:
>> On Tue, Oct 7, 2008 at 12:57 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>>> On Fri, 3 Oct 2008, Giuseppe Bilotta wrote:
>
>>>> +     # find which part of PATH_INFO is project
>>>> +     my $project = $path_info;
>>>
>>> Hmmm... now $project is local (lexically) here.
>>
>> Yes, itt's only used temporarily here, to see if  a proper $project
>> can be defined. It gets redefined outside. It just made sense to name
>> it like this 8-)
>
> Well, if $project is local in evaluate_path_info(), so could be
> $path_info...

But $path_info in evaluate_path_info() has the same purpose and the
same (initial) data as $path_info outside of evaluate_path_info(), the
same is not true for $project.

>>>> +     $project =~ s,/+$,,;
>>>> +     while ($project && !check_head_link("$projectroot/$project")) {
>>>> +             $project =~ s,/*[^/]*$,,;
>>>> +     }
>>>> +     # validate project
>>>> +     $project = validate_project($project);
>>>
>>> I'm not sure if it is worth worrying over, but I think you repeat
>>> check_head_link() check here.
>>>
>>> [After examining code further].  But I think you do double validation;
>>> once you do it here, and once you do it copying to global variables
>>> such as $action or $project, and double checking check_head_link()
>>> won't be easy to avoid; fortunately it is cheap filesystem-level check
>>> (might be slow only when stat is extremely slow, and is not cached).
>>
>> I know. This is actually the reason why I had interleaved path_info
>> definition and global validation in my previous version of the patch.
>> The big issue here is that path_info evaluation _needs_ (partial)
>> validation.
>>
>> A possible alternative could be to only put validated parameters into
>> %input_params. This would completely separate the validation for cgi
>> and path_info (modulo shared subs).
>>
>> Of course, the check_head_link would still be repeated inside
>> evaluate_path_info, but the other params could skip a double
>> validation.
>
> Wouldn't it be simpler and as good solution to just leave validation
> off evaluate_path_info() (well, of course except check_head_link() test),
> and allow it to be validated when assigning global 'params' variables?
> check_head_link() would be repeated for path_info links, but that
> should not affect performance much.

Well, it does have a performance hit in the case of invalid $project
since it spends time working on the rest of the URL before bailing
out, but it's probably the cleanest solution. I'll do it this way.

-- 
Giuseppe "Oblomov" Bilotta

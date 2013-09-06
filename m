From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH] git-svn: Fix termination issues for remote svn connections
Date: Fri, 6 Sep 2013 04:46:30 -0700
Message-ID: <A46AD76E-56FA-4555-8811-6141284300DD@gmail.com>
References: <6970c0cab40c60195c8f042a3b930a0a.squirrel@83.236.132.106> <xmqqli3bhzop.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>,
	Uli Heller <uli.heller@daemons-point.com>
X-From: git-owner@vger.kernel.org Fri Sep 06 13:46:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHuUp-0002MY-38
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 13:46:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241Ab3IFLqe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 07:46:34 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:39953 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067Ab3IFLqd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 07:46:33 -0400
Received: by mail-pa0-f47.google.com with SMTP id kl13so3243180pab.34
        for <git@vger.kernel.org>; Fri, 06 Sep 2013 04:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=Gm3uZeGDS6MohVP17piauhZx11rLwU5/xwixRSfM9H8=;
        b=cY+eCmnIrHhsgRtNqMhVjZn9JkpZvVDSv5bdqzSvXgzpAWeUQwFjKLNxbjgzUo53iH
         RHUHs23nSyRX+x+U/PpI1r7B8UJe9+Y/NmWVA18GTrgCjCgm02pNvn16/jHO2NeAg/+2
         7hf1C0okX8rDOaQGS7UbCbfcnJ1/x2BePHK66qmQ7YUkmjDYBS0GkB1YLOI9nLn+i3Vv
         ELF9I/mgUQLj4ti0MRuZ/tIoUEJtw7FAQBTfFnidjeRWDx5QTrweeL/llWPoGMzOX7rl
         bdJ403zAhevKki/oED9VKXxjbdsu+ww+j4dABFZlUnTLxM5cUGbq8aOBVFP3N0H30HvR
         0xuA==
X-Received: by 10.66.168.7 with SMTP id zs7mr3522129pab.152.1378467993322;
        Fri, 06 Sep 2013 04:46:33 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id fa4sm4279727pab.17.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 06 Sep 2013 04:46:32 -0700 (PDT)
In-Reply-To: <xmqqli3bhzop.fsf@gitster.dls.corp.google.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234041>

On Sep 5, 2013, at 11:48, Junio C Hamano wrote:
> "Uli Heller" <uli.heller@daemons-point.com> writes:
>
>> When using git-svn in combination with serf-1.2.1 core dumps are
>> created on termination. This is caused by a bug in serf, a fix for
>> the bug exists (see https://code.google.com/p/serf/source/detail?r=2146) 
>> .
>> Nevertheless, I think it makes sense to fix the issue within the
>> git perl module Ra.pm, too. The change frees the private copy of
>> the remote access object on termination which prevents the error
>> from happening.
>>
>> Note: Since subversion-1.8.0 and later do require serf-1.2.1 or  
>> later,
>> the core dumps typically do show up when upgrading to a recent  
>> version
>> of subversion.
>>
>> Credits: Jonathan Lambrechts for proposing a fix to Ra.pm.
>> Evgeny Kotkov and Ivan Zhakov for fixing the issue in serf and
>> pointing me to that fix.
>> ---
>
> Thanks.  Please sign-off your patch.
>
> I am Cc'ing Kyle McKay who apparently had some experience working
> with git-svn with newer svn that can only use serf, hoping that we
> can get an independent opinion/test just to be sure.  Also Cc'ed is
> Eric Wong who has been the official git-svn area expert, but I
> understand that Eric hasn't needed to use git-svn for quite a while,
> so it is perfectly fine if he does not have any comment on this one.
>
> We may want to find a volunteer to move "git svn" forward as a new
> area expert (aka subsystem maintainer), by the way.
>
>> perl/Git/SVN/Ra.pm | 5 +++++
>> 1 file changed, 5 insertions(+)
>>
>> diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
>> index 75ecc42..78dd346 100644
>> --- a/perl/Git/SVN/Ra.pm
>> +++ b/perl/Git/SVN/Ra.pm
>> @@ -32,6 +32,11 @@ BEGIN {
>> 	}
>> }
>>
>> +END {
>> +	$RA = undef;
>> +	$ra_invalid = 1;
>> +}
>> +
>> sub _auth_providers () {
>> 	my @rv = (
>> 	  SVN::Client::get_simple_provider(),

I have not, as of yet, been able to reproduce the problem, so I cannot  
verify the solution.  Maybe Uli can provide an example of a git-svn  
command that demonstrates the failure?

I am running a fresh build of subversion 1.8.3 with serf version 1.3.1  
(the most recent serf release).

According to the serf library history, version 1.3.1 of serf was  
tagged at revision 2139 from revision 2138, but the serf fix mentioned  
above was checked in at revision 2146, so it cannot possibly be in the  
serf 1.3.1 release.

I'm using Git built from master (57e4c1783).  I see the same behavior  
both with and without the SVN/Ra.pm patch (and using both bulk updates  
and skelta mode).  Does the problem not happen on a git svn clone?  I  
can force serf back to version 1.2.1 and try that version just to see,  
but I would like to have an example of a known failing git svn command  
for testing purposes.  Thanks.

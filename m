From: "Uli Heller" <uli.heller@daemons-point.com>
Subject: Re: [PATCH] git-svn: Fix termination issues for remote svn 
     connections
Date: Fri, 6 Sep 2013 14:06:32 +0200 (CEST)
Message-ID: <07b9b270090d6b42515c5dc3dfb8ab4f.squirrel@83.236.132.106>
References: <6970c0cab40c60195c8f042a3b930a0a.squirrel@83.236.132.106>
    <xmqqli3bhzop.fsf@gitster.dls.corp.google.com>
    <A46AD76E-56FA-4555-8811-6141284300DD@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Eric Wong" <normalperson@yhbt.net>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 06 14:06:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHuoI-0002YX-W4
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 14:06:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340Ab3IFMGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 08:06:42 -0400
Received: from daemons-point.com ([213.133.97.207]:59838 "EHLO
	daemons-point.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218Ab3IFMGl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 08:06:41 -0400
Received: from port-83-236-132-106.static.qsc.de ([83.236.132.106] helo=qscmail.daemons-point.com)
	by daemons-point.com with esmtp (Exim 4.76)
	(envelope-from <uli.heller@daemons-point.com>)
	id 1VHuoA-00016J-3C; Fri, 06 Sep 2013 14:06:38 +0200
Received: from [127.0.0.1] (helo=83.236.132.106)
	by qscmail.daemons-point.com with esmtp (Exim 4.60)
	(envelope-from <uli.heller@daemons-point.com>)
	id 1VHuo3-0005ew-TO; Fri, 06 Sep 2013 14:06:32 +0200
Received: from 155.250.255.142
        (SquirrelMail authenticated user uli)
        by 83.236.132.106 with HTTP;
        Fri, 6 Sep 2013 14:06:32 +0200 (CEST)
In-Reply-To: <A46AD76E-56FA-4555-8811-6141284300DD@gmail.com>
User-Agent: SquirrelMail/1.4.17
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234042>

On Fri, September 6, 2013 1:46 pm, Kyle J. McKay wrote:
> On Sep 5, 2013, at 11:48, Junio C Hamano wrote:
>> "Uli Heller" <uli.heller@daemons-point.com> writes:
>>
>>> When using git-svn in combination with serf-1.2.1 core dumps are
>>> created on termination. This is caused by a bug in serf, a fix for
>>> the bug exists (see
>>> https://code.google.com/p/serf/source/detail?r=2146)
>>> .
>>> Nevertheless, I think it makes sense to fix the issue within the
>>> git perl module Ra.pm, too. The change frees the private copy of
>>> the remote access object on termination which prevents the error
>>> from happening.
>>>
>>> Note: Since subversion-1.8.0 and later do require serf-1.2.1 or
>>> later,
>>> the core dumps typically do show up when upgrading to a recent
>>> version
>>> of subversion.
>>>
>>> Credits: Jonathan Lambrechts for proposing a fix to Ra.pm.
>>> Evgeny Kotkov and Ivan Zhakov for fixing the issue in serf and
>>> pointing me to that fix.
>>> ---
>>
>> Thanks.  Please sign-off your patch.
>>
>> I am Cc'ing Kyle McKay who apparently had some experience working
>> with git-svn with newer svn that can only use serf, hoping that we
>> can get an independent opinion/test just to be sure.  Also Cc'ed is
>> Eric Wong who has been the official git-svn area expert, but I
>> understand that Eric hasn't needed to use git-svn for quite a while,
>> so it is perfectly fine if he does not have any comment on this one.
>>
>> We may want to find a volunteer to move "git svn" forward as a new
>> area expert (aka subsystem maintainer), by the way.
>>
>>> perl/Git/SVN/Ra.pm | 5 +++++
>>> 1 file changed, 5 insertions(+)
>>>
>>> diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
>>> index 75ecc42..78dd346 100644
>>> --- a/perl/Git/SVN/Ra.pm
>>> +++ b/perl/Git/SVN/Ra.pm
>>> @@ -32,6 +32,11 @@ BEGIN {
>>> 	}
>>> }
>>>
>>> +END {
>>> +	$RA = undef;
>>> +	$ra_invalid = 1;
>>> +}
>>> +
>>> sub _auth_providers () {
>>> 	my @rv = (
>>> 	  SVN::Client::get_simple_provider(),
>
> I have not, as of yet, been able to reproduce the problem, so I cannot
> verify the solution.  Maybe Uli can provide an example of a git-svn
> command that demonstrates the failure?
>
> I am running a fresh build of subversion 1.8.3 with serf version 1.3.1
> (the most recent serf release).
>
> According to the serf library history, version 1.3.1 of serf was
> tagged at revision 2139 from revision 2138, but the serf fix mentioned
> above was checked in at revision 2146, so it cannot possibly be in the
> serf 1.3.1 release.
>
> I'm using Git built from master (57e4c1783).  I see the same behavior
> both with and without the SVN/Ra.pm patch (and using both bulk updates
> and skelta mode).  Does the problem not happen on a git svn clone?  I
> can force serf back to version 1.2.1 and try that version just to see,
> but I would like to have an example of a known failing git svn command
> for testing purposes.  Thanks.

I think this command should produce the error:

  git svn clone --stdlayout https://github.com/uli-heller/uli-javawrapper

You can use any other svn repo as well, you only have to specify an HTTPS
url.

[Yes, I know you typically don't clone github via git svn]

I'll do some more tests using git HEAD and serf 1.3.1 when I'm back home.

Thanks + best regards, Uli

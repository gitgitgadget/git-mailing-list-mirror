From: Karthik R <karthikr@fastmail.fm>
Subject: Re: [PATCH][resend] git-svn: Respect GIT_SSH setting
Date: Mon, 17 Aug 2009 23:33:02 -0500
Message-ID: <4A8A2EFE.6000203@fastmail.fm>
References: <4A89E185.2010307@fastmail.fm> <alpine.DEB.1.00.0908180117140.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 18 06:33:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdGNn-00037T-MO
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 06:33:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbZHREdD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 00:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbZHREdC
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 00:33:02 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:40159 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751024AbZHREdB (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Aug 2009 00:33:01 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 504755107A;
	Tue, 18 Aug 2009 00:33:02 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 18 Aug 2009 00:33:02 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=JC5SPBAU2UkMlYBJ10tIXS+HXq0=; b=LmpipTrcY9hI5/LALCrP9toT/bpKsW9uP3q4GjfV4C1J/Bex8PRWzyYpuw2TRDnqfUzMglCQ0HIavcyfts+hbGospOnlIRGfyJx85IZgx8PbKaO51M+WdxNt13hko0mQQp+BnBxg8VR5TBuiNCB//1Guv+fK/pSbkezN+/eYMMs=
X-Sasl-enc: LQc1sLLjtUxFL3OO2hHydKrbszmB/fYySiQ5HWVg6riq 1250569981
Received: from [192.168.10.12] (99-156-81-160.lightspeed.austtx.sbcglobal.net [99.156.81.160])
	by www.fastmail.fm (Postfix) with ESMTPSA id 9B6111F2DD;
	Tue, 18 Aug 2009 00:33:01 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
In-Reply-To: <alpine.DEB.1.00.0908180117140.8306@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126344>

Johannes Schindelin wrote:
> Hi,
>
> On Mon, 17 Aug 2009, Karthik R wrote:
>
>   
>> Setting GIT_SSH when using "git svn clone svn+ssh://..." does not
>> override the default ssh; SVN_SSH needed to be set instead.
>>     
>
> This is now in past tense, no?
>
>   
Yes... this is all in the past tense now :) ... should be "did not 
override the default ssh". I'll fix it if I have to resend the patch for 
a different reason.
>> diff --git a/git-svn.perl b/git-svn.perl
>> index b0bfb74..9bc1e71 100755
>> --- a/git-svn.perl
>> +++ b/git-svn.perl
>> @@ -21,6 +21,13 @@ $Git::SVN::default_ref_id = $ENV{GIT_SVN_ID} || 'git-svn';
>> $Git::SVN::Ra::_log_window_size = 100;
>> $Git::SVN::_minimize_url = 'unset';
>>
>> +# If GIT_SSH is set, also set SVN_SSH...
>> +$ENV{SVN_SSH} = $ENV{GIT_SSH} if defined $ENV{GIT_SSH};
>> +# ... and escape \s in shell-variable on Windows
>> +if ($^O eq 'MSWin32' || $^O eq 'msys') {
>> +       $ENV{SVN_SSH} =~ s/\\/\\\\/g if defined $ENV{SVN_SSH};
>> +}
>>     
>
> This is a change from before... I do not know if it is a good one, as 
> SVN_SSH could be defined differently by the user, no?  In that case, the 
> user was most likely using the correct amount of backslashes...
>   
Dscho, The *correct* amount of backslashes is 1 (per dir) - same as used 
with GIT_SSH. If the user has set SVN_SSH but not GIT_SSH (most likely 
without escaping \), then fixing up SVN_SSH for use with git-svn is not 
a bad thing.

I did this change to retain existing behavior (using SVN_SSH to 
override) even when user doesn't know the \\ quirk - or if the user has 
set it for some other non-msys version of svn.
> So maybe it was correct to make this dependent on "if defined 
> $ENV{GIT_SSH}", and maybe it should be dependent on "&& !defined 
> $ENV{SVN_SSH}" as well...
>
> Ciao,
> Dscho
>
>   

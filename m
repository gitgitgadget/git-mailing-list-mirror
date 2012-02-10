From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/5] gitweb: Option for filling only specified info in fill_project_list_info
Date: Fri, 10 Feb 2012 14:56:44 +0100
Message-ID: <201202101456.45944.jnareb@gmail.com>
References: <1328359648-29511-1-git-send-email-jnareb@gmail.com> <201202100052.26399.jnareb@gmail.com> <7vvcnftvb5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 14:56:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvqy7-0003yU-A6
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 14:56:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755053Ab2BJN4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Feb 2012 08:56:50 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:57535 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754160Ab2BJN4u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 08:56:50 -0500
Received: by eekc14 with SMTP id c14so964000eek.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 05:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=tb28X3+U0gzhU5xPUAyKfh5u0b2sg0ODWNyThaAB8ho=;
        b=I7Zhe5jbEfh4wWoAcnNrrK9RHGdYN3ACSgMmeUtbCCg2wuPtcCe5s1Ev0MGAF3UeV0
         L4/8eqsXsQbXNqFALBkOjSLuah8g8gGmlkrJgp0ZMb4xe0jjLu8ZDXorN8p1sG7bp5TX
         iFcyZ9fa81NUNGA9fp21cKFhL8zIN4XPIo/Og=
Received: by 10.213.25.215 with SMTP id a23mr1115895ebc.60.1328882208935;
        Fri, 10 Feb 2012 05:56:48 -0800 (PST)
Received: from [192.168.1.13] (abwh187.neoplus.adsl.tpnet.pl. [83.8.231.187])
        by mx.google.com with ESMTPS id n17sm22430594eei.3.2012.02.10.05.56.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Feb 2012 05:56:47 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vvcnftvb5.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190409>

On Fri, 10 Feb 2012, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>> On Fri, 10 Feb 2012, Junio C Hamano wrote:
>> ...
>>> That still does not answer the fundamental issues I had with the presented
>>> API: why does it take only a single $key (please re-read my "A, B and C"
>>> example), and what does that single $key intersecting with @fill_only have
>>> anything to do with "needs-filling"?
>>
>> project_info_needs_filling() in absence of @fill_only is just a thin
>> wrapper around "!defined $pr->{$key}", it checks for each key if it needs
>> to be filled.
>>
>> It is used like this
>>
>>   if (project_info_needs_filled("A", "A, B, C")) {
>>      fill A
>>   }
>>   if (project_info_needs_filled("B", "A, B, C")) {
>>      fill B
>>   }
>>   ...
>>  
>>> After all, that 'age' check actually wants to fill 'age' and 'age_string'
>>> in the project. [...]

Thanks for noticing that... though I think more important is that some
further command would mark only 'age_string' as needed, and 
fill_project_list_info() wouldn't notice that it needs to run
git_get_last_activity() if it checks only 'age'.

>> It is not as much matter of API, as the use of checks in loop in 
>> fill_project_list_info().
>>
>> What is now
>>
>>   my (@activity) = git_get_last_activity($pr->{'path'});
>>   unless (@activity) {
>>   	next PROJECT;
>>   }
>>   ($pr->{'age'}, $pr->{'age_string'}) = @activity;
>>
>> should be
>>
>>   if (!defined $pr->{'age'} ||
>>       !defined $pr->{'age_string'}) {
>>   	my (@activity) = git_get_last_activity($pr->{'path'});
>>   	unless (@activity) {
>>   		next PROJECT;
>>   	}
>>   	($pr->{'age'}, $pr->{'age_string'}) = @activity;
>>   }
> 
> Huh?  Compare that with what you wrote above "It is used like this".  This
> is *NOT* using the API like that.  The caller knows it wants both age and
> age-string, and if even one of them is missing, do the work to fill both.
> 
> So why isn't the info-needs-filled API not checking _both_ with a single
> call?  It is only because you designed the API to accept only a single $key
> instead of list of "here are what I care about".

Passing two lists as parameters is a bit harder and makes for more
complicated API. 

So what you mean is that instead of proposed

  if (project_info_needs_filled($pr, 'age', @fill_only) ||
      project_info_needs_filled($pr, 'age_string', @fill_only) {

it should be

  if (project_info_needs_filled($pr, 'age', 'age_string', \@fill_only) {

or

  if (project_info_needs_filled($pr, ['age', 'age_string'], @fill_only) {

(with either "..., 'owner', ..." or "..., [ 'owner' ], ..." for single-key
filling), or

  if (project_info_needs_filled($pr, ['age', 'age_string'], \@fill_only) {

Is it?

-- 
Jakub Narebski
Poland

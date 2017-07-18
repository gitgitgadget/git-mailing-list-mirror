Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCFE11FF30
	for <e@80x24.org>; Tue, 18 Jul 2017 08:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751412AbdGRIrT (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jul 2017 04:47:19 -0400
Received: from gogh.unco.de ([193.235.147.132]:38696 "EHLO gogh.unco.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751341AbdGRIrR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2017 04:47:17 -0400
X-Greylist: delayed 320 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Jul 2017 04:47:17 EDT
Received: from [IPv6:2a02:8108:45c0:70ce:7c3f:3719:6b93:4efa] (unknown [IPv6:2a02:8108:45c0:70ce:7c3f:3719:6b93:4efa])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by gogh.unco.de (Postfix) with ESMTPSA id 0445A1CC333;
        Tue, 18 Jul 2017 10:41:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=unco.de; s=default;
        t=1500367315; bh=E1mpbiReO+8+5NgZsiQdJvfvR21Q87g+fLLPEm08wW4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=PPcVJ8fABUWPjaAjbGlCJIXgEu83FZBwohsAELJ4Ja8t5/lCc81WuC+z4WiQFTKGe
         9lrMMVpchiszVr5ou7Ub439p6KB5uaZmpaLCYKkt/tcrfCLFQmVPtfSTWDc55REElL
         GcmuQoaFyKP//6AMNqnbPTq0FqI9T++lOT14HUZl0p8PkPPcwIRdCdukX4pjjJf4rf
         nllEiIqLKQF1U05+HpHUcDmdBv04wlaEb52T7QjSttz8xF40beBLg9Ip+Ysb4U0w1J
         AQsCpYVjoPhh+V7Xo2r7d6uuhLVZKOi/+NtdIOp5XNuaGyho2bA/zG0ZdR3Mhboi4R
         x+ecPrVLBWGnw==
Subject: [PATCH] gitweb bugfix - check for search permission on
 sub-directories while scanning project root to prevent program termination
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <0102015d5203f2ae-c7f1daeb-a6ab-413d-9036-c8da816c4c18-000000@eu-west-1.amazonses.com>
 <xmqqd18yhl5v.fsf@gitster.mtv.corp.google.com>
From:   Hielke Christian Braun <hcb@unco.de>
Message-ID: <8e4adda7-11df-8a26-71a8-2e6429b04c67@unco.de>
Date:   Tue, 18 Jul 2017 10:41:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqd18yhl5v.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-BZ
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

gitweb terminates and shows no project list, if it can not access a
sub-directory in the project root directory. It should show a list of
the projects it can access. Patch corrects this by skipping inaccessible
directories.


Signed-off-by: Hielke Christian Braun <hcb@unco.de>


---
 gitweb/gitweb.perl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 3d4a8ee27c96a..9208f42ed1753 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3071,6 +3071,8 @@ sub git_get_projects_list {
 				return if (m!^[/.]$!);
 				# only directories can be git repositories
 				return unless (-d $_);
+				# need search permission
+				return unless (-x $_);
 				# don't traverse too deep (Find is super slow on os x)
 				# $project_maxdepth excludes depth of $projectroot
 				if (($File::Find::name =~ tr!/!!) - $pfxdepth > $project_maxdepth) {

--
https://github.com/git/git/pull/384






On 2017-07-17 22:18, Junio C Hamano wrote:
> Hielke Christian Braun <hcb@unco.de> writes:
> 
>> ---
>>  gitweb/gitweb.perl | 2 ++
>>  1 file changed, 2 insertions(+)
> 
> Thanks for trying to help and welcome to Git development community.
> But
> 
>  (1) Please double-check the title of your change.  Imagine that the
>      title appears in a list of 600 other commits that goes in a
>      single release in "git shortlog --no-merges" output.  Does it
>      tell readers of the list what the change is about?  We cannot
>      even guess that it is about the project list that appears in
>      gitweb output.
> 
>  (2) Please explain what problem this is trying to solve; that is
>      what the blank space before "---" line we see up above is for.
>      What happens in the current code under what condition, until we
>      do not apply this patch, and why is it a bad thing to happen?
>      Once we apply this patch, in what way the situation gets
>      improved?
> 
>  (3) Please sign-off your patch (see SubmittingPatches in
>      Documentation).
> 
> Thanks.
> 
>>
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index 3d4a8ee27c96a..9208f42ed1753 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -3071,6 +3071,8 @@ sub git_get_projects_list {
>>  				return if (m!^[/.]$!);
>>  				# only directories can be git repositories
>>  				return unless (-d $_);
>> +				# need search permission
>> +				return unless (-x $_);
>>  				# don't traverse too deep (Find is super slow on os x)
>>  				# $project_maxdepth excludes depth of $projectroot
>>  				if (($File::Find::name =~ tr!/!!) - $pfxdepth > $project_maxdepth) {
>>
>> --
>> https://github.com/git/git/pull/384

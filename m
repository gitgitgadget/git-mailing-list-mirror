From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH] clone: do not segfault when specifying a nonexistent
 branch
Date: Sun, 06 Oct 2013 11:27:20 +0200
Message-ID: <52512CF8.2070205@googlemail.com>
References: <524EC896.3050703@opensoftware.pl> <1380896459-6451-1-git-send-email-stefanbeller@googlemail.com> <CACsJy8BX_fWdsCGa4jnh4CbkSMxp7btOFjwzB9K0eRtjUR_F-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	robert.mitwicki@opensoftware.pl,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 06 11:27:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VSkco-00013v-OG
	for gcvg-git-2@plane.gmane.org; Sun, 06 Oct 2013 11:27:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739Ab3JFJ1Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Oct 2013 05:27:25 -0400
Received: from mail-ea0-f175.google.com ([209.85.215.175]:39838 "EHLO
	mail-ea0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586Ab3JFJ1Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Oct 2013 05:27:24 -0400
Received: by mail-ea0-f175.google.com with SMTP id m14so2567030eaj.6
        for <git@vger.kernel.org>; Sun, 06 Oct 2013 02:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=KHGNwCdj081OoOacy+QN880wv8DsoWgIq3UNafeUugE=;
        b=aj8vn/FDV3IGGRoZ9N+sY0GpLauvGofK+Ai4nRaeRg8OCKwPg5UhZ6dHAAS9mUaoAg
         fQsgVUibMPUESgKg9uglZmJEF52zbZGsvLFMPs/vTM7EnO6UQsQYeBlDm0ZFuSypxMTe
         GZeCJ3MWkD85vqnHEWQAbwb5pyeMujwdtdx/YipK75s5ruMrqROIVA85Ihll6wrD4Btz
         gYWOcr6W1NEZ9lJ+HjAE8kjs2eBv5Ks23UVqxU2O5dZEF32ZFUyXI2oAKBr2iQ9utl/Q
         vxDfGGhQxrCoqOGd/cIicZ7dP45s57FPZIdQoqg/dUU11XXd7szeKHpa/FUApTWgH2XE
         jTHw==
X-Received: by 10.15.48.67 with SMTP id g43mr38573580eew.17.1381051642424;
        Sun, 06 Oct 2013 02:27:22 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id x47sm49250547eea.16.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 06 Oct 2013 02:27:21 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <CACsJy8BX_fWdsCGa4jnh4CbkSMxp7btOFjwzB9K0eRtjUR_F-Q@mail.gmail.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235736>

On 10/05/2013 01:55 AM, Duy Nguyen wrote:
> On Fri, Oct 4, 2013 at 9:20 PM, Stefan Beller
> <stefanbeller@googlemail.com> wrote:
>> I think we should emit a warning additionally?
>>
>> Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
> 
> I think it's nice to credit Robert for reporting the fault in the
> commit message (something like "reported-by:" or "noticed-by:"...)

I'll do so in a resend.

> 
>> ---
>>  builtin/clone.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/builtin/clone.c b/builtin/clone.c
>> index 0aff974..b764ad0 100644
>> --- a/builtin/clone.c
>> +++ b/builtin/clone.c
>> @@ -688,7 +688,7 @@ static void write_refspec_config(const char* src_ref_prefix,
>>
>>         if (option_mirror || !option_bare) {
>>                 if (option_single_branch && !option_mirror) {
>> -                       if (option_branch) {
>> +                       if (option_branch && our_head_points_at) {
>>                                 if (strstr(our_head_points_at->name, "refs/tags/"))
>>                                         strbuf_addf(&value, "+%s:%s", our_head_points_at->name,
>>                                                 our_head_points_at->name);
> 
> This prevents the segfault, but what about remote.*.fetch? Should we
> setup standard refspec for fetch or..?
> 

Looking at the code a few lines below, this comment comes up:

	/*
	 * otherwise, the next "git fetch" will
	 * simply fetch from HEAD without updating
	 * any remote-tracking branch, which is what
	 * we want.
	 */

This behavior was good for the case (!option_branch && !remote_head_points_at)
Now we extend that behavior doing nothing to
	 ((!option_branch || !our_head_points_at) &&  !remote_head_points_at)

I am not sure how to handle that case best. The user has given a non existing branch,
so it doesn't make sense to track that branch, but only have that 
registered as a remote*.fetch?

Reading the documentation enhancements of 31b808a 
(2012-09-20, clone --single: limit the fetch refspec to fetched branch), doesn't 
talk about this corner case. So maybe the remote.*.fetch shall be set, but no branch
should be checked out, when running 
git clone --depth 1 -b test https://github.com/mitfik/coredump.git /tmp/coredump.git

Does that make sense?

Stefan

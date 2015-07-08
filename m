From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] log: add log.follow config option
Date: Tue, 07 Jul 2015 21:12:51 -0700
Message-ID: <xmqqa8v71e4c.fsf@gitster.dls.corp.google.com>
References: <1436294440-20273-1-git-send-email-dturner@twopensource.com>
	<xmqqsi8z1urz.fsf@gitster.dls.corp.google.com>
	<1436318939.5521.32.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 06:13:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCgje-0000w8-Cl
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 06:13:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbbGHEM5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2015 00:12:57 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:34914 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782AbbGHEMz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 00:12:55 -0400
Received: by igcqs7 with SMTP id qs7so47774252igc.0
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 21:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=1DcNtYFB1QSxQy5M1ks3Dskld/MAYsQCFR8Qr8yP0js=;
        b=Y690PplxcRKs8JOH3CGGIAJ45gk2a5V2gLcaq3vny2OFytWQrsBgFxLpRiTk6KfypB
         aEjA4ULN1qqtuECsugp7G1WkMLsKF1PUo1mKG+uaFRNbW2bepQ34VF3EMF9mlnZ3iLdl
         cCuWgch9Uzd0Xc+PuXuNf2GJNEuVjgJ6mOPQdOXIWbXyClCXQM9p1p4AY7BqcJZwpigd
         7EU9OFSqjB9rhkCye0L5y9fhSUt91yFDFSyIBtBfLiVTWZV2jZtW6v7/CvTJTwbmzCcS
         Ozh9fTJTS66CHxNRCXZr+qD4zUZJZNZAjKFDS0PASm8/WNhKzq7G1ONus3qP7dzadXsw
         nT4g==
X-Received: by 10.50.66.174 with SMTP id g14mr84837872igt.7.1436328775116;
        Tue, 07 Jul 2015 21:12:55 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:7d74:6f43:1e30:fb1d])
        by smtp.gmail.com with ESMTPSA id rr5sm1084579igb.7.2015.07.07.21.12.52
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 07 Jul 2015 21:12:53 -0700 (PDT)
In-Reply-To: <1436318939.5521.32.camel@twopensource.com> (David Turner's
	message of "Tue, 07 Jul 2015 21:28:59 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273634>

David Turner <dturner@twopensource.com> writes:

>> IOW, I'd like to know why we need more than something like this
>> change to this file, instead of the above?  We didn't muck with
>> revs->diff in the original when FOLLOW_RENAMES was set, but now it
>> does, for example.
>
> We did, but we did it earlier.  But I can just rearrange the code.

Ah, I see.  You don't have to move the existing code for that then.
Just insert the "if prune has one element and DEFAULT_ is set" thing
before the first use of FOLLOW_RENAMES (i.e. "pick, filter and follow
needs diff" piece) and you are done, I think.

Thanks.

>
>> diff --git a/revision.c b/revision.c
>> index 3ff8723..f7bd229 100644
>> --- a/revision.c
>> +++ b/revision.c
>> @@ -2270,6 +2270,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>>  			got_rev_arg = 1;
>>  	}
>>  
>> +	if (DIFF_OPT_TST(&revs->diffopt, DEFAULT_FOLLOW_RENAMES) &&
>> +	    revs->diffopt.pathspec.nr == 1)
>> +		DIFF_OPT_SET(&revs->diffopt, FOLLOW_RENAMES);
>> +
>>  	if (prune_data.nr) {
>>  		/*
>>  		 * If we need to introduce the magic "a lone ':' means no
>
> revs->diffopt.pathspec isn't set up yet then. But prune_data is, so I
> can use that. 
>
> Will send a v3.

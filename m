From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 7/8] revert: Implement parsing --continue, --abort and
 --skip
Date: Fri, 13 May 2011 04:40:39 -0500
Message-ID: <20110513094038.GA30396@elie>
References: <1305100822-20470-1-git-send-email-artagnon@gmail.com>
 <1305100822-20470-8-git-send-email-artagnon@gmail.com>
 <20110511125900.GH2676@elie>
 <20110513091619.GC14272@ramkum.desktop.amazon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 13 11:42:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKore-0005hu-5r
	for gcvg-git-2@lo.gmane.org; Fri, 13 May 2011 11:40:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758768Ab1EMJks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2011 05:40:48 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56013 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758551Ab1EMJkr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2011 05:40:47 -0400
Received: by iwn34 with SMTP id 34so2124924iwn.19
        for <git@vger.kernel.org>; Fri, 13 May 2011 02:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=fNUidyIJqkR2hnDTjb1vjPet2DASHk2CMfgW9ANQZHs=;
        b=q6xkrS6B6vgYRW2/CehDfYNOGUgyRfLfIMzA8Rb6C9k19zzGTGjEU/ai+9Om7q6EYm
         U9hOh1gD65kE7Dcp295QNdbMGkj2xkVFDlB/w1+3txkhz8LPFap16QmavL0LDKnHyT43
         un92hULx4jQYN7bRn50JHZW6va7YZugRxUtHU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=rRB3SbbCcCb095VzfdQICmYl0TOIy0UxYYo07aD3T7UqOxGullr8AMPcrIcxyEBRv3
         IzXOsjcRcxxIkg86QPvm/rLiC5lsqI34IpQfNCfw64+n8ffXIKQsmeJ8Wbec+L/XOfxa
         wAeO0NcY0hXIamO73noITvHCkbUXFHivey65M=
Received: by 10.43.65.83 with SMTP id xl19mr1232250icb.55.1305279646770;
        Fri, 13 May 2011 02:40:46 -0700 (PDT)
Received: from elie ([69.209.56.134])
        by mx.google.com with ESMTPS id u17sm897906ibm.62.2011.05.13.02.40.44
        (version=SSLv3 cipher=OTHER);
        Fri, 13 May 2011 02:40:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110513091619.GC14272@ramkum.desktop.amazon.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173517>

Ramkumar Ramachandra wrote:

> What about --continue and --skip? They're no-ops too here, and
> there'll soon be patches adding the functionality.  Do you think it's
> alright to parse and exit immediately?

You're right: the same considerations apply to them.  If adding these
options before the functionality is ready makes the series easier to
read, then I'd at least prefer to see

	if (opts->abort_oper)
		die("--abort is not implemented yet");

to prevent scripts and humans from being confused.  And on the other
hand I suspect adding each option at the same time as adding the
corresponding functionality would be clearer anyway.

> Jonathan Nieder writes:
>> Ramkumar Ramachandra wrote:

>>> --- a/builtin/revert.c
>>> +++ b/builtin/revert.c
>>> @@ -145,7 +153,47 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
[...]
>>> +			die_opt_incompatible(me, this_oper,
>>> +					"--skip", opts->skip_oper,
>>> +					NULL);
>>> +			die_opt_incompatible(me, this_oper,
>>> +					"--continue", opts->continue_oper,
>>> +					NULL);
>>
>> What happened to
>> 
>> 			...(me, "--abort",
>> 				"--skip", opts->skip,
>> 				"--continue", opts->continue);
>
> Huh? Why? I've caught every possible combination of two of those
> options -- that already covers all three.

Sorry, that was unclear of me.  What I meant to say is that one
function call instead of two would suffice, like the API is
supposed to make possible.

In other words, nothing actually wrong here, just a possibility
of simplification.

>> ?  I also wonder if there should not be a function to deal with
>> mutually incompatible options:
>>
>> 	va_start(ap, commandname);
>> 	while ((arg1 = va_arg(ap, const char *))) {
>> 		int set = va_arg(ap, int);
>> 		if (set)
>> 			break;
>> 	}
>> 	while ((arg2 = va_arg(ap, const char *))) {
>> 		int set = va_arg(ap, int);
>> 		if (set)
>> 			die(arg1 and arg2 are incompatible);
>> 	}
>> 	va_end(ap);
>
> I personally think having a function is cleaner

Sorry, I was unclear again.  What I meant is that there could be
two functions:

 - one to check a single option against various options it is
   incompatible with, which you've already written
 - another to check a family of mutually incompatible options

The above was a sample implementation for the second function, but it
has a bug: the second "while" loop should have been preceded by
"if (!arg1) return;".

>> Seems reasonable.  A part of me would want to accept such options and
>> only error out if the saved state indicates that they are different
[...]
> Over-engineering definitely!

Yep, sorry.  Was just thinking out loud.

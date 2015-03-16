From: Koosha Khajehmoogahi <koosha@posteo.de>
Subject: Re: [PATCH] [RFC] Add a new config. option for skipping merges in
 git-log
Date: Mon, 16 Mar 2015 20:33:47 +0100
Message-ID: <5507301B.2060401@posteo.de>
References: <5506E751.8010506@posteo.de> <xmqqpp88rfq0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 20:34:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXamj-0007Lx-8H
	for gcvg-git-2@plane.gmane.org; Mon, 16 Mar 2015 20:34:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754759AbbCPTek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2015 15:34:40 -0400
Received: from mx02.posteo.de ([89.146.194.165]:43699 "EHLO mx02.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753253AbbCPTej (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2015 15:34:39 -0400
Received: from dovecot03.posteo.de (unknown [185.67.36.28])
	by mx02.posteo.de (Postfix) with ESMTPS id 3E1611EB2FA9;
	Mon, 16 Mar 2015 20:34:38 +0100 (CET)
Received: from mail.posteo.de (localhost [127.0.0.1])
	by dovecot03.posteo.de (Postfix) with ESMTPSA id 3l5SWK3Sr7z5vNN;
	Mon, 16 Mar 2015 20:34:37 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.5.0
In-Reply-To: <xmqqpp88rfq0.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265591>


On 03/16/2015 06:53 PM, Junio C Hamano wrote:
> Koosha Khajehmoogahi <koosha@posteo.de> writes:
> 
>> This patch adds a 'showmerges' config. option for git-log.
>> This option determines whether the log should contain merge
>> commits or not. In essence, if this option is set to false,
>> git-log will be run as 'git-log --no-merges'.
>>
>> To force git-log to show merges even if 'log.showmerges' is
>> set, we use --include-merges command line option.
> 
> Yuck.
> 
> I agree that there is currently no way to revert the setting that is
> touched by --merges and --no-merges back to the default, but I think
> the right way to fix that is by streamlining these two options,
> instead of piling yet another kludge --include-merges on top.
> 
> When we think about possible "canned" selection modes:
> 
>  (do we show merge commits?) * (do we show non-merge commits?)
> 
> we have four combinations.  Answering the above two questions with
> No/No would end up showing nothing, which is meaningless, so that
> leaves us three choices (of course, the user could choose to futz
> directly with min/max-parents to select only Octopus merges, but
> that is a more advanced/exotic usage).
> 
> Wouldn't it make more sense to spell which selection mode the user
> wants with:
> 
> 	git log --merges=<selection-mode>
> 
> by naming the three meaningful selection modes with short and sweet
> names?  Perhaps
> 
>     default? show? both? -- show both merge commits and non-merge commits
>     only -- show only merge commits
>     skip -- show only non-merge commits
> 
> or something?
> 
> Now, as I always say, I am not great at naming things, so do not
> take these names as the final suggestion, but I think you got the
> idea.
> 
> Of course, then the traditional "--merges" option can be kept as a
> short-hand for "--merges=only", and "--no-merges" would become a
> short-hand for "--merges=skip".
> 
> Once we have done that streamlining of the command line options, it
> will naturally follow that "log.merges = show | only | skip" would
> be a useful configuration option.
> 
> I doubt we need an extra bit in rev_info to implement such a syntax
> sugar.
> 
>> diff --git a/revision.h b/revision.h
>> index 0ea8b4e..f496472 100644
>> --- a/revision.h
>> +++ b/revision.h
>> @@ -145,6 +145,7 @@ struct rev_info {
>>  	unsigned int	track_linear:1,
>>  			track_first_time:1,
>>  			linear:1;
>> +	unsigned int force_show_merges:1;
>>  
>>  	enum date_mode date_mode;

Thanks for your suggestions. The "extra bit" in rev_info is used when
we need to compare user's command-line input to his configuration. Since
command-line input is processed in revision.c but config. options are read
in builtin/log.c, we need a way to pass the value to builtin/log.c. How
would you do that without this extra bit?

-- 
Koosha

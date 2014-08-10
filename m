From: Stefan Beller <stefanbeller@gmail.com>
Subject: Re: Unify subcommand structure; introduce double dashes for all subcommands?
Date: Sun, 10 Aug 2014 17:26:30 +0200
Message-ID: <53E78F26.3000701@gmail.com>
References: <53CFBA1A.8040600@gmail.com> <xmqqiomodkt9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 10 17:26:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGV13-0003rg-PC
	for gcvg-git-2@plane.gmane.org; Sun, 10 Aug 2014 17:26:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbaHJP0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2014 11:26:32 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:46304 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055AbaHJP0c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2014 11:26:32 -0400
Received: by mail-wg0-f44.google.com with SMTP id m15so7413275wgh.3
        for <git@vger.kernel.org>; Sun, 10 Aug 2014 08:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=X4GcpzhpLdYmLhZvuCD9+Q0RQUCOqGHNWkvDzEIrZfM=;
        b=GPZrqBkKIjWAI4Yzf+1CuO6OtRmV3QKprddTLLhlu4XQ1a+wWozysisNFIGyblGgjO
         zimaPrBPBgtkYk4r61r5fkmAm1EvgRwX00qpqC3kzdP41WQjEeMBLqF8IwJgvG8LBlde
         puIN6bd5zC4+pT6FO+rLNCUj/OIngBmnj97Dwnq0trlnF7ZQAhXqjexin/LR4Y170FC+
         LTkY6L1T2zlyhdDRrSxhc3Eht3fj6MfkCI/Bl/TWkaPFIOGxZ30eOOx0PGm5Nk9Cz0+5
         by/a8pvEjzRu+QT2luVfysRN2a5QButYMTLg5oH9g3L7T3mRqVhecqj2W93vga2uBo5E
         QLbw==
X-Received: by 10.194.187.4 with SMTP id fo4mr46834172wjc.35.1407684390533;
        Sun, 10 Aug 2014 08:26:30 -0700 (PDT)
Received: from [192.168.1.7] (ip-109-91-30-58.hsi12.unitymediagroup.de. [109.91.30.58])
        by mx.google.com with ESMTPSA id au7sm32750560wjc.41.2014.08.10.08.26.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Aug 2014 08:26:29 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <xmqqiomodkt9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255097>

On 23.07.2014 19:52, Junio C Hamano wrote:
> Stefan Beller <stefanbeller@gmail.com> writes:
> 
>> A git command is generally setup as:
>> 	git <command> [<subcommand>] [<options>] ...
>>
>> The subcommands vary wildly by the nature of the command. However all
>> subcommands
>> could at least follow one style. The commands bundle, notes, stash and
>> submodule
>> have subcommands without two leading dashes (i.e. git stash list) as
>> opposed to all
>> other commands (i.e. git tag --list).
> 
> Sounds familiar.  E.g. here is a similar thread about a year ago.
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/231376/focus=231478
> 
> Further discussions to make the plan more concrete is very much
> welcomed.
> 
> Thanks.
> 

So I'd want to add have the subcommands without double dashes ideally.
It's just less typing and more english like, not cryptic with dashes. 
This may come handy for newcomers/beginners using git. It also benefits 
the powerusers of git as you spare the typing of 2 dashes on the subcommand.

I'm currently trying to understand the functions to parse options 
and I wonder if the following is possible:

If there is an option set by OPT_CMDMODE 
(such as git tag --delete / --verify) we want to add an internal option,
(such as PARSE_OPT_NODASH ?), 
that you can deliver this CMD_MODE option without leading 2 dashes. 
The current behavior with leading 2 dashes is still supported, 
but maybe a warning is printed about deprecating the option with 2 dashes.

Having this change in place will switch over revert, replace, tag and merge-base
to having sane subcommands without dashes possible.

Once this change is in, we can rewrite the other commands, 
which as of now don't require the dashes.
Coincidentally these commands heavily rely on option parsing themselves,
such as git-notes having this code in place:

	if (argc < 1 || !strcmp(argv[0], "list"))
		result = list(argc, argv, prefix);
	else if (!strcmp(argv[0], "add"))
		result = add(argc, argv, prefix);
	else if (!strcmp(argv[0], "copy"))
		result = copy(argc, argv, prefix);
	...

Does that make sense?
Stefan

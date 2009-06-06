From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: parse-options: ambiguous LASTARG_DEFAULT and OPTARG
Date: Sat, 06 Jun 2009 12:30:12 +0200
Message-ID: <4A2A4534.80604@lsrfire.ath.cx>
References: <4A28B072.8030006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@madism.org>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 06 12:36:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCtG5-0000Ny-Ha
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 12:36:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752655AbZFFKaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 06:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752572AbZFFKaZ
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 06:30:25 -0400
Received: from india601.server4you.de ([85.25.151.105]:38249 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752297AbZFFKaY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 06:30:24 -0400
Received: from [10.0.1.101] (p57B7E4B1.dip.t-dialin.net [87.183.228.177])
	by india601.server4you.de (Postfix) with ESMTPSA id BBB092F806B;
	Sat,  6 Jun 2009 12:30:24 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <4A28B072.8030006@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120906>

Stephen Boyd schrieb:
> Hi,
> 
> This in builtin-branch.c
> 
>         {
> 		OPTION_CALLBACK, 0, "merged", &merge_filter_ref,
> 		"commit", "print only merged branches",
> 		PARSE_OPT_LASTARG_DEFAULT | PARSE_OPT_NONEG,
> 		opt_parse_merge_filter, (intptr_t) "HEAD",
> 	},
> 
> and the usage message for "git-branch -h" will print out
> 
>     --merged <commit>
> 
> when I'm expecting
> 
>     --merged[=<commit>]
> 
> This is because the PARSE_OPT_OPTARG flag is not used. Is this correct?

> The default value is still set correctly in some cases, but become
> ambiguous in other cases. Take this for example
> 
>     $ git branch --merged --verbose
>     fatal: malformed object name --verbose
> 
> but
> 
>     $ git branch --verbose --merged
> 
> works fine.
> 
> The simple fix is to just add PARSE_OPT_OPTARG to the flags, and fix a
> test or two. But I'm wondering if doing that will become problematic for
> end-users. Essentially you can no longer do git branch --merged master,
> you must do git branch --merged=master.

PARSE_OPT_OPTARG overrides PARSE_OPT_LASTARG_DEFAULT, as Pierre noted in
commit 1cc6985c, which introduced the latter, so the two should not be
used together.

PARSE_OPT_LASTARG_DEFAULT uses the default value if the option is the
last one on the command line and requires an explicit argument if it's
not the last, as you found out above.  That's also what the code says 
and its name implies; the comment in parse-options.h (by yours truly) is 
probably misleading because it doesn't mention this condition.

I don't remember any other program having options with such a behaviour; 
I'm not sure how to stress that --merged needs to be the last option, as 
implied by the help message.

From: Junio C Hamano <junkio@cox.net>
Subject: Re: [BUG] Empty reflogs and "git log -g"
Date: Thu, 08 Feb 2007 15:18:35 -0800
Message-ID: <7vveicw850.fsf@assigned-by-dhcp.cox.net>
References: <8aa486160702071721s401ea38fxa8eb71bb694a6915@mail.gmail.com>
	<Pine.LNX.4.63.0702082021210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<eqfu36$lb3$1@sea.gmane.org>
	<Pine.LNX.4.63.0702082040390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Santi =?utf-8?Q?B=C3=A9jar?= <sbejar@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 09 00:18:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFIXI-0004AA-Mm
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 00:18:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965716AbXBHXSh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 18:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965717AbXBHXSh
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 18:18:37 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:60901 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965716AbXBHXSg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 18:18:36 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070208231836.CFHM21704.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Thu, 8 Feb 2007 18:18:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id MBJb1W00Q1kojtg0000000; Thu, 08 Feb 2007 18:18:36 -0500
In-Reply-To: <Pine.LNX.4.63.0702082040390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 8 Feb 2007 20:46:43 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39119>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 8 Feb 2007, Jakub Narebski wrote:
>
>> StGIT used to produce no reflog messages; I don't know if this has 
>> improved. But you can have old reflog entries with empty messages; git 
>> log -g should deal with them IMHO.
>
> I just tried. An empty string is not enough. The tab before the message 
> has to be lacking, too.
>
> Here's a small patch, if you have to have it.

I think this is necessary for v1.5.0.  I'd appreciate a properly
signed-off log message.

>
> ---
>
>  refs.c |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 7e07fc4..ba5bd2d 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1189,12 +1189,14 @@ int for_each_reflog_ent(const char *ref, each_reflog_ent_fn fn, void *cb_data)
>  		    !message || message[0] != ' ' ||
>  		    (message[1] != '+' && message[1] != '-') ||
>  		    !isdigit(message[2]) || !isdigit(message[3]) ||
> -		    !isdigit(message[4]) || !isdigit(message[5]) ||
> -		    message[6] != '\t')
> +		    !isdigit(message[4]) || !isdigit(message[5]))
>  			continue; /* corrupt? */
>  		email_end[1] = '\0';
>  		tz = strtol(message + 1, NULL, 10);
> -		message += 7;
> +		if (message[6] != '\t')
> +			message += 6;
> +		else
> +			message += 7;
>  		ret = fn(osha1, nsha1, buf+82, timestamp, tz, message, cb_data);
>  		if (ret)
>  			break;

X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] gitweb: Add committags support (take 2)
Date: Mon, 04 Dec 2006 02:53:17 -0800
Message-ID: <7vmz64ortu.fsf@assigned-by-dhcp.cox.net>
References: <200612040001.13640.jnareb@gmail.com>
	<7virgstmg6.fsf@assigned-by-dhcp.cox.net>
	<200612041133.44816.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 4 Dec 2006 10:53:32 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200612041133.44816.jnareb@gmail.com> (Jakub Narebski's message
	of "Mon, 4 Dec 2006 11:33:44 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33186>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrBRw-0001kj-89 for gcvg-git@gmane.org; Mon, 04 Dec
 2006 11:53:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935842AbWLDKxZ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 05:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935868AbWLDKxZ
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 05:53:25 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:42725 "EHLO
 fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP id S935842AbWLDKxY
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 05:53:24 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061204105319.GAML18207.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>; Mon, 4
 Dec 2006 05:53:19 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id uasi1V00M1kojtg0000000; Mon, 04 Dec 2006
 05:52:43 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> I have one gripe about "git-cat-file -t". I'd like it to have 
> -q/--quiet, -s/--silent, --hush (or --dont-spew-errors-on-stdout)
> which would prohibit writing "object not found" errors on stderr
> (and in gitweb case to webserver logs). I know I can use "git-cat-file -e"
> to check if object exists, or modify git_get_type subroutine
>
>   # get type of given object
>   sub git_get_type {
> 	my $hash = shift;
>   	my $git_command = git_cmd_str();
>   
>   	open my $fd, "-|",
>   		"$git_command cat-file -t $hash 2>/dev/null"
>   		or return '';

It is one thing if you tend to randomly throw garbage at this
function and use it to check for object's existence, but I hope
you are already checking the user input (which is what $hash is,
I think, here), and the object is supposed to exist in the
repository you are looking at.  In such a case, I think you and
your server administrator have right to know about that
situation; I do not see why you would want to squelch it.

>> I do not know how this %committags{} is used per project.  With
>> a setting like repo.or.cz, it is likely that one instance of
>> gitweb is serving unrelated projects that have their issue
>> tracker at different locations using different "committags"
>> convention.  Is the idea to eventually allow enabling/disabling
>> elements from the global %committags per repository somehow
>> (perhaps not just enable/disable but even overriding patterns or
>> parameters)?
>
> I have thought about putting %committags and @committags before
> loading config file
>   do $GITWEB_CONFIG if -e $GITWEB_CONFIG;
> which can load config file depending on the project, but perhaps
> it is too complicated solution.

I think you are talking about a gitweb-instance wide
customization, but that's not what I meant.  I meant per-project
configuration where w/git-gui.git and w/git.git are served by
the same instance of gitweb but have pointers to different issue
trackers.

>>> 3. To not split message into many fragments we concatenate strings
>>> if possible.
>> 
>> I do not know why "avoiding splits" is needed, if it raises 
>> issues that you need to ask the list about in a message like
>> this...
>
> "Avoiding splits" is needed first for performance, and second to
> avoid situation where pattern would match on the boundary between
> two strings in a list of tokens to process.

I wouldn't know if constantly splitting and then concatenating
is faster than just concatenatting once before output without
benchmarking, so I'd refrain from talking about performance.
Two string case may be a valid concern, though.

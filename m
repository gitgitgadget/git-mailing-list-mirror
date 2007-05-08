From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC] diff: Make numstat machine friendly also for renames
Date: Mon, 07 May 2007 18:58:11 -0700
Message-ID: <7vhcqo5b64.fsf@assigned-by-dhcp.cox.net>
References: <11785850223782-git-send-email-jnareb@gmail.com>
	<7vzm4g5ddu.fsf@assigned-by-dhcp.cox.net>
	<200705080345.26817.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 08 03:58:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlEy1-00063g-MY
	for gcvg-git@gmane.org; Tue, 08 May 2007 03:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753640AbXEHB6O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 21:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966590AbXEHB6O
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 21:58:14 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:59689 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753640AbXEHB6O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 21:58:14 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070508015812.YDXO2758.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Mon, 7 May 2007 21:58:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id wRyB1W00H1kojtg0000000; Mon, 07 May 2007 21:58:12 -0400
In-Reply-To: <200705080345.26817.jnareb@gmail.com> (Jakub Narebski's message
	of "Tue, 8 May 2007 03:45:25 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46514>

Jakub Narebski <jnareb@gmail.com> writes:

>>> The numstat format for rename is now
>>>
>>>   added deleted TAB path for "src" TAB path for "dst" LF
>>>
>>> or if -z option is used
>>>
>>>   added deleted TAB path for "src" NUL NUL path for "dst" NUL
>> 
>> Why two NULs?
>
> That was the only way I could think of to separate pre-image name
> from posi-image name for renames. Note that file name might look like
> (part of) diffstat line, and there is no 'status' field in the
> numstat to mark rename (as there is in "git diff-tree --raw" output).

The --stat format is for human consumption, and --numstat (be it
with -z or without) is for machines, so I am not opposed to a
format change that gives information that is already computed
but currently is hard to parse.  If the format change breaks
existing scripts, we might want to do --numstat-extended,
though...

For example, I do not see a reason not to add "R98" in there.
I.e.

	added deleted status TAB "src" (TAB "dst"){0,1} LF
	added deleted status NUL "src" (NUL "dst"){0,1} NUL

where the dst path is present only when status says it is a
rename/copy, just like the --raw format.

> Did you mean --stat here?

No, I did mean --summary.  But that was foolish of me.  I forgot
that it had the same { namepart => namepart } issue.

>>> @@ -949,11 +955,19 @@ static void show_numstat(struct diffstat_t* data,
>>>  			printf("-\t-\t");
>>>  		else
>>>  			printf("%d\t%d\t", file->added, file->deleted);
>>> -		if (options->line_termination && !file->is_renamed &&
>>> +		if (options->line_termination &&
>>>  		    quote_c_style(file->name, NULL, NULL, 0))
>>>  			quote_c_style(file->name, NULL, stdout, 0);
>>>  		else
>>>  			fputs(file->name, stdout);
>>> +		if (file->is_renamed) {
>>> +			printf("%s", options->line_termination ? "\t" : "\0\0");
>
> It passes "make test".

But you already grepped to make sure this codepath is never
exercised ;-).

What I was hoping you to notice was that printf("%s", "\0\0")
thing.  %s would not even notice that the const char[] literal
is 2 bytes long.

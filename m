From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Use File::Find::find in git_get_projects_list
Date: Thu, 14 Sep 2006 11:32:01 -0700
Message-ID: <7vbqpi47vi.fsf@assigned-by-dhcp.cox.net>
References: <200609140839.56181.jnareb@gmail.com>
	<7v8xkm6gr6.fsf@assigned-by-dhcp.cox.net>
	<200609140959.04061.jnareb@gmail.com>
	<7v1wqe6buv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 14 20:32:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNw0O-0004Fu-1m
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 20:32:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbWINScF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 14:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751011AbWINScE
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 14:32:04 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:61431 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750995AbWINScC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Sep 2006 14:32:02 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060914183201.PQFM18985.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>;
          Thu, 14 Sep 2006 14:32:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id NJXq1V00Q1kojtg0000000
	Thu, 14 Sep 2006 14:31:51 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <7v1wqe6buv.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 14 Sep 2006 02:23:04 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27024>

Junio C Hamano <junkio@cox.net> writes:

> Jakub Narebski <jnareb@gmail.com> writes:
>
>> Not true. Link to directory is both -d $_ and -l $_, so
>>
>> 	return unless (-d $_ || (-l $_ && -d readlink($_)));
>>
>> is not needed.
>
> I think you mis-read what I said.  I first wondered why you did
> not say "return unless -d _" and wrote (seemingly more
> inefficient) "return unless -d $_".  The comment is to clarify
> why '$' is needed.
>
> In other words, after this setup:
>
>         $ rm -fr d dl
>         $ mkdir d
>         $ ln -s d dl
>
> you do not see an output from this:
>
>         $ perl -e 'lstat "dl"; print "is-dir\n" if -d _;'
>
> but you do from this:
>
>         $ perl -e 'lstat "dl"; print "is-dir\n" if -d "dl";'

Side note:

While

	return unless -d $_

there is definitely more correct than "return unless -d _" which
is not, it is not the most efficient.  Because you use fast_xxx,
you know the last stat was lstat so "-d _" would be true if the
thing you are looking at is a real directory and will be a
zero-cost operation.  The only case you want to be careful is a
symlink pointing at a directory, so

	return unless ((-d _) || (-l _ && -d $_))

would be more efficient.

I have a strange suspicion that Merlyn will soon join us with
more expertise if we keep talking about Perl ;-)

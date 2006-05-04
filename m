From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-feed-mail-list.sh
Date: Wed, 03 May 2006 22:16:02 -0700
Message-ID: <7v8xpi9xpp.fsf@assigned-by-dhcp.cox.net>
References: <1146678513.20773.45.camel@pmac.infradead.org>
	<7vmzdy9zl2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 04 07:16:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbWCC-000388-Iw
	for gcvg-git@gmane.org; Thu, 04 May 2006 07:16:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbWEDFQF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 May 2006 01:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbWEDFQF
	(ORCPT <rfc822;git-outgoing>); Thu, 4 May 2006 01:16:05 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:1677 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751092AbWEDFQE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 May 2006 01:16:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060504051603.VMDL25666.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 4 May 2006 01:16:03 -0400
In-Reply-To: <7vmzdy9zl2.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 03 May 2006 21:35:37 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19551>

Junio C Hamano <junkio@cox.net> writes:

> David Woodhouse <dwmw2@infradead.org> writes:
>
>> # $FROM specifies the From: header used in the mails. It'll default
>> # to GIT_COMMITTER_EMAIL if that exists, or to `whoami`@`hostname`
>
> I am not sure if this part is tested..
>
>> # Unless configured otherwise, just cat it instead of mailing.
>> if [ -z "$FROM" ]; then
>>     if [ -z "$GIT_COMMITTER_EMAIL" ]; then 
>> 	FROM="$GIT_COMMITTER_EMAIL"
>>     else
>> 	FROM=`whoami`@`hostname`
>>     fi
>> fi
>
> Maybe you meant 'if test -n "$GIT_COMMITTER_EMAIL"' here?
>
>> # takes an object and generates the object's parent(s)
>> createmail () {
>>     local commit
>
> If you were to do bashism local, don't you want to also localize
> other variables like key, SUBHEX, NEWSUB,...?
>
> It may make sense to enhance format-patch to do the Q encoding,
> so that you do not have to do this part by hand...
>
>> 	git-diff -B $parent $commit > $TMPCM
>> 	diffstat -p1 $TMPCM 2>/dev/null
>
> With GIT 1.3.0 and later:
>
> 	git diff --patch-with-stat $parent..$commit
>
> would be simpler here.

Or at least lose "diffstat -p1" and replace it with

	git-apply --stat --status

which would be more pleasant.

>> if [ -z $2 ]; then
>>     lastmail=`cat $MAILTAG`
>> else
>>     lastmail=$(git-rev-parse $2)
>> fi
>
> lastmail=`git rev-parse --default "$MAILTAG" ${2+"$2"}`

As I wrote it this is broken, sorry.

This assumes you stop doing "MAILTAG=.git/refs/tags/MailDone"
by hand and lose "do we have GIT_DIR" logic as well.
Instead define MAILTAG=tags/MailDone or maybe refs/tags/MailDone
and let "git rev-parse --default refs/tags/MailDone" figure out
what to do when GIT_DIR is set or unset.

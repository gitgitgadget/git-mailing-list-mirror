From: Junio C Hamano <junkio@cox.net>
Subject: Re: git and time
Date: Thu, 28 Sep 2006 09:05:15 -0700
Message-ID: <7vodt0vux0.fsf@assigned-by-dhcp.cox.net>
References: <20060928022917.29678.qmail@web51011.mail.yahoo.com>
	<Pine.LNX.4.64.0609272232040.9349@xanadu.home>
	<7vfyec63jx.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0609281029300.9349@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 18:09:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSyQn-0000bc-JT
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 18:08:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964933AbWI1QFm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 12:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030198AbWI1QFk
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 12:05:40 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:44469 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S964933AbWI1QFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 12:05:16 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060928160516.GWCA2704.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Thu, 28 Sep 2006 12:05:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Ts5J1V00A1kojtg0000000
	Thu, 28 Sep 2006 12:05:18 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0609281029300.9349@xanadu.home> (Nicolas Pitre's
	message of "Thu, 28 Sep 2006 10:34:56 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28012>

Nicolas Pitre <nico@cam.org> writes:

>> Nicolas Pitre <nico@cam.org> writes:
>> 
>> > SYNOPSIS
>> >
>> > 	git-local-arrival <committish>
>> >
>> > DESCRIPTION
>> >
>> > 	The command displays the time when given commit appeared in the 
>> > 	local repository.
>> 
>> This should be certainly doable, but local-arrival may not be
>> interesting if the repository has more than one branches.  Maybe
>> 
>> 	git-local-arrival <committish> [<branch>]
>> 
>> which defaults to the current branch?
>
> Indeed.  I didn't mention it initially because it is really easy to do 
> once you have it working for the current branch.  The technical 
> challenge is about making it efficient to find out which reflog entry 
> with a path to given commit is the oldest.

Perhaps bisect it like this.  This assumes you never rewind the
branch in question and the tip already contains the commit in
question.

-- >8 --

#!/bin/sh

. git-sh-setup
commit=`git rev-parse "$1"` &&
branch="${2-`git symbolic-ref HEAD`} || exit

contains () {
	contains=`git merge-base --all $1 $commit`
	case "$LF$contains$LF" in
	*"$LF$contains$LF"*)
		: ;;
	*)
		false ;;
	esac
}

LF='
'
script='{
	s/	.*//
	p
}' ;# strip things after TAB if a TAB exists
reflog="$GIT_DIR/logs/refs/heads/$branch";
lo=1;
hi=`wc -l <$reflog`
ld=$hi
while expr "$lo" \< "$hi" >/dev/null
do
	mi=`expr \( $hi \+ $lo \) / 2`
	line=`sed -ne "$mi$script" "$reflog"`
	to=`expr "$line" : '[^ ]* \([^ ]*\) '`
	if contains $to
	then
		ld=$hi
		hi=$mi
	else
		lo=`expr "$mi" + 1`
	fi
done

case "$ld" in	
'')
	echo >&2 Oops
	exit 1;;
?*)	
	line=`sed -ne "$ld$script" "$reflog"`
	time=`expr "$line" : '.*> \([0-9]*\) '`
	zone=`expr "$line" : '.*> [0-9]* \(.[0-9][0-9][0-9][0-9]\)$'`
	echo "$time $zone"
esac

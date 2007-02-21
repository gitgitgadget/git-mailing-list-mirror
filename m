From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-remote: support remotes with a dot in the name
Date: Tue, 20 Feb 2007 22:18:55 -0800
Message-ID: <7vfy90t4mo.fsf@assigned-by-dhcp.cox.net>
References: <20070221050336.26431.46485.stgit@dv.roinet.com>
	<7vwt2ct79x.fsf@assigned-by-dhcp.cox.net>
	<20070221004631.q4npyww808k88s0o@webmail.spamcop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
X-From: git-owner@vger.kernel.org Wed Feb 21 07:19:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJkon-00053W-IC
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 07:19:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbXBUGS5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 01:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbXBUGS5
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 01:18:57 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:34145 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136AbXBUGS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 01:18:56 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070221061857.UHEN21704.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Wed, 21 Feb 2007 01:18:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id S6Jv1W00D1kojtg0000000; Wed, 21 Feb 2007 01:18:56 -0500
In-Reply-To: <20070221004631.q4npyww808k88s0o@webmail.spamcop.net> (Pavel
	Roskin's message of "Wed, 21 Feb 2007 00:46:31 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40283>

Pavel Roskin <proski@gnu.org> writes:

> On the other hand, I've been tracking "wireless-2.6" for months without even
> realizing that the name could be a problem.

Ah, sorry.  You are absolutely right.  Using wireless-2.6 to
name wireless-2.6 repository (or linux-2.6 to name linux-2.6
repository) makes perfect sense.

>> I do not strongly oppose to allowing it now, but I suspect this
>> is probably less impact:
>>
>> 	if (/^remote\.(\S+?)\.([^.\s]+)\s+(.*)$/) {
>>         	...
>> 	}
>>
>> With this, we disallow whitespaces in remote names, but we leave
>> the door open for supporting variables other than fetch and url
>> by accepting the third token that matches any sequence of
>> non-dot, non-whitespace letters.
>
> It would be great as long as we don't use names with more than
> one dot after the remote name
> (e.g. remote.wireless-2.6.url.push),...

Do you mean:

	[remote "wireless-2.6.url"]
		url = wire.less:/repo/sito/ry.git
        	fetch = +refs/heads/*:refs/remotes/wireless-2.6.url/*

If so I think my replacement would match it.  It will be
returned from "git config --get-regexp '^remote\.'"  like this:

remote.wireless-2.6.url.url wire.less:/repo/sito/ry.git
remote.wireless-2.6.url.fetch +refs/heads/*:refs/remotes/wireless-2.6.url/*

and in:

 	/^remote\.(\S+?)\.([^.\s]+)\s+(.*)$/

$1 would match shortest non-whitespace sequence after "remote.",
$2 would match longuest non-dot, non-whitespace sequence before
a sequence of whitespaces, and
$3 would match everything after that sequence of whitespaces.

So, $1 = "wireless-2.6.url", $2 = "url", $3 = "wire.less:/repo/sito/ry.git"
or $1 = "wireless-2.6.url", $2 = "fetch", $3 = "+refs/heads/...."

But my Perl is rusty, so please double check it.

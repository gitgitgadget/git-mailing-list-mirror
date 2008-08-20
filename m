From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] test-lib.sh: work around ksh's trap shortcomings
Date: Tue, 19 Aug 2008 19:19:13 -0500
Message-ID: <nEEUmh6BVMDYtwf1vENCYuaLiFUWKW_dbgPP__ECl3s@cipher.nrlssc.navy.mil>
References: <giNXZFTxzY3B65dQob7CwvwwfSKlZpw_60oz81RxU5UN3PsTT_3dMQ@cipher.nrlssc.navy.mil> <gPlIc7E6mNDrXE6mwaHXFoin7rDpLmjvuzlhJfCp-YmuyVK3pEzqNA@cipher.nrlssc.navy.mil> <7vbpzplw9o.fsf@gitster.siamese.dyndns.org> <cqiOMMbzSSjqZoLDEa5uscl2d0D71PrGu2TpSOULLuV5nTVnEEWCzQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 02:20:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVbRA-0001c9-38
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 02:20:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753672AbYHTATY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 20:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753699AbYHTATX
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 20:19:23 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:47248 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753216AbYHTATX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 20:19:23 -0400
Received: by mail.nrlssc.navy.mil id m7K0JEtm017320; Tue, 19 Aug 2008 19:19:14 -0500
In-Reply-To: <cqiOMMbzSSjqZoLDEa5uscl2d0D71PrGu2TpSOULLuV5nTVnEEWCzQ@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 20 Aug 2008 00:19:13.0539 (UTC) FILETIME=[5FDCD530:01C9025A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92944>

Brandon Casey wrote:
> Junio C Hamano wrote:
>> Your alias test_done that calls function test_done look ugly and confusing
>> beyond words.  Perhaps test_done() can instead set a global variable and
>> die() can notice it instead, like this?  I haven't bothered to change the
>> other "trap - exit" but I think you got the idea...
> 
> Yes that works and is much clearer. Tested on solaris and irix.

I spoke too soon. Failing tests do not terminate the testing.

ksh does not place the exit status of the shell in $? or provide it as an argument
to the trap function. Possibly the status of the 'exit' command is provided instead?

$ cat test.sh
#!/bin/sh

die () {
    status=$?
    echo >&2 "die status: $status"
    exit $status
}

trap 'die' 0

echo "I am dying"
exit 1

###### END TEST SCRIPT ######

linux $ /bin/sh test.sh
I am dying
die status: 1
linux $ echo $?
1

linux $ /usr/bin/ksh test.sh
I am dying
die status: 1
linux $ echo $?
1

IRIX $ /bin/ksh test.sh
I am dying
die status: 0
IRIX $ echo $?
0

SunOS $ /usr/xpg4/bin/sh test.sh
I am dying
die status: 0
SunOS $ echo $?
0

Ah, no, it looks like the status of the command executed immediately before
exit is what the trap has access to in $?. Adding a call to false before exit
in the above script causes the korn scripts to exit with status 1 on IRIX and
SunOS.

#!/bin/sh

die () {
    status=$?
    echo >&2 "die status: $status"
    exit $status
}

trap 'die' 0

echo "I am dying"
false
exit 1

-brandon

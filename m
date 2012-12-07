From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: Weird problem with git-submodule.sh
Date: Fri, 07 Dec 2012 15:17:27 -0500
Message-ID: <50C24ED7.90000@xiplink.com>
References: <50C22B15.1030607@xiplink.com> <7vvccdhhod.fsf@alter.siamese.dyndns.org> <50C22F72.6010701@xiplink.com> <7vwqwtfzis.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 21:17:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Th4MX-0007OD-VK
	for gcvg-git-2@plane.gmane.org; Fri, 07 Dec 2012 21:17:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424123Ab2LGURR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2012 15:17:17 -0500
Received: from smtp130.ord.emailsrvr.com ([173.203.6.130]:35042 "EHLO
	smtp130.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753047Ab2LGURQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2012 15:17:16 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp13.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 6D18019810C;
	Fri,  7 Dec 2012 15:17:18 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp13.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 183091980B8;
	Fri,  7 Dec 2012 15:17:18 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7vwqwtfzis.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211189>

On 12-12-07 02:11 PM, Junio C Hamano wrote:
> Marc Branchaud <marcnarc@xiplink.com> writes:
> 
>> On 12-12-07 12:54 PM, Junio C Hamano wrote:
>>> Marc Branchaud <marcnarc@xiplink.com> writes:
>>>
>>>> This is with git 1.8.0.1 on all the machines involved.
>>>>
>>>> One of our build machines is having trouble with "git submodule":
>>>> ...
>>>> Any ideas?
>>>
>>> How and why is the IFS set differently only on one of your build
>>> machines?
>>
>> It's not.  On all machines:
>> 	$ set | grep IFS
>> 	IFS=$' \t\n'
>>
>> As I said, if I isolate the module_list() function into another script it
>> works fine, with the exact same environment that breaks in git-submodule.sh.
>>
>> Also, note that at the top of git-submodule there's
>> 	. git-sh-setup
>> which does
>> 	unset IFS
> 
> Yeah, now it makes sense why you wrote "Weird" on the subject line.
> What difference, if any, does the problematic box have compared to
> your other healthy boxes?  It uses a different /bin/sh?
> 
> Just taking a shot in the dark...

Bisected this down to exactly that "unset IFS" line in git-sh-setup.sh, from
your commit 785063e02bb249 (whaddya trying to do to me Junio?? :) ):

Author: Junio C Hamano <gitster@pobox.com>
Date:   Wed Aug 8 12:08:17 2012 -0700

    sh-setup: protect from exported IFS

    Many scripted Porcelains rely on being able to split words at the
    default $IFS characters, i.e. SP, HT and LF.  If the user exports a
    non-default IFS to the environment, what they read from plumbing
    commands such as ls-files that use HT to delimit fields may not be
    split in the way we expect.

    Protect ourselves by resetting it, just like we do so against CDPATH
    exported to the environment.

    Noticed by Andrew Dranse <adranse@oanda.com>.

    Signed-off-by: Junio C Hamano <gitster@pobox.com>

Perhaps IFS should be set to " \t\n" (which I believe is sh's default)
instead of just unsetting it altogether?  (Note that in my testing I had to
set IFS to a literal <space><tab><newline> string.)

		M.

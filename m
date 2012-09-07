From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 3/5] path.c: Use vsnpath() in the implementation of git_path()
Date: Fri, 07 Sep 2012 20:19:16 +0100
Message-ID: <504A48B4.9010109@ramsay1.demon.co.uk>
References: <50463A72.2000209@ramsay1.demon.co.uk> <7vsjax8rap.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 22:14:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TA4wd-0003Rw-NR
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 22:14:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754972Ab2IGUOT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Sep 2012 16:14:19 -0400
Received: from mdfmta004.mxout.tbr.inty.net ([91.221.168.45]:41149 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752047Ab2IGUOS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2012 16:14:18 -0400
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id 08BFAA0C4A6;
	Fri,  7 Sep 2012 21:14:16 +0100 (BST)
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id 24192A0C4A5;	Fri,  7 Sep 2012 21:14:15 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta004.tbr.inty.net (Postfix) with ESMTP;	Fri,  7 Sep 2012 21:14:14 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <7vsjax8rap.fsf@alter.siamese.dyndns.org>
X-MDF-HostID: 9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204994>

Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
> 
>> The current implementation of git_path() is essentially the same as
>> that of vsnpath(), with two minor differences. First, git_path()
>> currently insists that the git directory path is no longer than
>> PATH_MAX-100 characters in length. However, vsnpath() does not
>> attempt this arbitrary 100 character reservation for the remaining
>> path components. Second, vsnpath() uses the "is_dir_sep()" macro,
>> rather than comparing directly to '/', to determine if the git_dir
>> path component ends with a path separator.
>> In order to benefit from the above improvements,...
> 
> In the longer term, I think this goes in the right direction, but
> the loss of reservation, especially when we know git_path() is used
> by some callers to get the base directory in $GIT_DIR that want to
> append stuff after the returned directory path to form the final
> pathname, is a bit worrysome.  It may be hiding a bug (lack of
> proper limit check) on the callers' side.

Hmm, at first I could not see what you found worrysome here.
After all, the number of inputs which leads to success (i.e. does
not result in an "/bad-path/" return) has been *increased* with
this patch.

However, I suppose you are concerned about something like this:

    char *git_dir = git_path("");
    if (strcmp(git_dir, "/bad-path/") != 0) {
        /*
         * Having studied the implementation of git_path(), I know
         * that the buffer pointed to by git_dir has space for an
         * additional 100 chars. This is enough room to concatenate
         * the doberry path, so this is safe ...
         */
        strcat(git_dir, doberry); /* oops */
    }

Yes?

Hmm, yes it would be a little disapointing to see such parasitic code!
;-)

You said above: "... especially when we know git_path() is used
by some callers to get the base directory in $GIT_DIR ...". Can you
point me to an example of such a caller; I have been unable to find
any code which does this.

ATB,
Ramsay Jones

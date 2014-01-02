From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 4/5] safe_create_leading_directories(): fix a mkdir/rmdir
 race
Date: Thu, 02 Jan 2014 01:53:49 +0100
Message-ID: <52C4B89D.5020902@alum.mit.edu>
References: <1387696451-32224-1-git-send-email-mhagger@alum.mit.edu> <1387696451-32224-5-git-send-email-mhagger@alum.mit.edu> <20131226230204.GZ20443@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 02 01:54:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VyWXw-0001a3-TH
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jan 2014 01:54:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbaABAxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jan 2014 19:53:55 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:60376 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750706AbaABAxy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Jan 2014 19:53:54 -0500
X-AuditID: 1207440d-b7f4c6d000004a16-74-52c4b8a2144e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 27.0D.18966.2A8B4C25; Wed,  1 Jan 2014 19:53:54 -0500 (EST)
Received: from [192.168.69.148] (p57A256B4.dip0.t-ipconnect.de [87.162.86.180])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s020romA013535
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 1 Jan 2014 19:53:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131005 Icedove/17.0.9
In-Reply-To: <20131226230204.GZ20443@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsUixO6iqLtox5Egg03vWS26rnQzWTT0XmG2
	eHtzCaMDs8fOWXfZPS5eUvb4vEkugDmK2yYpsaQsODM9T98ugTtjwc1/LAV35CouXJjL3MA4
	XaKLkYNDQsBEYv0jlS5GTiBTTOLCvfVsXYxcHEIClxkl2r51MkM455gkfl/YxAhSxSugLfGs
	dSqYzSKgKtH6ag2YzSagK7Gop5kJxBYVCJJ4dOghO0S9oMTJmU9YQGwRAQ2J55++sYHYzALW
	EiteHwarFxYIkTjW1Q+1eSGjxOJdE8CGcgoYSGy8eYgN4lJxiZ7GIIheHYl3fQ+YIWx5ie1v
	5zBPYBSchWTdLCRls5CULWBkXsUol5hTmqubm5iZU5yarFucnJiXl1qka6SXm1mil5pSuokR
	EtK8Oxj/r5M5xCjAwajEw7sg/EiQEGtiWXFl7iFGSQ4mJVHe2i1AIb6k/JTKjMTijPii0pzU
	4kOMEhzMSiK8T7YB5XhTEiurUovyYVLSHCxK4rxqS9T9hATSE0tSs1NTC1KLYLIyHBxKErwX
	tgM1ChalpqdWpGXmlCCkmTg4QYZzSYkUp+alpBYllpZkxIMiOL4YGMMgKR6gvRog7bzFBYm5
	QFGI1lOMuhzzvnz4xijEkpeflyolzvsApEgApCijNA9uBSyBvWIUB/pYmPcZSBUPMPnBTXoF
	tIQJaIlIySGQJSWJCCmpBsa5GTztJ3cG7T5co8wktEEyrHv+lmW5P/8YHFBgejUncpXjsSqN
	pB1p+7YE9TxVFlkjELPdj6PGo3N5r3Tiu93eaXz+fv2l67Q8m5yqUvc3GE558Irn 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239847>

On 12/27/2013 12:02 AM, Jonathan Nieder wrote:
> Michael Haggerty wrote:
> 
>> It could be that some other process is trying to clean up empty
>> directories at the same time that safe_create_leading_directories() is
>> attempting to create them.  In this case, it could happen that
>> directory "a/b" was present at the end of one iteration of the loop
>> (either it was already present or we just created it ourselves), but
>> by the time we try to create directory "a/b/c", directory "a/b" has
>> been deleted.  In fact, directory "a" might also have been deleted.
> 
> When does this happen in practice?  Is this about git racing with
> itself or with some other program?

I think it could be triggered by a reference creation racing with a
reference packing.  See below.

> I fear that the aggressive directory creator fighting the aggressive
> directory remover might be waging a losing battle.

That may be so, but it would be strange for a directory remover to be
aggressive.  And even if it were, the worst consequence would be that
the director creator would try three times before giving up.

> Is this about a push that creates a ref racing against a push that
> deletes a ref from the same hierarchy?

The race could be triggered in this scenario but I don't think it would
result in a spurious error (at least not if there are only two
racers...)  The reason is that empty loose reference directories are not
deleted when a reference is *deleted*, but rather when a new
d/f-conflicting reference is *created*.  E.g., if

    git branch foo/bar
    git branch -d foo/bar # this leaves directory foo behind
    # this removes directory foo and creates file foo:
    git branch foo &
        git branch foo/baz

The last two commands could fight.  However, in this scenario one of the
reference creations would ultimately have to fail anyway, so this patch
doesn't really help.

However, when packing references, the directories that used to hold the
old references are deleted right away.  So

    git branch foo/bar
    git pack-refs --all &
        git branch foo/baz

Here, the last two commands could fight.

>> So, if a call to mkdir() fails with ENOENT, then try checking/making
>> all directories again from the beginning.  Attempt up to three times
>> before giving up.
> 
> If we are racing against a ref deletion, then we can retry while our
> rival keeps walking up the directory tree and deleting parent
> directories.  As soon as we successfully create a directory, we have
> won the race.
> 
> But what happens if the entire safe_create_leading_directories
> operation succeeds and *then* our racing partner deletes the
> directory?  No one is putting in a file to reserve the directory for
> the directory creator.
>
> If we care enough to retry more than once, I fear this is retrying at
> the wrong level.

I realize that this change doesn't solve the whole problem.  But you
make a good point, that if the caller is going to retry anyway, then
there is no need to retry within this function.  It would be sufficient
for this function to return a specific error value indicating that
"creating the directory failed, but there's a chance of success if you
try again".

On the other hand, your argument assumes that all callers really *do*
retry, which isn't the case, and I doubt that all callers are going to
be fixed.  So there might be some value in retrying within this function
anyway (it's a game of averages we're playing here anyway).

I'll think some more about it.

> Tests?

I can't think of how to test this short of either instrumenting the code
(which I did for my own tests, but didn't include the test code in this
submission) or running the test within some kind of malicious virtual
filesystem.  Ideas?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/

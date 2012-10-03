From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: Git diff-file bug?
Date: Wed, 3 Oct 2012 07:58:15 -0400
Message-ID: <CAM9Z-nmhxHQF5CxL5ivef=DGpL2mC_67J7g+e7UsNW2U6qcU8Q@mail.gmail.com>
References: <CAEkqydxRy3ukSWyQ53Tiosq+DMWWLG=AVuZk+Jm79Y5SaRmeDw@mail.gmail.com>
	<7vr4plkhin.fsf@alter.siamese.dyndns.org>
	<CAEkqydxxmG1QsNUGqQnNn9xfXmS3D3qUvJR6OPV2poabKqcVeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Scott Batchelor <scott.batchelor@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 13:59:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJNat-0002Je-He
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 13:58:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753971Ab2JCL6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 07:58:17 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:38120 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753888Ab2JCL6R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 07:58:17 -0400
Received: by bkcjk13 with SMTP id jk13so6061158bkc.19
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 04:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=LsGDdYfjqQCv/C+LvbYwVJN207jO0UAhLPw3pTrV62s=;
        b=TYLIAtMMtf/7EXijtuKH/BEZ8zLTgW7mMUtXJlUGRubhqbOZZCv+R8zEhRnoOiZl/4
         LjnO3uKmFxH/ZHL1BjsYsX7J06vvTb6VDrc/mgbGtFTAK5YJhf/GoGUvKvu897tOyOhj
         bIJKNNMbaRrmwHml6KjyGjhwOI0/7UNuCjbAljSPcJ/A7v1oIHuAKfP6wSb7OWlvOcQc
         iKSaaix88cvrx1FjGDXGuUN+SFt7aOjxpdeNcVIEfNnwNEeCqXisG7fN9bgZ518PXUUR
         myRAdCitFUxfs6bhf5UZ2kW4OYTE4eblgklda1c5V6+d9cFlLC4Ir9uO5fq8jc09PKb6
         NCbA==
Received: by 10.204.11.210 with SMTP id u18mr398116bku.123.1349265495713; Wed,
 03 Oct 2012 04:58:15 -0700 (PDT)
Received: by 10.205.122.144 with HTTP; Wed, 3 Oct 2012 04:58:15 -0700 (PDT)
In-Reply-To: <CAEkqydxxmG1QsNUGqQnNn9xfXmS3D3qUvJR6OPV2poabKqcVeQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206884>

On Wed, Oct 3, 2012 at 4:04 AM, Scott Batchelor
<scott.batchelor@gmail.com> wrote:
> Many thanks to all who have responded to my question.
> I have found that something is, indeed, modifying the inodes for all
> the files in my repository. Our systems administrator executes a
> backup using "tar" with the "--atime-preserve" flag. It is this flag
> that modifies the "changed time" in the inode, and causes gitk to show
> that all my files have changed.
> Thanks,
> Scott.

Scott,
We do that in our office @work. Perhaps this will help:

"core.trustctime
If false, the ctime differences between the index and the working tree
are ignored; useful when the inode change time is regularly modified
by something outside Git (file system crawlers and some backup
systems). See git-update-index(1). True by default."

(Quoted via http://git-scm.com/docs/git-config )

When/if I have problems I set that false.


(CC list reconstructed)

> On 28 September 2012 21:40, Junio C Hamano <gitster@pobox.com> wrote:
>> Scott Batchelor <scott.batchelor@gmail.com> writes:
>>
>>> I'm fairly new to git and am witnessing some strange behavior with git
>>> that I suspect may be a bug. Can anyone set my mind at rest.
>>>
>>> Every so often (I've not quite figured out the exact set of
>>> circumstances yet)
>>
>> Figure that circumstances out.  That is the key to the issue.
>> Something in your workflow is futzing with the inode data of the
>> files in your working tree behind your back.  It sometimes is a
>> virus scanner.
>>
>> "git diff-*" plumbing commands are meant to be used after running
>> "git update-index --refresh" once in the program and when the caller
>> of these commands (in your case, gitk) knows that any change in the
>> information returned by lstat(2) on the paths in the working tree
>> files since that call indicate real changes to the files.
>>
>> "git status" internally runs an equivalent of "--refresh" before it
>> goes to find changes, so after running it, until that something
>> smudges the inode data behind your back, "gitk" will not be
>> confused.

-- 
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59

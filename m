From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: feature request
Date: Tue, 16 Oct 2012 23:15:00 +1100
Message-ID: <CAH5451=1VU6oUzAyGXZvOW-Pk3+Os1mq1neum572venNjRfT+g@mail.gmail.com>
References: <CAB9Jk9AwTVM4TPwPg1Gmi8TCnnXWUsMAfaz8DdfcEhBNW_15Ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 14:15:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TO63f-00026x-PJ
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 14:15:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753539Ab2JPMPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 08:15:24 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:55974 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752356Ab2JPMPV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 08:15:21 -0400
Received: by mail-qc0-f174.google.com with SMTP id o22so930101qcr.19
        for <git@vger.kernel.org>; Tue, 16 Oct 2012 05:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0s4CjaM/NAk+cmex9FlBGwmV/FpJ0VObIz+YOvG13N4=;
        b=cZ7ODMTQAtJOeS6f2Ek23bP8ZH4uAukpGDOIRmzMQcpNWTVvPT3tysINOn8m3nv93i
         oHhthhi9RTVLyvMXq9QDoTpGey7fqWwWRwNo1779SQHtVHKe08TTZu7AkMszVzsiCc9q
         CYlpnMXTHfa8K2dujkm3Pg1xDOgj4gBEs70pPT20nD0R8IJRyiU0g4Q71iYNcSSmQylh
         t0Z8L3Tc8UG/3gc9mFSNdOWBmhKsuC9wmYdBNrpxyuyvZ0u25rzTcbbbe5TziUxVDo0l
         B8mNMnCIHT1Gu45lSZsRUWPjhZFItvVD/xX3EsZeXkpCrAM8jdZ/12j+m1sk6wwZVYOn
         R6QA==
Received: by 10.49.48.109 with SMTP id k13mr33817557qen.44.1350389720805; Tue,
 16 Oct 2012 05:15:20 -0700 (PDT)
Received: by 10.49.58.225 with HTTP; Tue, 16 Oct 2012 05:15:00 -0700 (PDT)
In-Reply-To: <CAB9Jk9AwTVM4TPwPg1Gmi8TCnnXWUsMAfaz8DdfcEhBNW_15Ug@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207821>

On 16 October 2012 22:36, Angelo Borsotti <angelo.borsotti@gmail.com> wrote:
>
> Hello,
>
> some VCS, e.g. ClearCase, allow to control the fetching of files so as
> to warn, or
> disallow parallel changes to the same files.
> As of today, there is no way to implement the same kind of workflow with
> git
> because there are no fetch hooks.
> Would it be a good idea to provide them?
>
> -Angelo Borsotti

It seems like you want to be able to lock a file for editing once
someone has 'checked-out' the file. This really only makes sense for
binary files (or files which there is no straightforward way to merge)
as otherwise you are throwing away the usefulness of git without any
gain. Git is designed so that multiple people can work on a file at
the same time. Easy merging means that collating those changes is an
easy task, and so locking a file has no use. If a file cannot be
easily merged then it does make sense to lock the file. Is this what
you need to do, or is there some other reason for wanting a lock?

In any case, locking a file is a hard thing to do right in a
distributed system, and doesn't really make sense (although it may be
useful!) When you clone a git repository you have the entire history
of the repository on your computer. What does it mean to have a locked
file? Does the file get deleted from everyone's repository every time
someone else locks it? That would seem silly. Perhaps everyone simply
can't write to that file once it has been locked - how do you impose
that restriction in a distributed system (you can't)?

Instead you can only refuse pushes that change the locked file (which
is normal - you would have to force the push for any non fast-forward
changes), and you can try to warn users that somebody else has locked
the file. This warning system might be doable in some fashion, by
using hooks to write the locked files to a text file somewhere and
checking that, however it would be near impossible to get right or
would hamstring the distributed nature of git by forcing constant
server checks.

Instead of continuing making the point here, let me point you towards
some other discussions around file locks, in particular how git
handles binary files. You should be able to find many more, but as a
starter, look at [1] and [2].

In general, I would reconsider why two users shouldn't be able to
change the same file at the same time.

Regards,

Andrew Ardill

[1] http://stackoverflow.com/questions/119444/locking-binary-files-using-git-version-control-system
[2] http://git.661346.n2.nabble.com/Lock-binairy-files-in-Git-td2422894.html

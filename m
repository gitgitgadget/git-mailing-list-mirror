From: Scott Sandler <scott.m.sandler@gmail.com>
Subject: Re: Git push race condition?
Date: Mon, 24 Mar 2014 16:01:32 -0400
Message-ID: <CAAyEjTNPqPHswbrrV9pRyXUUqD8dYzJaXQpWr+g3kuBERNLMRw@mail.gmail.com>
References: <CAAyEjTN53+5B9Od9wW698wODNL3hR6Upot8-ZLwEksn3ir_zjA@mail.gmail.com>
	<vpq61n3bcve.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Mar 24 21:01:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSB3z-0004wU-Ns
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 21:01:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754077AbaCXUBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 16:01:35 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:39644 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753624AbaCXUBe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2014 16:01:34 -0400
Received: by mail-lb0-f178.google.com with SMTP id s7so4128441lbd.9
        for <git@vger.kernel.org>; Mon, 24 Mar 2014 13:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5MVfH5eSLugFzDzIQzvVwpp9Ko9AO7ijiJQSlwlpqzo=;
        b=syjYfGcdvldTX4+p2nelnYfZVQu8g9qkYbQpHN/BKD8PXzVud3hw9Px7GhGnrN0+QG
         d6Yf/b0U5lKjH5hJgWqDiCZ0dRfeJoXg1ExLolw3LwO+v9eGEl592FjOhEvY6F5U2w70
         7i9odFtR+j3sEnY7tXffwZrjdJ/+DeSyEwnIH6boB+0vjhd4x6jmnCVRNyU8FK8n5MHS
         kAcaTApLTDzEJEt8Td2iG7mazJmArNZC1xOOArx1X09qiR7YTXly0XXcsr1gA71c1Cow
         hYm9E/68p/KnmtGtZ+U0ZgH2NgNlPTA3Q+3IN62xwfe1aHIUcA/19g5hiC2gIv+p5O7C
         oMbQ==
X-Received: by 10.112.186.98 with SMTP id fj2mr42488lbc.54.1395691292924; Mon,
 24 Mar 2014 13:01:32 -0700 (PDT)
Received: by 10.114.64.103 with HTTP; Mon, 24 Mar 2014 13:01:32 -0700 (PDT)
In-Reply-To: <vpq61n3bcve.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244864>

It's a bare repo and I didn't realize server-side reflogs were a
thing. Just ran "git config core.logallrefupdates true" in the repo on
the server which seems to be what I should do to enable that.

The server does know about B, it shows up when you do "git show B".
However "git branch --contains B" returns nothing.

The filesystem is ext4 on linux. It's on a virtual machine in our own
datacenter. It's not an NFS share or anything like that, there is
definitely only one server accessing the filesystem at a time.

Gitlab's update hook maintains an event log when any push event
happens, who pushed and which commits. The most recent time this
happened, the first push which was lost occured at 2014-03-24 19:04:51
and the one that overwrote it happened at 2014-03-24 19:05:04. That's
when the update hook ran, not necessarily when the user hit "git
push", but it is notable that it's 13 seconds apart which is a pretty
long time. We do run several hooks for checking coding syntax and
various other things so it's believable to me that the hooks would
take more than 13 seconds on occasion, but based on the testing I did
with the sleep hook it didn't seem like the hooks were actually the
problem.

On Mon, Mar 24, 2014 at 3:44 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Scott Sandler <scott.m.sandler@gmail.com> writes:
>
>> Both pushes are
>> determined to be fast-forwards and both succeed, but B' overwrites B
>> and B is no longer on origin/master. The server does have B in its
>> .git directory but the commit isn't on any branch.
>
> Is the reflog enabled on the server? If so, does it say anything about B
> and B'?
>
> What filesystem do you use on the server? Is there any kind of NFS, and
> if so are you sure that there's only one machine accessing the
> filesystem at the same time?
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/

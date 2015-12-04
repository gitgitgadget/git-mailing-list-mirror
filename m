From: Stefan Beller <sbeller@google.com>
Subject: Re: Multiple fetches when unshallowing a shallow clone
Date: Fri, 4 Dec 2015 12:46:59 -0800
Message-ID: <CAGZ79ka=RxVZ49D0wkqTRqspKb=Ce5Ay01muBt_Gk6_rDbH6KA@mail.gmail.com>
References: <CACs8u9STLLHr3c3O9kQKGEN52DLfJ2LatjWkeaeeLA-xP=gC5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jason Paller-Rzepka <jasonpr@google.com>
X-From: git-owner@vger.kernel.org Fri Dec 04 21:47:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4xFz-0008Gn-Qm
	for gcvg-git-2@plane.gmane.org; Fri, 04 Dec 2015 21:47:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756405AbbLDUrC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2015 15:47:02 -0500
Received: from mail-yk0-f169.google.com ([209.85.160.169]:33300 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755118AbbLDUrA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2015 15:47:00 -0500
Received: by ykdv3 with SMTP id v3so138185533ykd.0
        for <git@vger.kernel.org>; Fri, 04 Dec 2015 12:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=VZKmNOBpW+1A4fiXnSp+UOL8ZFa2gsEf7HnjoC/u5WY=;
        b=iJlrLBybgtXiAkgL7BX+kswRyzeg7nqU/GXKQcpmr7fbN8Pgvh1JFs31/jLzVi3nA7
         TI6eMV3SANRMDMkXcncr3VZOj4IDhpx2CarJgrwE2hD8N4C6cgy3Z3nReTwbdGtj+2vk
         3nI/CTFBvC11M/RQ3D0wwukrbIBBkQuZ/YoyN0jNRtsEmvLKVgOYNI3uRjs/T0SVVVk6
         SWRWgWtXwgpt8RHV3K5glhS9Pm6AwhkCTue69J5p5hE3oHGwg4/nTZAf9l5bBoI7LTih
         XmG3KMdUfOKKNum+0mhKjEaGQlC01DRQFAWvpFd6F5i2UC9QqMlETcNnvyFW/mFHldhk
         VG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=VZKmNOBpW+1A4fiXnSp+UOL8ZFa2gsEf7HnjoC/u5WY=;
        b=AWnSBoKbZGlHm5J2B6DMJdOEu1cU9PD0hJE1qZbyojQXJRNK7t/5TDS6KaEx0Xk7Q7
         qOfutKXPVkkhRRbvmkoUzKzlKChubOLgrgjATTyxMEebuyX4ACijR5zCAfeiKB20Pgun
         V2+HaZ0mYZrMnIGxxK29K8Plp0BXUknKmaVZZBmZmbIIZDYI3LH18T0dv8D5UOg4nCzr
         WdaOdl+UZiAEKA1/aqtXf/2wTWHK4Eec3w6PMVp3kV7A9T8JxzkbGT6XrXiePwiv4YGS
         U/iImRN7uD3S7vOh9DtZpHOebsK+BqQaOyTVHVvaCcJWAsroTQVMjrEWZ5EAAmEe1rgq
         vmng==
X-Gm-Message-State: ALoCoQmqOX6Z6oCzj6I4bL7PNZsregFSAPzyuSkl/mKbwIkhXdqWMWEZnJkdbNUC7Lpb8uOeHHyl
X-Received: by 10.13.198.133 with SMTP id i127mr12823087ywd.252.1449262019623;
 Fri, 04 Dec 2015 12:46:59 -0800 (PST)
Received: by 10.37.215.16 with HTTP; Fri, 4 Dec 2015 12:46:59 -0800 (PST)
In-Reply-To: <CACs8u9STLLHr3c3O9kQKGEN52DLfJ2LatjWkeaeeLA-xP=gC5Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282001>

On Mon, Nov 30, 2015 at 11:35 AM, Jason Paller-Rzepka
<jasonpr@google.com> wrote:
> Hi all,
>
> Would anyone be willing to help me understand some shallow-clone
> behavior?  (I found a bug in Dulwich, and I'm looking for some context
> so I can determine how to fix it.)
>
> I learned that cgit sometimes performs two fetches for a `git fetch
> --unshallow`: one with depth 'infinity', and a subsequent one with
> depth zero.

Is there a condition to trigger this 'sometimes' ?

I just tried reproducing via
$ GIT_TRACE=1 git fetch --unshallow

and could not see a second fetch, but only a
fetch-pack with --depth=2147483647
>
> Could anyone answer:
> 1) What is the purpose of the second fetch?
> 2) What does this depth of zero mean? Is it the same as a depth of
> infinity?  (I assume not... but, since I thought the smallest
> meaningful depth was 1, I don't know what else it might mean.)
>
> Thank you!
> Jason
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Alexander Kostikov <alex.kostikov@gmail.com>
Subject: Re: Rebase doesn't restore branch pointer back on out of memory
Date: Thu, 4 Oct 2012 14:09:03 -0700
Message-ID: <CAGAhT3k=T0SGngMQkbXHqNfh-=LUb71C7CSrWXP2wsAgc8Tb8A@mail.gmail.com>
References: <CAGAhT3kofdaQEye9QHnvFhAAzoQqZtR7d5UzbxU+zEdkAHVfuQ@mail.gmail.com>
	<506CB3B5.808@gmail.com>
	<CAGAhT3mVn-W5P-n_YeafZ_7bntkJGArJ3o6+dA5GO_H44=KHFg@mail.gmail.com>
	<506DA7AE.50005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Andrew Wong <andrew.kw.w.lists@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:54:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtiC-00033L-5r
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:16:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757576Ab2JDVJG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Oct 2012 17:09:06 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:38966 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757543Ab2JDVJE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Oct 2012 17:09:04 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so998930oag.19
        for <git@vger.kernel.org>; Thu, 04 Oct 2012 14:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=iCKFcSE8ndfw7Rw3c5XmZCvJnWmYqihzcYjF4IwUWR0=;
        b=bOt7K5oOh7aZ9DsmvR9dA6Hwmy8Xx6WLtCVt6SLQJZxqP9C6aJss3C5nVcTAUwSRT5
         S+SvGNTJ/CJZzdV1+f/HLSEldw7k/E6dXBi79YQ3eQmWtouxgBNdY+a8hwoGLXjnoBv7
         6/IqL+vdc4DYYOmpa70cI2CwKssxxOAzzzVcB+mMEoH6kEaDikVXe3JtnT14wVn7bnPA
         Ua9+DE9BqbSQgA2uJUR5U5VHq6BEAl1nrpEvMfWD/vLQSooZyzG1r7VhwvDwgFIKyeQ8
         8kPcVp2m/KtmDEiQGQcz0sLYNee+MTUmQsaDHexkrTik6Kqtq8ro4M7fDPEyYFHkhidb
         uT+g==
Received: by 10.60.11.67 with SMTP id o3mr5639643oeb.43.1349384943331; Thu, 04
 Oct 2012 14:09:03 -0700 (PDT)
Received: by 10.182.86.164 with HTTP; Thu, 4 Oct 2012 14:09:03 -0700 (PDT)
In-Reply-To: <506DA7AE.50005@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207031>

> Having the
> last page of that output should give us enough context as to where it=
's
> failing.
=46ull script is uploaded to
https://dl.dropbox.com/u/10828740/rebase.log Here is the last page:

-----------------------------------[code]
if test -s "$dotest"/rewritten; then
    git notes copy --for-rewrite=3Drebase < "$dotest"/rewritten
    if test -x "$GIT_DIR"/hooks/post-rewrite; then
        "$GIT_DIR"/hooks/post-rewrite rebase < "$dotest"/rewritten
    fi
fi

rm -fr "$dotest"
git gc --auto
git rev-parse HEAD

ret=3D$?
test 0 !=3D $ret -a -d "$state_dir" && write_basic_state
exit $ret
-----------------------------------[/code]


> It'd also be interesting to see if "rebase -i" will also workaround t=
he
> issue.

rebase -i fails with different error:

=BB git rebase -i master rebase_debug
fatal: Out of memory, malloc failed (tried to allocate 458753 bytes)

Do you need verbose log for it as well?

-- Alexander


On Thu, Oct 4, 2012 at 8:13 AM, Andrew Wong <andrew.kw.w.lists@gmail.co=
m> wrote:
> On 10/03/2012 06:35 PM, Alexander Kostikov wrote:
>>>
>>> That allows you can go back to the pre-rebase state by
>>> "rebase --abort".
>>
>> rebase --abort command were not available. I guess rebase file was n=
ot
>> created.
>
> I meant "rebase --abort" would be available *if* the error was caught=
 by
> "rebase". But in your case, "rebase" is probably dying somewhere and =
the
> error was not caught, causing "rebase" to think that everything compl=
eted
> successfully, and go ahead to update the branch.
>
>
>> Is there a way to include some log verbose mode to detect where
>> exactly error happens?
>
> There isn't any built-in to git itself. But one way to get more info =
is
> running the rebase command this way:
>     env SHELLOPTS=3D"verbose" git rebase <your arguments>
>
> That should print out every shell command that rebase executes. Havin=
g the
> last page of that output should give us enough context as to where it=
's
> failing.
>
> Just a wild guess: rebase is probably failing at the "format-patch" c=
ommand.
> It'd also be interesting to see if "rebase -i" will also workaround t=
he
> issue. But like you said, there's no way set "-i" or "-m" as the defa=
ult.



--=20
Alexander Kostikov

From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2] mergetools/p4merge: Honor $TMPDIR for the /dev/null placeholder
Date: Sat, 22 Dec 2012 13:56:53 -0800
Message-ID: <CAJDDKr54XBtU4J-A8T9LwXAPL6E8M2_0kaTxH_-LZCAR0fwN+g@mail.gmail.com>
References: <1356073023-15376-1-git-send-email-davvid@gmail.com>
	<7v4njf2xrk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeremy Morton <admin@game-point.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 22 22:57:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmX4C-0001Zk-Sw
	for gcvg-git-2@plane.gmane.org; Sat, 22 Dec 2012 22:57:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752246Ab2LVV4z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2012 16:56:55 -0500
Received: from mail-vb0-f44.google.com ([209.85.212.44]:43339 "EHLO
	mail-vb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752071Ab2LVV4y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2012 16:56:54 -0500
Received: by mail-vb0-f44.google.com with SMTP id fc26so6390849vbb.31
        for <git@vger.kernel.org>; Sat, 22 Dec 2012 13:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=GAE+dnYFW7vhtchH+bG+9mSCbfhFa1kWyXXi9wZMTbQ=;
        b=qgKaiwifOaGboFKX9GG6ZKyXml5j93YXdThHZucPGP1TcCS27R/s37bohh1Jvjai8l
         TNG+HmQ4uY3lPy7k+UcW9dxI5Qm4l5umKL1paTPjZrALH+EiIoSssdN/43zZnnvkSoHy
         yntSAAzHA+k3zpSdS3m5uMfbEmOA/brffRl3CZA2ffs7kvyDRFRn1X1aXjjgPddX6QLp
         hChnTAsb59INI/oJX9Ri7a1mA1jt6jADX00uocDYssEweTuTaomNkR8e9FGZCcgDCXB7
         onmbK6mwxiijjLcue29zRF3JxW7c+u7xhTtkKVL0ganN0GNv063oJT+KpYOWaSCaMgK9
         yWIA==
Received: by 10.220.239.14 with SMTP id ku14mr25996333vcb.57.1356213413725;
 Sat, 22 Dec 2012 13:56:53 -0800 (PST)
Received: by 10.58.182.10 with HTTP; Sat, 22 Dec 2012 13:56:53 -0800 (PST)
In-Reply-To: <7v4njf2xrk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212071>

On Fri, Dec 21, 2012 at 8:08 AM, Junio C Hamano <gitster@pobox.com> wrote:
> David Aguilar <davvid@gmail.com> writes:
>
>> Use $TMPDIR when creating the /dev/null placeholder for p4merge.
>> This keeps it out of the current directory.
>
> The usual $REMOTE "this is theirs" and $LOCAL "this is ours" are
> still created in the current directory, no?  It is unclear why this
> "this side does not exist" case wants to be outside of the current
> directory in the first place.

I'll take this as a hint that I should improve the commit message.
As you alluded to in your earlier email, we are in feature freeze
so I will be holding off on sending it until things have settled.

I don't believe there is a strong reason why the file should be in one
place vs. another, and the explanation is different depending on who
is driving the scriptlet.

When difftool drives then $LOCAL and $REMOTE may point to
temporary files created by the GIT_EXTERNAL_DIFF machinery.
For that use case, this commit makes things consistent with
those location of paths.

When mergetool drives it creates $LOCAL and $REMOTE in
the current directory.  They contain the different stages
of the index and can be helpful to the user when resolving merges.

The temporary /dev/null placeholder is a workaround for p4merge
and from the user's point of view this file is never interesting, so
writing it into the worktree is distracting to the user.
I could also say that it makes it consistent because "/dev" is
also not in the current directory, but that's a stretch ;-)

> In other words, "This keeps it out of the current directory" only
> explains what this patch changes, without explaining why it is a
> good thing to do in the first place.

I'll try and write up a replacement patch but I'll hold off
on sending it out until after things have settled down.

FWIW I'm seeing a "Bus Error" when doing "git update-index --refresh"
in a repository with large files on a 32bit machine. I'm not sure if
that counts as a regression since the same error occurs in 1.7.10.4
(debian testing).

I'll start another thread on this topic in case anyone is interested.

>> +create_empty_file () {
>> +     empty_file="${TMPDIR:-/tmp}/git-difftool-p4merge-empty-file.$$"
>> +     >"$empty_file"
>> +
>> +     printf "$empty_file"
>> +}
>
> Assuming that it makes sense to create only the "this side doe not
> exist, and here is a placeholder empty file" in $TMPDIR, I think
> this is probably sufficient.

Yup.  I mulled over whether or not to embed "LOCAL" and "REMOTE"
in the name but eventually decided that it was not worth the effort.
It makes the code much simpler when they share the placeholder
since we no longer need to track them separately.
-- 
David

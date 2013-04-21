From: John Szakmeister <john@szakmeister.net>
Subject: Re: Is there a way to speed up remote-hg?
Date: Sun, 21 Apr 2013 08:59:06 -0400
Message-ID: <CAEBDL5UD9Bedxbtp3H+m5J_0Hq0ddVa1OLxXjyX1CX-Dhd+jzA@mail.gmail.com>
References: <CAEBDL5XO4oU9QL1=kQ_f8_MM9jHAKQojMQr_6VSZsEYNY7PLpA@mail.gmail.com>
	<CAMP44s3Rh6Ef8aSif39UXgr5tqBCCMj92vo_MFoDOupu3Xj8Hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 14:59:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTtrO-0001k7-7E
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 14:59:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753565Ab3DUM7J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 08:59:09 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:60980 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753397Ab3DUM7I (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 08:59:08 -0400
Received: by mail-wi0-f172.google.com with SMTP id hq17so2948904wib.5
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 05:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=SUH2lSs8B2DizjTAyTmvvKz+ioDyyHQ9il+KcZbfU0o=;
        b=qNpldng5J1hfdX+/D0xePbxYbue0vh+zRYDwbLp2OSpSBb9ixedl9JlCPdGSHS4+Nh
         GoULKmmnX+83VUTL+FmEBZlWH8+fZcrwqr4mZIAhayemfatkxdg6ONn7wcVBDsctmCgz
         TtPKb7hXWCePIDOpBAUM5UK38/8yGOYMdgQbIlvTK5U7wVheGLiZuTlUZWQWEbfEpVCs
         7Hc9KvKSdNXw//UTRKSNFcsBEtF5L51Tt09XRVvyzUSibbE0XFFIIYhn/nSNVFwD1Ps1
         Xxmy7g6D+Ndp7+S6ux0MIWNW0q7JTwwD+BXdPLmvpdfwMUK77vbibU//l56rz5ve2Nc8
         0O/A==
X-Received: by 10.194.241.231 with SMTP id wl7mr35571927wjc.52.1366549146377;
 Sun, 21 Apr 2013 05:59:06 -0700 (PDT)
Received: by 10.180.187.240 with HTTP; Sun, 21 Apr 2013 05:59:06 -0700 (PDT)
In-Reply-To: <CAMP44s3Rh6Ef8aSif39UXgr5tqBCCMj92vo_MFoDOupu3Xj8Hw@mail.gmail.com>
X-Google-Sender-Auth: e5tEO9XMu2LCRNdYn3YT4qjV2uc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221946>

On Sat, Apr 20, 2013 at 7:07 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Sat, Apr 20, 2013 at 6:07 AM, John Szakmeister <john@szakmeister.net> wrote:
>> I really like the idea of remote-hg, but it appears to be awfully slow
>> on the clone step:
>
> The short answer is no. I do have a couple of patches that improve
> performance, but not by a huge factor.
>
> I have profiled the code, and there are two significant places where
> performance is wasted:
>
> 1) Fetching the file contents
>
> Extracting, decompressing, transferring, and then compressing and
> storing the file contents is mostly unavoidable, unless we already
> have the contents of such file, which in Git, it would be easy to
> check by analyzing the checksum (SHA-1). Unfortunately Mercurial
> doesn't have that information. The SHA-1 that is stored is not of the
> contents, but the contents and the parent checksum, which means that
> if you revert a modification you made to a file, or move a file, any
> operation that ends up in the same contents, but from a different
> path, the SHA-1 is different. This means the only way to know if the
> contents are the same, is by extracting, and calculating the SHA-1
> yourself, which defeats the purpose of what you want the calculation
> for.
>
> I've tried, calculating the SHA-1 and use a previous reference to
> avoid the transfer, or do the transfer, and let Git check for existing
> objects doesn't make a difference.
>
> This is by Mercurial's stupid design, and there's nothing we, or
> anybody could do about it until they change it.

That's a bummer. :-(

> 2) Checking for file changes
>
> For each commit (or revision), we need to figure out which files were
> modified, and for that, Mercurial has a neat shortcut that stores such
> modifications in the commit context itself, so it's easy to retrieve.
> Unfortunately, it's sometimes wrong.
>
> Since the Mercurial tools never use this information for any real
> work, simply to show the changes to the users, Mercurial folks never
> noticed the contents they were storing were wrong. Which means if you
> have a repository that started with old versions of mercurial, chances
> are this information would be wrong, and there's no real guarantee
> that future versions won't have this problem, since to this day this
> information continues to be used only display stuff to the user.
>
> So, since we cannot rely on this, we need to manually check for
> differences the way Mercurial does, which blows performance away,
> because you need to get the contents of the two parent revisions, and
> compare them away. My content I mean the the manifest, or list of
> files, which takes considerable amount of time.

Eek!

> For 1) there's nothing we can do, and for 2) we could trust the files
> Mercurial thinks were modified, and that gives us a very significant
> boost, but the repository will sometimes end up wrong. Most of the
> time is spent on 2).
>
> So unfortunately there's nothing we can do, that's just Mercurial
> design, and it really has nothing to do with Git. Any other tool would
> have the same problems, even a tool that converts a Mercurial
> repository to Mercurial (without using tricks).
[snip]

That's unfortunate, but thank you for taking the time to explain!

-John

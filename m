From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Is there a way to speed up remote-hg?
Date: Sat, 20 Apr 2013 18:07:41 -0500
Message-ID: <CAMP44s3Rh6Ef8aSif39UXgr5tqBCCMj92vo_MFoDOupu3Xj8Hw@mail.gmail.com>
References: <CAEBDL5XO4oU9QL1=kQ_f8_MM9jHAKQojMQr_6VSZsEYNY7PLpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Sun Apr 21 01:07:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTgsw-0004EI-0j
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 01:07:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755872Ab3DTXHo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Apr 2013 19:07:44 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:50199 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755841Ab3DTXHn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Apr 2013 19:07:43 -0400
Received: by mail-la0-f43.google.com with SMTP id ea20so1007765lab.30
        for <git@vger.kernel.org>; Sat, 20 Apr 2013 16:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=y0AAwY/MZBFSIz1SzfdpSWqrSRVOATeIjUNG7siE4vg=;
        b=DDmfefOUVcEKMu6D+J70/AjWMhGqp359FVwQ6oe+xfNmYvo8t4NN+R8ttat3+NP4SN
         RsSNYpGg4Hu5EwHs5Y6Qtasz/RpFvX6NYOWUjkrl+KZVk4yHLXkoue5AQBVKlx975jq9
         ReCZMGuABRACb8T6JADwGCiuMpiTuNuDh4ima19aXw7IU0s1BBWCTDqcuTmLZVmAITJb
         qhoi5Mo4zrW0I1l2tzx+BoSGlawpVoe1fbREkOiZPrIityQ6KfLOYuJwvxnO13XtWhzc
         Ob2HQVZoVJqOBGBYgJHOEJc38jh+kD6LN0Zb1hzIoQHPSqhxLdzWj+RQ4TwdSsXzA0su
         Zw5A==
X-Received: by 10.112.135.3 with SMTP id po3mr7360903lbb.103.1366499261733;
 Sat, 20 Apr 2013 16:07:41 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Sat, 20 Apr 2013 16:07:41 -0700 (PDT)
In-Reply-To: <CAEBDL5XO4oU9QL1=kQ_f8_MM9jHAKQojMQr_6VSZsEYNY7PLpA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221882>

On Sat, Apr 20, 2013 at 6:07 AM, John Szakmeister <john@szakmeister.net> wrote:
> I really like the idea of remote-hg, but it appears to be awfully slow
> on the clone step:

The short answer is no. I do have a couple of patches that improve
performance, but not by a huge factor.

I have profiled the code, and there are two significant places where
performance is wasted:

1) Fetching the file contents

Extracting, decompressing, transferring, and then compressing and
storing the file contents is mostly unavoidable, unless we already
have the contents of such file, which in Git, it would be easy to
check by analyzing the checksum (SHA-1). Unfortunately Mercurial
doesn't have that information. The SHA-1 that is stored is not of the
contents, but the contents and the parent checksum, which means that
if you revert a modification you made to a file, or move a file, any
operation that ends up in the same contents, but from a different
path, the SHA-1 is different. This means the only way to know if the
contents are the same, is by extracting, and calculating the SHA-1
yourself, which defeats the purpose of what you want the calculation
for.

I've tried, calculating the SHA-1 and use a previous reference to
avoid the transfer, or do the transfer, and let Git check for existing
objects doesn't make a difference.

This is by Mercurial's stupid design, and there's nothing we, or
anybody could do about it until they change it.

2) Checking for file changes

For each commit (or revision), we need to figure out which files were
modified, and for that, Mercurial has a neat shortcut that stores such
modifications in the commit context itself, so it's easy to retrieve.
Unfortunately, it's sometimes wrong.

Since the Mercurial tools never use this information for any real
work, simply to show the changes to the users, Mercurial folks never
noticed the contents they were storing were wrong. Which means if you
have a repository that started with old versions of mercurial, chances
are this information would be wrong, and there's no real guarantee
that future versions won't have this problem, since to this day this
information continues to be used only display stuff to the user.

So, since we cannot rely on this, we need to manually check for
differences the way Mercurial does, which blows performance away,
because you need to get the contents of the two parent revisions, and
compare them away. My content I mean the the manifest, or list of
files, which takes considerable amount of time.

For 1) there's nothing we can do, and for 2) we could trust the files
Mercurial thinks were modified, and that gives us a very significant
boost, but the repository will sometimes end up wrong. Most of the
time is spent on 2).

So unfortunately there's nothing we can do, that's just Mercurial
design, and it really has nothing to do with Git. Any other tool would
have the same problems, even a tool that converts a Mercurial
repository to Mercurial (without using tricks).

It seems Bazaar is more sensible in this regard; 1) the checksums are
try of the file contents, and 2) each revision does store the file
modifications correctly. So a clone in Bazaar is much faster. In my
opinion Mercurial just screwed up their design.

Cheers.

-- 
Felipe Contreras

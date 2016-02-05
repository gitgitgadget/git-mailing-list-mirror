From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: git clean without ignored files
Date: Fri, 5 Feb 2016 09:42:10 -0600
Message-ID: <CAHd499Dhz-2+z_E8muPaucjfMhbcJisVM2eyQf=U4DOvgv2oZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 05 16:42:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRiWX-0003xX-Kl
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 16:42:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755017AbcBEPmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 10:42:12 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:33544 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755013AbcBEPmL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 10:42:11 -0500
Received: by mail-ig0-f172.google.com with SMTP id rs20so43030693igc.0
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 07:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=5o48PxAsJcV0zq+MO4UWV7d+sMT0UtznmsQtzhqdxwA=;
        b=LSbzw6AZiIDxAyGPeO3DH3RFpTd/h1gZTVh85C2o44OYsLXHT9Za5J5olajw+doKJ4
         jTMMwh+04fVwLJN0WWHEc3aYW+mhmqPBeOZ8DClT9XSXgkVoy6Kz7OUoTuMoC/aZRRMF
         1fwdGWwxEFoQ4Nzg5U0HhLsxGGZqpJQ599DyPUH5WpkIyPxbojQzMJsZIZHNDTiDEIsc
         VJnfui8CCLijLwmDR2halnD6qBOQwLpyrVSeiZGxlsfdoXIjgwfyXjn8Ri9xqi4LZNE3
         9RjoM+4unSQLbqAC9WDVuhPZ54TjSFHR2J7ZEYKcB3ansDmYR8MavL49Pr55Zl5U7/U/
         147g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:date:message-id:subject:from
         :to:content-type;
        bh=5o48PxAsJcV0zq+MO4UWV7d+sMT0UtznmsQtzhqdxwA=;
        b=mj7D0xipH+DV32BqVlCw69b5NE6Wvi6Og4yGnLYWDWg4D/9txqCNSo3DCJ8M+PK8Pg
         x7+BXuWMUtvNRALTJoxFMrMMdhLFl1dlMopl0mLJ06jERfM1ZAASfT934eCV713CPTHv
         fpUqgi+z+nPR4EwjUVmhl0okx6bUNUYO8NFebpsaETsf+yPzUNIHNHiR1GIN3wSYQ/ud
         cgLEu/niJXE7Zz8SlJvfHd250ulnfGJqhOtrMaXX9yKjS2uMvqsDkAp3/y/scPxgYDSC
         MzlRm+U9bRA0KfIsT3X4+UI+xzOpKcR3pWLQSUqKpGiXKi2rUO8jRhLBsp6Vp+fwZ2C4
         tHhQ==
X-Gm-Message-State: AG10YOReY3t5/WdjlDNp6xPbm61vYcGY22ZlutpfGHa4Qob1ETZoEOyp/KNTZ8tYmmLCPoVshpbLhjKQZ4hH3Q==
X-Received: by 10.50.150.66 with SMTP id ug2mr10260149igb.33.1454686930105;
 Fri, 05 Feb 2016 07:42:10 -0800 (PST)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.36.83.83 with HTTP; Fri, 5 Feb 2016 07:42:10 -0800 (PST)
X-Google-Sender-Auth: pZIVcMSoNnqwJ3Ktq4xgu4Hd7bg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285580>

I noticed that `git clean` does not handle a specific scenario. I have
the following types of untracked entities in my working copy:

* Untracked files in tracked directories (non-recursive; sibling files
are tracked)
* Untracked files in untracked directories (recursive)
* Ignored files meeting the same criteria above

My goal is to clean the first 2 points, but not the 3rd. Basically, I
want all untracked files that show up in `git status` to be removed,
but not ignored files or directories.

If I run this command:

$ git clean -nd

I get a list of all the untracked files but oddly I get a few
directories in the list that indirectly ignored via my .gitignore.
Basically, the directory itself isn't ignored by any pattern in my
.gitignore but its entire contents (recursively) is ignored, due to
patterns matching the files themselves.

I think `clean` sees this as an untracked directory, because it's not
specifically matching a pattern in my .gitignore. Whereas git status
is smart enough to not display it because it knows that every single
file contained in there, regardless of depth, matches an ignore
pattern.

As a workaround, the following command accomplishes what I want:

$ git ls-files --others --exclude-standard | sed 's/.*/"&"/' | xargs rm -rfv

Is there a reason why `git clean -nd` file listing doesn't match more
closely with what I see in `git status` regarding untracked files and
directories?

Note I am aware git does not directly track directories. So when I
refer to tracked/untracked directories, I'm actually referring to that
directories contents recursively. If recursively 100 files exist, but
only 99 are ignored, then I consider that root directory to be
"untracked" but not ignored, because 1 file still shows up in `git
status`.

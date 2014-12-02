From: Derek Moore <derek.p.moore@gmail.com>
Subject: Re: RCS Keywords in Git done right
Date: Tue, 2 Dec 2014 10:31:02 -0600
Message-ID: <CAMsgyKZWr-1isLvRXMFdzOYu0Yfm3vN_bdk4oRg6UhzSOMq_yQ@mail.gmail.com>
References: <CAMsgyKbTRY5=cHj8Ar8zHDd5WdbcNwZC5caGV-snvZU4aek=YQ@mail.gmail.com>
	<CAGZ79kZz4_q+p91e7fn8uS--DRqEUPj_eeQPf2WPOWEk=R8fkw@mail.gmail.com>
	<CAMsgyKZywnac_b2RV0dGs9zOdemJDUQ8oR=bSydBuSxp1VDixQ@mail.gmail.com>
	<CAGZ79kZLAHDG8h5DMQdOH2cQtaMs_iCtC-xsoKst966a+jaBNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 17:31:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvqM1-0003yv-O2
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 17:31:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469AbaLBQbF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 11:31:05 -0500
Received: from mail-oi0-f52.google.com ([209.85.218.52]:61016 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932520AbaLBQbD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 11:31:03 -0500
Received: by mail-oi0-f52.google.com with SMTP id h136so9156938oig.25
        for <git@vger.kernel.org>; Tue, 02 Dec 2014 08:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=WSe7pKRLoxr2KU6O/ehHYPeIG7dDbsBpV9NSeteJm3U=;
        b=VlJ+xwcval4eKYbVJMZiUHamw2TpNwkzR9YFNjeEtQXMErnisWPZgbl1uUb4nsSZMB
         JPGHSZMkC7gs5vYnPsmf8I4yExYg72+uGdhbMJ08AwSr7kH7QVLi3FXZZSV4mvAADrpv
         Mo6NdWmJJR1scgZ/xEXR+0tUBT4RqWqEGTUIgBnG0CzYUneh+aNnh+OQ+U02NtOTR0d4
         PKbBm4katvRUMnz28a8XHwGW7L8cwf0dJo8mnolcqMqron017JLSalcIlbLdAxOkq/cI
         Ao/oa8Q8D6S90bqiyJbRhTPkFgKk3br1hC1bmDyiAGNW/9nK9+e1uJ28Oc8QS7G5cZaY
         y7Pw==
X-Received: by 10.60.48.65 with SMTP id j1mr135879oen.42.1417537862808; Tue,
 02 Dec 2014 08:31:02 -0800 (PST)
Received: by 10.76.33.68 with HTTP; Tue, 2 Dec 2014 08:31:02 -0800 (PST)
In-Reply-To: <CAGZ79kZLAHDG8h5DMQdOH2cQtaMs_iCtC-xsoKst966a+jaBNA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260572>

I've finished testing this work in larger repositories.

While the approach is performant and works nicely in small repos, but
in larger repos one of the requirements for the "correctness" of
substitutions slows things down (1 or 2 minutes to perform checkouts
between branches with 10,000+ files).

The operation that is slowing things down is discovering the relative
complement of commits between the common files of two branches (i.e.,
which files are common between two branches but differ in their latest
commit).

My current approach is:
1) find files common between @ & @{-1}, "ls-tree --full-tree
--name-only -r" both branches, take the intersection
2) find current branch's commits for common files, for each file in
intersection "log -1 --format=%H $current_branch -- $file"
3) find common files where latest commits differ, for each file in
intersection keep the file if current branche's latest commit does not
equal prior branch's latest commit
4) overwrite all kept files with the results of git-archive

It is steps 2 & 3 that consume the most time in a large repo with
large intersections of common files between branches.

I've tried to conceive of other ways to arriving at the same
"filename"/"latest current branch commit hash" pairs where filenames
are common between branches and latest current branch commit hash
differs from latest prior branch commit hash. I've thought maybe I
could traverse commits starting from merge-base instead of traversing
files, but that doesn't seem like it would be a huge improvement.

I'm sure internal to git in C there would be a better/faster way (and
it would probably look like writing Btrieve queries). Can anyone think
of a good solution for the intersection of files and complement of
commits using only the git CLI tools?

Thanks,

Derek

From: Elijah Newren <newren@gmail.com>
Subject: Re: git reset for index restoration?
Date: Thu, 22 May 2014 09:46:51 -0700
Message-ID: <CABPp-BHtYnput7SiAbnqUjpDibTi5o_2MAXfSj17fCdKSC7Hjg@mail.gmail.com>
References: <1400775763.1933.5.camel@stross>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu May 22 18:47:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnW8y-0003sW-V8
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 18:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752613AbaEVQqx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 12:46:53 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:35480 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833AbaEVQqv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 12:46:51 -0400
Received: by mail-ig0-f170.google.com with SMTP id uy17so6452779igb.3
        for <git@vger.kernel.org>; Thu, 22 May 2014 09:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=dwWHeJyIXrRAtMPzMUxQ71mp7FSb99MIdnfbVBCy0aY=;
        b=eXZuTjYeQJ08k6eEVdISvupD7+WWIXsN1o4gl9LOJGkT3RFmgixDbntqUEaRISu7Vq
         CmmQyiZ07pLKy1yedVwdDj7ALzrK9ACLMaR794SngJwiWchM7DoSQ7dT8J5boOnjSsJp
         xQYPv4CmMItwoXxd0Rvy6S6UKprxZb5onCGHloZLBbJoZ13TCFBgHYzet3j6jRPLDPNs
         hQWRDmkDOxr4djsonpjQ8j95ofLuXaCCvlIm5/u1hTx509HN6ekNMXMBsAwyCClvQRBK
         J4wSwzqWv05TT8m4ltNmONp47+Yl9USPyeLRpYOdVhEoKT1XfPa0V/92fE6B/wB46x+9
         9Hnw==
X-Received: by 10.42.199.144 with SMTP id es16mr3817731icb.87.1400777211097;
 Thu, 22 May 2014 09:46:51 -0700 (PDT)
Received: by 10.64.87.197 with HTTP; Thu, 22 May 2014 09:46:51 -0700 (PDT)
In-Reply-To: <1400775763.1933.5.camel@stross>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249916>

On Thu, May 22, 2014 at 9:22 AM, David Turner <dturner@twopensource.com> wrote:
> If I have a git repository with a clean working tree, and I delete the
> index, then I can use git reset (with no arguments) to recreate it.
> However, when I do recreate it, it doesn't come back the same.  I have
> not analyzed this in detail, but the effect is that commands like git
> status take much longer because they must read objects out of a pack
> file.  In other words, the index seems to not realize that the index (or
> at least most of it) represents the same state as HEAD.  If I do git
> reset --hard, the index is restored to the original state (it's
> byte-for-byte identical), and the pack file is no longer read.
>
> Before I try to dig in to why this should be so, does anyone happen to
> know off the top of their head?  Does this constitute a bug in git, or a
> bug in my understanding of git?

It's not a bug.  The index has additional stat-info it tracks about
files -- inode number, mtime, etc. -- so that it can quickly check
whether files are up to date without comparing full file contents in
the working copy to the relevant version from .git/objects.

'git reset' means make the index match the commit in HEAD.  It implies
nothing about the working copy files, which could be different.
Although you say that you have a clean working tree, git doesn't check
to verify that, so it has to treat these files as stat-dirty until the
next operation (e.g. git status) fills these in -- an operation that
involves full comparison of the files in the working copy with the
relevant version of the file from under .git/objects. (You may find
'git update-index --refresh' helpful here.)

git reset --hard means not only make the index match the commit in
HEAD, but change files in the working copy to match as well.  In such
a case, git will know that the index matches the working copy (since
it is enforcing it), so it can update all the stat-info in the index
and future git-status operations will be fast.

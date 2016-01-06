From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Questions on passing --depth to git-clone vs. git-fetch
Date: Wed, 6 Jan 2016 19:41:55 +0700
Message-ID: <CACsJy8D5DeDOCd1tn876s3+2fBR6e-X1UANkAeiw8tzAeDcDng@mail.gmail.com>
References: <n6j1cs$p4$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 13:42:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGnQ6-0001mt-Ev
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jan 2016 13:42:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbcAFMm1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2016 07:42:27 -0500
Received: from mail-lf0-f54.google.com ([209.85.215.54]:36587 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140AbcAFMm0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jan 2016 07:42:26 -0500
Received: by mail-lf0-f54.google.com with SMTP id z124so307041041lfa.3
        for <git@vger.kernel.org>; Wed, 06 Jan 2016 04:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=FV29tkAkNIAeEBfUBr9xw334QuIwlDV1yHW8TnnvprI=;
        b=LJzR0S3p7csuIwA4+Qz92i5JYmUm5of4EBWRVylKP3Bdw6kOF8hbE2WkcSvL2nEDvm
         yZPuiRCohrUvUP7iWdCAG9Mmu6ar9m49ZXAE0L0t+DOoZ3LV0yXkp2BIqFngsd8XnuZU
         BafOkPGHKzrb3dPFri5jgdJsvyyggRN7l9UmfMxHN/NKO48+nImWyr9THCiTdqQHOh9U
         L7isPzD/qm/IRzYYvyZegoNbGPTcTZ02s337OS43eoHaIAJIRIrRtFaQ1lLc3eUtK/5O
         nDoZQepkmyevOrw4BNXgHWy6uF7q4HwWV9FHA+kJ7mqIyUzM+rPkuZX8CdsSkpGZFpZA
         ZIDA==
X-Received: by 10.25.137.84 with SMTP id l81mr35568552lfd.45.1452084144625;
 Wed, 06 Jan 2016 04:42:24 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Wed, 6 Jan 2016 04:41:55 -0800 (PST)
In-Reply-To: <n6j1cs$p4$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283437>

On Wed, Jan 6, 2016 at 7:30 PM, Sebastian Schuberth
<sschuberth@gmail.com> wrote:
> Hi,
>
> I recently compared the results of doing
>
>     $ git clone --depth=1 https://github.com/git/git.git git-clone-depth-1
>
> versus
>
>     $ mkdir git-fetch-depth-1
>     $ cd git-fetch-depth-1
>     $ git init
>     $ git remote add origin https://github.com/git/git.git
>     $ git fetch --depth=1
>
> and noticed a few things:

I think the culprit is the "git remote add" line. "git clone --depth"
by default will fetch only one branch (aka --single-branch option in
git-clone). But I suspect when you add a new remote, the default
refspec is to get all refs. So "git fetch --depth=1" means fetch _all_
refs, each one has maximum one commit. "git log --graph --decorate"
should show this clearer.

> 1. The docs of clone [1] say about --depth "Create a shallow clone with a history truncated to the specified number of revisions" while for fetch the docs [2] say "[...] to the specified number of commits [...]". As in this particular case revision are always commits, I think the clone docs should also say "commits".
>
> 2. In the fetch docs --depth is described to "Deepen or shorten the history of a shallow repository created by git clone". That sounds as if my example from above where I initialze a repo manually would not allow fetch to be called with --depth as I did not clone before. But in fact my example works fine. I guess we need some clarfication in the wording here.
>
> 3. When running "git log --all -oneline" in the two working trees I get different results, which is not what I'd expect:
>
>     $ cd git-clone-depth-1
>     $ git log --all --oneline
>       7548842 Git 2.7
>
> versus
>
>     $ cd git-fetch-depth-1
>     $ git log --all --oneline
>       b819526 Merge branch 'jk/notes-merge-from-anywhere' into pu
>       e2281f4 What's cooking (2016/01 #01)
>       ef7b32d Sync with 2.7
>       7548842 Git 2.7
>       833e482 Git 2.6.5
>
> So in the clone case only the specified number of commits from the tip of the default branch (master in this case) is fetched, not of each remote branch history. fetch in the other hand really gets the specified number of commits from the tip of each remote branch history. I don't know whether this behavior is inded or not as I cannot find any docs on it either way. But it seems inconsistent to me that clone with --depth only gets the history for the default branch, as clone without --depth would give me the history of all branches.
>
> For completeness, I'm using Git for Windows 2.7.
>
> Any comments?
>
> [1] https://git-scm.com/docs/git-clone
> [1] https://git-scm.com/docs/git-fetch
>
> --
> Sebastian Schuberth
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Duy

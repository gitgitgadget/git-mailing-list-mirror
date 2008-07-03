From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Cherry picking instead of merges.
Date: Thu, 3 Jul 2008 16:15:22 -0400
Message-ID: <32541b130807031315j3d9b7d77y277e3cb994ab0964@mail.gmail.com>
References: <20080703182650.GA11166@old.davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 03 22:16:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEVE6-0004aN-JJ
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 22:16:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969AbYGCUPZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 16:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751694AbYGCUPZ
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 16:15:25 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:58869 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853AbYGCUPY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 16:15:24 -0400
Received: by yx-out-2324.google.com with SMTP id 8so334770yxm.1
        for <git@vger.kernel.org>; Thu, 03 Jul 2008 13:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=SYne8ObLcR00Jp0wAvQuQ1mmrPhp3muVXRvbBa094lk=;
        b=wJAiO0OGG7wicFT9RNFgajhLUtASsunKr1s8SURUgvAupr/TM14ASl/N4xyqJQK9PG
         THvonVTIDmxPTn7ehoGKDMWrJAJ8bxodTzUlLk8roiPs/vIFGLRn8UT+3VWhLyh1XE+k
         eyVk37NTjn+DbJaA+739Y1zI3Iy/upYSJlGdw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=cqqI8mUSkmNXzgQPNwp8AF2pRZqaAVl0o7EB1Wj40QwdWt8ymaaSzm6mJT7mO1IUjG
         8B4AxFUApfI2d4RZ88sI+rx9m19V3zFcR2cWX8yYtB43DdNgsEfcC2j7z5rHKS+72NGS
         9brwvmB4IznGrNbo1dCiNUGNQC7Caylgwmy/w=
Received: by 10.151.154.12 with SMTP id g12mr947643ybo.110.1215116123048;
        Thu, 03 Jul 2008 13:15:23 -0700 (PDT)
Received: by 10.150.96.5 with HTTP; Thu, 3 Jul 2008 13:15:22 -0700 (PDT)
In-Reply-To: <20080703182650.GA11166@old.davidb.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87314>

On 7/3/08, David Brown <git@davidb.org> wrote:
>  First we tried a git-merge and resolved the conflicts.  The problem here is
>  that the resultant code didn't work.  git-bisect wasn't very useful because
>  the intermediate versions don't have resolved conflicts.
>
>  Yesterday, one developer cherry picked company B's changes into a branch.
>  It appears he resolved the conflicts for each commit, which should make
>  bisecting easier.
>
>  The problem is that we now have very divergent history.
>
>  Any advice on how to make use of how he resolved conflicts in order to
>  merge company B's changes in using git-merge.  [...]

Unfortunately, since your mismerged branches are already published,
rewriting history would cause a lot of pain for everyone.  It would be
better to avoid doing that entirely.  However, I can see why you'd
want to do that in order to make future git-bisect easier.

Basically, if you're going to try to fix the git-bisect intermediate
versions, you're going to have to rewrite history anyway; in which
case, why not just make your developer's cherry-picked branch the
official one?  Then your problems are solved, other than getting all
your developers onto the new history.

Alternatively, if you just want to fix your main development tree so
that it's "correct", then you could do this:

- Go to a point in time where both branches (main and developer) have
exactly the same set of patches: that is, your company + company B.
The exact history (ie. commit ids) will look different, because the
two branches took different paths to get there, but the code *should*
have been identical at those two times, since you have the same set of
patches.  Call the two points X and Y.

- X (on the main branch) is actually different from Y (on your
developer's branch) because someone mis-resolved the conflicts on X.
However, the only difference between X and Y should be the mis-merge.
Thus:

- git diff X..Y >fix-mis-merge.patch

- git checkout HEAD

- git apply fix-mis-merge.patch

This will apply the correct conflict resolution to the tip of your
newest branch.  All the revisions between X and HEAD will still be
broken, but that's usually better than trying to rewrite history and
pretend the broken revisions never existed.  You can always use "git
bisect skip" for cases like that.

Have fun,

Avery

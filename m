From: "Jason Sewall" <jasonsewall@gmail.com>
Subject: Re: Submit/Workflow question
Date: Sun, 29 Jul 2007 10:21:27 -0700
Message-ID: <31e9dd080707291021y5fd258ccobc4fa30e23a9880a@mail.gmail.com>
References: <85abtfw6d5.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, bfields@fieldses.org
To: "David Kastrup" <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Jul 29 19:21:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFCST-0002ns-1B
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 19:21:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763953AbXG2RV3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 13:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764653AbXG2RV3
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 13:21:29 -0400
Received: from wx-out-0506.google.com ([66.249.82.239]:62715 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763849AbXG2RV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 13:21:28 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1171464wxd
        for <git@vger.kernel.org>; Sun, 29 Jul 2007 10:21:27 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DpMeetvMWzkduEBXvgQLJBJH70K907p6D66xtPRgfG9ycReuKf0AIYWhIIwmLoLDLRclPlYA0oMAmMxM6Nj1Jb230fEEoToYcg7IO0VzgRazQl4FTH3eY1bnCpf+nWcfnfeomOTfkoMBBTpdDT6J0iO5JPabYTjygHzXuuR/yaM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=B+HqMI2LjgOgy3OoheCgJMl2hLcCIYGsA3mH2EKDl4XCBDEjQQPtSTcAwXYXnO8U2qXi/VnvjJDUUsFG4ySz0wlvX64JlBo0I54TkFfsOnnioaptqQrgunGNLE44L3r7ZtdSY3vppLi18rp/2vKaNjFDVfWk2DHYgXzkE66UN2k=
Received: by 10.90.113.20 with SMTP id l20mr1325833agc.1185729687263;
        Sun, 29 Jul 2007 10:21:27 -0700 (PDT)
Received: by 10.90.54.18 with HTTP; Sun, 29 Jul 2007 10:21:27 -0700 (PDT)
In-Reply-To: <85abtfw6d5.fsf@lola.goethe.zz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54127>

On 7/29/07, David Kastrup <dak@gnu.org> wrote:
>
> Suppose that I have created a half-baked patch A suiting my personal
> needs and went on from there, having something like
>
> ...->A->B->...
>
> Now at some point of time I decide that really A should be made fit
> for submission.

What I do in this sort of situation varies on how good I was about
keeping A and B "independent"; first of all, let's assume you're not
on 'master', you're on 'some-feature' (and if you weren't, it's easy
to make it a branch, tho you might have to rebase the branch to the
point on master where the patch is meaningful to others, and
optionally rewind master to keep it clean)

some-feature:         A->B->...
                     /
master:  ->W->X->Y->Z

If I really want to edit *just* A and not use any of B at all, then
the excellent rebase -i would do the job - you may want to rebase to
Z, or if A weren't the first commit exclusive to your branch, you
could rebase to whatever that is...

The point is that rebase -i will let you say "edit just A, just apply
B afterwards" and it will rewrite history for you after you fix A, and
then it will try to apply B on top of A, and so on until you're done.

Sometimes, rebase -i doesn't cut it for me, (because I didn't make my
commits cleanly separated, or perhaps because I haven't totally
explored rebase) - then I do it the "old-fashioned way" which it the
way this was usually done before rebase -i. I make a temporary branch
off of master called (apply-some-feature) and I start generating diffs
between this new branch and some-feature. A apply them, sometimes
reaching across commits and so forth, and commit the changes in nice,
clean format. When I'm done, *I* usually merge these onto master (if
its my own project) but if you were going to make it into a patch, I
would probably just replace some-feature with apply-some-feature.

It's probably pretty self-evident, but (git) diff (and some sort of
visual patch-applier) is pretty powerful and you can generate very
"narrow" diffs to look at just the parts you want to for a given step
in this process. And of course, you can use to to make sure that at
the end, apply-some-feature and some-feature's HEADS have the same
tree (or not, if you chose to omit some debugging stuff as I often
do).

By the way, the way Bruce suggested was fine too, I just though I'd
share what I do in this sort of situation (and I do it often because I
always forget to make my commits clean the first time)

Jason

From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCHv2 00/57] Re-roll of en/merge-recursive from pu
Date: Fri, 12 Aug 2011 20:37:39 -0600
Message-ID: <CABPp-BH3eoYAM9-beQv57Byaf73hQECORxJnqt3JFXTvBpgPRw@mail.gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
	<7vei0rnprt.fsf@alter.siamese.dyndns.org>
	<CABPp-BE_cqtOBC_0tsy1nSOfH1XPGM0vdv9fHWp38Q0GBr7OhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 13 04:37:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qs46h-0008Lr-QV
	for gcvg-git-2@lo.gmane.org; Sat, 13 Aug 2011 04:37:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752527Ab1HMChl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Aug 2011 22:37:41 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60873 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751949Ab1HMChl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Aug 2011 22:37:41 -0400
Received: by fxh19 with SMTP id 19so2643245fxh.19
        for <git@vger.kernel.org>; Fri, 12 Aug 2011 19:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=s9K/y5PYKgmdKtoWOimlMhbF8KIur5CD6Emj7pbWpvk=;
        b=xgff5t6MAZWaOzcoMrCa7kY52aRJh58OMq6EV5OJmG8pl3auxUiaxn0tSsHvEshcqf
         gqLnuNV7ydlIxHAbs0nuRxvzgI851l24XT0kGxojHSfGbgN5uiG9TUda41G8qEj6SlBk
         BF2aCESBW1S5pFhjq8vhP2HEI5eBfRC1DRpD4=
Received: by 10.223.74.10 with SMTP id s10mr2097170faj.73.1313203059692; Fri,
 12 Aug 2011 19:37:39 -0700 (PDT)
Received: by 10.223.134.84 with HTTP; Fri, 12 Aug 2011 19:37:39 -0700 (PDT)
In-Reply-To: <CABPp-BE_cqtOBC_0tsy1nSOfH1XPGM0vdv9fHWp38Q0GBr7OhQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179268>

On Fri, Aug 12, 2011 at 3:59 PM, Elijah Newren <newren@gmail.com> wrote=
:
> On Thu, Aug 11, 2011 at 11:48 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
>> Avoiding silent mismerges is of course one of the most important cri=
teria,
>> but we also need to make sure that a conflicted state left in the in=
dex
>> and the working tree files must not be harder to reconcile than what=
 we
>> have been giving our users---otherwise the change will be seen as a
>> regression by them.
>
> Yeah, good point. =C2=A0I tried re-running my previous re-merge all m=
erges
> in git.git testcase, modified so that when both versions of git
> reported a conflict I would compare the output of 'git ls-files =C2=A0=
-s'.
> That uncovered a regression. =C2=A0I think I know the fix but I need =
to
> retest and do some more checks.

With the new patch that I just submitted ("[PATCHv2 57/57]
merge-recursive: Don't re-sort a list whose order we depend upon"), I
now have fixed up the only issue I found with the more thorough tests
you suggest.  In other words:

I used the new patch on top of my series and redid my testing.  For
each two-parent merge commit in git.git (about 5000 of them), I redid
my tests.  I verified that for each redone commit,  both versions of
git would:
  (A) EITHER both fail to merge cleanly OR both merged cleanly
  (B) had identical 'git ls-files -s' output
  (C) had identical output from
       find . -type f -print0 | grep -z -v ^./.git | sort -z -u |
xargs -0 sha1sum
(Note that (B) is different than before; it should be useful in
comparing failed merges as well as successful ones, making sure the
contents of the index match.  Also, the purpose of (C) is to ensure
that the contents of the working tree match.)

In all cases, (A) and (B) were true.  There were 16 commits for which
(C) was not true; the working tree contents were different.  However,
each and every such difference were due to the change in behavior to
provide more info in conflict markers (branchname:filename instead of
just branchname) -- see patch 36 in the series.


So with the new patch, and the commit message changes Johannes
suggested for patch 27, I'm hoping this series is finally in good
shape.  But, as before, comments on the changes and other ideas for
more thorough testing are welcome.

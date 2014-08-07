From: Fabian Ruch <bafain@gmail.com>
Subject: Re: [PATCH v1 09/19] rebase -i: commit only once when rewriting picks
Date: Thu, 07 Aug 2014 02:24:36 +0200
Message-ID: <53E2C744.4040106@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1406589435.git.bafain@gmail.com> <235b55a0ec3db4a111fbb32e58e578ced6307d72.1406589435.git.bafain@gmail.com> <20140802002231.GD20040@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 07 02:24:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFBVc-0003FQ-7l
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 02:24:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754579AbaHGAYk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 20:24:40 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:55550 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754444AbaHGAYj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 20:24:39 -0400
Received: by mail-wi0-f182.google.com with SMTP id d1so4146661wiv.9
        for <git@vger.kernel.org>; Wed, 06 Aug 2014 17:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Pot601WlXperH8idDHZWetHyRstiTlcHb/r+KF/Z3Bg=;
        b=Ofdvr9+sn0bT7nemWm0pCA95Jzv4gotz8olqqDZRvstpx+zlS0HdAiDgSLFGNQrwv2
         MDcXR8ndizMyTS+fAK5yfWNa8ikU/ecfk8KPrvh1CiYlGoKFVPPcicihTN1kkhLpYEWA
         uxezkmELgSNhoZrqqELo+rHP7BnPAXvZ8Qh+fVGghiZBhk1DgBsiysZqEbo1OlEzG6rg
         uqsBdKF2hqWESD0hJ8ldbFoNLbDcyDhoPZnKN68Gr+7WmkCRRib6kp5bOS5YToxzCtI1
         MHn1K0KaZjANhkpjE20tWRGnBD99++r5EwtvXYOc0t/yHls6Bks5V601pj+kapaopBpl
         uzYQ==
X-Received: by 10.180.221.133 with SMTP id qe5mr13674217wic.17.1407371078547;
        Wed, 06 Aug 2014 17:24:38 -0700 (PDT)
Received: from client.googlemail.com (HSI-KBW-046-005-203-106.hsi8.kabel-badenwuerttemberg.de. [46.5.203.106])
        by mx.google.com with ESMTPSA id ge8sm23243624wib.4.2014.08.06.17.24.36
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 06 Aug 2014 17:24:37 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <20140802002231.GD20040@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254941>

Hi Jeff,

Jeff King writes:
> On Tue, Jul 29, 2014 at 01:18:09AM +0200, Fabian Ruch wrote:
>> The options passed to `do_pick` determine whether the picked commit
>> will be rewritten or not. If the commit gets rewritten, because the
>> user requested to edit the commit message for instance, let
>> `pick_one` merely apply the changes introduced by the commit and do
>> not commit the resulting tree yet. If the commit is replayed as is,
>> leave it to `pick_one` to recreate the commit (possibly by
>> fast-forwarding the head). This makes it easier to combine git-commit
>> options like `--edit` and `--amend` in `do_pick` because
>> git-cherry-pick does not support `--amend`.
>>
>> In the case of `--edit`, do not `exit_with_patch` but assign
>> `rewrite` to pick the changes with `-n`. If the pick conflicts, no
>> commit is created which we would have to amend when continuing the
>> rebase. To complete the pick after the conflicts are resolved the
>> user just resumes with `git rebase --continue`.
> 
> Hmm. So does this mean the user will actually see a different state
> during such a conflict?
> 
> E.g., if I have instructions like:
> 
>   pick A
>   squash B
>   squash C
> 
> and there is a conflict picking C, then what state do I see? Right now I
> see a commit with the A+B squash prepared. But your description sounds
> to me like we would avoid the squash for "B", and the user would see a
> different state.

The squash state will not be different. squash sequences are still taken
care of one line after the other: committing A, committing A+B,
committing A+B+C. If there is a conflict picking C, HEAD will point to
A+B and the index will record the conflicting changes.

> However, I couldn't trigger that behavior in a few experiments. Am I
> misunderstanding, or is there some case where the user-visible state
> will be different?

The user-visible state will be different for rewords. For instance,
let's consider

    pick A
    reword B.

The verbose log used to show two commits for B (with ff disabled), one
after picking and one after editing. Now the log will show a single
commit in connection with 'reword B' which might be less confusing.

Thanks for raising your eyebrows. I noticed now that the last paragraph
is plainly wrong. The described amend situation did not arise "if the
pick conflicted" but "if the edited commit did not verify". There will
be no "after the conflicts are resolved" but the user can either commit
manually and circumvent log message verification if she knows what she's
doing, or provide a corrected log message in the editor launched by 'git
rebase --continue'. The _incomplete_ 'git commit --amend' tip which used
to be displayed after a failed verification hook could become
unnecessary and this would possibly spare us including correct GPG sign
options for instance.

However, this patch is mostly motivated by the unification of how
commits are rewritten. Before, rewords and squashes went about this
differently, now both fail with an uncommitted index if there are
conflicts or the log message is ill-formatted.

The log message must be corrected and the following bug, which was
noticed after PATCH v2, must be fixed.

    cat >.git/hooks/commit-msg <<-EOF
    #!/bin/sh
    exit 1
    EOF
    chmod +x .git/hooks/commit-msg
    test_must_fail env FAKE_LINES="reword 1" git rebase -i
    test_must_fail git rebase --continue
    # the last command succeeds because --continue does not verify

   Fabian

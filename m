From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] revert.c: defer writing CHERRY_PICK_HEAD till it is safe
 to do so
Date: Thu, 6 Oct 2011 13:33:23 -0400
Message-ID: <CAG+J_Dx0W0oRL-MkoZSGuOfmUNCqmMRUigmgND_0o7kbKppu1Q@mail.gmail.com>
References: <1317911641-47660-1-git-send-email-jaysoffian@gmail.com>
	<7vty7m12b2.fsf@alter.siamese.dyndns.org>
	<CAG+J_DxqpDAm-qPR-Udkr_b1gc=Y+LoKbsQdmiCi6ztNKz0_Mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, nicolas.dichtel@6wind.com,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 19:33:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBrp4-0007D1-JD
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 19:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965177Ab1JFRdZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 13:33:25 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:52765 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965106Ab1JFRdY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 13:33:24 -0400
Received: by yxl31 with SMTP id 31so2833520yxl.19
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 10:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=whpmRQLdt8ovitdfAFwOmXAVEVplGNrbVBJPhE6YOlU=;
        b=wiHZnlbHK0iZwfGhpCd+mhKnwVbtkXtmcgKcELLDeu1ZPwtxMPx3A9wIT48IxLWQ+E
         FYR6O4h+0BmG1+A+FYIR1SbJ637mMmcEca+xy6IcpGuC4GIYfpH2+/c/EBWGk9HoQp8F
         Z/L1HCfDO8IaUP1DJ214l8TGZvdw9Lx+tDK1o=
Received: by 10.236.183.170 with SMTP id q30mr5036238yhm.42.1317922403989;
 Thu, 06 Oct 2011 10:33:23 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Thu, 6 Oct 2011 10:33:23 -0700 (PDT)
In-Reply-To: <CAG+J_DxqpDAm-qPR-Udkr_b1gc=Y+LoKbsQdmiCi6ztNKz0_Mg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182998>

On Thu, Oct 6, 2011 at 1:28 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> On Thu, Oct 6, 2011 at 1:02 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> I think do_recursive_merge() would die() when the merge cannot even start
>> (i.e. the local changes after the cherry-pick exits are the ones from the
>> time before such a failed cherry-pick started), but I suspect that the
>> other codepath uses try_merge_command() to drive strategies other than
>> recursive and it does not die() there in such a case. Can you make sure
>> this patch is sufficient in such a case as well?
>
> It's wrong to write out CHERRY_PICK_HEAD if we couldn't start the
> merge, but using cherry-pick with a strategy other than recursive
> seems broken in that case in other ways as well:
>
> $ git cherry-pick --strategy=resolve side
> error: Untracked working tree file 'bar' would be overwritten by merge.
> error: could not apply a77535c9ac... bar
> hint: after resolving the conflicts, mark the corrected paths
> hint: with 'git add <paths>' or 'git rm <paths>'
> hint: and commit the result with 'git commit'
>
> The "hint" advice is completely wrong.

For that matter, I don't see how to distinguish "the merge did not
even start" from "the merge had conflicts" when using
try_merge_command(). In the former case we do NOT want
CHERRY_PICK_HEAD left behind (nor to print the wrong advice above),
while in the latter case we do.

j.

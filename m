Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BBDC433E0
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 01:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1B7520792
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 01:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="oxobjKiJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbgHEBh1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 21:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgHEBh0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 21:37:26 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A14C06174A
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 18:37:26 -0700 (PDT)
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
        s=default; t=1596591444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=BAmoUwaoe64BfNbhkVjgatAKchT/AeQpA+uOCa3um8o=;
        b=oxobjKiJDqwZFf8aZ5ZEiAhzCe6C8jiS2eAc72fA6PpWojiGrXZQIqz+qAT+OJXi1XiLk+
        3ojZob/1WHTX8OIqTfEnTIAMU6u9Vt34bHJIPW8i6j5V51rIONVBm3SPPeYHCYtofemBkg
        EYjx7Ve7XOHr5vRt0r4+YWFMXz3LOQw=
Content-Type: text/plain; charset=UTF-8
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH v2] apply: allow "new file" patches on i-t-a entries
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Raymond E. Pasco" <ray@ameretat.dev>
To:     "Junio C Hamano" <gitster@pobox.com>
Date:   Tue, 04 Aug 2020 20:32:48 -0400
Message-Id: <C4ON23BIKMVK.2ZESQJ1FB5PVA@ziyou.local>
In-Reply-To: <xmqqeeomq8dr.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue Aug 4, 2020 at 7:49 PM EDT, Junio C Hamano wrote:
> How exactly does "git add -p" fail for such a patch? What operation
> does it exactly want to do ("apply --cached"???) and is it "apply"
> that is wrong, or is it "git add -p" that fails to remove the i-t-a
> entry from the index before running "git apply" that is at fault?

Yes, "add -p" uses "apply --cached". I do believe this belongs in apply,
both because all "add -p" really does is assemble things to be fed to
apply and also for the more detailed reasons below.

The index and the filesystem are both able to represent "no file" and "a
file exists" states, but the index has an additional state (i-t-a) with
no direct representation in the worktree. By (correctly) emitting "new
file" patches when comparing a file to an i-t-a index entry, we are
setting down the rule that a "new file" patch is not merely the diff
between "no file" and "a file exists", but also the diff between i-t-a
and "a file exists".

Similarly, "deleted file" patches are the diff between "a file exists"
and "no file exists", but they are also the diff between i-t-a and "no
file exists" - if you add -N a file and then delete it from the
worktree, "deleted file" is what git diff (correctly) shows. As a
consequence of these rules, "new file" and "deleted file" diffs are now
the only diffs that validly apply to an i-t-a entry. So apply needs to
handle them (in "--cached" mode, anyway).

But the worktree lives in the filesystem, where there are no i-t-a
entries. So the question seems to me to be whether "no file" in the
worktree matches an i-t-a entry in the index for the purposes of "add
--index". I count a couple options here:

- Nothing on the filesystem can accurately match an i-t-a entry in the
  index, so all attempts at "apply --index" when there is an i-t-a in
  the index fail with "file: does not match index". "apply --cached",
  which "add -p" uses, applies only to the index and continues to work.
  I think I prefer this one; additionally, the comment in read-cache.c
  indicate that this is supposed to be the case already, so I just need
  to make sure this check is not skipped on "new file" patches.

- The current (as of this patch) behavior: a "new file" patch applies
  both to an i-t-a in the index, and to the lack of a file in the
  worktree. This may seem strange, but it may also seem strange that an
  identical new file patch, which can be applied either to just the
  worktree or just the index successfully, fails when applied to both at
  the same time with "apply --index". However, this is precisely what is
  done anyway by "apply --index" when there are no i-t-a entries
  involved, so I lean towards i-t-a entries never matching the worktree.

Patch for the first option in progress.

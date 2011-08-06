From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 00/48] Handling more corner cases in merge-recursive.c
Date: Sat, 6 Aug 2011 14:31:52 -0600
Message-ID: <CABPp-BERsAoL2eiTMiqDPx4EtZX599m+XOTH4VOu14-fZbR-Ew@mail.gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
	<7v4o1y81sv.fsf@alter.siamese.dyndns.org>
	<CABPp-BE=9r+upGUD45J7fPshqQE97UMZzaA+cu_WJ1A2p_Bigg@mail.gmail.com>
	<7vpqkl3sok.fsf@alter.siamese.dyndns.org>
	<CABPp-BFx38gLQDn0sccp74Z=RtEVzaxWiVqopxkWwXTSGuYxxw@mail.gmail.com>
	<7vr54z15dn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, jgfouca@sandia.gov
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 06 22:35:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qpnb5-0005ZW-RL
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 22:35:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754072Ab1HFUby (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 16:31:54 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63353 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753854Ab1HFUbx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 16:31:53 -0400
Received: by fxh19 with SMTP id 19so3960546fxh.19
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 13:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=r5DCieXLG2Tr180PWA7TgsyKoCvDhcpnrZDqbCwHmvY=;
        b=vOYZ2/W7o8K8nH3ud644TW8kAsgWStZzBq2h4zjz4kMVKdShT05YG+CuoLKhMImQXR
         +ib3fuHkIQxCmpyOF8FuVrTrCgUh5pwmsMiWdqzCh7cJ4onRGPmL9t+JA1uLHrdC8pGV
         eiQBWEneqnyLNHylM1mzyEtEmNWZXcsh6Vk38=
Received: by 10.223.91.147 with SMTP id n19mr4075352fam.53.1312662712376; Sat,
 06 Aug 2011 13:31:52 -0700 (PDT)
Received: by 10.223.109.198 with HTTP; Sat, 6 Aug 2011 13:31:52 -0700 (PDT)
In-Reply-To: <7vr54z15dn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178890>

On Fri, Aug 5, 2011 at 11:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
> But why do you care about the original index (i.e. the starting state of
> our side) in the first place? If your algorithm depends on the original
> index, wouldn't that mean you would screw up the same merge if the user
> merged branches in the opposite direction?

No, it does not mess up the same merge in the opposite direction.  The
code in question (with some local modifications) is

       if (mfi.clean && !df_conflict_remains &&
           sha_eq(mfi.sha, a_sha) && mfi.mode == a_mode) {
               output(o, 3, "Skipped %s (merged same as existing)", path);
               /*
                * The content merge resulted in the same file contents we
                * already had.  We can return early if those file contents
                * are recorded at the correct path (which may not be true
                * if the merge involves a rename).
                */
               if (was_tracked(&o->original_index, path)) {
                       add_cacheinfo(mfi.mode, mfi.sha, path,
                                     0 /*stage*/, 1 /*refresh*/, 0 /*options*/)
                       return mfi.clean;
               }
       } else
                output(o, 2, "Auto-merging %s", path);

And the merge is:
  BASE: original-path: v1
  HEAD: original-path: v2
  SIDE: renamed-path: v1

So, HEAD did have the correct contents that we wanted, as checked in
the first if.  However, we cannot bail early because those contents
were recorded at the wrong path.  Repeating the merge in the other
direction would simply show that we don't have the right contents
(a_sha != mfi.sha).  Only if we have both the right contents and have
it at the right path should we exit early.

If we use "&the_index" instead of "&o->original_index", which is what
my previous series essentially did, then we get the wrong answer about
whether the contents are recorded at the necessary path, i.e.
was_tracked() lies to us.


Now, your gut feel and question here does turn out to be
important...in a different case.  You'll note that I'm passing an
index to was_tracked(); that's because there is one case (the call to
was_tracked() from would_lose_untracked()) where it is important that
we use the index as modified by unpack_trees rather than the original
index and not doing so causes a bug depending on the direction things
are merged.  I added a big comment in the code about that one.

> I think the fact you have a path "two" at stage 0, combined with the two
> diffs you ran for rename detection between the common ancestor and two
> branches, should be enough to decide if one branch added the path or moved
> it from elsewhere (in which case the common ancestor would not have that
> path), or it kept the path at the original place (with or without content
> change), no?

You are correct.  I just need to reorder the patch series somewhat
(other patches added the passing of the relevant diff_filepair
information to merge_content, which is needed to do these checks you
suggest), and then I can change the was_tracked() call to instead
compare pathnames.

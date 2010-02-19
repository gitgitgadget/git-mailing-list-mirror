From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: RFD: best way to automatically rewrite a git DAG as a linear 
	history?
Date: Thu, 18 Feb 2010 22:13:45 -0500
Message-ID: <32541b131002181913t24989addr84b612787a2f8c48@mail.gmail.com>
References: <2cfc40321002171835j107d2cdcr5f7667d769bf391e@mail.gmail.com> 
	<20100218051129.GD10970@coredump.intra.peff.net> <2cfc40321002181704i73eb87demd03faaddf9bb108@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 04:14:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiJJw-0003BY-KU
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 04:14:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754191Ab0BSDOJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 22:14:09 -0500
Received: from mail-yx0-f200.google.com ([209.85.210.200]:33546 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754163Ab0BSDOI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 22:14:08 -0500
Received: by yxe38 with SMTP id 38so7095892yxe.4
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 19:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=xy72VVDHFy5y/L+o61NebbLIXLMphiDlB8teme4f5v0=;
        b=V3sECFu/Wg50IZSNY1GQ5mtl1tL2TnJVd2GEU1gCqGUH6idDfh/cxN9t86/jU8r57D
         Pv/9c+kgTOrd2jk4o97z5Y2FT2TNjKqj5pV8p5zfI7mjT0mENHPAifHO1LX7JR1kSdDn
         jYaEX09+YubGMSqeTH9XXFr8B+g68yqjKkWj8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=LO9iXPAJ+ckw3Mq5Lfb3NR+uManamR3clSSzSjPDxC0Tz7bmSvv6hI9vYcAuZgYO6E
         UVw23YVVRuqpMNBHlPGUoQxSMLrANtrhWmu/s0VQyust4itZqnoWZANkfzWusVxCzb2U
         kYjS66qvcVe3I0+HVRUpffPNGhl6mLDwi8vbA=
Received: by 10.150.209.11 with SMTP id h11mr2597213ybg.300.1266549245097; 
	Thu, 18 Feb 2010 19:14:05 -0800 (PST)
In-Reply-To: <2cfc40321002181704i73eb87demd03faaddf9bb108@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140402>

On Thu, Feb 18, 2010 at 8:04 PM, Jon Seymour <jon.seymour@gmail.com> wrote:
> Avery's script almost does what I need, except the rewritten diffs
> corresponding to the merge commits introduces unnecessary noise (from
> upstream deltas) in the series and potentially complicate eventual
> merges of the linear history back into the upstream.

You're never going to get the "linear" history merged back upstream
until you fix the inconsistencies.  At least, no sensible upstream
should accept the patches.

Using the linearization mechanism you propose, you end up producing a
false history: one in which, other than at certain checkpoints, the
code doesn't even work.  What's the point of such a history?  It
neither reflects the true development history (ie. pre-linearization)
nor a more useful, idealized version of history (ie. one that compiles
at every point and adds features in a rational order and is useful for
git bisect).

It doesn't even provide something useful for patch review, since half
your patches will have randomly-selected conflict resolutions (ie.
changes to unrelated code that never should have changed) thrown in.
You'd be better off reviewing patches from the original history, and
just ignoring merge commits, which is what 'git format-patch' or just
'git log -p' would do automatically.

The result is also still not suitable for submission upstream: the
sync points (where the files actually match what the developer had in
his tree) are the only places where the code is even likely to
compile, and yet they *also* include all the code brought in by prior
merges, which you already said include code that shouldn't go
upstream.

The linearization script I gave you at least has these interesting
characteristics:

- If the original history compiled at every point, then the linearized
history does too.

- It is an accurate representation of the successive states of the
tree experienced by the original developer.

- You can use 'git rebase' to incrementally rearrange and combine
patches until they make enough sense to submit upstream.

- It is easy to separate out merges (which usually don't need patch
review) from individual patches (which do).

- If some merges added useless code, you can remove them completely
with rebase by just removing a single patch from the list.

Of course, even with this script, it will still take work (rebasing)
to produce code that's polished and ready to go upstream.  But I'm not
sure there's a way to automate that without producing interim versions
that are much, much worse.

Have fun,

Avery

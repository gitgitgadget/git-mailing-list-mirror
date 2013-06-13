From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] am: handle stray $dotest directory case
Date: Fri, 14 Jun 2013 00:37:27 +0530
Message-ID: <CALkWK0kO=KY4=Y7ex47LJ2F0oEfF+R9g3REO7rddDLL4c8CuEw@mail.gmail.com>
References: <1371133031-28049-1-git-send-email-artagnon@gmail.com>
 <7v61xivsxh.fsf@alter.siamese.dyndns.org> <CALkWK0mUnNTfJQuGQAoMtnsOXvXU+z+W6D_MMuio1sq4vkucjA@mail.gmail.com>
 <7vmwqtua5r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 13 21:08:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnCsY-0007Sr-Q0
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 21:08:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757612Ab3FMTIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 15:08:09 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:63946 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756363Ab3FMTII (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 15:08:08 -0400
Received: by mail-ie0-f174.google.com with SMTP id 9so11851847iec.33
        for <git@vger.kernel.org>; Thu, 13 Jun 2013 12:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Bt0RvCk0i9/rzKNvRTg9DyJxKJu1/qV+AO/KK+hg2ec=;
        b=e36HGlvm+LL9U/An7NsZA2HceuJf+9ViLEPplAVqEuscK7eMlW+uw3WHcfsMDgaaSy
         tODXvZsJcYsHNs1s6vXHlHFQZ/xIBrIWm2kyEhMT82aKwG6Zj18MwhPU+x7MuQgRRpup
         6jevZUZ0UPnGfbL1axpSJoY8RNFM8RuZ8EzqzJ+SU+avu76Q88AHv6DfRp6qlVP3fzIk
         TFutH21xHdTbUTsMHIqbR3OW+FJ1sXZ0Dcd67uh7qD/EX4dNuBxo6hTXJL7gBTmLdhBK
         EyCGoWIzsIBxZOTiw2XnC6F17j6eJwyGIMoQ3DHTXHvLpfZkkX3Wzv6Gw27jr7B120ND
         h3qQ==
X-Received: by 10.50.79.231 with SMTP id m7mr997202igx.40.1371150487946; Thu,
 13 Jun 2013 12:08:07 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Thu, 13 Jun 2013 12:07:27 -0700 (PDT)
In-Reply-To: <7vmwqtua5r.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227774>

Junio C Hamano wrote:
> Hmph, when did ORIG_HEAD set, and what commit does it point at?

By some unrelated previous operation (eg. pull, rebase, merge).  The
point is that at any point in "normal operation", ORIG_HEAD exists,
and usually points to @~N, for some N.  If I rm .git/ORIG_HEAD by
hand, the am --abort obviously errors out:

  $ git am --abort
  fatal: Not a valid object name ORIG_HEAD
  fatal: ambiguous argument 'ORIG_HEAD': unknown revision or path not
in the working tree.
  Use '--' to separate paths from revisions, like this:
  'git <command> [<revision>...] -- [<file>...]'

> As "git am" reading from stdin, waiting, hasn't moved HEAD yet at
> all, I think two things need to happen to fix that:
>
>  (1) at around the call to check_patch_format and split_patches,
>      clear ORIG_HEAD (this may have to be done only !$rebasing,
>      though).
>
>  (2) safe_to_abort() should make sure ORIG_HEAD exists; otherwise it
>      is unsafe.
>
> But that is entirely an independent issue (I am going to agree with
> you in the end).

Exactly.  It might be nice to fix those two things (are there any
observed bugs?), but it is entirely orthogonal to our issue.

> That is a correct observation.  But it needed a bit of thinking to
> reach your conclusion that special casing this and handling --abort
> in a new different codepath is the right solution.

Yeah, the commit message is lacking.

> How would "am --skip", "am --resolved", or "am anothermbox" behave
> in this "we already have $dotest because the user started one
> session but killed it" case, which used to be covered by -d $dotest
> alone but now flows to the other side of the if/else/fi codepath?
> Do they need a similar treatment, or would they naturally error out
> as they should?

am --skip and am --resolved will error out, saying "Resolve operation
not in progress, we are not resuming".  The message needs to be
tweaked.

am anothermbox will work just fine, implicitly overwriting the
existing $dotest directory.  But yeah, we could explicitly remove the
directory and allow the mkdir -p to re-create it.

I'll probably work on these follow-ups in the morning.  Thanks for poking.

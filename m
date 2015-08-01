From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 0/2] bisect per-worktree
Date: Fri, 31 Jul 2015 22:12:51 -0700
Message-ID: <CAPc5daVnfit8pkjc2HCSn0erW-q++We8gx8tPsb_ptd5H+CpJg@mail.gmail.com>
References: <1438387012-29229-1-git-send-email-dturner@twopensource.com> <55BC4438.8060709@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Aug 01 07:13:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLP6i-00032E-BO
	for gcvg-git-2@plane.gmane.org; Sat, 01 Aug 2015 07:13:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbbHAFNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Aug 2015 01:13:12 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:33785 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999AbbHAFNL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Aug 2015 01:13:11 -0400
Received: by ioii16 with SMTP id i16so103728663ioi.0
        for <git@vger.kernel.org>; Fri, 31 Jul 2015 22:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=t5eQkw9yYLheaXMwnocSaq7QqdZtwWEd/LhmzAM9IRw=;
        b=lGU4RODgQrsbczCJT+YRwLepU3pheM+DFeUu65ywx20HjSpaqEilbRdSB9CbxBnIM2
         K41ZjZY7+0fCqaNakB3yGfjQa3JUiNPXP/9C/BQzfqDvItphCsYUkCYXVmAdgiLSXROj
         pVEnKx1KHqvqJNs98Z+lQG8u/MFOCI7G90yMgaSZZJAS5an8U9qDxfWW0XS6wgmrnvbc
         4D8EsYCY0tn26h431JTfBDkupLcbqpLfQ1uhLqgOislKBmSeiOlrHhAee4HxGO5XNCx1
         BOayIdkJ4C3qksJA78WCNEOeBKrA67/2CDAicDATvp36M6kKlsBik4nwiY2dH+RE/7pj
         bwig==
X-Received: by 10.107.15.226 with SMTP id 95mr11647455iop.44.1438405991048;
 Fri, 31 Jul 2015 22:13:11 -0700 (PDT)
Received: by 10.36.41.149 with HTTP; Fri, 31 Jul 2015 22:12:51 -0700 (PDT)
In-Reply-To: <55BC4438.8060709@alum.mit.edu>
X-Google-Sender-Auth: zXU6Qt99VbSjFCTMu5upa13oq2I
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275105>

On Fri, Jul 31, 2015 at 8:59 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>
> It seems to me that adding a new top-level "worktree-refs" directory is
> pretty traumatic. Lots of people and tools will have made the assumption
> that all "normal" references live under "refs/".
> ...
> It's all a bit frightening, frankly.

I actually feel the prospect of pluggable ref backend more frightening,
frankly ;-). These bisect refs are just like FETCH_HEAD and MERGE_HEAD,
not about the primary purpose of the "repository" to grow the history of refs
(branches), but about ephemeral pointers into the history used to help keep
track of what is being done in the worktree upstairs. There is no need for
these to be visible across worktrees. If we use the real refs that are grobal
in the repository (as opposed to per-worktree ones), we would hit the backend
databas with transactions to update these ephemeral things, which somehow
makes me feel stupid.

I wish we could just make refs/bisect/* (or whatever the current bisect
code uses) automatically per worktree. I know David dismissed it saying
that the current code is not set up to allow it easily, but is it
really a fundamental
limitation, or is it just a matter of coding a few more dozens of lines?

If we can keep using the same location under refs/ and transparently make
them appear per-worktree, "what is the name of the main one?", and "do we
even need to call the one and the only one 'main'?" will automatically
disappear.
Of course, "git bisect" and "gitk --bisect" does not have to change if
we go that
route.

And there will not be any backward compatibility worries. If you are not
using multiple worktrees, you will see them as refs/bisect/*, just at the
same location as you are familiar with.

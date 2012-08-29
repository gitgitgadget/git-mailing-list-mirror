From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/3] checkout: reorder option handling
Date: Wed, 29 Aug 2012 19:16:10 +0700
Message-ID: <CACsJy8Cjbg2tb_E+D7hMwPZNFWhvEF1eNpf5HUBzJnBoQQaMAg@mail.gmail.com>
References: <7vr4qroel6.fsf@alter.siamese.dyndns.org> <1346161748-25651-1-git-send-email-pclouds@gmail.com>
 <1346161748-25651-3-git-send-email-pclouds@gmail.com> <7vipc2zqxg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 29 14:17:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6hCf-000892-BF
	for gcvg-git-2@plane.gmane.org; Wed, 29 Aug 2012 14:17:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752979Ab2H2MQm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Aug 2012 08:16:42 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:49124 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752793Ab2H2MQl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2012 08:16:41 -0400
Received: by qaas11 with SMTP id s11so3439510qaa.19
        for <git@vger.kernel.org>; Wed, 29 Aug 2012 05:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ny+MBI3L7mh5dxhAcaLe5bqSKT5UASTkYboie+7PG9I=;
        b=CQW2/I/F0eByr0N79p07YDQ7/9nqNo+DeT8EAUP0kcej+J1ZFN/mDayhhK9w1kkDIh
         H0GJ76g9FaNxHhVR3GhU/BOdbg8jGVKCOP6g6azLNAXIHlPpFsZpjLXgRIT3QxGzwJHp
         bP9QN/KxlWwLYzGdWq2unlRU6YGA8CR8HXHZF8Feo0sqh4p0yICxpVafp+reNq9x95CD
         bBMgUFegQsxdBewG3+z0n980zlEMFIaSpfSJIcazm8eqcFPxiOnteVg95nRwGl+bnPYm
         vX426lQnk6P+X3EshAF4kHqRbxF8R0+vqmzJAm+IV+T8LSOQUk4oiH0kiAuulfPq7h5O
         nljg==
Received: by 10.224.220.138 with SMTP id hy10mr3172754qab.21.1346242601029;
 Wed, 29 Aug 2012 05:16:41 -0700 (PDT)
Received: by 10.49.4.6 with HTTP; Wed, 29 Aug 2012 05:16:10 -0700 (PDT)
In-Reply-To: <7vipc2zqxg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204477>

On Wed, Aug 29, 2012 at 3:45 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> +     /* Easy mode-independent incompatible checks */
>>       if (opts.force_detach && (opts.new_branch || opts.new_orphan_branch))
>>               die(_("--detach cannot be used with -b/-B/--orphan"));
>
> Did you catch "--detach -B" combination without checking new_branch_force?

I did not. Will move this check further down once opts.new_branch is final.

>>       if (opts.force_detach && 0 < opts.track)
>>               die(_("--detach cannot be used with -t"));
>> +     if (opts.force && opts.merge)
>> +             die(_("git checkout: -f and -m are incompatible"));
>> +
>> +     if (conflict_style) {
>> +             opts.merge = 1; /* implied */
>> +             git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
>> +     }
>
> "checkout --conflict=diff3 -f <branch>" would imply combination of
> "-m" and "-f", which is supposed to be forbidden in the previous
> check, no?

Yep. That last "if" must be moved up.

> I very much like the idea of separating things in phases like your
> proposed log message explains.  But I wonder if the order should be
> to do dwimming and parameter canonicalization first, then decide the
> mode (these might have to be swapped, as the same parameter may dwim
> down to different things depending on the mode), and finally check
> for sanity before performing.

I do a few sanity checks after the mode has been decided and obviously
missed some as you pointed out above. Will move them all down. So
parameter canonicalization, dwim, then separate code paths for each
mode, which includes sanity checks.

> To avoid confusion, it also might not be a bad idea to remove
> new_branch_force and new_orphan_branch from the structure and
> introduce "enum branch_creation_type" or something, and always have
> the new branch name in "new_branch" field (this needs to get various
> pointers into opts out of the parseopt options[] array; parse into
> separate variables and decide what to put in "struct checkout_opts"),
> independent from how that branch is going to be created (either -b,
> -B, or --orphan).

OK
-- 
Duy

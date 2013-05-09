From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/4] get_packed_refs: reload packed-refs file when it changes
Date: Thu, 9 May 2013 15:18:51 -0400
Message-ID: <CAPig+cSOryztWJBXJErQv-i7L863vOmtUBtm0_u-OcNZxQ5Q7w@mail.gmail.com>
References: <20130507023610.GA22053@sigill.intra.peff.net>
	<20130507024313.GC22940@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 09 21:18:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaWMj-0004U7-6x
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 21:18:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844Ab3EITSx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 15:18:53 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:48685 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419Ab3EITSw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 15:18:52 -0400
Received: by mail-lb0-f182.google.com with SMTP id r11so3457549lbv.13
        for <git@vger.kernel.org>; Thu, 09 May 2013 12:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=OLrIto9oaDSnsK8efg/VksMPm4XitV6tiyaG3OuSqU0=;
        b=z07iy8housPagaBthH84uryrkpVnITTemfyIrLCfPAaUDuzt1Jkt7lWyPHXnKX67+o
         VamlD+b3hpG6BUgpsKUZvIvxE+jwqKuOAr3GbXyPoT364Whys073BKo8H0RLMysdXkVC
         QfCUyJdvxZyE7qZryRomeqRg4ZONYcU6a0xUZI2o3ML+3GGWMRgbTyD3D5hEi7rTCPRT
         kfh0bGN1tIa9kWLAE4zqNDDCPu6B9UbRNjH138ZZL91KNCU0Uxo6mYlcxR2esMTXt8YF
         EAQ819WjAnrnt3EXirwHnhZOX/l1boqUQjEIU2Z1pY0f2x07vGSUrepSdk/obeS3aFwm
         z0EA==
X-Received: by 10.152.26.225 with SMTP id o1mr6133666lag.43.1368127131239;
 Thu, 09 May 2013 12:18:51 -0700 (PDT)
Received: by 10.114.181.3 with HTTP; Thu, 9 May 2013 12:18:51 -0700 (PDT)
In-Reply-To: <20130507024313.GC22940@sigill.intra.peff.net>
X-Google-Sender-Auth: refBfWmKQGPqW_fqaTkLo835oVU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223773>

On Mon, May 6, 2013 at 10:43 PM, Jeff King <peff@peff.net> wrote:
> Once we read the packed-refs file into memory, we cache it
> to save work on future ref lookups. However, our cache may
> be out of date with respect to what is on disk if another
> process is simultaneously packing the refs. Normally it
> is acceptable for us to be a little out of date, since there
> is no guarantee whether we read the file before or after the
> simultaneous update. However, there is an important special
> case: our packed-refs file must be up to date with respect
> to any loose refs we read. Otherwise, we risk the following
> race condition:
>
>   0. There exists a loose ref refs/heads/master.
>
>   1. Process A starts and looks up the ref "master". It
>      first checks $GIT_DIR/master, which does not exist. It
>      then loads (and caches) the packed-refs file to see if
>      "master" exists in it, which it does not.
>
>   2. Meanwhile, process B runs "pack-refs --all --prune". It
>      creates a new packed-refs file which contains
>      refs/heads/master, and removes the loose copy at
>      $GIT_DIR/refs/heads/master.
>
>   3. Process A continues its lookup, and eventually tries
>      $GIT_DIR/refs/heads/master.  It sees that the loose ref
>      is missing, and falls back to the packed-refs file. But
>      it examines its cached version, which does not have
>      refs/heads/master. After trying a few other prefixes,
>      it reports master as a non-existent ref.
>
> There are many variants (e.g., step 1 may involve process A
> looking up another ref entirely, so even a fully qualified
> refname can fail). One of the most interesting ones is if
> "refs/heads/master" is already packed. In that case process
> A will not see it as missing, but rather will report
> whatever value happened to be in the packed-refs file before
> process B repacked (which might be an arbitrarily old
> value).
>
> We can fix this by making sure we reload the packed-refs
> file from disk after looking at any loose refs. That's
> unacceptably slow, so we can check it's stat()-validity as a

s/it's/its/

> proxy, and read it only when it appears to have changed.
>
> Reading the packed-refs file after performing any loose-ref
> system calls is sufficient because we know the ordering of
> the pack-refs process: it always makes sure the newly
> written packed-refs file is installed into place before
> pruning any loose refs. As long as those operations by B
> appear in their executed order to process A, by the time A
> sees the missing loose ref, the new packed-refs file must be
> in place.
>
> Signed-off-by: Jeff King <peff@peff.net>

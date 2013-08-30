From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] has_sha1_file: re-check pack directory before giving up
Date: Thu, 29 Aug 2013 21:40:32 -0400
Message-ID: <CAPig+cQnD3bUA5qdvMGCLuC3f0-+EcSbHrnqxBqEhaYRX3wDxQ@mail.gmail.com>
References: <20130830011052.GA21895@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 30 03:40:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFDhW-00026j-Un
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 03:40:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754240Ab3H3Bke (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 21:40:34 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:38314 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754182Ab3H3Bkd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 21:40:33 -0400
Received: by mail-la0-f45.google.com with SMTP id eh20so1007969lab.4
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 18:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=+EO/iyT7mwq/pE0HJtFs+x/25MJpfpienZ4OrrXknn0=;
        b=BbXs/VnMnEdLgT4JA+G1s4f6O6gaDrQ6IqwtQtSZKfXTm47CcLckDDY374yxGOj8G3
         SpqsVSTyMJI5kYfr2lskytv6lZT6gyegxmxTkyGY6M9kMKfKmnXSzGP5ACf65q2Yt8bl
         eUNsPt65iaCQAgYcRxzJpPGlS2IllS4JSco6P+o/iwpPX9GUl6XXy1Z6vi6CRu5Ik6D3
         i2CnxirzhDwIqsfcCqgRClVB7mpDQmLTDquDlnrqtXZWRHZ8NwsKdCbdAjF4RTXj9RMr
         8me+UTzNtgmQ9tI78MT6DPEcJQ3qOSeKR8EZ1uJ9f0FHlsQTqO0CSoeho1l4iJsDA/Ny
         Gr2w==
X-Received: by 10.152.8.115 with SMTP id q19mr5577720laa.16.1377826832245;
 Thu, 29 Aug 2013 18:40:32 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Thu, 29 Aug 2013 18:40:32 -0700 (PDT)
In-Reply-To: <20130830011052.GA21895@sigill.intra.peff.net>
X-Google-Sender-Auth: vFosixrNz3Pws6IeQc-sCjadzYU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233386>

On Thu, Aug 29, 2013 at 9:10 PM, Jeff King <peff@peff.net> wrote:
> When we read a sha1 file, we first look for a packed
> version, then a loose version, and then re-check the pack
> directory again before concluding that we cannot find it.
> This lets us handle a process that is writing to the
> repository simultaneously (e.g., receive-pack writing a new
> pack followed by a ref update, or git-repack packing
> existing loose objects into a new pack).
>
> However, we do not do the same trick with has_sha1_file; we
> only check the packed objects once, followed by loose
> objects. This means that we might incorrectly report that we
> do not have an object, even though we could find it if we
> simply re-checked the pack directory.
>
> By itself, this is usually not a big deal. The other process
> is running simultaneously, so we may run has_sha1_file
> before it writes, anyway. It is a race whether we see the
> object or not.  However, we may also see other things
> the writing process has done (like updating refs); and in
> that case, we must be able to also see the new objects.
>
> For example, imagine we are doing a for_each_ref iteration,
> and somebody simultaneously pushes. Receive-pack may write
> the pack and update a ref after we have examined the
> objects/pack directory, but before the iteration gets to the
> updated ref. When we do finally see the updated ref,
> for_each_ref will call has_sha1_file to check whether the
> ref is broken. If has_sha1_file returns the wrong answer, we
> erroneously will think that the ref is broken.
>
> In the case of git-fsck, which uses the
> DO_FOR_EACH_INCLUDE_BROKEN flag, this will cause us to
> erroneously complain that the ref points to an invalid
> object. But for git-repack, which does not use that flag, we
> will skip the ref completely! So not only will we fail to
> process the new objects that the ref points to (which is
> acceptabale, since the processes are running simultaneously,

s/acceptabale/acceptable/

> and we might well do our whole repack before the other
> process updates the ref), but we will not see the ref at
> all. Its old objects may be omitted from the pack (and even
> lost, if --unpack-unreachable is used with an expiration
> time).
>
> There's no test included here, because the success case is
> two processes running simultaneously forever. But you can
> replicate the issue with:
>
>   # base.sh
>   # run this in one terminal; it creates and pushes
>   # repeatedly to a repository
>   git init parent &&
>   (cd parent &&
>
>     # create a base commit that will trigger us looking at
>     # the objects/pack directory before we hit the updated ref
>     echo content >file &&
>     git add file &&
>     git commit -m base &&
>
>     # set the unpack limit abnormally low, which
>     # lets us simulate full-size pushes using tiny ones
>     git config receive.unpackLimit 1
>   ) &&
>   git clone parent child &&
>   cd child &&
>   n=0 &&
>   while true; do
>     echo $n >file && git add file && git commit -m $n &&
>     git push origin HEAD:refs/remotes/child/master &&
>     n=$(($n + 1))
>   done
>
>   # fsck.sh
>   # now run this simultaneously in another terminal; it
>   # repeatedly fscks, looking for us to consider the
>   # newly-pushed ref broken.
>   cd parent &&
>   while true; do
>     broken=`git fsck 2>&1 | grep remotes/child`
>     if test -n "$broken"; then
>       echo $broken
>       exit 1
>     fi
>   done
>
> Without this patch, the fsck loop fails within a few seconds
> (and almost instantly if the test repository actually has a
> large number of refs). With it, the two can run
> indefinitely.
>
> Signed-off-by: Jeff King <peff@peff.net>

From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] diff-lib.c: adjust position of i-t-a entries in diff
Date: Tue, 24 Mar 2015 08:15:50 +0700
Message-ID: <CACsJy8BczCNxm3WHK1gtkXiZCbDkFD-67oOMR+eK8uwOBfQXuw@mail.gmail.com>
References: <1425910445-27383-2-git-send-email-pclouds@gmail.com>
 <1426514206-30949-1-git-send-email-pclouds@gmail.com> <5506F3A9.1020704@drmicha.warpmail.net>
 <xmqqa8zdrkpy.fsf@gitster.dls.corp.google.com> <20150317140704.GA7248@lanh>
 <xmqq1tknpkwd.fsf@gitster.dls.corp.google.com> <CACsJy8Beoz=qcHrOG=akCR+gOQRjBcsQHaXdL_=PW70BOf4q3g@mail.gmail.com>
 <xmqqtwxikpz6.fsf@gitster.dls.corp.google.com> <xmqqlhitle5w.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 02:16:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaDSE-0001oI-Ka
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 02:16:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752211AbbCXBQW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2015 21:16:22 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:33686 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbbCXBQV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2015 21:16:21 -0400
Received: by iecvj10 with SMTP id vj10so49808297iec.0
        for <git@vger.kernel.org>; Mon, 23 Mar 2015 18:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=XKkhAGgL1/7RlZ8t7+kba428QLH/8jsQDw6Z/XUylOE=;
        b=INjzvcrn9ThuXD7zB/lGRdNYlmCn2cCdCGghSOL9EhSo+XaWdEIi2hbJhnUZGJaeIV
         JU/DHHmUo5VGlX815IHL4iRuDDKtQaJ/6wnWxw2uH+GebZZMutfunbEyW73D2YhzwohP
         0l3T6j2ylaT6z0iErefLvK5jNvkYuwnvobs9nYAXr1KrGKk4CG/TVeHIgd5sGt2OTUfY
         +tX+tECYVNujSodfO16Cxg1sHAI6Bz8BKZxcq8R0I/w8izjG6+L3esjkZJKktys6kCWM
         8brEYoI+FZoLs+cxVTBV8F2Am9TQVgTO+Ht39Vw8ABLCBN0u9WS51XErxYzL0NUwqulV
         2+QA==
X-Received: by 10.50.66.243 with SMTP id i19mr18555868igt.7.1427159780507;
 Mon, 23 Mar 2015 18:16:20 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Mon, 23 Mar 2015 18:15:50 -0700 (PDT)
In-Reply-To: <xmqqlhitle5w.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266171>

On Thu, Mar 19, 2015 at 1:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Ah, wait.
>>
>> I suspect that it all cancels out.
>> ...
>> Now, as you mentioned, there _may_ be codepaths that uses the same
>> definition of "what's in the index" as what diff-cache used to take
>> before your patches, and they may be broken by removing the
>> invalidation.  If we find such codepaths, we should treat their old
>> behaviour as buggy and fix them, instead of reintroducing the
>> invalidation and keep their current behaviour, as the new world
>> order is "i-t-a entries in the index does not yet exist."
>
> One potential negative consequence of the new world order I can
> immediately think of is this.  In many operations, we try to be
> lenient to changes in the working tree as long as the index is
> clean.  "read-tree -m" is the most visible one, where we require
> that the index and HEAD matches while allowing changes to working
> tree paths as long as they do not interfere with the paths that are
> involved in the merge.  We need to make sure that the path dir/bar
> added by "add -N dir/bar", which in the new world order does not
> count as "index is not clean and there is a difference from HEAD",
> (1) does not interfere with the mergy operation that wants to touch
> dir (which _could_ even be expected to be a file) or dir/bar, and
> (2) is not lost because the mergy operation wants to touch dir or
> dir/bar, for example.

"read-tree -m" does not invoke diff, does it? If I went with my
previous approach (modifying unpack-trees to ignore i-t-a entries)
then this could be a problem, but because unpack-trees is untouched,
merge operations should not be impacted by this patch. Even if some
other command does "diff --cached" first to abort early, if "diff
--cached" fails to report "HEAD and index are different" as you
described, I would expect unpack-trees to be able to deal with it
anyway.

PS. Sorry for the late response, busy fighting the evil last weekend.
I blame Steam on Linux.
-- 
Duy

From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: RFC/Pull Request: Refs db backend
Date: Tue, 23 Jun 2015 20:10:03 +0700
Message-ID: <CACsJy8B=jthxn_E-zWnDfua29FGGgz221N-cLw=NxeVOKadUxA@mail.gmail.com>
References: <1435020656.28466.8.camel@twopensource.com> <20150623114716.GC12518@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Turner <dturner@twopensource.com>,
	git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 23 15:10:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7NyI-000652-TP
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 15:10:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753802AbbFWNKe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 09:10:34 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:34085 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752368AbbFWNKd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 09:10:33 -0400
Received: by iebmu5 with SMTP id mu5so11075089ieb.1
        for <git@vger.kernel.org>; Tue, 23 Jun 2015 06:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=P8Nbo0WGAFgw3Ru27Ao7zpHcfKXgskSv11nshRtDQaM=;
        b=XUAUUlYOU0W9LgdrxDHrHg2QkL6Q0f6I5yR34uNtDcD1dGv4Zh0MhyOb+R0VtrChrg
         Wt/1iCEHnQ9GUZM+gd79w3oVWHd+9TO6P67lnbxz59zDkvfjIL0WbvMiWhLq/oJ5297j
         29GTY2AHYMyt8zulgr4V2PYC+LirMSbwAumuKmADG6FvnaY7m7S2fqJJZZ3r8H48uWnw
         qelICq2kS7VACDvlj6pK8rQ3jK1XE4OtjrWQnRtK9+9kooPW/ztZiyujcIgiseEMyZDy
         5lKtUJxJ0ah+w0tvAnHlo9s4K+OY/xL0T7fRTxu6gCXdiQ6OpWCOSLuya91WthY8NRoB
         Y5lQ==
X-Received: by 10.107.47.224 with SMTP id v93mr45458127iov.86.1435065032586;
 Tue, 23 Jun 2015 06:10:32 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Tue, 23 Jun 2015 06:10:03 -0700 (PDT)
In-Reply-To: <20150623114716.GC12518@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272456>

On Tue, Jun 23, 2015 at 6:47 PM, Jeff King <peff@peff.net> wrote:
> I was thinking of actually moving to a log-structured ref storage.
> Something like:
>
>   - any ref write puts a line at the end of a single logfile that
>     contains the ref name, along with the normal reflog data
>
>   - the logfile is the source of truth for the ref state. If you want to
>     know the value of any ref, you can read it backwards to find the
>     last entry for the ref. Everything else is an optimization.
>
>     Let's call the number of refs N, and the number of ref updates in
>     the log U.
>
>   - we keep a key/value index mapping the name of any branch that exists
>     to the byte offset of its entry in the logfile. This would probably

One key/value mapping per branch, pointing to the latest reflog entry,
or one key/valye mapping for each reflog entry?

>     be in some binary key/value store (like LMDB). Without this,
>     resolving a ref is O(U), which is horrible. With it, it should be
>     O(1) or O(lg N), depending on the index data structure.

I'm thinking of the user with small or medium repos, in terms of refs,
who does not want an extra dependency. If we store one mapping per
branch, then the size of this mapping is small enough that the index
in a text file is ok. If we also store the offset to the previous
reflog entry of the same branch in the current reflog entry, like a
back pointer, then we could jump back faster.

Or do you have something else in mind? Current reflog structure won't
work because I think you bring back the reflog graveyard with this,
and I don't want to lose that

>   - the index can also contain other optimizations. E.g., rather than
>     point to the entry in the logfile, it can include the sha1 directly
>     (to avoid an extra level of indirection). It may want to include the
>     "peeled" value, as the current packed-refs file does.
>
>   - Reading all of the reflogs (e.g., for repacking) is O(U), just like
>     it is today. Except the storage for the logfile is a lot more
>     compact than what we store today, with one reflog per file.
>
>   - Reading a single reflog is _also_ O(U), which is not as good as
>     today. But if each log entry contains a byte offset of the previous
>     entry, you can follow the chain (it is still slightly worse, because
>     you are jumping all over the file, rather than reading a compact set
>     of lines).
>
>   - Pruning the reflog entries from the logfile requires rewriting the
>     whole thing. That's similar to today, where we rewrite each of the
>     reflog files.
-- 
Duy

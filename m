From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 2/2] builtin-remote: make rm operation safer in mirrored 
	repository
Date: Wed, 4 Feb 2009 10:56:06 -0500
Message-ID: <76718490902040756m1f5c6f37o45865c51ad1a2e6d@mail.gmail.com>
References: <76718490902030638y36299191i1fcc2ab8646b9593@mail.gmail.com>
	 <1233683473-87893-2-git-send-email-jaysoffian@gmail.com>
	 <20090204154227.GE6896@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 04 16:57:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUk8E-0003QD-V4
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 16:57:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753125AbZBDP4J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 10:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751920AbZBDP4I
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 10:56:08 -0500
Received: from rv-out-0506.google.com ([209.85.198.237]:18859 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269AbZBDP4H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 10:56:07 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2615092rvb.1
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 07:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8pNfldNXCQlF2V5k166Kn2PJW052XzUzarpNPsS/Kbw=;
        b=HYGX8Bogm/Q9gWmmycuW2Z2bqRc8Gzu6yo4OGstp7cyRqplzstz7qUKfFjzOskQz4M
         kpFo6kbRLQYdbOApVincKZ1M/P28QMdpVvNA8uBkJpm64PSx3qDyYsNGNQAoHPDet5dr
         f3tosHUxz4JV6/Urw8bf60cZtE8KNlUet0PGk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=EdrwiHateCjPE8XnG+GG6Bht1rm0T1mSJ0krKn+LwD0IWJqrsd1e0eoIbQ9enjv0p8
         iZ5jxun4qqkROwzoMeibev1EyNSdPK1K5WHN7qoOiydUSZABz3QXz+i00WMU/xHCI3ae
         1NlWmse7AAVUl5Hq52wLA4ii+ed1oUQsPuxKQ=
Received: by 10.140.249.20 with SMTP id w20mr271719rvh.4.1233762966391; Wed, 
	04 Feb 2009 07:56:06 -0800 (PST)
In-Reply-To: <20090204154227.GE6896@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108386>

On Wed, Feb 4, 2009 at 10:42 AM, Jeff King <peff@peff.net> wrote:
>> +     /* don't delete non-remote branches */
>> +     if (prefixcmp(refname, "refs/remotes")) {
>> +             if (!prefixcmp(refname, "refs/heads/"))
>> +                     string_list_append(abbrev_branch(refname),
>> +                                        branches->skipped);
>> +             return 0;
>> +     }
>
> Why does this version introduce the "only skip refs/heads/" check?
> Shouldn't we also protect other random refs (or if not, shouldn't the
> commit message explain why not)?

Note that we do protect refs, but we only emit messages about those
refs which are obviously branches. Frankly, I wasn't sure what other
kinds of refs there might be, so wasn't sure what an appropriate
message is for anything other than those under refs/heads.

In particular though, I noticed that w/o this check, I was emitting an
incorrect message about anything under refs/tags. I thought about
saying "and you can clean up these ignored tags like so", but that is
likely to emit a huge number of messages, so I thought it best just to
silently ignore non-remote non-branch refs. Perhaps I should better
explain that in a code comment.

Alternately, it could do something like:

Note: A non-remote branch was not removed; to delete it use:
   git branch -d ...

Note: Tags were not removed, to delete them use:
   git tag -d ...

Note: Some refs were ignored:
   refs/whoknows/whatthisis
   refs/whoknows/whatthiscouldbe

But that's getting a little insane me thinks.

j.

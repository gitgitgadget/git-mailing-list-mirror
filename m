From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 3/3] cat-file: add --follow-symlinks to --batch
Date: Tue, 12 May 2015 16:02:11 -0700
Message-ID: <xmqq617xe6x8.fsf@gitster.dls.corp.google.com>
References: <1431384645-17276-1-git-send-email-dturner@twopensource.com>
	<1431384645-17276-4-git-send-email-dturner@twopensource.com>
	<xmqqoalpzn3s.fsf@gitster.dls.corp.google.com>
	<1431455779.16652.20.camel@ubuntu>
	<xmqqk2wdzlfm.fsf@gitster.dls.corp.google.com>
	<1431456922.16652.26.camel@ubuntu>
	<xmqqlhgtftw0.fsf@gitster.dls.corp.google.com>
	<xmqqd225fsw8.fsf@gitster.dls.corp.google.com>
	<1431470204.16652.52.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed May 13 01:02:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsJC4-0005PB-5Y
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 01:02:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964927AbbELXCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 19:02:15 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:34285 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964914AbbELXCN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 19:02:13 -0400
Received: by iecmd7 with SMTP id md7so16261205iec.1
        for <git@vger.kernel.org>; Tue, 12 May 2015 16:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=cTvyuXlc0aPDNuqQoYmAhitYZXE2XnVbtX1yfuZXhvw=;
        b=ZqDEM7oSXYcmrphgL8Gllff8Qy5i1au9iRLRSzdiMAWSVjru2C46vGoKSDiQwQ420O
         XdMyd6fI52LnCsqeMba+TvLv6UmI2e0LnkfYD0KNzdieB5LjEpHWtVCJ2CxJJHLbyY3I
         7drHo1P6odpWFKyE2x6Xm/mC+cMgXbPsbQVs6sD47YjLxJBYwfgnUHq2a+BFCg2q3TAc
         5dAuVyAAEmoHgxK5gWDHhu4u85LmrlQX5RpGa2eDlKXpoRNa9QuHHEdq/wNr35VkKFIj
         zEOYLx4W9S8hsXEEjHBp+sv2kVwWxC7e/Gt0SlQq3Wd3LWd/O8mTPeOl4rndOOR2dOyj
         JWYw==
X-Received: by 10.50.66.172 with SMTP id g12mr6947095igt.34.1431471733258;
        Tue, 12 May 2015 16:02:13 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3cfa:54ee:8e48:89ad])
        by mx.google.com with ESMTPSA id rj5sm2244338igc.2.2015.05.12.16.02.12
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 May 2015 16:02:12 -0700 (PDT)
In-Reply-To: <1431470204.16652.52.camel@ubuntu> (David Turner's message of
	"Tue, 12 May 2015 18:36:44 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268902>

David Turner <dturner@twopensource.com> writes:

> On Tue, 2015-05-12 at 13:22 -0700, Junio C Hamano wrote:
>
>> Are there other cases?  The only other case I think of is when the
>> link resolves cleanly inside the tree, which you already handle.

Funny double-inclusion ;-)

> While updating the tests, I noticed another two cases:
> 1. HEAD:broken-link/file
>
> I am inclined to describe this as "dangling" as well.  (It is not useful
> to tell users that "file" is the remaining bit to be resolved, because
> due to chains of symlinks, users have no idea what file would be
> relative to).  I think the filesystem returns ENOENT in the equivalent
> case.
>
> 2. HEAD:link-to-file/file
>
> This should be "notdir", I think, in that it is a distinct way of
> failing that the user might care to know. The filesystem returns ENOTDIR
> in the equivalent case.

Thanks.

> In addition, I would like to have the format for the dangling, loop, and
> notdir cases match the missing case.  In other words, "HEAD:link
> missing", "HEAD:link dangling", etc.  Users already need to parse the
> missing case, so we might as well make the others match.

Interesting to see our opinions differ here, especially because the
previous suggestion was coming from "users already need to parse the
'symlink' case, so we might as well make the others match" ;-).

Between 'missing' and 'symlink', the latter is richer in information
and easier to parse, I would have thought.

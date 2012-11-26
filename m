From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] diff: Fixes shortstat number of files
Date: Mon, 26 Nov 2012 10:10:41 +0100
Message-ID: <CALWbr2z+9fJGg34q7zp3knZVWgaTwtvzFBvFHRSmXfH+hc-jNw@mail.gmail.com>
References: <1353533210-29684-1-git-send-email-apelisse@gmail.com>
	<7vhaodxctq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 10:10:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcuiQ-0001SX-GY
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 10:10:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754461Ab2KZJKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 04:10:42 -0500
Received: from mail-qa0-f46.google.com ([209.85.216.46]:34298 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753169Ab2KZJKl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 04:10:41 -0500
Received: by mail-qa0-f46.google.com with SMTP id c11so2638319qad.19
        for <git@vger.kernel.org>; Mon, 26 Nov 2012 01:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=lFR9E9xppAmOOImrMto58C9xhsr1AqASyWKkIl/uw44=;
        b=GHkPYYagyNNwW3jlhjDH3IV/OS73i9JkB3fOenoX0E3ynLNAdMwLtGK90wG38aR22m
         21RORBV5i/HoHhg0SieYGU/P4b6iy38ly27tgZU8gJEAxbiHX+ErphUbH0o9crhyCcwi
         8ukv4IB40UOnnHDR3aMK6wxs5k26rx0PrsoCqKKLKv2P2MtzkE07Tg2IdEWJ2GKaNzeN
         w/FekdOUYnWUAIMBGHZ9GAnwYijilSW4HQBiPm1YHQIpSl3K+EEFsIpJz61TKG5Xkg42
         L8tvrgCaK655inoCR9HZyB1aqGAaMcdRTLQZU3mnP/cXs8/ecU4gF6pnsEsXAnHaPavr
         Z7ww==
Received: by 10.49.75.226 with SMTP id f2mr4674298qew.43.1353921041250; Mon,
 26 Nov 2012 01:10:41 -0800 (PST)
Received: by 10.49.121.36 with HTTP; Mon, 26 Nov 2012 01:10:41 -0800 (PST)
In-Reply-To: <7vhaodxctq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210426>

Indeed stat seems to be broken on master by commit 74faaa16 from Linus Torvalds

There are three separated issues here:
 - unmerged files are marked as "interesting" in stat and probably
shouldn't, with some patch like this:

        data->is_interesting = p->status != 0;

        if (!one || !two) {
                data->is_unmerged = 1;
+               data->is_interesting = 0;
                return;
        }

By the way, I don't get the point of this code then:

        else if (data->files[i]->is_unmerged) {
            fprintf(options->file, "%s", line_prefix);
            show_name(options->file, prefix, name, len);
            fprintf(options->file, " Unmerged\n");
            continue;
        }

and

        if (file->is_unmerged) {
            /* "Unmerged" is 8 characters */
            bin_width = bin_width < 8 ? 8 : bin_width;
            continue;
        }

Are we ever supposed to print that ? I feel like it could be removed.

 - Unmerged files are not filtered out in shortstat, thus counted
twice (addressed by the patch)
 - no file has ever been filtered out of numstat, and probably should
the way it's done in stat. That is with something like this:

        if (!data->files[i]->is_interesting &&
             (added + deleted == 0)) {
            continue;
        }


Cheers,
Antoine Pelisse


---------- Forwarded message ----------
From: Junio C Hamano <gitster@pobox.com>
Date: Mon, Nov 26, 2012 at 4:28 AM
Subject: Re: [PATCH] diff: Fixes shortstat number of files
To: Antoine Pelisse <apelisse@gmail.com>
Cc: git@vger.kernel.org


Antoine Pelisse <apelisse@gmail.com> writes:

> Subject: Re: [PATCH] diff: Fixes shortstat number of files

Please replace "Fixes" with "Fix at least (because our log messages
are written as if a patch is giving an order to the codebase, iow,
in imperative mood), but we would prefer to see a concrete
description on what is fixed, when we can.  And in this case, I
think we can, perhaps:

    diff: do not count unmerged paths twice in --shortstat/--numstat

or something.

> There is a discrepancy between the last line of `git diff --stat`
> and `git diff --shortstat` in case of a merge.
> The unmerged files are actually counted twice, thus doubling the
> value of "file changed".

I think the current 'master' and upward is broken with respect to
this; I am consistently getting two entries for unmerged paths
across --stat, --shortstat and --numstat options (iow, not just
shortstat and numstat but the '--stat' seems to be broken as well).

Thanks.

From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Borrowing objects from nearby repositories
Date: Mon, 24 Mar 2014 22:21:03 +0100
Message-ID: <CACBZZX5teZuqtNkPT4PdXJn=g34cOhRH2oNehROT8kJ_M2cgfg@mail.gmail.com>
References: <BFF5FBC7-8F53-4958-8D56-90EADD3AD626@kellerfarm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Git List <git@vger.kernel.org>
To: Andrew Keller <andrew@kellerfarm.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 22:21:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSCJF-0007eA-59
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 22:21:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbaCXVVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 17:21:25 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:58923 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbaCXVVY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2014 17:21:24 -0400
Received: by mail-oa0-f44.google.com with SMTP id n16so6639977oag.31
        for <git@vger.kernel.org>; Mon, 24 Mar 2014 14:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ZxptN1gw9YkQtlX5v2zhdHLtkk09hp/Ic4nfhxJHE/U=;
        b=GqxB6ihduvHzUiFbaYUzuPh6N9F37eT2De9x1k08SASdEvzy9wLPr+qgldqseFZLGQ
         l5uf/INpdgmOKN8Fu5f/5T0R0yv+JTzPldV3EZx0rZtJq6zfzawZWstx0SXEYSY9Si0Q
         9MwyKBrwOtVOftT/s3PDF/f/a+B8ZmCGfQ6kNBLrIahp8foje3DzSOeiMcnxaZNtKsp3
         5EQNoVK46vn4jBYofqwZnbP/IeRCGLYffc8fdEQFm1uLfTASOq7xRuIWI+QRixqvKl5C
         9wBkar2zLq8GhIHrVDoW5ZW2DourfYO3iAiRl5d0gzYiJrXgQSRpHdKbSeMKLhEiBsiI
         W0aQ==
X-Received: by 10.182.2.170 with SMTP id 10mr4174758obv.50.1395696084029; Mon,
 24 Mar 2014 14:21:24 -0700 (PDT)
Received: by 10.76.33.161 with HTTP; Mon, 24 Mar 2014 14:21:03 -0700 (PDT)
In-Reply-To: <BFF5FBC7-8F53-4958-8D56-90EADD3AD626@kellerfarm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244872>

On Wed, Mar 12, 2014 at 4:37 AM, Andrew Keller <andrew@kellerfarm.com> wrote:
> Hi all,
>
> I am considering developing a new feature, and I'd like to poll the group for opinions.
>
> Background: A couple years ago, I wrote a set of scripts that speed up cloning of frequently used repositories.  The scripts utilize a bare Git repository located at a known location, and automate providing a --reference parameter to `git clone` and `git submodule update`.  Recently, some coworkers of mine expressed an interest in using the scripts, so I published the current version of my scripts, called `git repocache`, described at the bottom of <https://github.com/andrewkeller/ak-git-tools>.
>
> Slowly, it has occurred to me that this feature, or something similar to it, may be worth adding to Git, so I've been thinking about the best approach.  Here's my best idea so far:
>
> 1)  Introduce '--borrow' to `git-fetch`.  This would behave similarly to '--reference', except that it operates on a temporary basis, and does not assume that the reference repository will exist after the operation completes, so any used objects are copied into the local objects database.  In theory, this mechanism would be distinct from '--reference', so if both are used, some objects would be copied, and some objects would be accessible via a reference repository referenced by the alternates file.

Isn't this the same as git clone --reference <path> --no-hardlinks <url> ?

Also without --no-hardlinks we're not assuming that the other repo
doesn't go away (you could rm-rf it), just that the files won't be
*modified*, which Git won't do, but you could manually do with other
tools, so the default is to hardlink.

> 2)  Teach `git fetch` to read 'repocache.path' (or a better-named configuration), and use it to automatically activate borrowing.

So a default path for --reference <path> --no-hardlinks ?

> 3)  For consistency, `git clone`, `git pull`, and `git submodule update` should probably all learn '--borrow', and forward it to `git fetch`.
>
> 4)  In some scenarios, it may be necessary to temporarily not automatically borrow, so `git fetch`, and everything that calls it may need an argument to do that.
>
> Intended outcome: With 'repocache.path' set, and the cached repository properly updated, one could run `git clone <url>`, and the operation would complete much faster than it does now due to less load on the network.
>
> Things I haven't figured out yet:
>
> *  What's the best approach to copying the needed objects?  It's probably inefficient to copy individual objects out of pack files one at a time, but it could be wasteful to copy entire pack files just because you need one object.  Hard-linking could help, but that won't always be available.  One of my previous ideas was to add a '--auto-repack' option to `git-clone`, which solves this problem better, but introduces some other front-end usability problems.
> *  To maintain optimal effectiveness, users would have to regularly run a fetch in the cache repository.  Not all users know how to set up a scheduled task on their computer, so this might become a maintenance problem for the user.  This kind of problem I think brings into question the viability of the underlying design here, assuming that the ultimate goal is to clone faster, with very little or no change in the use of git.
>
>
> Thoughts?
>
> Thanks,
> Andrew Keller
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

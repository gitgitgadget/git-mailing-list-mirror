From: Brian Gesiak <modocache@gmail.com>
Subject: Re: [GSoC14][RFC] Proposal Draft: Refactor tempfile handling
Date: Sun, 9 Mar 2014 02:04:16 +0900
Message-ID: <CAN7MxmW-aWgTQpTMuEx=kzyHVUf5E7unZR-LmLQrY-AmmrZxjA@mail.gmail.com>
References: <CAN7MxmVQuk96dmXfxZ5kRZPTXNwpz2RY=y8HyqX4mZzrZUVbNg@mail.gmail.com>
	<20140303224238.GA2699@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 08 18:04:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMKfd-00018G-UX
	for gcvg-git-2@plane.gmane.org; Sat, 08 Mar 2014 18:04:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676AbaCHRER (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2014 12:04:17 -0500
Received: from mail-ig0-f179.google.com ([209.85.213.179]:43291 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610AbaCHREQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2014 12:04:16 -0500
Received: by mail-ig0-f179.google.com with SMTP id t19so4696276igi.0
        for <git@vger.kernel.org>; Sat, 08 Mar 2014 09:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0TnYUHM8WjgaQUSy0Lj4jEfeLjrqJfgg7Ml63IycPVM=;
        b=H9p2IX/1MWEIWiQpLfE3Iosc+sEuLkQAXMqO8DSn1/gfprNbVQNyenqSMjcJC0WbG/
         dabN2+dUEuX4wBn5BWUktm1mMpMIy74vgSnlEjUxtz6MBcyaQQiXVPPWZ6zMWdvrC6FA
         FHMSCr2pKu3YChuv9+yBVc/yafGinMP97Z274m76pSRqIW6paM5FQhwIZTbg8uhYeYDX
         O8BXve+JxSHk4SnITYBWDeySkjpoolI5LYQ0m/FfvoREsbi3qHRBSxvyhYgmYfVUL9v3
         d7E/mSEayh+48c65KSdBTbVX5lT+kqaCl92u6vLuC9stnd4360Fwwucj/7M+r5bnSNn/
         gCRQ==
X-Received: by 10.42.15.142 with SMTP id l14mr970475ica.64.1394298256223; Sat,
 08 Mar 2014 09:04:16 -0800 (PST)
Received: by 10.64.55.161 with HTTP; Sat, 8 Mar 2014 09:04:16 -0800 (PST)
In-Reply-To: <20140303224238.GA2699@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243677>

Excellent, thank you very much for the feedback, Jeff! It was very
helpful and encouraging. I've done some more research based on your
comments.

> Once the logic is extracted into a nice API, there are
> several other places that can use it, too: ...

I've found the following four areas so far:

1. lockfile.lock_file
2. git-compat-util.odb_mkstemp
3. git-compat-util.odb_pack_keep
4. diff.prepare_temp_file

Tons of files use (1) and (2). (3) is less common, and (4) is only
used for external diffs.

> the shallow_XXXXXX tempfiles

I'm not sure I was able to find this one. Are you referring to the
lock files used when fetching, such as in fetch-pack.c?

> What are the mismatches in how lockfiles and object files are
> handled? E.g., how do we finalize them into place? How should
> the API be designed to minimize race conditions (e.g., if we
> get a signal delivered while we are committing or cleaning up a file)?

I'd say the biggest difference between lockfiles and object files is
that tempfile methods like odb_mkstemp need to know the location of
the object directory. Aside from that, lockfiles and the external diff
files appear to be cleaned up at exit, while temporary object files
tend to have a more finely controlled lifecycle. I'm still
investigating this aspect of the proposal, though.

One question, though: the idea on the ideas page specifies that
temporary pack and object files may "optionally" be cleaned up in case
of error during program execution. How will users specify their
preference? I think the API for creating temporary files should allow
cleanup options to be specified on a per-file basis. That way each
part of the program that creates tempfiles can specify a different
config value to determine the cleanup policy.

Thanks for all your help so far!

- Brian Gesiak

PS: I'm maintaining a working draft of my proposal here, in case
anyone wants to offer any feedback prior to its submission:
https://gist.github.com/modocache/9434914


On Tue, Mar 4, 2014 at 7:42 AM, Jeff King <peff@peff.net> wrote:
> On Sun, Mar 02, 2014 at 06:04:39AM +0900, Brian Gesiak wrote:
>
>> My name is Brian Gesiak. I'm a research student at the University of
>> Tokyo, and I'm hoping to participate in this year's Google Summer of
>> Code by contributing to Git. I'm a longtime user, first-time
>> contributor--some of you may have noticed my "microproject"
>> patches.[1][2]
>
> Yes, we did notice them. Thanks, and welcome. :)
>
>> The ideas page points out that while lock files are closed and
>> unlinked[3] when the program exits[4], object pack files implement
>> their own brand of temp file creation and deletion. This
>> implementation doesn't share the same guarantees as lock files--it is
>> possible that the program terminates before the temp file is
>> unlinked.[5]
>>
>> Lock file references are stored in a linked list. When the program
>> exits, this list is traversed and each file is closed and unlinked. It
>> seems to me that this mechanism is appropriate for temp files in
>> general, not just lock files. Thus, my proposal would be to extract
>> this logic into a separate module--tempfile.h, perhaps. Lock and
>> object files would share the tempfile implementation.
>>
>> That is, both object and lock temp files would be stored in a linked
>> list, and all of these would be deleted at program exit.
>
> Yes, I think this is definitely the right way to go. We should be able
> to unify the tempfile handling for all of git. Once the logic is
> extracted into a nice API, there are several other places that can use
> it, too:
>
>   - the external diff code creates tempfiles and uses its own cleanup
>     routines
>
>   - the shallow_XXXXXX tempfiles (these are not cleaned right now,
>     though I sent a patch recently for them to do their own cleanup)
>
> Those are just off the top of my head. There may be other spots, too.
>
> It is worth thinking in your proposal about some of the things that the
> API will want to handle. What are the mismatches in how lockfiles and
> object files are handled? E.g., how do we finalize them into place?
> How should the API be designed to minimize race conditions (e.g., if we
> get a signal delivered while we are committing or cleaning up a file)?
>
>> Please let me know if this seems like it would make for an interesting
>> proposal, or if perhaps there is something I am overlooking. Any
>> feedback at all would be appreciated. Thank you!
>
> You definitely have a grasp of what the project is aiming for, and which
> areas need to be touched.
>
> -Peff

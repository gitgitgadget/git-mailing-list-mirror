From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH] Make is_gitfile a non-static generic function
Date: Wed, 12 Oct 2011 09:29:17 -0400
Message-ID: <CABURp0qDH6+S-m4nmPrfOECEVQUoXjsvz9ZQhA5PbVJEuwEL_g@mail.gmail.com>
References: <4E94C70E.3080003@cisco.com> <4E94C8AB.3040807@cisco.com> <7vipnvccso.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Phil Hord <hordp@cisco.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 12 15:29:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDysX-0003Pm-BC
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 15:29:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753265Ab1JLN3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 09:29:44 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:53680 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753264Ab1JLN3n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 09:29:43 -0400
Received: by wwn22 with SMTP id 22so6705018wwn.1
        for <git@vger.kernel.org>; Wed, 12 Oct 2011 06:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=fkhAfYab2Nrg/OnenybEKc1F5sfYmMlaXKrbK7WBaDo=;
        b=wLm5UITZV55WLIOC4dpmMOum4//0fW/VY1TyHG4aUpQjrSw//ri0+h0J340HwDllBT
         Ren28UXiei/ymVL+IHEqT8d+Z7WUsK8yJDHs+CHzrDj31mQYN6+KQ7yhRRlyImBckl7k
         dU1q2gJQqYl5MT2InUYQu9th7YbVIlt9Nx0oE=
Received: by 10.216.133.129 with SMTP id q1mr9743935wei.87.1318426182555; Wed,
 12 Oct 2011 06:29:42 -0700 (PDT)
Received: by 10.216.88.72 with HTTP; Wed, 12 Oct 2011 06:29:17 -0700 (PDT)
In-Reply-To: <7vipnvccso.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183366>

Junio C Hamano <gitster@pobox.com> wrote:
> Phil Hord <hordp@cisco.com> writes:
>
>> The new is_gitfile is an amalgam of similar functional checks
>> from different places in the code....
>
>
> After looking at this patch and the way the other caller in transport.c
> uses it, I am more and more convinced that "is_gitfile()" is a stupid and
> horrible mistake.

I think it's a simple and low-impact change that fixes a bug with a
minimum of disruption.  But I also think it is lazy.

> The caller in transport.c says "I am about to read from a regular file,
> and usually I would treat it as a bundle, but I want to avoid that
> codepath if that regular file is not a bundle. So I use the codepath only
> when that file is not a gitfile".
>
> It should be saying "Is it a bundle? Then I'd use the codepath to read
> from the bundle" to begin with. Otherwise the code will break when we add
> yet another regular file we can fetch from that is not a bundle nor a
> gitfile.

Yes, and this is part of the kind of distraction that held back my
update over the weekend.

When we do add another file type we'll wind up with a half-dozen
places that get affected in slightly different ways again.  Wouldn't
it be nice to have a function to tell us what kind of thing it is
we've been asked to look at?  Something like git_type(url) that
returns GIT_BUNDLE, GIT_DIRECTORY or GIT_FILE, maybe.

Except I didn't see many examples in the code using this sort of
enumerated decision function.

> I think the hand-crafted check in builtin/clone.c you removed originated
> from laziness to avoid teaching read_gitfile() to read potential gitfile
> silently (and signal errors by simply returning NULL).

I made a read_gitfile(... , gently) function, but I didn't like it
much.  When !gently, I think it should be rather explicit about the
type of failure.  This makes the code look like 20% of it is repeated
"if (!gently) die... ;\n return;" sequences.  It's almost enough to
lead me to macros.

And what about when fopen() fails and we are running silently.  Do we
just shrug and say "Not a gitfile"?  I don't think it's good enough.
We need to be able to say all of these:

  It's a gitfile, here's the internal path.

  It's not a gitfile, it is something else.

  It looked like a gitfile until I ran into E_ACCES or some other error.

Making the one function run silently or not complicates the code further.

I tried to find a similar style to mimic elsewhere in the code, but I
didn't find any consistency.  Pointers to clean examples would be
welcome.

I started working on more of an API.  But it's still very ugly and not
ready for even a strawman discussion.

But I don't know how much time I have for a full writeup atm.  Without
something, though, I cannot easily fetch from a submodule, because
submodules all use gitfiles now, and git:master does not know how to
fetch from them.

And that's the itch I had to scratch.

> I also suspect the
> codepath may become simpler if we had a way to ask "Is this a bundle?".
>
> I think read_bundle_header() in bundle.c can be refactored to a silent
> interface that allows us to ask "Is this a bundle?" question properly.

I'll take a look at it.  But I won't have much time for it this week.

Thanks,
Phil

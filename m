From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git log fails to show all changes for a file
Date: Wed, 15 Jul 2015 10:13:12 -0700
Message-ID: <CA+55aFy8urE+0w7mfgywcAnyoUu+6LMz-GGaOrUQYJ59gT9FfA@mail.gmail.com>
References: <20150714073035.GA22707@aepfle.de>
	<20150714074508.GE1451@serenity.lan>
	<20150714075955.GA24577@aepfle.de>
	<CA+55aFzPvwAghGtA-WH8i1PcNe55XORokaXF9hNu7OUXBx++6Q@mail.gmail.com>
	<xmqq8uahxu3e.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Olaf Hering <olaf@aepfle.de>, John Keeping <john@keeping.me.uk>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 15 19:13:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFQFC-0000m5-1p
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jul 2015 19:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752567AbbGORNN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2015 13:13:13 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:36139 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592AbbGORNN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2015 13:13:13 -0400
Received: by ieik3 with SMTP id k3so38588673iei.3
        for <git@vger.kernel.org>; Wed, 15 Jul 2015 10:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=WvX7yR96brm8HnzJ7D57vOdcG3IIIhKq1OWNeJJ3DMs=;
        b=oDAkjG7NIh5q6sWdiaJp/W4d3Iu27S0WAcMvu6G1HOKeycqsfv65C4H4vGi9Q4KMI6
         +l7LO4K+IW446BBkSeQ3CJnV5M/XTOZ72squ1wMaamtNwqZhwuE0xhmge3q4EbZA9ZeT
         D1yK313Jl3HXrO7Xw8rl9qBj6f8wNwGoLoZlLS/cyaYCYxAztGtyPcXY2k3ZBdzeumqu
         IK5hfRDewggfQ6hbklIw6UF/7T8rr8n9VzoXclqXInao3BmnXfUTwwKOU9hfr9LpH/yF
         kCcE7Mc8JDId3cP+F80iNE6pftmdkmnLmMJOKkh0zUb5cZUF3KGd2IrVc1NUKB1jwMLG
         rLDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=WvX7yR96brm8HnzJ7D57vOdcG3IIIhKq1OWNeJJ3DMs=;
        b=e55BYPbn1wS83QXKmOK4rRWJM+/cO+THap4vCJoD9W1XWcoM3F/We+KcqLobNOy0aJ
         xNhbf71ndkVTrmzhF57KJIMXg94NjB8PvodlYAhN3fry/viKAe61DrZ1Ir2o4Ooc0Tyk
         3J7j//0DPVcvQIod5G3+Vv60AVTFu/+oi3z7Q=
X-Received: by 10.50.176.164 with SMTP id cj4mr25160636igc.55.1436980392374;
 Wed, 15 Jul 2015 10:13:12 -0700 (PDT)
Received: by 10.36.78.7 with HTTP; Wed, 15 Jul 2015 10:13:12 -0700 (PDT)
In-Reply-To: <xmqq8uahxu3e.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: OqGhKgTILqTQA8ziblBQpxnDu10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273988>

On Wed, Jul 15, 2015 at 9:29 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> I would think "git log -p" that implies "--cc" would be a good
> change, as long as there is an easy escape hatch to let us do what
> we have to do with a rather lengthy "git log -p --first-parent -m"
> (i.e. show the change relative to its first parent while traversing
> the first parent chain) today.  Perhaps only when there is no
> explicit "-m" but "-p" is given, automatically enable "--cc", or
> something like that.

That's very close to what "git show" does through that magic
show_rev_tweak_rev() logic, with the crucial difference being that
"git show" is designed to always show the diff, so the "-p" is
implied.

That said, having thought about it more, I'm not entirely sure we can
do it.  The big conceptual difference between "git log" and "git show"
is obviously that "git show" doesn't walk the revision list, and you
always explicitly say "show _this_ commit".

And that means that with "git show", you kind of _know_ that the
commit is relevant and interesting, in a way that "git log" does not.
So got "git show", it's very natural to say "show all the relevant
information", while for "git log" we did make the choice that maybe
commit diffs aren't relevant by default.

And the whole issue ends up boiling down to "maybe we picked the wrong
choice default". We default to that "ignore_merges = 1" behavior.

Now, we defaulted to ignoring merge diffs because long long ago, in a
galaxy far away, we didn't have a great way to show the diffs. The
whole "--cc" option goes back to January -06 and commit d8f4790e6fe7
("diff-tree --cc: denser combined diff output for a merge commit") .
And before that option - so for about 8 months - we had no good way to
show the diffs of merges in a good dense way.

So the whole "don't show diffs for merges by default" actually made a
lot of sense originally, because our merge diffs were not very useful.

But that does mean that if we now enable "--cc" by default when you
ask for diffs, we have no good way to _disable_ it. We picked "disable
by default", and "-m" means "enable merge diffs". And that made sense
back in 2005 because we really wanted to disable the whole "show diffs
for merges" thing.

Of course, you can use "--no-merges" to basically not show merges at
all, so maybe that's ok. But I get the feeling that if we make "-p"
imply "--cc", we should probably add a "--no-merge-diff" option too to
replace the (broken) "-m" flag properly. And I'm a tiny bit worried
that it might break some script (although I'm really not seeing
how/why you'd script "git log -p" output and not want to get a --cc
patch for a merge).

And "-m"? We should probably get rid of it. The diffs we get for
merges when "-c" or "--cc" isn't given are _not_ useful. The original
non-combined diff format was really just useful for showing that
"yeah, we have multiple parents, and they are different in all these
ways".  So there is no actual valid use for "-m" that I can imagine.
It's simply just an odd historical artifact from a time when we didn't
know how to show merges.

                 Linus

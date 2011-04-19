From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: git rebase -p doesn't understand -X
Date: Tue, 19 Apr 2011 11:06:38 +0200
Message-ID: <BANLkTi=sW_J4LGS=XRuLrwYZTgx4GP65PA@mail.gmail.com>
References: <4DA87E94.2050700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Marius Storm-Olsen <mstormo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 11:06:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QC6tR-0006OX-W7
	for gcvg-git-2@lo.gmane.org; Tue, 19 Apr 2011 11:06:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752320Ab1DSJGl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2011 05:06:41 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:45854 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943Ab1DSJGk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2011 05:06:40 -0400
Received: by ewy4 with SMTP id 4so1634727ewy.19
        for <git@vger.kernel.org>; Tue, 19 Apr 2011 02:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=qo4FswzLO1XK74pevUqmvpZ5i8F4tQusW1e2C9Q2kPE=;
        b=io/UmQtPks4VdHZ61j3mWZ8JHc8xedO4Q+hRK0YfQlQU6F27Fnq22lk6Uz2PWQTlZh
         Rn2+wP8hSeWBBdiD7lOACie3SQmkF2VPtXcues/lY+n/N1V8MALeCcFwNcuTEFlTXWB3
         5SJBjDA2/26+6aNzlLKRDv2rhDFBGnS9Kch30=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=JuwpW91t64pZHgJF80i3Cwj+Q+37k1DBPnl50wsOEny6ZDeO1rNk+N2t81p9UXYV5Z
         Nmof1+yw3dNVJKK70XY+A9PI2dZVy9/SYTPqOWs2Lhr6ItnIEBAdeqz1AmNhqDeZxnnk
         nwgqsO5dtju3n/ay/gxTqtyIlbyUbBQw+nTJE=
Received: by 10.213.8.146 with SMTP id h18mr2538078ebh.108.1303203998780; Tue,
 19 Apr 2011 02:06:38 -0700 (PDT)
Received: by 10.213.105.194 with HTTP; Tue, 19 Apr 2011 02:06:38 -0700 (PDT)
In-Reply-To: <4DA87E94.2050700@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171782>

On Fri, Apr 15, 2011 at 7:21 PM, Marius Storm-Olsen <mstormo@gmail.com> wrote:
> Hi,
>
> I'm trying to rebase a rather large series of patches, which also contains a
> couple of merges which I'd like to recreate in the rebase, and for the other
> conflicts I'd like git to automatically choose 'ours'.
>
> So, I run
>    git rebase -p -X ours -X patience -X ignore-all-space --onto foo bar baz
> and I get
>    error: unknown switch `X'

Interactive rebase uses cherry-pick internally. Jonathan added support
for -X to that command not too long ago (in commit 67ac1e1, late last
year), so it should be pretty straight-forward to add support for what
you want. Maybe I'll do that in a few weeks when I get back from
vacation.

A related topic is _when_ to use the strategy (and strategy options).
I asked the question on
http://thread.gmane.org/gmane.comp.version-control.git/164241/focus=164543,
but I will try to clarify here.

I saw that when rebase -p was initially introduced by Johannes in
f09c9b8 in 2007, he gave this example:


    Example:

               X
                \
             A---M---B
            /
    ---o---O---P---Q

    When the current HEAD is "B", "git rebase -i -p --onto Q O" will yield

                   X
                     \
    ---o---O---P---Q---A'---M'---B'


Is that similar to what you want? I have normally been thinking about
an example that looks more like:

               C---D
              /     \
             A---B---M
            /
    ---o---O---P---Q

which would yield

                         C'---D'
                        /       \
    ---o---O---P---Q---A'---B'---M'


In such a case, it probably makes sense to use the same strategy to
create A' through D', because the upstream change for all of them
would be the changes from O to Q (the merge base is O). However, when
applying M to form M', that part of the history is not involved (the
merge base is A').

Would it be completely insane to stop passing the strategy when
recreating merges? It seems to me that it would at least be better in
the second example above. Johannes, do you think that would break
things in the first example?

A more advanced solution would be recreate the merge using rerere. We
could first redo the merge from D to B and reset the tree to look like
in M, then record the resolutions and reuse them when doing the merge
to form M'. Makes sense? Overkill? If we want to avoid interfering
with the normal rerere cache, I guess we could use a separate rerere
cache (which I don't think is currently supported).

> Is there any work around to allow me to achieve the same result?

Not that I know of. (Except, of course, piece-wise rebasing the linear
parts of history and doing the merges manually.)


/Martin

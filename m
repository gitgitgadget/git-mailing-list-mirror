From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] notes: allow merging from arbitrary references
Date: Wed, 18 Nov 2015 23:29:26 +0100
Message-ID: <CALKQrge+agZ2NstnjkkVKmgqQRtE1cwiq6d7B9bP4_VApq+e_Q@mail.gmail.com>
References: <1447432462-21192-1-git-send-email-jacob.e.keller@intel.com>
	<CALKQrgcKxJqJn+3-rg4DCbT5CFDZW8o9GtCS=kh-iSy0YyGAUA@mail.gmail.com>
	<CA+P7+xoyCwgYWaiVj0FNVHuaY=kUZA5a3LBMtpe6SirOVeK9rA@mail.gmail.com>
	<CALKQrgdDH2WZc-xi3ROLUBxdk=yVqfFGN3jN1GjQq4qJj_K+-A@mail.gmail.com>
	<CA+P7+xqGwb6yejh+HZMt8cwx=4arR6+YKCNVdftuQe5SBY_X9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Mike Hommey <mh@glandium.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 23:29:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzBES-0004XE-2p
	for gcvg-git-2@plane.gmane.org; Wed, 18 Nov 2015 23:29:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757040AbbKRW3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2015 17:29:35 -0500
Received: from locusts.copyleft.no ([188.94.218.116]:51475 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411AbbKRW3e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2015 17:29:34 -0500
Received: from mail-yk0-f182.google.com ([209.85.160.182])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1ZzBEK-000O09-T6
	for git@vger.kernel.org; Wed, 18 Nov 2015 23:29:33 +0100
Received: by ykfs79 with SMTP id s79so87818120ykf.1
        for <git@vger.kernel.org>; Wed, 18 Nov 2015 14:29:26 -0800 (PST)
X-Received: by 10.13.234.151 with SMTP id t145mr4294456ywe.117.1447885766898;
 Wed, 18 Nov 2015 14:29:26 -0800 (PST)
Received: by 10.37.208.21 with HTTP; Wed, 18 Nov 2015 14:29:26 -0800 (PST)
In-Reply-To: <CA+P7+xqGwb6yejh+HZMt8cwx=4arR6+YKCNVdftuQe5SBY_X9w@mail.gmail.com>
X-Gmail-Original-Message-ID: <CALKQrge+agZ2NstnjkkVKmgqQRtE1cwiq6d7B9bP4_VApq+e_Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281462>

On Mon, Nov 16, 2015 at 8:41 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> The main other issue is how to get notes DWIM things to work for all
> cases where we want to use notes refs, since right now the DWIM is
> basically done at the top level and only handles notes like things.
> The problem with it is that if you specify a full ref that *isn't*
> refs/notes, you will always prefix it with refs/notes, like so:
>
> refs/remote-notes/origin => refs/notes/refs/remote-notes/origin,

I am becoming convinced that this is a bug. I don't know anywhere else
in Git, where a fully qualified ref name (i.e. anything starting with
"refs/") is not interpreted verbatim. For the notes code to do just
that adds unnecessary confusion.

> This makes it really difficult to expand a ref. However, Junio seemed
> to think this was a possibly valuable expansion under normal
> circumstances.

I doubt it. It carries its own set of problems in that refs/foo/bar
(=> refs/notes/refs/foo/bar) is treated differently from refs/notes/bar
(=> refs/notes/bar). If users _really_ want to create
refs/notes/refs/$whatever, they should have to be explicit about that
(i.e. we should require them to say refs/notes/refs/$whatever instead
of allowing them to lazily say refs/$whatever). (It even saves them
from a potential bug if their $whatever happens to start with "notes/",
in which case the current code already forces them to fully qualify...)

I realize this is a backwards-incompatible change in behavior, but I
don't think it'll matter much in practice. Given e.g.

  git notes --ref refs/foo list

when refs/foo and refs/notes/refs/foo is both missing:
  Current behavior: refs/notes/refs/foo lookup fails.
    Treat like empty notes tree; no output, exit code 0
  Proposed behavior: refs/foo lookup fails -> refs/notes/refs/foo
    lookup fails. Same behavior as current.

when refs/notes/refs/foo exists:
  Current behavior: refs/notes/refs/foo lookup succeeds.
    Shows notes in that tree
  Proposed behavior: refs/foo lookup fails -> refs/notes/refs/foo
    lookup succeeds. Same as current.

when refs/foo exists:
  Current behavior: refs/notes/refs/foo lookup fails. Treat like empty
    notes tree; no output, exit code 0
  Proposed behavior: refs/foo lookup succeeds. Load as notes tree,
    probably empty, hence no output, exit code 0

when both refs/foo and refs/notes/refs/foo exist:
  Current behavior: refs/notes/refs/foo lookup succeeds. Shows notes
    in that tree
  Proposed behavior: refs/foo lookup succeeds. Load as notes tree,
    probably empty, hence no output, exit code 0

In other words, this change requires both refs/foo and
refs/notes/refs/foo to be present in order to cause any real confusion.
And in that case, the proposed behavior forces you to use fully-
qualified refs (which will be interpreted as such) whereas the current
behavior takes what looks like a fully-qualified ref (refs/foo) and
interprets it like a notes-shorthand (-> refs/notes/refs/foo), which
I argue is probably more confusing to most users.

> The current solution is to try to do a normal lookup
> first and only use the notes DWIM after we fail a lookup, which I
> think is what the above patch attempts to do. This seems ok enough to
> me.

Yes, given $whatever, we should first lookup $whatever, and only
failing that, we should try refs/notes/$whatever. Maybe it's also
worth trying refs/$whatever (before refs/notes/$whatever), since that
would be consistent with what's currently done for other refs (e.g.
try "git log heads/master" or "git log tags/v2.6.3" in git.git).


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net

From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] notes: allow merging from arbitrary references
Date: Mon, 16 Nov 2015 08:55:04 +0100
Message-ID: <CALKQrgdDH2WZc-xi3ROLUBxdk=yVqfFGN3jN1GjQq4qJj_K+-A@mail.gmail.com>
References: <1447432462-21192-1-git-send-email-jacob.e.keller@intel.com>
	<CALKQrgcKxJqJn+3-rg4DCbT5CFDZW8o9GtCS=kh-iSy0YyGAUA@mail.gmail.com>
	<CA+P7+xoyCwgYWaiVj0FNVHuaY=kUZA5a3LBMtpe6SirOVeK9rA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Mike Hommey <mh@glandium.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 16 08:55:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyEdE-0000SC-Cn
	for gcvg-git-2@plane.gmane.org; Mon, 16 Nov 2015 08:55:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbbKPHzO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2015 02:55:14 -0500
Received: from locusts.copyleft.no ([188.94.218.116]:55576 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438AbbKPHzN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2015 02:55:13 -0500
Received: from mail-yk0-f171.google.com ([209.85.160.171])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1ZyEd4-000EA1-UD
	for git@vger.kernel.org; Mon, 16 Nov 2015 08:55:11 +0100
Received: by ykdv3 with SMTP id v3so225973201ykd.0
        for <git@vger.kernel.org>; Sun, 15 Nov 2015 23:55:05 -0800 (PST)
X-Received: by 10.129.74.212 with SMTP id x203mr37127407ywa.69.1447660505039;
 Sun, 15 Nov 2015 23:55:05 -0800 (PST)
Received: by 10.37.208.21 with HTTP; Sun, 15 Nov 2015 23:55:04 -0800 (PST)
In-Reply-To: <CA+P7+xoyCwgYWaiVj0FNVHuaY=kUZA5a3LBMtpe6SirOVeK9rA@mail.gmail.com>
X-Gmail-Original-Message-ID: <CALKQrgdDH2WZc-xi3ROLUBxdk=yVqfFGN3jN1GjQq4qJj_K+-A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281327>

On Mon, Nov 16, 2015 at 12:23 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Sun, Nov 15, 2015 at 2:14 PM, Johan Herland <johan@herland.net> wrote:
>> A related topic that has been discussed (although I cannot remember if
>> any conclusion was reached) is whether to allow more notes operations
>> - specifically _read-only_ operations - on notes trees outside
>> refs/notes/. I believe this should also become possible, although I
>> haven't thoroughly examined all implications.
>
> This was discussed at some point on one of the versions of my patch.
> The tricky part is in how to get it implemented correctly.
>
> We need to be able to correctly handle DWIM logic for things, and
> ensure that what we're operating on actually looks "note-like" since
> we don't really want to perform read-only ops on refs that don't hold
> notes like objects.

I believe read-only operations on non-notes trees is harmless
(although suboptimal). When reading in a notes tree, the notes code
maintains non-note entries in a sorted linked list. Only paths that
contain exactly 40 hex characters (modulo '/') ends up as "notes"
(i.e. false positives). The rest ends up in the non-notes list. The
overwhelming majority of non-notes trees will have no "notes" in them
(zero false positives).

For those few trees that do contain note-like paths: since we never
write out the tree again, we don't end up corrupting the non-notes
tree itself (which would typically look like changing the "fanout" of
note-like paths, e.g. moving 'de/adbeef...' to 'deadbeef...'). Hence,
the only damage we can get from reading in a non-notes tree depend on
what we subsequently do with the "notes" information read from that
tree.

Again, since the number of "notes" read from a non-notes tree is
typically zero, the subsequent damage is typically, also, zero.

For "git notes merge", false positives from a non-notes tree are
merged into the first (proper) notes tree.

For "git log --notes", false positives end up being displayed as part
of the output. Note that here, a false positive must not only match
the above criteria (40 hex chars, modulo '/'), but must also correctly
name a commit that occurs in the log.

Are there other cases where a false positive would wreak considerable havoc?

Additionally, if we suspect that passing non-notes trees to read-only
operations will be a common error, we could add a simple heuristic to
the notes code, to warn (or even abort) if we strongly suspect that we
are reading in a non-notes tree. For example, if the ratio of
non-notes to notes entries goes above, say, 1:1 (or even 10:1), then
what we're reading is probably not a proper notes tree...


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net

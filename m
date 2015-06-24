From: Shawn Pearce <spearce@spearce.org>
Subject: Re: RFC/Pull Request: Refs db backend
Date: Tue, 23 Jun 2015 23:09:40 -0700
Message-ID: <CAJo=hJsu2b0kmpjOhGwvgRsG3yGK56+U_2RANDi2qoEg7V_PmQ@mail.gmail.com>
References: <1435020656.28466.8.camel@twopensource.com> <20150623114716.GC12518@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Turner <dturner@twopensource.com>,
	git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 24 08:10:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7dt2-0006kO-Qr
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 08:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbbFXGKE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 02:10:04 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:37423 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbbFXGKC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 02:10:02 -0400
Received: by wicgi11 with SMTP id gi11so35882800wic.0
        for <git@vger.kernel.org>; Tue, 23 Jun 2015 23:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=/6NrhEzPZbEqX14A3J2EZgqbxMrdTke+4Q6wvQRKb6s=;
        b=DYiOe5cfj9gZnXpOTIdvbqs56d0v8bTnujcwEdjaMWiIpSgtsg96F0CB/gYpowVGy5
         RxwsnzjO0tmUhzqZfQutIMGYOKlb1UuamWT+5p2QHZrWBkHTIsM1mDEqE3TKJTuUpk6U
         PV5Stjr6GJ3GoP+Czh/SRa+k/JTrccGDOd9lw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=/6NrhEzPZbEqX14A3J2EZgqbxMrdTke+4Q6wvQRKb6s=;
        b=ewSyW85pmIE337IuSjvhL7biHPy6SvfvTn0lvbS17RCCXdNDMg+coJxiUagGpXb5nw
         CD8k5Q7X1WTr95pJb/4P/qjIQXyOqhjEOZzUZ73m50h438Ome2gOaCeJWxVD7ZUafzki
         VfZgkIHK872mdiXofBRrSYhOnqNbM2J3jEeUEAOtYrgdY/YvoLRQn4PLemH7xRioTsOb
         1TWlDCdIEPX76hCgfzarufkgqiiCL92jGlgICp9RE5l4m4FvIRIGGWkxzg9hs1EjC0Jx
         fbo6GAcJ09GOF3mWfb+SJ9AHCWCA/UA+0x2Kxz0b8zgHl8xV7wCXo4qQRqMu3JNPEklZ
         jqGQ==
X-Gm-Message-State: ALoCoQlc6wdyijtrx7cRgzZep1Yrbe/eJ8FktV2D7X3A+NY1OYGE6LsEV1N5YVbEF8RIA/f284hQ
X-Received: by 10.194.191.201 with SMTP id ha9mr67956786wjc.20.1435126200358;
 Tue, 23 Jun 2015 23:10:00 -0700 (PDT)
Received: by 10.28.46.5 with HTTP; Tue, 23 Jun 2015 23:09:40 -0700 (PDT)
In-Reply-To: <20150623114716.GC12518@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272533>

On Tue, Jun 23, 2015 at 4:47 AM, Jeff King <peff@peff.net> wrote:
>
> One of the problems we've had with large-ref repos is that the reflog
> storage is quite inefficient.

Yup. We ran into this with Gerrit Code Review years ago. The
refs/changes/... namespace created by Gerrit Code Review is 1 ref per
snapshot per code review, and never modified. Reflogs for these are
always exactly one record. We broke down and modified JGit to add an
API that allowed Gerrit Code Review to disable recording reflogs for
specific updates just to avoid creating reflogs under refs/changes/.

In our JGit DFS implementation we store reflogs in databases to
eliminate these overheads. It works well for us. Hopefully the feature
can come to git-core through this series.

> It has also been a dream of mine to stop tying the reflogs specifically
> to the refs. I.e., have a spot for reflogs of branches that no longer
> exist, which allows us to retain them for deleted branches. Then you can
> possibly recover from a branch deletion, whereas now you have to dig
> through "git fsck"'s dangling output. And the reflog, if you don't
> expire it, becomes a suitable audit log to find out what happened to
> each branch when (whereas now it is full of holes when things get
> deleted).

Yes. $DAY_JOB's DFS implementation never expires reflogs, allowing it
to be used as a history to inspect what happened. Its been useful a
couple of times to investigate and recover from a few accidental
deletions.

Once you never expire reflog records you now have to consider at what
point do you stop paying attention to the reflog entries for graph
reachability during repack and fsck. Users still expect to be able to
force push or delete a branch and have a set of objects disappear from
the repository.

I am looking forward to something like this in git-core. I delete
branches in my local repos and then regret that. Then remember HEAD
has a reflog and hope I can find it somewhere in there. Usually I
fail, and am sad. :(

> I was thinking of actually moving to a log-structured ref storage.
> Something like:
>
>   - any ref write puts a line at the end of a single logfile that
>     contains the ref name, along with the normal reflog data
>
>   - the logfile is the source of truth for the ref state. If you want to
>     know the value of any ref, you can read it backwards to find the
>     last entry for the ref. Everything else is an optimization.
>
>     Let's call the number of refs N, and the number of ref updates in
>     the log U.
>
>   - we keep a key/value index mapping the name of any branch that exists
>     to the byte offset of its entry in the logfile. This would probably
>     be in some binary key/value store (like LMDB). Without this,
>     resolving a ref is O(U), which is horrible. With it, it should be
>     O(1) or O(lg N), depending on the index data structure.

This ... would be fantastic.

There are some issues with append. Before appending we would need to
verify the last record actually ends with an LF. If there was a power
failure and only part of the last record wrote, you can't append
without that record separator in place.

If that last record was truncated, and an LF was wedged in to do a new
append, we can't trust that intermediate record. A CRC at the end of
the record might make it safer to know the record is intact or bogus
due to an earlier failed write that wasn't completed.

What about the case of never expiring the reflog? This log would grow
forever. You may eventually need to archive old sections of it (e.g. 1
year ago?) to maintain an audit log, while keeping the "latest" entry
for each ref to rebuild the index.

>   - the index can also contain other optimizations. E.g., rather than
>     point to the entry in the logfile, it can include the sha1 directly
>     (to avoid an extra level of indirection). It may want to include the
>     "peeled" value, as the current packed-refs file does.

+1 to always storing the peeled value. This was a major improvement
for $DAY_JOB's Git servers as peeling tags on the fly can be costly
when your storage is something remote, such as NFS. Unfortunately the
current wire protocol demands peeled information to serve a ref
advertisement.

One thing we do is always peel all refs. We record a bit to state its
been peeled, but there is no peeled value because the ref is pointing
to a non-tag object (e.g. refs/heads/master points to a commit).

I guess this puts an index structure at something like:

  refname \0 log_idx_4 sha1_20 ('n' | 'p' sha1_20)

Or refname + 26 bytes for heads and refname + 46 bytes for tags.


Updating the index on updates to a ref would be costly, as its O(N).
You could skip some index updates. Record in the header of the index
the length of the reflog file used to build it. When reading the
index, scan the reflog from that position to the end and patch those
updates in memory. Rewrites of the index could then be deferred until
the scan delta on the log is high, or the next gc.

>   - Reading all of the reflogs (e.g., for repacking) is O(U), just like
>     it is today. Except the storage for the logfile is a lot more
>     compact than what we store today, with one reflog per file.
>
>   - Reading a single reflog is _also_ O(U), which is not as good as
>     today. But if each log entry contains a byte offset of the previous
>     entry, you can follow the chain (it is still slightly worse, because
>     you are jumping all over the file, rather than reading a compact set
>     of lines).

But this is like saying reading `git log` is bad because we jump all
over the pack file to parse ancestors and insert them into the
revqueue at the correct position. Feh.

I think given the typical size of reflogs, this is irrelevant.

>   - Pruning the reflog entries from the logfile requires rewriting the
>     whole thing. That's similar to today, where we rewrite each of the
>     reflog files.
>
> One of the nice properties of this system is that it should be very
> resilient to corruption and races. Most of the operations are either
> appending to a file, or writing to a tempfile and renaming in place.
> The exception is the key/value index, but if we run into any problems
> there, it can be rebuilt by walking over the logfile (for a cost of
> O(U)).
>
> I dunno. Maybe I am overthinking it.

Not really. Your idea is quite simple. I like it.

> But it really feels like the _refs_
> are a key/value thing, but the _reflogs_ are not. You can cram them into
> a key/value store, but you're probably operating on them as a big blob,
> then.

+1. Refs are key/value but you need all of the key/value pairs fast
for the current wire protocol.

Reflogs are a long queue that is more or less just table scanned when
its accessed.

>> I chose to use LMDB for the database.  LMDB has a few features that make
>> it suitable for usage in git:
>
> One of the complaints that Shawn had about sqlite is that there is no
> native Java implementation, which makes it hard for JGit to ship a
> compatible backend. I suspect the same is true for LMDB, but it is
> probably a lot simpler than sqlite (so reimplementation might be
> possible).

Yes. Whatever the default standard format is for git-core, we need
that format to be easily supportable from JGit. Loading code via JNI
is not "easily supportable".

Non-default formats that the user can opt-into (and opt-out of) don't
need JGit compatibility. Users can choose to use $FANCY_DB or JGit and
make the tradeoff that is best for them. If JGit is also able to do
$FANCY_DB, great. If not, that's fine too. Not everyone needs JGit.
Not everyone needs $FANCY_DB.

IIRC some part of Ronnie's series was about setting up a socket
protocol between Git and the ref backend. If non-default backends are
like this, JGit could spawn the backend binary and then speak the
socket protocol just like git-core. This would be preferable to
linking JNI into the JVM.

Think remote helper protocol between transport.c and the helpers. JGit
doesn't yet speak that, but it should, and there is no technical
reason why it can't. Same for a ref helper protocol.

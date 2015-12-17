From: Shawn Pearce <spearce@spearce.org>
Subject: Re: RefTree: Alternate ref backend
Date: Thu, 17 Dec 2015 14:28:01 -0800
Message-ID: <CAJo=hJsSgU6yOFZMac85jkOtw9TXWXh0Ext4-Gb1TsSXqROn4g@mail.gmail.com>
References: <CAJo=hJvnAPNAdDcAAwAvU9C4RVeQdoS3Ev9WTguHx4fD0V_nOg@mail.gmail.com>
 <20151217221045.GA8150@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 17 23:28:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9h2A-0003TA-3I
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 23:28:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934126AbbLQW2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 17:28:22 -0500
Received: from mail-vk0-f47.google.com ([209.85.213.47]:34600 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933531AbbLQW2V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2015 17:28:21 -0500
Received: by mail-vk0-f47.google.com with SMTP id j66so55242665vkg.1
        for <git@vger.kernel.org>; Thu, 17 Dec 2015 14:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=b323b9vZMbWmuTspFevqRJkpILazLyYDj/xjshJPOok=;
        b=M7GmSVkq3S3URg0F0ceAzgJJT2kpk0EC0hQRYMqQugVrMXaq/cqN46QsawqzXcGtkb
         EQBnB4/7ZTZ4gpZhA/z7r2AezrPn9LwsNunJYNhMd9RSMV2KrC53vGgUJypeySOkryoH
         XgQTJLKF+6+tz8Sp+pX5gZAsqq4q854kRgyWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=b323b9vZMbWmuTspFevqRJkpILazLyYDj/xjshJPOok=;
        b=R5ES882k3wML4Tvlf5v4xDWIAMJvbankSvvhzxsbjDd5krzsJBxH9mfg23PYCmp89F
         tmq+XLMw/jzbMnhd2Qu74UT5mhdNBOXLZaTqvMEjuf475CoYcwavaVDzHBH36Z1VzZMp
         hvfo9W17KFXexlRLcEeolAlz+ZzgR18UFo7/+13t9mv5/2fKhXy+KoFnf24eBdrzeycB
         GoeUUrMRQxtpqCkuCvtp5MXe5bkaqs1/lWIcfgWltpYtUD3G5/EYxnqXdgTmq88TKtHR
         m1QhHdUuf3zvNQXh76CBID2Rae+NNK+Nlh5feEZnE1BGVKlD3NHSAK3T4jXAan3HW6mv
         pu6A==
X-Gm-Message-State: ALoCoQkmchSxHD2WdZFljv236jYosv5OZLHFbwzaLNsOigG8YJT2fIZ9ZWX1bWDhg2EC+PA2aG9DSO11wJG31c9QLJJKrM9Rew==
X-Received: by 10.31.161.131 with SMTP id k125mr183360vke.74.1450391300473;
 Thu, 17 Dec 2015 14:28:20 -0800 (PST)
Received: by 10.103.97.197 with HTTP; Thu, 17 Dec 2015 14:28:01 -0800 (PST)
In-Reply-To: <20151217221045.GA8150@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282684>

On Thu, Dec 17, 2015 at 2:10 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Dec 17, 2015 at 01:02:50PM -0800, Shawn Pearce wrote:
>
>> I started playing around with the idea of storing references directly
>> in Git. Exploiting the GITLINK tree entry, we can associate a name to
>> any SHA-1.
>
> Gitlink entries don't imply reachability, though. I guess that doesn't
> matter if your ref backend says "no, really, these are the ref tips, and
> they are reachable".

Exactly. This works with existing JGit because it swaps out the ref
backend. When GC tries to enumerate the roots (current refs), it gets
these through the ref backend by scanning the tree recursively. The
packer itself doesn't care where those roots came from.

Same would be true for any other pluggable ref backend in git-core. GC
has to ask the ref backend, and then trust its reply. How/where that
ref backend tracks that is an implementation detail.

>  But you could not push the whole thing up to
> another server and expect it to hold the whole graph.

Correct, pushing this to another repository doesn't transmit the
graph. If the other repository also used this for its refs backend,
its now corrupt and confused out of its mind. Just like copying the
packed-refs file with scp. Don't do that. :)

> Which is not strictly necessary, but to me seems like the real advantage
> of using git objects versus some other system.

One advantage is you can edit HEAD symref remotely. Commit a different
symlink value and push. :)

I want to say more, but I'm going to hold back right now. There's more
going on in my head than just this.

> Of course, the lack of reachability has advantages, too. You can
> drop commits pointed to by old reflogs without rewriting the ref
> history.

Yes.

> Unfortunately you cannot expunge the reflogs at all. That's
> good if you like audit trails. Bad if you are worried that your reflogs
> will grow large. :)

At present our servers do not truncate their reflogs. Yes some are... big.

I considered truncating this graph by just using a shallow marker. Add
a shallow entry and repack. The ancient history will eventually be
garbage collected and disappear.

One advantage of this format is deleted branches can retain a reflog
post deletion. Another is you can trivially copy the reflog using
native Git to another system for backup purposes. Or fetch it over the
network to inspect locally. So a shared group server could be
exporting its reflog, you can fetch it and review locally what
happened to branches without logging into the shared server.

So long as you remember that copying the reflog doesn't mean you
actually copied the commit histories, its works nicely.

Another advantage of this format over LMDB or TDB or whatever is Git
already understands it. The tools already understand it. Plumbing can
inspect and repair things. You can reflog the reflog using traditional
reflog ($GIT_DIR/reflogs/refs/txn/committed).

>> By storing all references in a single tree, atomic transactions are
>> possible. Its a simple compare-and-swap of a single 40 byte SHA-1.
>> This of course leads to a bootstrapping problem, where do we store the
>> 40 byte SHA-1? For this example its just $GIT_DIR/refs/txn/committed
>> as a classical loose reference.
>
> Somehow putting it inside `refs/` seems weird to me, in an infinite
> recursion kind of way.  I would have picked $GIT_DIR/REFSTREE or
> something. But that is a minor point.

I had started with $GIT_DIR/REFS, but see above. I have more going on
in my head. This is only a tiny building block.

>> Configuration:
>>
>>   [core]
>>     repositoryformatversion = 1
>>   [extensions]
>>     refsBackendType = RefTree
>
> The semantics of extensions config keys are open-ended. The
> formatVersion=1 spec only says "if there is a key you don't know about,
> then you may not proceed". Now we're defining a refsBackendType
> extension. It probably makes sense to write up a few rules (e.g., is
> RefTree case-sensitive?).

In my prototype in JGIt I parse it as case insensitive, but used
CamelCase because the JavaClassNameIsNamedThatWayBecauseJava.

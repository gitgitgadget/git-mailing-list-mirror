From: David Turner <dturner@twopensource.com>
Subject: Re: RFC/Pull Request: Refs db backend
Date: Tue, 23 Jun 2015 14:18:36 -0400
Organization: Twitter
Message-ID: <1435083516.28466.24.camel@twopensource.com>
References: <1435020656.28466.8.camel@twopensource.com>
	 <20150623114716.GC12518@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 23 20:18:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7SmS-00068D-H8
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 20:18:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754937AbbFWSSk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 14:18:40 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:34271 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753817AbbFWSSj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 14:18:39 -0400
Received: by qkeo142 with SMTP id o142so9316588qke.1
        for <git@vger.kernel.org>; Tue, 23 Jun 2015 11:18:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=I0YBA4hz+RCKVBLldi/aipfw9RpYRFuJbPgI3dEhg4k=;
        b=fUtbjjJ3XGq85Uv+baB9eeuZCV3IlJClNA0qR9fumvGT8qYpMY85qSpqXz0EYfgfa/
         aJvcSwA1hrJLUHcswd2fe61Fj/4TubLPVtMGs5GoaJuVIiGfCPjWJ3iHTRo4BbewQdIO
         jLmvbwKi7kJbiSeDr3eAoKtse8fPOnAn2hBtDMoPV8DN/R+n4wPGVxw5E0Efco2TL3m8
         3IUdCMGr6uOt+GA0L990jt2Y+CUC4tXGi1/tiAY3TFrEZsuWFcBHuhIFHM02A6Bs8DgW
         uocxVqNMLEJXVIQNMv47OanqUq0Fz/z6LX/vnT+G/qhZ1Q0DilT9wFc1V99xW0ajF1i5
         UGaw==
X-Gm-Message-State: ALoCoQk3EFDXuYFlLwqCSkxdSxnLScuf/tZ3ldaIbpd09vzHj6TgFLStGPNa2SZVo7VHpVPaYPR+
X-Received: by 10.55.25.12 with SMTP id k12mr2754565qkh.81.1435083518276;
        Tue, 23 Jun 2015 11:18:38 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by mx.google.com with ESMTPSA id 64sm1850958qkw.13.2015.06.23.11.18.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jun 2015 11:18:37 -0700 (PDT)
In-Reply-To: <20150623114716.GC12518@peff.net>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272474>

On Tue, 2015-06-23 at 07:47 -0400, Jeff King wrote:
> On Mon, Jun 22, 2015 at 08:50:56PM -0400, David Turner wrote:
> 
> > The db backend runs git for-each-ref about 30% faster than the files
> > backend with fully-packed refs on a repo with ~120k refs.  It's also
> > about 4x faster than using fully-unpacked refs.  In addition, and
> > perhaps more importantly, it avoids case-conflict issues on OS X.
> 
> Neat.
> 
> Can you describe a bit more about the reflog handling?
> 
> One of the problems we've had with large-ref repos is that the reflog
> storage is quite inefficient. You can pack all the refs, but you may
> still be stuck with a bunch of reflog files with one entry, wasting a
> whole inode. Doing a "git repack" when you have a million of those has
> horrible cold-cache performance. Basically anything that isn't
> one-file-per-reflog would be a welcome change. :)

Reflogs are stored in the database as well.  There is one header entry
per ref to indicate that a reflog is present, and then one database
entry per reflog entry; the entries are stored consecutively and
immediately following the header so that it's fast to iterate over them.

> It has also been a dream of mine to stop tying the reflogs specifically
> to the refs. I.e., have a spot for reflogs of branches that no longer
> exist, which allows us to retain them for deleted branches. Then you can
> possibly recover from a branch deletion, whereas now you have to dig
> through "git fsck"'s dangling output. And the reflog, if you don't
> expire it, becomes a suitable audit log to find out what happened to
> each branch when (whereas now it is full of holes when things get
> deleted).

That would be cool, and I don't think it would be hard to add to my
current code; we could simply replace the header with a "tombstone".
But I would prefer to wait until the series is merged; then we can build
on top of it.

> I dunno. Maybe I am overthinking it. But it really feels like the _refs_
> are a key/value thing, but the _reflogs_ are not. You can cram them into
> a key/value store, but you're probably operating on them as a big blob,
> then.

Reflogs are, conceptually, queues. I agree that a raw key-value store is
not a good way to store queues, but a B-Tree is not so terrible, since
it offers relatively fast iteration (amortized constant time IIRC).

> > I chose to use LMDB for the database.  LMDB has a few features that make
> > it suitable for usage in git:
> 
> One of the complaints that Shawn had about sqlite is that there is no
> native Java implementation, which makes it hard for JGit to ship a
> compatible backend. I suspect the same is true for LMDB, but it is
> probably a lot simpler than sqlite (so reimplementation might be
> possible).
> 
> But it may also be worth going with a slightly slower database if we can
> get wider compatibility for free.

There's a JNI interface to LMDB, which is, of course, not native.  I
don't think it would be too hard to entirely rewrite LMDB in Java, but
I'm not going to have time to do it for the forseeable future.  I've
asked Howard Chu if he knows of any efforts in progress.

> > To test this backend's correctness, I hacked test-lib.sh and
> > test-lib-functions.sh to run all tests under the refs backend. Dozens
> > of tests use manual ref/reflog reading/writing, or create submodules
> > without passing --refs-backend-type to git init.  If those tests are
> > changed to use the update-ref machinery or test-refs-be-db (or, in the
> > case of packed-refs, corrupt refs, and dumb fetch tests, are skipped),
> > the only remaining failing tests are the git-new-workdir tests and the
> > gitweb tests.
> 
> I think we'll need to bump core.repositoryformatversion, too. See the
> patches I just posted here:
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/272447

Thanks, that's valuable.  For the refs backend, opening the LMDB
database for writing is sufficient to block other writers.  Do you think
it would be valuable to provide a git hold-ref-lock command that simply
reads refs from stdin and keeps them locked until it reads EOF from
stdin?  That would allow cross-backend ref locking. 

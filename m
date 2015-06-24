From: David Turner <dturner@twopensource.com>
Subject: Re: RFC/Pull Request: Refs db backend
Date: Wed, 24 Jun 2015 13:29:59 -0400
Organization: Twitter
Message-ID: <1435166999.26709.12.camel@twopensource.com>
References: <1435020656.28466.8.camel@twopensource.com>
	 <20150623114716.GC12518@peff.net>
	 <1435083516.28466.24.camel@twopensource.com>
	 <20150624091417.GB5436@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 24 19:30:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7oVI-0003o2-53
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 19:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbbFXRaX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 13:30:23 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:36660 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753330AbbFXRaE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 13:30:04 -0400
Received: by pdcu2 with SMTP id u2so34849127pdc.3
        for <git@vger.kernel.org>; Wed, 24 Jun 2015 10:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=ExELJ0EsJcA2lGNmaLb+7JhOdhb3QEgt/AUZJXucrXk=;
        b=Wr/2ydmcN5ialOiIKQ05Hte6MSJFdMgFHzX49ESy4/WO3eSN0vJmkxAkNlfDgz5OCP
         MCPFt8jD6J8OLUdYdxAJppupqajJXBpMYNlo6cneIVkJElSYiOYICncShOeNeosJ06M5
         6nx/l+euq9UvRuEEAxDQgvllTWa7xdQ/lqlmzQbqxwekEyiYgjoqRW1OZ6zGQSHMoOcV
         v4foDLJoWkv9FG9W7t2UhT41y6ahCrF2kn60Y8mCJPHb8wn5gCMWXmXYk+vmtuG0d+mG
         p2MVyZL+Bls51gtdFh500nEd4bUCJNslkGAFbcVb1GB0icDIUghWRfoTEOJC9lTRanw0
         9jBA==
X-Gm-Message-State: ALoCoQmict80z5cBNqgrKWuVrKs6FlWPhhnoSh0geG6Z2LzpEHDt/nsbWbpVKIGj2jLkL9GKjufQ
X-Received: by 10.66.142.199 with SMTP id ry7mr13633550pab.14.1435167002914;
        Wed, 24 Jun 2015 10:30:02 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by mx.google.com with ESMTPSA id pp6sm27334951pbb.79.2015.06.24.10.30.00
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jun 2015 10:30:01 -0700 (PDT)
In-Reply-To: <20150624091417.GB5436@peff.net>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272570>

On Wed, 2015-06-24 at 05:14 -0400, Jeff King wrote:
> On Tue, Jun 23, 2015 at 02:18:36PM -0400, David Turner wrote:
> 
> > > Can you describe a bit more about the reflog handling?
> > > 
> > > One of the problems we've had with large-ref repos is that the reflog
> > > storage is quite inefficient. You can pack all the refs, but you may
> > > still be stuck with a bunch of reflog files with one entry, wasting a
> > > whole inode. Doing a "git repack" when you have a million of those has
> > > horrible cold-cache performance. Basically anything that isn't
> > > one-file-per-reflog would be a welcome change. :)
> > 
> > Reflogs are stored in the database as well.  There is one header entry
> > per ref to indicate that a reflog is present, and then one database
> > entry per reflog entry; the entries are stored consecutively and
> > immediately following the header so that it's fast to iterate over them.
> 
> OK, that make sense. I did notice that the storage for the refdb grows
> rapidly. If I add a millions refs (like refs/tags/$i) with a simple
> reflog message "foo", I ended up with a 500MB database file.
> 
> That's _probably_ OK, because a million is getting into crazy
> territory[1].  But it's 500 bytes per ref, each with one reflog entry.
> Our ideal lower bound is probably something like 100 bytes per reflog
> entry:
> 
>   - 20 bytes for old sha1
>   - 20 bytes for new sha1
>   - ~50 bytes for name, email, timestamp
>   - ~6 bytes for refname (1000000 is the longest unique part)
> 
> That assumes we store binary[2] (and not just the raw reflog lines), and
> reconstruct the reflog lines on the fly. It also assumes we use some
> kind of trie-like storage (where we can amortize the cost of storing
> "refs/tags/" across all of the entries).
> 
> Of course that neglects lmdb's overhead, and the storage of the ref tip
> itself. But it would hopefully give us a ballpark for an optimal
> solution. We don't have to hit that, of course, but it's food for
> thought.
> 
> [1] The homebrew/homebrew repository on GitHub has almost half a million
>     ref updates. Since this is storing not just refs but all ref
>     updates, that's actually the interesting number (and optimizing the
>     per-reflog-entry size is more interesting than the per-ref size).
> 
> [2] I'm hesitant to suggest binary formats in general, but given that
>     this is a blob embedded inside lmdb, I think it's OK. If we were to
>     pursue the log-structured idea I suggested earlier, I'm torn on
>     whether it should be binary or not.

I could try a binary format.  I was optimizing for simplicity,
debuggability, recoverability, compatibility with the choice of the text
format, but I wouldn't have to.  I don't know how much this will save.
Unfortunately, given the way LMDB works, a trie-like storage to save
refs/tags does not seem possible (of course, we could hard-code some
hacks like \001=refs/rags, \002=refs/heads, etc but that is a
micro-optimization that might not be worth it.

Also, the reflog header has some overhead (it's an entire extra record
per ref). The header exists to implement reflog creation/existence
checking.  I didn't really try to understand why we have the distinction
between empty and nonexistent reflogs; I just copied it.  If we didn't
have that distinction, we could eliminate that overhead.

> > Thanks, that's valuable.  For the refs backend, opening the LMDB
> > database for writing is sufficient to block other writers.  Do you think
> > it would be valuable to provide a git hold-ref-lock command that simply
> > reads refs from stdin and keeps them locked until it reads EOF from
> > stdin?  That would allow cross-backend ref locking.
> 
> I'm not sure what you would use it for. If you want to update the refs,
> then you can specify a whole transaction with "git update-ref --stdin",
> and that should work whatever backend you choose. Is there some other
> operation you want where you hold the lock for a longer period of time?

I'm sure I had a reason for this at the time I wrote it, but now I can't
think of what it was.  Nevermind!

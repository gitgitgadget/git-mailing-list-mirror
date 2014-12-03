From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/14] Re: copy.c: make copy_fd preserve meaningful errno
Date: Tue, 2 Dec 2014 21:02:17 -0800
Message-ID: <20141203050217.GJ6527@google.com>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
 <20141117233525.GC4336@google.com>
 <CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
 <20141118004841.GE4336@google.com>
 <CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 06:02:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xw259-0001Um-1Z
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 06:02:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbaLCFCW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 00:02:22 -0500
Received: from mail-ig0-f173.google.com ([209.85.213.173]:50411 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705AbaLCFCV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 00:02:21 -0500
Received: by mail-ig0-f173.google.com with SMTP id r2so16257097igi.12
        for <git@vger.kernel.org>; Tue, 02 Dec 2014 21:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=LtelUrNJOoE1rSCye6JyD2RmI0yqeUauSQHFk6HJfL0=;
        b=pdRF3z+UQ2/ebDiOtPr9n+RV6VfqpUDNGHoOKQqdea0NSk5jk+n9SU+FwM0vME9mkr
         eQ7Zq93Vw+hRXat0LL1bnM7dlWfblry/WJH9GsesO0zVNZ19w5SOPHI9myjHsaMSxlKq
         H/lnzI1OUspO/EZJk0r74bipXJ6Jy0tU5b5VMlGCHWPkSWdnDydyYqzniivc0pYjBd2z
         +a+gRIHl5zqOStLsszL6KWdVJ/CTKLnPVurrWbIjjx7P20PrYNc/5cZpGUakW91cZLBL
         L3Xv21OH35D9uWOE0CAJfdromt0z25+K0LT4VMgCUOaCdAmh89hsO8PKsZ9he8opCwpg
         fE6w==
X-Received: by 10.50.134.101 with SMTP id pj5mr6784216igb.28.1417582940336;
        Tue, 02 Dec 2014 21:02:20 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:fd7b:507b:3c7b:554e])
        by mx.google.com with ESMTPSA id a1sm12207893ioa.27.2014.12.02.21.02.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Dec 2014 21:02:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260624>

Stefan Beller wrote:
> On Mon, Nov 17, 2014 at 4:48 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> After this patch, setting errno is not part of the contract of
>> copy_fd, so the bug Ronnie was fixing is gone.
>>
>> But it's a little more invasive.  What do you think?
>
> I really like that approach and would be happy if

Thanks for looking it over, and sorry for the delay.  Here's a series
that carries out that approach.

The patch I'm least happy with in this series is 12/14, mostly because
it's just so noisy.  It would be safe (and non-leaky) to leave out
most of those strbuf_release calls since nobody appends to 'err' in
the non-error case, but always free-ing means that normal escape
analysis can work.  I could be convinced to go either way.

Jonathan Nieder (14):
  strbuf: introduce strbuf_prefixf()
  add_to_alternates_file: respect GIT_OBJECT_DIRECTORY
  copy_fd: pass error message back through a strbuf
  hold_lock_file_for_append: pass error message back through a strbuf
  lock_packed_refs: pass error message back through a strbuf
  lockfile: introduce flag for locks outside .git
  fast-import: use message from lockfile API when writing marks fails
  credentials: use message from lockfile API when locking
    ~/.git-credentials fails
  config: use message from lockfile API when locking config file fails
  rerere: error out on autoupdate failure
  hold_locked_index: pass error message back through a strbuf
  hold_lock_file_for_update: pass error message back through a strbuf
  lockfile: remove unused function 'unable_to_lock_die'
  lockfile: make 'unable_to_lock_message' private

 Documentation/technical/api-lockfile.txt | 41 ++++++---------
 builtin/add.c                            | 12 +++--
 builtin/apply.c                          | 15 ++++--
 builtin/checkout-index.c                 | 10 +++-
 builtin/checkout.c                       | 55 ++++++++++++++------
 builtin/clone.c                          | 12 ++++-
 builtin/commit.c                         | 36 +++++++++----
 builtin/describe.c                       | 11 ++--
 builtin/diff.c                           | 12 +++--
 builtin/gc.c                             |  8 ++-
 builtin/merge.c                          | 14 +++--
 builtin/mv.c                             |  5 +-
 builtin/read-tree.c                      |  9 +++-
 builtin/reset.c                          | 10 +++-
 builtin/rm.c                             |  9 +++-
 builtin/update-index.c                   | 10 ++--
 bundle.c                                 | 10 ++--
 cache-tree.c                             | 18 +++++--
 cache.h                                  |  4 +-
 config.c                                 | 14 +++--
 convert.c                                |  6 ++-
 copy.c                                   | 32 ++++++++----
 credential-store.c                       |  8 ++-
 fast-import.c                            |  9 ++--
 lockfile.c                               | 89 ++++++++++++++------------------
 lockfile.h                               | 13 +++--
 merge-recursive.c                        | 13 +++--
 merge.c                                  | 17 ++++--
 read-cache.c                             |  7 +--
 refs.c                                   | 28 ++++++----
 refs.h                                   |  8 +--
 rerere.c                                 | 24 +++++----
 sequencer.c                              | 33 +++++++++---
 sha1_file.c                              | 17 ++++--
 shallow.c                                | 16 ++++--
 strbuf.c                                 | 16 ++++++
 strbuf.h                                 |  4 ++
 test-scrap-cache-tree.c                  |  5 +-
 38 files changed, 434 insertions(+), 226 deletions(-)

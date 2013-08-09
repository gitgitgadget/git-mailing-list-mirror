From: =?UTF-8?B?0JvQtdC20LDQvdC60LjQvSDQmNCy0LDQvQ==?= 
	<abyss.7@gmail.com>
Subject: Huge possible memory leak while cherry-picking.
Date: Fri, 9 Aug 2013 16:13:17 +0400
Message-ID: <CAJc7LbpRuqug9pLFVVg=XMvJ9u_P0ZVSy2MVBDaCVkjvfKnfJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 09 14:13:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7lZL-00044O-4v
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 14:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967056Ab3HIMNS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 08:13:18 -0400
Received: from mail-vc0-f175.google.com ([209.85.220.175]:62141 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966285Ab3HIMNS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 08:13:18 -0400
Received: by mail-vc0-f175.google.com with SMTP id ia10so944613vcb.6
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 05:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Oj07wSqxGML/L6tJpRBhoQupbZ0iBHpz/0RhbB4aMzk=;
        b=ld/Wa1tJO7ZoZnZjDLMPKesctHsBmPg/cmhPkrncenPLA5y3BGkQPnIyG+7Bq0boey
         jjFQ2LUu/IC6xXqir3uDUpVjtf+0XwDw6fJQ35IXigMpHiiKMJyxdl83RS9KrrIlSm0G
         tpDDFah0PbS7vHAle44eLmsYXNrA5Zc4fzNFmYGx2zHFzDQUmg6hYpfNgGheOMFj7Zl3
         HAU2JnYeQsxVKVtAlYlT/eY+eX2Nt+DZ35HiIsL6lifudXikE9WTN/6pcYETLg0wVqYc
         w5IbN8lKdl1dHudPV2QGhN/uCzspcVsNjsD+Qq74lWP/EAxYyFK0S1P0pl6h1OMCMnXR
         7oLA==
X-Received: by 10.220.84.65 with SMTP id i1mr171000vcl.51.1376050397435; Fri,
 09 Aug 2013 05:13:17 -0700 (PDT)
Received: by 10.58.80.40 with HTTP; Fri, 9 Aug 2013 05:13:17 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231972>

Hi,

I have tried to cherry-pick a range of ~200 commits from one branch to
another. And you can't imagine how I was surprised when the git
process ate 8 Gb of RAM and died - before cherry-picking was complete.

I downloaded git sources from master and built it with gperftools
support (-ltcmalloc). After running `git cherry-pick <some hash>` with
a heap-leak checker enabled I got this:

> Have memory regions w/o callers: might report false leaks
> Leak check _main_ detected leaks of 42838782 bytes in 257986 objects

These objects are allocated at

> read-cache.c:1340: struct cache_entry *ce = xmalloc(cache_entry_size(len));

After looking in the code, I found a comment in the function `static
void remove_dir_entry(...)`:

/*
 * Release reference to the directory entry (and parents if 0).
 *
 * Note: we do not remove / free the entry because there's no
 * hash.[ch]::remove_hash and dir->next may point to other entries
 * that are still valid, so we must not free the memory.
 */

So, this objects are never freed - by design?
Is it a real issue, or do I just misunderstand something?

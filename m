From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Git is not scalable with too many refs/*
Date: Tue, 14 Jun 2011 12:20:29 -0700
Message-ID: <BANLkTin0CjnM_hMaEpMroZdDhhavaoKAv00_4xBqeHj9biToVA@mail.gmail.com>
References: <BANLkTimnCqaEBVreMhnbRBV3r-r1ZzkFcg@mail.gmail.com>
 <7vtybtm3dl.fsf@alter.siamese.dyndns.org> <BANLkTimNoh3-Jde_-arzwBa=aUR+KK3Xhw@mail.gmail.com>
 <201106141202.46720.johan@herland.net> <20110614170214.GB26764@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johan Herland <johan@herland.net>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Andreas Ericsson <ae@op5.se>,
	NAKAMURA Takumi <geek4civic@gmail.com>,
	A Large Angry SCM <gitzilla@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 14 21:21:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWZAW-0005jC-7f
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 21:20:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753033Ab1FNTUu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2011 15:20:50 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:36193 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101Ab1FNTUu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2011 15:20:50 -0400
Received: by yia27 with SMTP id 27so1736428yia.19
        for <git@vger.kernel.org>; Tue, 14 Jun 2011 12:20:49 -0700 (PDT)
Received: by 10.236.44.39 with SMTP id m27mr9631478yhb.92.1308079249075; Tue,
 14 Jun 2011 12:20:49 -0700 (PDT)
Received: by 10.147.182.11 with HTTP; Tue, 14 Jun 2011 12:20:29 -0700 (PDT)
In-Reply-To: <20110614170214.GB26764@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175789>

On Tue, Jun 14, 2011 at 10:02, Jeff King <peff@peff.net> wrote:
> I also think we can do something a little more lightweight. The user has
> already created and is maintaining a mapping in one direction via the
> notes. We just need the inverse mapping, which we can generate
> programatically. So it can be a straight cache, with the sha1 of the
> notes tree determining the cache validity (i.e., if the forward mapping
> in the notes tree changes, you regenerate the cache from scratch).
>
> We would want to store the cache in an on-disk format that could be
> searched easily. Possibly something like the packed-refs format would be
> sufficient, if we mmap'd and binary searched it. It would be dirt simple
> if we used an existing key/value store like gdbm or tokyocabinet, but we
> usually try to avoid extra dependencies.

Yea, not a bad idea. Use a series of SSTable like things, like Hadoop
uses. It doesn't need to be as complex as the Hadoop SSTable concept.
But a simple sorted string to string mapping file that is immutable,
with edits applied by creating an overlay file that contains
new/updated entries.

As you point out, we can use the notes tree to tell us the validity of
the cache, and do incremental updates. If the current cache doesn't
match the notes ref, compute the tree diff between the current cache's
source tree and the new tree, and create a new SSTable like thing that
has the relevant updates as an overlay of the existing tables. After
some time you will have many of these little overlay files, and a GC
can just merge them down to a single file.

The only problem is, you probably want this "reverse notes index" to
be indexing a portion of the note blob text, not all of it. That is,
we want the SVN note text to say something like "SVN Revision: r1828"
so `git log --notes=svn` shows us something more useful than just
"r1828". But in the reverse index, we may only want the key to be
"r1828". So you need some sort of small mapping function to decide
what to put into that reverse index.

-- 
Shawn.

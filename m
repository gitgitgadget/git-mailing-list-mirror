Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C945C46467
	for <git@archiver.kernel.org>; Sat,  7 Jan 2023 13:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjAGNse (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Jan 2023 08:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjAGNsc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2023 08:48:32 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25CF5E088
        for <git@vger.kernel.org>; Sat,  7 Jan 2023 05:48:31 -0800 (PST)
Received: (qmail 23473 invoked by uid 109); 7 Jan 2023 13:48:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 07 Jan 2023 13:48:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23762 invoked by uid 111); 7 Jan 2023 13:48:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 07 Jan 2023 08:48:30 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 7 Jan 2023 08:48:30 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 0/5] cleaning up read_object() family of functions
Message-ID: <Y7l4LsEQcDT9HZ21@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I often get confused about the difference between:

  - read_object()
  - read_object_file();
  - read_object_file_extended();
  - repo_read_object_file();

Since Jonathan's recent cleanups from 9e59b38c88 (object-file: emit
corruption errors when detected, 2022-12-14), these are mostly thin
wrappers around each other and around oid_object_info_extended().

This series shuffles things around a little more so that we are down to
just read_object_file() and repo_read_object_file(). And the
relationship there is pretty easy (and long-term we'd eventually merge
them once everyone has a repository object).

It is a net reduction in lines, even though some of the callers end up a
little longer (because they have to stuff pointers into an object_info
struct). If that's too distasteful, the middle ground is to have a
helper like:

  void *foo(struct repository *r, const struct object_id *oid,
            enum object_type *type, unsigned long *size,
	    unsigned flags)
  {
	struct object_info oi = OBJECT_INFO_INIT;
	void *content;

	oi.typep = type;
	oi.sizep = size;
	oi.contentp = ret;

	if (oid_object_info_extended(r, oid, &oi, flags) < 0)
		return NULL;
	return content;
  }

which is basically the same as read_object(), but makes it clear that
you can pass OBJECT_INFO flags. The trouble is that I could not come up
with a name for it that was not confusing. ;) So just having most places
call oid_object_info_extended() directly seemed better. It would be nice
if that function had a shorter name, too, but I left that for another
day.

  [1/5]: object-file: inline calls to read_object()
  [2/5]: streaming: inline call to read_object_file_extended()
  [3/5]: read_object_file_extended(): drop lookup_replace option
  [4/5]: repo_read_object_file(): stop wrapping read_object_file_extended()
  [5/5]: packfile: inline custom read_object()

 object-file.c  | 52 ++++++++++++++++++--------------------------------
 object-store.h | 18 +++++------------
 packfile.c     | 26 +++++++++----------------
 streaming.c    | 11 ++++++++---
 4 files changed, 41 insertions(+), 66 deletions(-)

-Peff

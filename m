Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E41AB1F404
	for <e@80x24.org>; Wed, 21 Mar 2018 19:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753465AbeCUT2l (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 15:28:41 -0400
Received: from siwi.pair.com ([209.68.5.199]:56636 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753023AbeCUT2i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 15:28:38 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 53E353F4013;
        Wed, 21 Mar 2018 15:28:37 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id CAEE93F4000;
        Wed, 21 Mar 2018 15:28:36 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, avarab@gmail.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v2] routines to generate JSON data
Date:   Wed, 21 Mar 2018 19:28:26 +0000
Message-Id: <20180321192827.44330-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

This is version 2 of my JSON data format routines.  This version addresses
the non-utf8 questions raised on V1.

It includes a new "struct json_writer" which is used to guide the
accumulation of JSON data -- knowing whether an object or array is
currently being composed.  This allows error checking during construction.

It also allows construction of nested structures using an inline model (in
addition to the original bottom-up composition).

The test helper has been updated to include both the original unit tests and
a new scripting API to allow individual tests to be written directly in our
t/t*.sh shell scripts.


TODO
====

I still don't know what to do about the Unicode/UTF-8 questions that
were raised WRT strings.  Pathnames on Linux can be any sequence of 8bit
characters -- this is likely to be UTF-8 on modern systems.  Pathnames on
Windows are UCS2/UTF-16 in the filesystem and we always convert to/from
UTF-8 when moving between git data structures and IO calls.

There are few other fields (like author name) that we may want to log which
may or may not be, but that is beyond our control.  Even localized error
messages may be problematic if they include other fields.

So, I'm not sure we have a route to get UTF-8-clean data out of Git, and if
we do it is beyond the scope of this patch series.

So I think for our uses here, defining this as "JSON-like" is probably the
best answer.  We write the strings as we received them (from the file system,
the index, or whatever).  These strings are properly escaped WRT double
quotes, backslashes, and control characters, so we shouldn't have an issue
with decoders getting out of sync -- only with them rejecting non-UTF-8
sequences.

We could blindly \uXXXX encode each of the hi-bit characters, if that would
help the parsers, but I don't want to do that right now.

WRT binary data, I had not intended using this for binary data.  And without
knowing what kinds or quantity of binary data we might use it for, I'd like
to ignore this for now.


Jeff Hostetler (1):
  json_writer: new routines to create data in JSON format

 Makefile                    |   2 +
 json-writer.c               | 321 +++++++++++++++++++++++++++++++++
 json-writer.h               |  86 +++++++++
 t/helper/test-json-writer.c | 420 ++++++++++++++++++++++++++++++++++++++++++++
 t/t0019-json-writer.sh      | 102 +++++++++++
 5 files changed, 931 insertions(+)
 create mode 100644 json-writer.c
 create mode 100644 json-writer.h
 create mode 100644 t/helper/test-json-writer.c
 create mode 100755 t/t0019-json-writer.sh

-- 
2.9.3


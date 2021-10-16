Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D64C433EF
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 23:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82B4260F8F
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 23:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241142AbhJPXUj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Oct 2021 19:20:39 -0400
Received: from avasout03.plus.net ([84.93.230.244]:43025 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235619AbhJPXUi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Oct 2021 19:20:38 -0400
Received: from [10.0.2.15] ([147.147.167.109])
        by smtp with ESMTPA
        id bswVmQtf3YDhbbswYmGVCC; Sun, 17 Oct 2021 00:18:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1634426305; bh=on3qFBkk6GYXeWaobeWgMSRxrWnv8h6XDwOWGB8oHNM=;
        h=From:To:Cc:Subject:Date;
        b=e4Fup4ZM+vb400heZdGSw31Wnu/gtMg6H4GjlazTupwhYZnj4dD9/PCVnpiR2SC3Y
         xPA/Aio5TEHDnbampSro6e0IJnRs7VJTwt8DhwA1KrCGc1Kw/o1lGeGsjSQhM28kIS
         VMq+BYBs2CFdPYNaM+66nKSAXaZuzs4k5ffyF9c8o0UPLq03uZXhRlP7hpgFt8SgnM
         jOUNGNMIVAQhlM3X0yKELLaVvEXOeCL+KX0WRrS3P7ORr75qeXB7DfWfwTEIkIHy33
         Gal6qRk3ROE1kq6+5fPjW8a/rRNNpL6nl17ULH12aO1E2MIS8yDOBJs0UrBcH4eEuT
         I93dNFTQHPDvA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=O+WiQC1W c=1 sm=1 tr=0
 a=QdS5mZX/VJYKMdXaSBaSIA==:117 a=QdS5mZX/VJYKMdXaSBaSIA==:17
 a=IkcTkHD0fZMA:10 a=_3b5S5OhKBgeyNcIHxkA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Build failure of 'seen'
Message-ID: <48748e0e-7c18-b7ff-e1c3-ac0733cc7d34@ramsayjones.plus.com>
Date:   Sun, 17 Oct 2021 00:18:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfLAcML/u6xVI2gkPMSNIUgofiYtaj3VlEfYkkvZFyEfhkIp0CTRxyOz5MpwjNd0WU9A2//EB649jj7At/67QxesU4tEB5htrwY1CeTHuutAbVJn0Fgww
 5Irq9W/jLa2bDjZTeSZEK1Bu1VQ/5z+vpUv/3ZWM5/anc0MKP7xG79Jzi7IDqUWnju0Bm5Rw2fk9eA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Tonight's build of 'seen' failed for me (on Linux and Cygwin):

      CC refs/files-backend.o
  refs/files-backend.c: In function ‘files_reflog_expire’:
  refs/files-backend.c:3212:11: error: ‘type’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
   3212 |    !(type & REF_ISSYMREF) &&
        |     ~~~~~~^~~~~~~~~~~~~~~
  cc1: all warnings being treated as errors
  make: *** [Makefile:2555: refs/files-backend.o] Error 1
  $ 

gcc correctly complains, since 'type' _will_ be used uninitialized.
Note that, despite passing &type to the lock_ref_oid_basic() function,
the body of that function does not mention the parameter at all. 

I just did the obvious to get it to compile:

  $ git diff
  diff --git a/refs/files-backend.c b/refs/files-backend.c
  index ca35950a80..c7ac1d1d6b 100644
  --- a/refs/files-backend.c
  +++ b/refs/files-backend.c
  @@ -3132,7 +3132,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
          struct strbuf log_file_sb = STRBUF_INIT;
          char *log_file;
          int status = 0;
  -       int type;
  +       int type = 0;
          struct strbuf err = STRBUF_INIT;
          const struct object_id *oid;
   
  $ 

... but (as you already noted) it fails the testsuite anyway.

Don't quote me (because I didn't look too hard), but I think that
commit 5bad105452 ("refs/files: remove "name exist?" check in
lock_ref_oid_basic()", 2021-10-14) removed the last use of the 'type'
parameter to lock_ref_oid_basic(). (when removing a call to the function
refs_resolve_ref_unsafe()).

ATB,
Ramsay Jones




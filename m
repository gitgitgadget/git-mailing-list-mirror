From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [BAD PATCH 0/9] v4-aware tree walker API
Date: Wed,  9 Oct 2013 21:46:07 +0700
Message-ID: <1381329976-32082-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Oct 09 16:42:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTuyO-0006xN-F4
	for gcvg-git-2@plane.gmane.org; Wed, 09 Oct 2013 16:42:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754325Ab3JIOmo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Oct 2013 10:42:44 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:64000 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753343Ab3JIOmn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Oct 2013 10:42:43 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc17so1006179pbc.32
        for <git@vger.kernel.org>; Wed, 09 Oct 2013 07:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=trx2RnhnBN8iPGL6G1LS3VRrXd6+37WSLOTfcRNEZcc=;
        b=vA9zeGuFBq5ZaROJmQLtt2U9fluBqN9MHovwGhnLIRyFc71o8uGk1HKvRsa0MZdEOf
         GkXqFjWzs9iRbjqUjXKur36F+07xPVRxuMnmQqzB3GHy9U44YXAVvXFI0+zWpr/PdUUi
         o0F3GPVabAtr/JBh+p1Pneicy3P9R10qjXRuzFvvgViFXKGNvdkHNBjdsHo3DchJAK4X
         KPAeBPNWDQF9O4LDTCVrvqx5hpRpzhsN7VS+7+KZEZzNFwGyHpAZOA9F6LTormVLI9GI
         fXy1H6OlKnS0xRjxroiMv/fVKAHRKAuD5vUBkEcf0lltw7pnmxqZL/0S277bUl4OpKnp
         PZaQ==
X-Received: by 10.66.4.5 with SMTP id g5mr2132892pag.187.1381329762324;
        Wed, 09 Oct 2013 07:42:42 -0700 (PDT)
Received: from lanh ([115.73.225.201])
        by mx.google.com with ESMTPSA id qp10sm55396570pab.13.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 09 Oct 2013 07:42:41 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 09 Oct 2013 21:46:24 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235813>

I know I still have a lot of holes to plug, but this was more
interesting because we could see some encouraging numbers.
Unfortunately the result is disappointing. Maybe I did it in a stupid
way and need to restart with a totally different way.

"rev-list --objects" on v2 takes 4 secs, v4 with current walker 11s
and the new walker 16s (worst!). perf's top functions with v2 are

 23,51%  git  libz.so.1.2.7       [.] inflate
 16,66%  git  git                 [.] lookup_object
 11,46%  git  libz.so.1.2.7       [.] inflate_fast
  6,89%  git  libc-2.16.so        [.] __memcpy_ssse3_back
  4,19%  git  libz.so.1.2.7       [.] inflate_table
  4,15%  git  git                 [.] find_pack_entry_one
  3,84%  git  git                 [.] decode_tree_entry

and with new walker

 58,61%  git  git                [.] decode_entries
 18,66%  git  git                [.] decode_varint
  9,73%  git  git                [.] use_pack
  3,31%  git  git                [.] nth_packed_object_offset
  1,73%  git  git                [.] process_tree
  1,66%  git  git                [.] pv4_lookup_blob
  1,09%  git  git                [.] get_pathref
  1,03%  git  libc-2.16.so       [.] __memcpy_ssse3_back
  0,90%  git  libz.so.1.2.7      [.] inflate
  0,50%  git  libz.so.1.2.7      [.] inflate_table

It's no surprise that lookup_object is no longer hot. The closet is
pv4_lookup_blob. nth_packed_object_offset is getting hotter as it's
used extensively by decode_entries.

And decode_entries is getting toooo hot. This function is now called
for each tree entry of every tree. And it does get_tree_offset_cache()
lookup for every call (ironically we try hard to avoid hash lookup in
lookup_object).

The only bit I haven't done is avoid checking if a tree is already
examined, if so do not bother with copy sequences referring to it.
That should cut down the number of decode_entries but not sure how
much because there's no relation between tree traversing order and how
copy sequences are made.

Maybe we could make an exception and allow the tree walker to pass
pv4_tree_cache* directly to decode_entries so it does not need to do
the first lookup every time..

Suggestions?

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (9):
  sha1_file: provide real packed type in object_info_extended
  pack v4: move v2 tree entry generation code out of decode_entries
  pv4_tree_desc: introduce new struct for pack v4 tree walker
  pv4_tree_desc: use struct tree_desc from pv4_tree_desc
  pv4_tree_desc: allow decode_entries to return v4 trees, one at a time
  pv4_tree_desc: complete interface
  pv4_tree_desc: don't bother looking for v4 trees if no v4 packs are p=
resent
  pv4_tree_desc: avoid lookup_object() when possible
  list-object.c: take "advantage" of new pv4_tree_desc interface

 cache.h        |   3 +-
 list-objects.c |  38 +++++----
 packv4-parse.c | 263 ++++++++++++++++++++++++++++++++++++++++++++++---=
--------
 packv4-parse.h |  48 +++++++++++
 sha1_file.c    |   9 +-
 streaming.c    |   9 +-
 6 files changed, 300 insertions(+), 70 deletions(-)

--=20
1.8.2.83.gc99314b

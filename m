Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BFFC433DF
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 18:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1445220809
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 18:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TnALcJwj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730367AbgG3SCl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 14:02:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51008 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgG3SCk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 14:02:40 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7462F6C4BB;
        Thu, 30 Jul 2020 14:02:38 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=qEowMNR6eG+YpJ0GDja5jhcHL
        rk=; b=TnALcJwjwzGx7QHLytBfwT4O8sGB6iTq77IaQToNNtU07OaBnfU9W0aJy
        Td1p/SM37sTCtfx4jdIaY46TbIsPpTlCekzBULDDSUmGuWpWPxgMNWqQWdcUhRN+
        /rpNNG7SXEW6s8uxjA0LpWCNv4O167sWzpbZv/RU88/GCgYbMA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=oTVzII3DO+J5d9/2wex
        zwr3iCGRrp/w0vtpJVYK6v7LMpa/MFWt25jvIQgfIKxyCN+4XheUVYIEwMAdvG8h
        OGBRk/yc2fDA+7hhSJgk9oTsL9ISNfNT055As+GWINoujaijR8hgY7+fPjy0QpA4
        e/B4MvQHBvTsDMShYBJ4/o/Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6CD9C6C4BA;
        Thu, 30 Jul 2020 14:02:38 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E019C6C4B9;
        Thu, 30 Jul 2020 14:02:37 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v3 0/2] fmt-merge-msg: selectively suppress "into <branch>"
Date:   Thu, 30 Jul 2020 11:02:35 -0700
Message-Id: <20200730180237.1392480-1-gitster@pobox.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <xmqq5za596uo.fsf@gitster.c.googlers.com>
References: <xmqq5za596uo.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: DA630B64-D28E-11EA-8B22-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So, this is the third iteration, which separates the reversion that
involves too many uninteresting test changes, and the implementation
of the new feature proper.

Two things that changed in the implementation since the previous
iterations are

 - An assignment-less 'truth', i.e.

	[merge] suppressDest

   is now an error ("missing value for 'merge.suppressDest'"), not
   "clear the list", which should be spelled as an empty string, i.e.

        [merge] suppressDest =3D ""

 - Scanning of dest_patterns to see if "into <branch>" is suppressed
   for the current_branch is done in a helper function to make the
   main codeflow easier to read, as suggested by Peff.

The previous iterations were

 v1 <xmqqlfj27x7q.fsf@gitster.c.googlers.com>
 v2 <xmqq5za596uo.fsf@gitster.c.googlers.com>

and can be found at https://lore.kernel.org/git/

Junio C Hamano (2):
  Revert "fmt-merge-msg: stop treating `master` specially"
  fmt-merge-msg: allow merge destination to be omitted again

 Documentation/config/fmt-merge-msg.txt        | 12 ++++
 fmt-merge-msg.c                               | 35 ++++++++-
 t/t1507-rev-parse-upstream.sh                 |  2 +-
 t/t4013-diff-various.sh                       |  4 +-
 t/t4013/diff.log_--decorate=3Dfull_--all        |  2 +-
 t/t4013/diff.log_--decorate_--all             |  2 +-
 ...--patch-with-stat_--summary_master_--_dir_ |  2 +-
 t/t4013/diff.log_--patch-with-stat_master     |  2 +-
 .../diff.log_--patch-with-stat_master_--_dir_ |  2 +-
 ...ot_--cc_--patch-with-stat_--summary_master |  2 +-
 ..._--root_--patch-with-stat_--summary_master |  2 +-
 .../diff.log_--root_--patch-with-stat_master  |  2 +-
 ...root_-c_--patch-with-stat_--summary_master |  2 +-
 t/t4013/diff.log_--root_-p_master             |  2 +-
 t/t4013/diff.log_--root_master                |  2 +-
 t/t4013/diff.log_-m_-p_--first-parent_master  |  2 +-
 t/t4013/diff.log_-m_-p_master                 |  4 +-
 t/t4013/diff.log_-p_--first-parent_master     |  2 +-
 t/t4013/diff.log_-p_master                    |  2 +-
 t/t4013/diff.log_master                       |  2 +-
 t/t4013/diff.show_--first-parent_master       |  2 +-
 t/t4013/diff.show_-c_master                   |  2 +-
 t/t4013/diff.show_-m_master                   |  4 +-
 t/t4013/diff.show_master                      |  2 +-
 ...ot_--cc_--patch-with-stat_--summary_master |  2 +-
 ...root_-c_--patch-with-stat_--summary_master |  2 +-
 t/t4202-log.sh                                | 72 +++++++++----------
 t/t6200-fmt-merge-msg.sh                      | 56 ++++++++++-----
 t/t7600-merge.sh                              | 14 ++--
 t/t7608-merge-messages.sh                     | 10 +--
 30 files changed, 159 insertions(+), 94 deletions(-)

--=20
2.28.0


From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 00/48] Libifying git apply
Date: Wed,  9 Mar 2016 18:48:28 +0100
Message-ID: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 09 18:52:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiH2-0007Hf-E5
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 18:51:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933502AbcCIRvs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 12:51:48 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:33067 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753423AbcCIRvr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 12:51:47 -0500
Received: by mail-wm0-f45.google.com with SMTP id l68so203638605wml.0
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 09:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=YN3vvmpTHRhg753dxaf4CzovqntoEOxzk+toanoFk88=;
        b=Zp8H6ekiIMHAJOcJgQoSzvJz5pOoobSqsGdU5dM83tR6TTw+KXoP9titNZPpaB3Yu9
         ZCAw4L2f/gtIqgP0EbKiPtL3bdkx3bLRxL6D9Yfo8+MBTP88kvt7+k23zwQ+aTxyeHYG
         9w+wAF7d0DEqBPlFMRw3dwsekEd0aksqUV0GE1jaF+cZg1AxVJEKviR7nbxSrPMamlhv
         T29JMT+nL2nAyTlUtknfI5jFkvm5b+WbXsKjLeHLkjz5j++0nKbqrINXk06jWM1/WJ9M
         u9mTUsSv1FskwqeiLPZKaVpMZU9d0Ak1rzDOK+v2vo3e2Fi/RqHumjZTkajSmz8wIvWs
         MQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YN3vvmpTHRhg753dxaf4CzovqntoEOxzk+toanoFk88=;
        b=BL9p+k2SSxUgMeB4AknQ1Nco4W8nQqA298/xfwOdaJRbW+qwDdEV9I7P0h5vE4tqfk
         MVpud5RSSsFrypF6ZeyO3RpqejUbpAy5lm2Thw5VA7557OIH1hMIgddCmrh02XO54fDp
         SC/O9tEUKR9oj+sQ+f2Tq0qNWZqDT+r2xlGDbBlKgae7DTLwtNr40DZf1FE66eDwbqT6
         DORgh4TSPbBvsn/W4mxbkYZb1j8EZcfKZNLVBQuh4SYZIrcweFw01eX0oLFtVM+TWEGI
         X8PzMiU4w/bYo6kHMSCE4/5dD4mKdzJ/E1hprb8wGrx9ONg+YdfNWW/aJFktpZAZXuWt
         daaw==
X-Gm-Message-State: AD7BkJLwqmGL9gAAEjAzwf04X7sU5oa6B6yoGQ/46aKb6rgs6VzJmVJdsbxid6c/yjQEOw==
X-Received: by 10.28.107.9 with SMTP id g9mr6014268wmc.34.1457545906185;
        Wed, 09 Mar 2016 09:51:46 -0800 (PST)
Received: from localhost.localdomain ([80.215.161.239])
        by smtp.gmail.com with ESMTPSA id e127sm24975419wma.20.2016.03.09.09.51.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 09:51:45 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc1.49.gca61272
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288489>

This is a patch series about libifying "git apply" functionality, to
be able to use this functionality in "git am" without spawning new
processes. This should make "git am" and "git rebase" significantly
faster.

This has been discussed in the following thread:

http://thread.gmane.org/gmane.comp.version-control.git/287236/

This RFC patch series for now just gets rid of the global variables
and refactors the code around a bit.

As suggested by Junio the global variables in builtin/apply.c are just
thrown into a single "apply_state" structure that is passed around the
callchain. A new parameter called "state" that is a pointer to the
"apply_state" structure comes at the beginning of the helper functions
that need it.

Before I make further changes to handle erroneous input and make the
libified functions not die() and properly clean things up, I'd be
happy to get some feedback.

One point I'd especially welcome feedback about is the fact that there
are many boolean options that are using OPT_BOOL(...), so they use an
int. And there are a few others that are using OPT_BIT(...), so they
use just a bit. I wonder if it is worth it to try to be consistent,
and maybe also to try to save some memory.

Related to this, some of the variables for these options have not been
moved into the "apply_state" structure, because they are not global to
the file, but maybe for consistency they should be.

Christian Couder (48):
  builtin/apply: avoid parameter shadowing 'p_value' global
  builtin/apply: avoid parameter shadowing 'linenr' global
  builtin/apply: avoid local variable shadowing 'len' parameter
  builtin/apply: extract line_by_line_fuzzy_match() from
    match_fragment()
  builtin/apply: move 'options' variable into cmd_apply()
  builtin/apply: introduce 'struct apply_state' to start libifying
  builtin/apply: move 'newfd' global into 'struct apply_state'
  builtin/apply: move 'unidiff_zero' global into 'struct apply_state'
  builtin/apply: move 'check' global into 'struct apply_state'
  builtin/apply: move 'check_index' global into 'struct apply_state'
  builtin/apply: move 'apply_in_reverse' global into 'struct
    apply_state'
  builtin/apply: move 'apply_with_reject' global into 'struct
    apply_state'
  builtin/apply: move 'apply_verbosely' global into 'struct apply_state'
  builtin/apply: move 'update_index' global into 'struct apply_state'
  builtin/apply: move 'allow_overlap' global into 'struct apply_state'
  builtin/apply: move 'cached' global into 'struct apply_state'
  builtin/apply: move 'diffstat' global into 'struct apply_state'
  builtin/apply: move 'numstat' global into 'struct apply_state'
  builtin/apply: move 'summary' global into 'struct apply_state'
  builtin/apply: move 'threeway' global into 'struct apply_state'
  builtin/apply: move 'no-add' global into 'struct apply_state'
  builtin/apply: move 'unsafe_paths' global into 'struct apply_state'
  builtin/apply: move 'line_termination' global into 'struct
    apply_state'
  builtin/apply: move 'fake_ancestor' global into 'struct apply_state'
  builtin/apply: move 'p_context' global into 'struct apply_state'
  builtin/apply: move 'apply' global into 'struct apply_state'
  builtin/apply: move 'read_stdin' global into cmd_apply()
  builtin/apply: move 'lock_file' global into 'struct apply_state'
  builtin/apply: move 'patch_input_file' global into 'struct
    apply_state'
  builtin/apply: move 'limit_by_name' global into 'struct apply_state'
  builtin/apply: move 'has_include' global into 'struct apply_state'
  builtin/apply: move 'p_value' global into 'struct apply_state'
  builtin/apply: move 'p_value_known' global into 'struct apply_state'
  builtin/apply: move 'root' global into 'struct apply_state'
  builtin/apply: move 'whitespace_error' global into 'struct
    apply_state'
  builtin/apply: move 'whitespace_option' into 'struct apply_state'
  builtin/apply: remove whitespace_option arg from
    set_default_whitespace_mode()
  builtin/apply: move 'squelch_whitespace_errors' into 'struct
    apply_state'
  builtin/apply: move 'applied_after_fixing_ws' into 'struct
    apply_state'
  builtin/apply: move 'ws_error_action' into 'struct apply_state'
  builtin/apply: move 'ws_ignore_action' into 'struct apply_state'
  builtin/apply: move 'max_change' and 'max_len' into 'struct
    apply_state'
  builtin/apply: move 'linenr' global into 'struct apply_state'
  builtin/apply: move 'fn_table' global into 'struct apply_state'
  builtin/apply: move 'symlink_changes' global into 'struct apply_state'
  builtin/apply: move 'state' init into init_apply_state()
  builtin/apply: move 'state' check into check_apply_state()
  builtin/apply: move applying patches into apply_all_patches()

 builtin/apply.c | 1424 +++++++++++++++++++++++++++++++------------------------
 1 file changed, 817 insertions(+), 607 deletions(-)

-- 
2.8.0.rc1.49.gca61272

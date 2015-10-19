From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 00/34] libify mailinfo and call it directly from am
Date: Mon, 19 Oct 2015 00:28:17 -0700
Message-ID: <1445239731-10677-1-git-send-email-gitster@pobox.com>
References: <1444855557-2127-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 19 09:29:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zo4sO-0002R0-EU
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 09:29:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618AbbJSH2z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 03:28:55 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34663 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbbJSH2y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 03:28:54 -0400
Received: by padhk11 with SMTP id hk11so21764098pad.1
        for <git@vger.kernel.org>; Mon, 19 Oct 2015 00:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=1lS7tgUMKS3y33UMlD0JYG+T3fVpZ0p8ZTVrzH3ciVE=;
        b=sn+I775tWJIY7LBCW+c8KK4yCWxSVM3/Q71QdhoIcQcfYgIbUkHpb848ZyJwtvsKfg
         udA2QchITg2WNX8QuS3lvTMNt0T++R8v6YIgtWmuZqWCBtSL/mqW2N4pTIgvY2hplCkw
         IqsFkX4IG+Ti6+wwsHRLl1Q03/hqFVKpEaxYMZUm2O4trDOpcZjhnuELK1Vk6Z3aGijy
         lwSzLXhkY7I5+Oz+2Lb2q72MsvhAzN87BKlGcvlPVn0LNs0iPAl64uvyNRC0iMoXtrDE
         ON2hxGtDMIRU8sNpklHxBi4YYWh680ZtjYH4cxPlygDkO91OmcIanLQwWJjNk3AheqLC
         18jQ==
X-Received: by 10.66.160.100 with SMTP id xj4mr32927616pab.39.1445239733942;
        Mon, 19 Oct 2015 00:28:53 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:f5db:ee54:4f5:9373])
        by smtp.gmail.com with ESMTPSA id zk3sm17259903pbb.41.2015.10.19.00.28.51
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 19 Oct 2015 00:28:52 -0700 (PDT)
X-Mailer: git-send-email 2.6.2-388-g10c4a0e
In-Reply-To: <1444855557-2127-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279832>

During the discussion on the recent "git am" regression, I noticed
that the command reimplemented in C spawns one "mailsplit" and then
spawns "mailinfo" followed by "apply --index" to commit the changes
described in each message.  As there are platforms where spawning
subprocess via run_command() interface is heavy-weight, something
that is conceptually very simple like "mailinfo" is better called
directly inside the process---something that is lightweight and
frequently used is where the overhead of run_command() would be felt
most.

I think this round is ready for 'next'.  Relative to the previous
round, the changes are:

 * Editorial fixes on log messages.

 * The previous round leaked some fields in struct mailinfo upon
   completion (of course, inherited from the original that let the
   system clean them up upon process termination).  clear_mailinfo()
   has been enhanced to clear them.

 * The step to remove the global "line" variable has been split into
   multiple steps.

 * The step to move metainfo_charset to the struct has been split
   into two.

And here are the patches.

  mailinfo: remove a no-op call convert_to_utf8(it, "")
  mailinfo: fold decode_header_bq() into decode_header()
  mailinfo: fix an off-by-one error in the boundary stack
  mailinfo: explicitly close file handle to the patch output
  mailinfo: move handle_boundary() lower
  mailinfo: get rid of function-local static states

Mostly unchanged other than editorial fixes on their log messages.

  mailinfo: do not let handle_body() touch global "line" directly
  mailinfo: do not let handle_boundary() touch global "line" directly
  mailinfo: do not let find_boundary() touch global "line" directly
  mailinfo: move global "line" into mailinfo() function

After Stefan's review comments, I wanted to be really sure that this
conversion was correct.  Blindingly replacing the reference to the
global with a pointer passed from the callern is not sufficient to
ensure that the change is a no-op; the patches needed to show that
the pointer passed from the caller is always the global "line".  For
that, the patch [v2 7/31] needed to be split further into 3 patches
to convert three functions, each of which always is called with the
pointer that points at the global "line", in separate steps.

  mailinfo: introduce "struct mailinfo" to hold globals

The previous round was lazy and did not introduce clear_mailinfo()
until later, leaking the two strbuf moved into the struct.  The
original was leaking the global anyway, so it is not a big deal, but
this round adds corresponding clean-up as the patches move global
variables to the struct, which should make it harder to miss
forgotten clean-up.

  mailinfo: move keep_subject & keep_non_patch_bracket to struct mailinfo
  mailinfo: move global "FILE *fin, *fout" to struct mailinfo
  mailinfo: move filter/header stage to struct mailinfo
  mailinfo: move patch_lines to struct mailinfo
  mailinfo: move add_message_id and message_id to struct mailinfo
  mailinfo: move use_scissors and use_inbody_headers to struct mailinfo
  mailinfo: move metainfo_charset to struct mailinfo

Mostly unchanged, except for the clean-up in clear_mailinfo().

  mailinfo: move check for metainfo_charset to convert_to_utf8()

Eric's review noticed that the previous round conflated this step
in the previous step.  Separated the change to its own commit.

  mailinfo: move transfer_encoding to struct mailinfo
  mailinfo: move charset to struct mailinfo
  mailinfo: move cmitmsg and patchfile to struct mailinfo
  mailinfo: move [ps]_hdr_data to struct mailinfo
  mailinfo: move content/content_top to struct mailinfo

Mostly unchanged, except for the clean-up in clear_mailinfo().

  mailinfo: handle_commit_msg() shouldn't be called after finding patchbreak
  mailinfo: keep the parsed log message in a strbuf

These two were placed earlier in the series in the previous round,
but are not about moving globals to struct.  This round finishes
moving the globals to struct mailinfo before doing these two steps.

  mailinfo: move read_one_header_line() closer to its callers
  mailinfo: move check_header() after the helpers it uses
  mailinfo: move cleanup_space() before its users
  mailinfo: move definition of MAX_HDR_PARSED closer to its use

Mostly unchanged.  These are pure shuffling of functions and
variables to lose forward declarations and to allow easier reading
by grouping related things together.

  mailinfo: libify

Mostly pure code movement that is unchanged since v2.

  mailinfo: handle charset conversion errors in the caller
  mailinfo: remove calls to exit() and die() deep in the callchain
  am: make direct call to mailinfo

 Makefile                         |    1 +
 builtin/am.c                     |   42 +-
 builtin/mailinfo.c               | 1137 ++------------------------------------
 builtin/mailinfo.c => mailinfo.c |  799 +++++++++++++--------------
 mailinfo.h                       |   41 ++
 5 files changed, 505 insertions(+), 1515 deletions(-)
 rewrite builtin/mailinfo.c (95%)
 copy builtin/mailinfo.c => mailinfo.c (67%)
 create mode 100644 mailinfo.h

-- 
2.6.2-383-g144b2e6

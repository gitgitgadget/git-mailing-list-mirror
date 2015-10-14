From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 00/31] libify mailinfo and call it directly from am
Date: Wed, 14 Oct 2015 13:45:26 -0700
Message-ID: <1444855557-2127-1-git-send-email-gitster@pobox.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 22:48:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmSyn-0003xF-1f
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 22:48:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932555AbbJNUqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 16:46:22 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34657 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932238AbbJNUp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 16:45:59 -0400
Received: by payp3 with SMTP id p3so16201722pay.1
        for <git@vger.kernel.org>; Wed, 14 Oct 2015 13:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=zbXMacMtBXjJYPTl/d8qYNdDHYjkjbGLTQRWEEojUok=;
        b=mc9RKb4feX0Icligz5m7W36PnhQyQcZNw4Gq1s2/ykQ1T4raOHHbG6yRepQxWgYE1N
         v/PIkU4mq2nctRyMDfyvv30uzi4FsCQHUf9gNHfQ16F++nfrSSFTG1chdiX20s7qJ6kC
         X+J4d3r/jRKw/W+zzrErL288ZZojW0Zc2L83Hk1c4zZD2f6w1mM6+pRNUrLS3pDGdeY6
         kMTq8TMEYlNREEbiVikdwxIhA5aNxXJ0YlqpcWUfHUXUOY+v5Tei1WVoWO6a9bfd82qh
         5winpvMywfM0702/JO7ytNmmOcjwHPN43+uKPu9mSthQyW460IA4nl1LD1Za57gR7VSe
         c/HQ==
X-Received: by 10.68.216.193 with SMTP id os1mr5604117pbc.110.1444855558840;
        Wed, 14 Oct 2015 13:45:58 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7964:41eb:7b4:cd77])
        by smtp.gmail.com with ESMTPSA id xa4sm11339586pac.28.2015.10.14.13.45.58
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 Oct 2015 13:45:58 -0700 (PDT)
X-Mailer: git-send-email 2.6.1-320-g86a1181
In-Reply-To: <1444778207-859-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279625>

During the discussion on the recent "git am" regression, I noticed
that the command reimplemented in C spawns one "mailsplit" and then
spawns "mailinfo" followed by "apply --index" to commit the changes
described in each message.  As there are platforms where spawning
subprocess via run_command() interface is heavy-weight, something
that is conceptually very simple like "mailinfo" is better called
directly inside the process---something that is lightweight and
frequently used is where the overhead of run_command() would be felt
most.

And here is that topic, slightly reordered and polished up, since
yesterday's version.

 - The series no longer depends on an unrelated "how about this" patch
   to mailinfo.

 - Fixes are moved to earlier spots in the series.

 - Error checking in the endgame patch has been tightened.

Junio C Hamano (31):
  mailinfo: remove a no-op call convert_to_utf8(it, "")
  mailinfo: fix for off-by-one error in boundary stack
  mailinfo: explicitly close file handle to the patch output
  mailinfo: fold decode_header_bq() into decode_header()
  mailinfo: move handle_boundary() lower
  mailinfo: get rid of function-local static states
  mailinfo: always pass "line" as an argument
  mailinfo: move global "line" into mailinfo() function
  mailinfo: introduce "struct mailinfo" to hold globals
  mailinfo: move keep_subject & keep_non_patch_bracket to struct mailinfo
  mailinfo: move global "FILE *fin, *fout" to struct mailinfo
  mailinfo: move filter/header stage to struct mailinfo
  mailinfo: move patch_lines to struct mailinfo
  mailinfo: move add_message_id and message_id to struct mailinfo
  mailinfo: move use_scissors and use_inbody_headers to struct mailinfo
  mailinfo: move metainfo_charset to struct mailinfo
  mailinfo: move transfer_encoding to struct mailinfo
  mailinfo: move charset to struct mailinfo
  mailinfo: handle_commit_msg() shouldn't be called after finding patchbreak
  mailinfo: move cmitmsg and patchfile to struct mailinfo
  mailinfo: move [ps]_hdr_data to struct mailinfo
  mailinfo: keep the parsed log message in a strbuf
  mailinfo: move content/content_top to struct mailinfo
  mailinfo: move read_one_header_line() closer to its callers
  mailinfo: move check_header() after the helpers it uses
  mailinfo: move cleanup_space() before its users
  mailinfo: move definition of MAX_HDR_PARSED to closer to its use
  mailinfo: libify
  mailinfo: handle charset conversion errors in the caller
  mailinfo: remove calls to exit() and die() deep in the callchain
  am: make direct call to mailinfo

 Makefile           |    1 +
 builtin/am.c       |   42 ++-
 builtin/mailinfo.c | 1055 +---------------------------------------------------
 mailinfo.c         | 1024 ++++++++++++++++++++++++++++++++++++++++++++++++++
 mailinfo.h         |   41 ++
 5 files changed, 1109 insertions(+), 1054 deletions(-)
 create mode 100644 mailinfo.c
 create mode 100644 mailinfo.h

-- 
2.6.1-320-g86a1181

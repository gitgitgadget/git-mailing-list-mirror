From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 00/26] mailinfo libification
Date: Tue, 13 Oct 2015 16:16:21 -0700
Message-ID: <1444778207-859-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 01:17:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zm8oi-00064u-Aq
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 01:17:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924AbbJMXQu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 19:16:50 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33104 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717AbbJMXQt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 19:16:49 -0400
Received: by pabrc13 with SMTP id rc13so34522492pab.0
        for <git@vger.kernel.org>; Tue, 13 Oct 2015 16:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id;
        bh=IpzjF5IcySs/8YS2TuD2XpFu+51KBtP2XW5o1WPQ32M=;
        b=S6tcEPKDWMPriNXWXtUI8aJAOvu2JBdlVsdlAYZReTZDFpvDjytoszWEy+8hARNWcP
         CJjGtAk7LN8lsJgn58YBcEKWD86Xw+puMuy1R+H/rTYDfgX0riteKGfc5523N40Eweeh
         3xboWXWr7f7BXilbvKIvhSrUlBJf42iGRZYq7bAHjZVVHmdpgHdxa21FyfU27uxSXlgU
         Gh8Y0/8HaRmDHSWg/JpMWZVKNcViMD8R1IxLstwosm8FMuLvVe8pAxtSOsrn1BkZhU70
         2pbXLyLnqvcVelK0Pv45+Hoq8CnBF+Dk3Q+VSsE9fUgV7JzIxgXojyPu49+6rumnIqCQ
         pVGg==
X-Received: by 10.66.221.104 with SMTP id qd8mr44538602pac.155.1444778209383;
        Tue, 13 Oct 2015 16:16:49 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:45f3:915b:d2ba:37bc])
        by smtp.gmail.com with ESMTPSA id or9sm5848967pbb.17.2015.10.13.16.16.48
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 13 Oct 2015 16:16:48 -0700 (PDT)
X-Mailer: git-send-email 2.6.1-320-g86a1181
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279530>

So here is an attempt to libify "git mailinfo" so that the built-in
version of "git am" does not have to run it via run_command()
interface.  "git am", when fed an N-patch series, runs one
"mailsplit", N "mailinfo" and N "apply" all via run_command()
interface (plus 2 more "apply" and 1 "merge-recursive" per a patch
that does not apply cleanly, when run with the "-3" option), and
among the various programs spawned from "git am", "mailinfo" is the
most straight-forward, stupid and light-weight program, so it is a
no-brainer to pick it as the candidate for libification.

This goes on top of c5920b21 (mailinfo: ignore in-body header that
we do not care about, 2015-10-08) that was posted earlier as a
weatherbaloon patch.

Junio C Hamano (26):
  mailinfo: remove a no-op call convert_to_utf8(it, "")
  mailinfo: fix for off-by-one error in boundary stack
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
  mailinfo: handle errors found in decode_header() better
  mailinfo: handle charset conversion errors in the caller
  mailinfo: remove calls to exit() and die() deep in the callchain
  mailinfo: libify the whole thing

 Makefile           |    1 +
 builtin/mailinfo.c | 1083 +---------------------------------------------------
 mailinfo.c         | 1058 ++++++++++++++++++++++++++++++++++++++++++++++++++
 mailinfo.h         |   41 ++
 4 files changed, 1120 insertions(+), 1063 deletions(-)
 create mode 100644 mailinfo.c
 create mode 100644 mailinfo.h

-- 
2.6.1-320-g86a1181

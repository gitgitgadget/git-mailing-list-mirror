Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40C9C433DF
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 14:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B2E524873
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 14:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388756AbgJMOlW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 10:41:22 -0400
Received: from elephants.elehost.com ([216.66.27.132]:54291 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729605AbgJMOlW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 10:41:22 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [173.32.57.223])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 09DEfJrL062452
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Tue, 13 Oct 2020 10:41:20 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Subject: [Bug] Git 2.29.0-rc1 t5562.8 Hang on NonStop
Date:   Tue, 13 Oct 2020 10:41:13 -0400
Message-ID: <05db01d6a16e$e9cc8ea0$bd65abe0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AdahbtgR32BU2G8YToOiAiqDhbH5+Q==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a repeat of a prior unresolved situation. During the full regression
suite, subtest t5562.8 (fetch gzipped empty) appears to have hung on the
NonStop port. The code was in a loop repeatedly calling waitpid here in
git-http-backend:

  waitpid + 0x320 (SLr)
  $n_EnterPriv + 0x280 (Milli)
  cleanup_children + 0x250 (UCr)
  cleanup_children_on_exit + 0x30 (UCr)
  git_atexit_dispatch + 0xB0 (UCr)
  __process_atexit_functions + 0xA0 (DLL zcredll)
  CRE_TERMINATOR_ + 0xB50 (DLL zcredll)
  exit + 0x2A0 (DLL zcrtldll)
  die_webcgi + 0xA0 (UCr)
  die_errno + 0x150 (UCr)
  write_or_die + 0xC0 (UCr)
  end_headers + 0x70 (UCr)
  die_webcgi + 0x160 (UCr)
  die + 0x120 (UCr)
  inflate_request + 0x3D0 (UCr)
  run_service + 0x540 (UCr)
  service_rpc + 0x1F0 (UCr)
  cmd_main + 0x3B0 (UCr)
  main + 0x120 (UCr)
  _MAIN + 0x80 (UCr)

I do not see any relevant diff between rc0 and rc1 that could account for
this. I also experienced this hang during 2.28.0 testing and in earlier
releases transiently. 2.21.0 had this hang also. I have noticed a number of
reports of this subtest hanging on different platforms. It looks like the
situation is here:

                while (waitpid(p->pid, NULL, 0) < 0 && errno == EINTR)
                        ; /* spin waiting for process exit or error */

It is possible that, without kernel threads, the child never terminates (or
is waiting on a deferred signal that is not being delivered). If both git
and git-http-backend are in cleanup_children at the same time, it is
possible that neither will terminate, if git-http-backend has a child that
is waiting on something else - apparent from this trace.

Sincerely,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



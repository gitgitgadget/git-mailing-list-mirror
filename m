Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12A201F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 22:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932704AbcHCWIj (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 18:08:39 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:64843 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752961AbcHCWIh (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2016 18:08:37 -0400
X-Greylist: delayed 460 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Aug 2016 18:08:37 EDT
X-AuditID: 1207440e-dafff70000000931-e9-57a2698cbf15
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id A0.2F.02353.C8962A75; Wed,  3 Aug 2016 18:00:44 -0400 (EDT)
Received: from michael.fritz.box (p57907C5F.dip0.t-ipconnect.de [87.144.124.95])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u73M0fSX023677
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 3 Aug 2016 18:00:42 -0400
From:	Michael Haggerty <mhagger@alum.mit.edu>
To:	git@vger.kernel.org
Cc:	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 0/8] Better heuristics make prettier diffs
Date:	Thu,  4 Aug 2016 00:00:28 +0200
Message-Id: <cover.1470259583.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.8.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsUixO6iqNuTuSjc4O9XS4uuK91MFg29V5gt
	di/uZ7ZYcXUOs8XtFfOZLX609DBbbN7czuLA7vH3/Qcmj52z7rJ7LNhU6vGsdw+jx8VLyh6f
	N8kFsEVx2aSk5mSWpRbp2yVwZXy4spCt4KxIxeEpM5kaGLfydzFyckgImEjs+XOEpYuRi0NI
	YCujRN/PO1DOcSaJOcvusYBUsQnoSizqaWYCsUUExCXeHp/JDlLELNDPJPGjo4sRJCEsYCVx
	8uYDsCIWAVWJrdv2ATVzcPAKmEs8uSULsU1O4vL0B2wTGLkWMDKsYpRLzCnN1c1NzMwpTk3W
	LU5OzMtLLdI11svNLNFLTSndxAgJE74djO3rZQ4xCnAwKvHwbpBcFC7EmlhWXJl7iFGSg0lJ
	lDcnFSjEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhPdeClCONyWxsiq1KB8mJc3BoiTOq7ZE3U9I
	ID2xJDU7NbUgtQgmK8PBoSTBm5wB1ChYlJqeWpGWmVOCkGbi4AQZzgM0fC1IDW9xQWJucWY6
	RP4Uo6KUOK9FOlBCACSRUZoH1wuL41eM4kCvCPNuAWnnAaYAuO5XQIOZgAafMFgAMrgkESEl
	1cDoLGne/Iwh2Ebmo0+9StW+rbLzL3+XPxp45d2zA9p2B2e/+qa/2SfI/t5bne1Pa4NSkxfX
	yenLfNk3hfX04a2n1VXVVu8peTZpTmV0YX/infVT2R3Sw/w1fwXI27CnPhfe9+321NeFR0RD
	1N88fL/k31736acW+e+bxqS355r0MbH64+4JHiFGSizFGYmGWsxFxYkAUQ16QL4CAAA=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

I've talked about this quite a bit on the list already. The idea is to
improve ugly diffs like

    @@ -231,6 +231,9 @@ if (!defined $initial_reply_to && $prompting) {
     }

     if (!$smtp_server) {
    +       $smtp_server = $repo->config('sendemail.smtpserver');
    +}
    +if (!$smtp_server) {
            foreach (qw( /usr/sbin/sendmail /usr/lib/sendmail )) {
                    if (-x $_) {
                            $smtp_server = $_;

by feeding clues from the surrounding lines (namely their patterns of
indentation and blank lines) into a heuristic that more often produces
the diffs that users would rather see, like

    --- a/9c572b21dd090a1e5c5bb397053bf8043ffe7fb4:git-send-email.perl
    +++ b/6dcfa306f2b67b733a7eb2d7ded1bc9987809edb:git-send-email.perl
    @@ -230,6 +230,9 @@ if (!defined $initial_reply_to && $prompting) {
            $initial_reply_to =~ s/(^\s+|\s+$)//g;
     }

    +if (!$smtp_server) {
    +       $smtp_server = $repo->config('sendemail.smtpserver');
    +}
     if (!$smtp_server) {
            foreach (qw( /usr/sbin/sendmail /usr/lib/sendmail )) {
                    if (-x $_) {

See the last commit's log message for a very detailed explanation of
the heuristic, how it was optimized, and how you can get involved to
make sure that the heuristic also works well for your favorite
language.

When tested against a corpus of 2700 diffs that I optimized by hand,
this heuristic gets a "wrong" answer only about 1.7% as frequently as
the current default Git algorithm and only about 5.3% as often as `git
diff --compaction-heuristic`. (Though please don't treat these numbers
as final; I want to verify them again first.)

For now the new algorithm has to be enabled explicitly using either
`--indent-heuristic` or `git config diff.indentheuristic true`.

Michael Haggerty (8):
  xdl_change_compact(): rename some local variables for clarity
  xdl_change_compact(): clarify code
  xdl_change_compact(): rename i to end
  xdl_change_compact(): do one final shift or the other, not both
  xdl_change_compact(): fix compaction heuristic to adjust io
  xdl_change_compact(): keep track of the earliest end
  is_blank_line: take a single xrecord_t as argument
  diff: improve positioning of add/delete blocks in diffs

 Documentation/diff-options.txt |   6 +-
 diff.c                         |  11 +
 git-add--interactive.perl      |   5 +-
 xdiff/xdiff.h                  |   1 +
 xdiff/xdiffi.c                 | 458 ++++++++++++++++++++++++++++++++++-------
 5 files changed, 409 insertions(+), 72 deletions(-)

-- 
2.8.1


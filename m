Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5655220189
	for <e@80x24.org>; Wed, 22 Jun 2016 15:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798AbcFVPDA (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 11:03:00 -0400
Received: from mout.gmx.net ([212.227.15.18]:53772 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751726AbcFVPCH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 11:02:07 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MVeCF-1asPcK3mO7-00YyX0; Wed, 22 Jun 2016 17:01:56
 +0200
Date:	Wed, 22 Jun 2016 17:01:54 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 06/10] format-patch: explicitly switch off color when
 writing to files
In-Reply-To: <cover.1466607667.git.johannes.schindelin@gmx.de>
Message-ID: <c0fdb78fbb7b19e4b367c50a9c0c570193e98fa3.1466607667.git.johannes.schindelin@gmx.de>
References: <cover.1466505222.git.johannes.schindelin@gmx.de> <cover.1466607667.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:B8CKlMiyZjk0sEeOvMWD7fnskL2U1rvldmRfqodeV0L49fe8aNn
 TLJWo2e6LlSlQ4yhz4KRpNQ/B4+PEj80BL1QOfi+72qlYer2N/AV4+gpGEDiT8jCevKMvMr
 tvfLnSemkj0Gr118a6iA6rOK7d4XKYxNjkx8UOL23nalJS0BbH1YXJfquM+gujU3Nf8zwki
 GHBd/dY0vDGl0qoJYnHhg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:D5D1nYqAo9I=:tBrkmeOcVbQTZsEWRhjC0C
 qj0QTdk19Z0WahZKR/nOP7w7DQD9kCDP6zTFsCxy2jOvvttWFFouXwcmqS+2H30rCVxOc9w5r
 XbNQT2VRtEn32qxWLM/MZAOfkn5FK0+PEki/UA79FtTbMITnxS3AKFKAxtwNoVz7n8dZ7JHs/
 XNaBT/6VpE+fciSYTV7bIN7ayztViHr96DSjRi8A6ooRIZXGY4PVAsWwEbmHP0Zz8RReWcs9U
 4tV8E7Kid+STplT9/CJLv5ADyFa+EsHYuZKYPCULF1qY30gc+vy8BMOC96DSJL7ASQrHYcgaf
 6AbZYTy5v7kUDlYAUiNEg1aWyVZBQhHeQ3nxsJhAbDvzRUdIKDQ4COGJJP90PQaIzArZ1u1wj
 X4RbvaUSENZLE/puaRHh4XciOeYrB7A/IsJfAKuO087d87LgO96QPMpEhEf7/6DFljFbXvsCf
 spgNMpIgUsmF+cH3flf71KEqL/29RL+54BHWizqjIHJaa8qZmzYSKgrxrZDrwe/36Fy/As6hn
 tLl2xgYxygcew3dzIVAVq74qpmOvJ4dv3FkO7kWhCdo6N39+8hQ43SSJG4RzQ2zqvXruKthas
 DoQaG8r1+5vii12zcz2A4rnVTXYuSi2CQRWNS0ciqKLe6HhX9t2yG9t76dXq+ict8ay4jtyRg
 LMQXNUOZH3fGemkbtpxI1oHGb/12SXbTsh139HBfK3mZc1VR3Zk5yu76WSL4EoHbGyAZHiZQ1
 k79/6hipciWJG/VgXSWVItWX6eBW8/43ntwWrzVhRxlzVZmKnqFlCfLTezcg8lqnvyqVzyNC1
 KdnY1Sq
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

We rely on the auto-detection ("is stdout a terminal?") to determine
whether to use color in the output of format-patch or not. That happens
to work because we freopen() stdout when redirecting the output to files.

However, we are about to fix that work-around, in which case the
auto-detection has no chance to guess whether to use color or not.

But then, we do not need to guess to begin with. As argued in the commit
message of 7787570c (format-patch: ignore ui.color, 2011-09-13), we do not
allow the ui.color setting to affect format-patch's output. The only time,
therefore, that we allow color sequences to be written to the output files
is when the user specified the --color command-line option explicitly.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/log.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/log.c b/builtin/log.c
index 27bc88d..5683a42 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1578,6 +1578,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		setup_pager();
 
 	if (output_directory) {
+		if (rev.diffopt.use_color != GIT_COLOR_ALWAYS)
+			rev.diffopt.use_color = 0;
 		if (use_stdout)
 			die(_("standard output, or directory, which one?"));
 		if (mkdir(output_directory, 0777) < 0 && errno != EEXIST)
-- 
2.9.0.118.g0e1a633



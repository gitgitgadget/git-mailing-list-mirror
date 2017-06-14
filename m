Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB84520401
	for <e@80x24.org>; Wed, 14 Jun 2017 11:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752124AbdFNLfu (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 07:35:50 -0400
Received: from mout.gmx.net ([212.227.15.18]:58830 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751874AbdFNLft (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 07:35:49 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MaZrd-1d5UTU3iVl-00K57M; Wed, 14
 Jun 2017 13:35:41 +0200
Date:   Wed, 14 Jun 2017 13:35:26 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v4 1/6] discover_git_directory(): avoid setting invalid
 git_dir
In-Reply-To: <cover.1497440104.git.johannes.schindelin@gmx.de>
Message-ID: <77bc4209b6e1e782dca367c7b3b2500e0cb655d0.1497440104.git.johannes.schindelin@gmx.de>
References: <cover.1497440104.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:1d4gNe6RB89CB63or1b9k2NNL3j/6U/g0hKWveVh8EJnEcApXIk
 Q40iqTjzB1NP4dE7VRwvJ5zWnYfFrzqLXu8XYkRgKckpgF2IOt6qt6uqJYzspaGcDAarkvZ
 b0GTAYaqWk9T0wfsX8EQHHcxymhzRZ7rR47blbtugC/kAF+DVHwRAs6U4xAgI+Hk3AzjXdK
 zI7DjQIpd4VbPVkuhGrsQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FnZfvnJkIwY=:gaTQSJKglmE3+1EoiSLLiI
 Gx3s/41oN5wj43VXyYkDkmdsneQLM0CCn20OlvtzeefJmdq+OTrxNp0b2GUAIunTNt8CX/LT9
 V8wJD6lFOuo1uLhdpiNQr3ofZCLPADQX7kKfBxgipy6siJM41Y2KafmEaaITlfkVdwqZhLvHS
 020CH3fmyYdqWF8dr6pTMBoo/i8L75bVEDq5OrAPxYV06tGAOhfXrYfNt9iV364pa2lMct/s0
 GLis4emjDCJFAODF6NiNCU7/AYAqsariAkom84KqDmPA1MrymbgdD/dB47cA+ZVE8ZA+quouA
 BT5O7Z0N2aST8aiVgqt/S1owJFGHyuzEHOeuou8vBVMqRPPCPvCp8OjIWRWmDRmGTXdWb0ahE
 08vTk7wJM7eDFDQ7B56ndE71R9WQH/V9sfblCFPXPctwsBgHVIPI+3+Yn6SYJXm0H49xxSBna
 X9IjUInuRKdQVNOzvr/NbKhrUlzwA1y8rSKpUTYuHKtNRNaZLtNkVk5R9LKHF68+qE1pyE/XA
 1aUPd0Yr8NUvOIFwZaFiNYHbA14PAkC6UzCtWczFM4DwhK6B0N4hUPLG3d9hMQN0T8D7t+EZ+
 b8lUK0Qp3yD3lmJGSyC6X4kllrP+TGOMMxY2oh5dal9zNRPGqXlOCfzCpDEysqvQQC0frlz0e
 Gpf0FQgrosH7WN5aduRxpMPcEUNMFIh0badZKFDrY7hZm8iLaKuFn2prFy8K6zem6PiVlvUp1
 LLqX8NVcPqa/NSEzcxrd5QVTxZMaFxgTJcTPo2R+tZt8Z+r43Gr0qRmX1ZykYXN86wO590SZv
 eGw8ckp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When discovering a .git/ directory, we take pains to ensure that its
repository format version matches Git's expectations, and we return NULL
otherwise.

However, we still appended the invalid path to the strbuf passed as
argument.

Let's just reset the strbuf to the state before we appended the .git/
directory that was eventually rejected.

There is another early return path in that function, when
setup_git_directory_gently_1() returns GIT_DIR_NONE or an error. In that
case, the gitdir parameter has not been touched, therefore there is no
need for an equivalent change in that code path.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 setup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/setup.c b/setup.c
index ba6e8551788..ad12d79ac02 100644
--- a/setup.c
+++ b/setup.c
@@ -982,6 +982,7 @@ const char *discover_git_directory(struct strbuf *gitdir)
 		warning("ignoring git dir '%s': %s",
 			gitdir->buf + gitdir_offset, err.buf);
 		strbuf_release(&err);
+		strbuf_setlen(gitdir, gitdir_offset);
 		return NULL;
 	}
 
-- 
2.13.1.windows.1.1.ga36e14b3aaa



Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D734A207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 20:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967216AbdDZUT7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 16:19:59 -0400
Received: from mout.gmx.net ([212.227.15.19]:57250 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967214AbdDZUT5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 16:19:57 -0400
Received: from virtualbox ([95.208.59.152]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LoE4f-1dj9wt1Jgf-00gDRs; Wed, 26
 Apr 2017 22:19:34 +0200
Date:   Wed, 26 Apr 2017 22:19:33 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 05/26] git_config_rename_section_in_file(): avoid resource
 leak
In-Reply-To: <cover.1493237937.git.johannes.schindelin@gmx.de>
Message-ID: <d88e30ff9ada2f47b4f303269162b6e8e19b1baa.1493237937.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:4AxZfz5nnhCURYnlS5Pwl/KMTv9Iok6Nmv6Li/8A/NlrPzQKnex
 OQF4CsNykyKP/w2K8/XDE3vBOLJ/AZjT0xLtf6FdP0OUZYTRUKCqXLWbBzfhyI+AV+OXQgY
 c9Np5nAbO3gxZ1s7a9NL7uSrqXHRAROP4DqQNUCDLRP6LqMQPSZ5QRawI6S+kKFY7Wv0pKp
 5YPEcLuH3KNT0kfrey0CQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6uClC71G5bM=:NfcaJO5z3YFTfpSfZc0IYR
 MY36DAgNDTQl46eoOM1nj5P0I1KcCoj6LTnk8L6xnhvV9N+u/RCV9pdeN+Hwz19YNUBpSLxWp
 9VkykHNiamoBRI7aW1UE4CDXWRBG/obaIMdTeDQzYsOXNlwfK3I13cs1pIzNSACCdxt4/GPcF
 oAD6GvQoOOPoZnOEJpbmjAIqS7rzf3fqlwmHRhX0VR9BQe1PK4en4nCOmMfGcdpGJnDmCNiya
 0HTzTyaFdEWwqfDFaY15cjZSGrNJVbvGU+FMZ4cIMOdheNy+qEy/YHHIOlkEeLhJn5O4/vtDG
 XxLD9XXRydqvxAFZxw3+BiAQ4VmKbeR0kVaINXSL2E1d4Z4J/DPfPXbqQ+aYcSlVxp6iEC+sV
 4IxVLO2ez1nK9u2Eoc7sZ3QAr8WZOXN/WwP9wOCqnZNKjJHsVS6tkjJofiVowULkaQ9OCSPsZ
 Fa+730BIiaxJI3eE38xM1RFC/zaUMGF+S2DTcoNzsvHK2mbiNNiTPUIK1Te20hAzWLJ1rtq/E
 44uF2YpP58ZlP9i2272HyCkjZmKJczVAzO1YYl8u4uA4UP1L8y16t2KZbJBf3qo9Gk5GDpcHL
 QkCShd2+Q0igBZmnFIdntOGUq85zONy+o7IFX7fzOLB7kzj/uu5oeRGMD51aQCGBx4N4odryt
 u71l0IfyZwxqbVqxtyRpyEFeESCtLomGbiil1a5A7V05RgCbYrIFxjb+mqZJ8uqwELxqr5JAk
 3BkrtjsXzG/IBr1rfNcEB1/mKNPOKpLUKWaZR2sdXi5E1PvIGnoqNK80WFCPkd7HqvldvnBda
 ZfeXhCJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In case of errors, we really want the file descriptor to be closed.

Discovered by a Coverity scan.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 0daaed338ea..ed1420fb096 100644
--- a/config.c
+++ b/config.c
@@ -2599,7 +2599,7 @@ int git_config_rename_section_in_file(const char *config_filename,
 	struct lock_file *lock;
 	int out_fd;
 	char buf[1024];
-	FILE *config_file;
+	FILE *config_file = NULL;
 	struct stat st;
 
 	if (new_name && !section_name_is_ok(new_name)) {
@@ -2681,11 +2681,14 @@ int git_config_rename_section_in_file(const char *config_filename,
 		}
 	}
 	fclose(config_file);
+	config_file = NULL;
 commit_and_out:
 	if (commit_lock_file(lock) < 0)
 		ret = error_errno("could not write config file %s",
 				  config_filename);
 out:
+	if (config_file)
+		fclose(config_file);
 	rollback_lock_file(lock);
 out_no_rollback:
 	free(filename_buf);
-- 
2.12.2.windows.2.800.gede8f145e06



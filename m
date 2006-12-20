X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RCVD_NUMERIC_HELO,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: SungHyun Nam <goweol@gmail.com>
Subject: Patch  (Re: t1300-repo-config.sh failed on CYGWIN)
Date: Wed, 20 Dec 2006 12:22:12 +0900
Message-ID: <emaa94$qn4$1@sea.gmane.org>
References: <4588A1EC.7040301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 20 Dec 2006 03:30:49 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 29
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 218.147.190.89
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
In-Reply-To: <4588A1EC.7040301@gmail.com>
X-Enigmail-Version: 0.94.1.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34906>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwsAI-0007kK-By for gcvg-git@gmane.org; Wed, 20 Dec
 2006 04:30:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964836AbWLTDaR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 22:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964842AbWLTDaQ
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 22:30:16 -0500
Received: from main.gmane.org ([80.91.229.2]:43321 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S964836AbWLTDaP
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006 22:30:15 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43) id
 1Gws9a-0006b1-CF for git@vger.kernel.org; Wed, 20 Dec 2006 04:30:02 +0100
Received: from 218.147.190.89 ([218.147.190.89]) by main.gmane.org with esmtp
 (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 20
 Dec 2006 04:30:02 +0100
Received: from goweol by 218.147.190.89 with local (Gmexim 0.1 (Debian)) id
 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 20 Dec 2006 04:30:02 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

SungHyun Nam wrote:
> If I run it on CYGWIN, there's an error msg:
>
> * FAIL 39: rename section
>         git-repo-config --rename-section branch.eins branch.zwei
> * FAIL 40: rename succeeded
>         diff -u expect .git/config

With a patch below, the problem gone.

BTW, there's a leak for 'config_filename' in
git_config_rename_section().

Thanks,
namsh

diff --git a/config.c b/config.c
index 663993f..a23ac47 100644
--- a/config.c
+++ b/config.c
@@ -806,6 +806,7 @@ int git_config_rename_section(const char *old_name,
const char *new_name)
 		}
 		write(out_fd, buf, strlen(buf));
 	}
+	fclose(config_file);
 	if (close(out_fd) || commit_lock_file(lock) < 0)
 		return error("Cannot commit config file!");
 	return ret;

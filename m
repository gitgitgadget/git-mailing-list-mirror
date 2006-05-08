From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Release config lock if the regex is invalid
Date: Mon, 8 May 2006 02:32:52 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605080229220.32508@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060507213612.27887.28600.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 08 02:32:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FctgG-0002Yq-V2
	for gcvg-git@gmane.org; Mon, 08 May 2006 02:32:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbWEHAcy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 20:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbWEHAcy
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 20:32:54 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:6827 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751245AbWEHAcx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 May 2006 20:32:53 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id B6532D81;
	Mon,  8 May 2006 02:32:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id AA1B8CCF;
	Mon,  8 May 2006 02:32:52 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 89B11C9E;
	Mon,  8 May 2006 02:32:52 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <20060507213612.27887.28600.stgit@dv.roinet.com>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19729>

Hi,

On Sun, 7 May 2006, Pavel Roskin wrote:

> @@ -516,6 +516,8 @@ int git_config_set_multivar(const char* 
>  				fprintf(stderr, "Invalid pattern: %s\n",
>  					value_regex);
>  				free(store.value_regex);
> +				close(fd);
> +				unlink(lock_file);
>  				ret = 6;
>  				goto out_free;
>  			}
> 

This is not enough. There are quite a few exit paths. Notice the "goto 
out_free"? That is where this must go.

This patch is totally untested but obviously correct:

diff --git a/config.c b/config.c
index 30effe3..d8fd94d 100644
--- a/config.c
+++ b/config.c
@@ -445,7 +445,7 @@ int git_config_set_multivar(const char* 
 	const char* value_regex, int multi_replace)
 {
 	int i;
-	int fd;
+	int fd = -1;
 	int ret;
 	char* config_filename = strdup(git_path("config"));
 	char* lock_file = strdup(git_path("config.lock"));
@@ -619,10 +619,14 @@ int git_config_set_multivar(const char* 
 	ret = 0;
 
 out_free:
+	if (fd > 0)
+		close(fd);
 	if (config_filename)
 		free(config_filename);
-	if (lock_file)
+	if (lock_file) {
+		unlink(lock_file);
 		free(lock_file);
+	}
 	return ret;
 }
 

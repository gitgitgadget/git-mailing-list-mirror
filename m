From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: th/remote-usage
Date: Wed, 18 Nov 2009 06:05:08 -0600
Message-ID: <20091118120508.GB13346@progeny.tock>
References: <7v7hto46ce.fsf@alter.siamese.dyndns.org>
 <20091118114808.GA13346@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 12:54:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAj79-0006RW-Q2
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 12:54:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509AbZKRLyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 06:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbZKRLyL
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 06:54:11 -0500
Received: from mail-gx0-f226.google.com ([209.85.217.226]:42037 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426AbZKRLyK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2009 06:54:10 -0500
Received: by gxk26 with SMTP id 26so926384gxk.1
        for <git@vger.kernel.org>; Wed, 18 Nov 2009 03:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=rFJW6FGllRdXklYbGUbAH4ihDkn7Gse5SlocB4hRgr4=;
        b=VrPXatry0HKdbzwfVbBjPu2Cq/GhiS+kkIz8xiRPOgn+B3uQOaT2/Abo52xg+lqf5/
         xaKVftMhxPUZhIB3L3A430yAlpZgrono0Q85QL3pTW9ZRwU9PJ7xfJb+6IH/pp/mpgfR
         Q4EE4WtYVpOrohKLE19pvfS9fasJjiMZv7Ols=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ZkCUKxFrjrz8JT5NZyt0LHAtZiTGovx4xJ9w/dLRw6ZtgTplXcknpjGl8giTwYD3Wz
         6AMqrZSaX7jFW2pMCgGC/aep1WnqwwyPRzM1Kx2n0erbku3/Is66MKuDWFf6CW2d0FXf
         UE/ec4AcXqYE/+jBZaorxAcLPCZoP6ASMLvcI=
Received: by 10.90.62.4 with SMTP id k4mr2003092aga.56.1258545254082;
        Wed, 18 Nov 2009 03:54:14 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 9sm396342yxf.59.2009.11.18.03.54.12
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 18 Nov 2009 03:54:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091118114808.GA13346@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133162>

Hi,

Another thought.

Yesterday, Tim Henigan wrote:

> Do you object to the new #defines for the strings?  I added them since we now
> really need to construct the usage string for 2 separate uses:
>   (1) When 'git remote -h' is invoked, we need to return the usage
> string showing
>        all subcommands.
>   (2) When 'git remote <subcommand> -h' is invoked, we need to return the
>       usage for just that command.
>
> It doesn't make sense to me to maintain separate strings for the two use cases.

Another option would be to make the strings into static variables.

I vaguely hoped this would help the code size a little, but gcc is
already smart enough to notice the strings are the same on its own.
Actually, this increases the text size by 15 bytes.  Apparently,
static arrays have to live at 4-byte aligned addresses in the x86 ABI.

So there is not much to recommend this.  I am sending it mostly for
academic interest.  It also has the virtue of decreasing the density
of capital letters in the code.

 builtin-remote.c |   47 ++++++++++++++++++++++++-----------------------
 1 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index cfd8a36..185ce42 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -7,34 +7,35 @@
 #include "run-command.h"
 #include "refs.h"
 
-#define REMOTE_BARE_USAGE "git remote [options]"
-#define REMOTE_ADD_USAGE "git remote add [options] <name> <url>"
-#define REMOTE_RENAME_USAGE "git remote rename <old> <new>"
-#define REMOTE_RM_USAGE "git remote rm <name>"
-#define REMOTE_SETHEAD_USAGE "git remote set-head <name> (-a|-d|<branch>)"
-#define REMOTE_SHOW_USAGE "git remote show [options] <name>"
-#define REMOTE_PRUNE_USAGE "git remote prune [options] <name>"
-#define REMOTE_UPDATE_USAGE "git remote update [options]"
+static const char remote_bare_usage[] = "git remote [options]";
+static const char remote_add_usage[] = "git remote add [options] <name> <url>";
+static const char remote_rename_usage[] = "git remote rename <old> <new>";
+static const char remote_rm_usage[] = "git remote rm <name>";
+static const char remote_sethead_usage[] =
+"git remote set-head <name> (-a|-d|<branch>)";
+static const char remote_show_usage[] = "git remote show [options] <name>";
+static const char remote_prune_usage[] = "git remote prune [options] <name>";
+static const char remote_update_usage[] = "git remote update [options]";
 
 static const char * const builtin_remote_usage[] = {
-	REMOTE_BARE_USAGE,
-	REMOTE_ADD_USAGE,
-	REMOTE_RENAME_USAGE,
-	REMOTE_RM_USAGE,
-	REMOTE_SETHEAD_USAGE,
-	REMOTE_SHOW_USAGE,
-	REMOTE_PRUNE_USAGE,
-	REMOTE_UPDATE_USAGE,
+	remote_bare_usage,
+	remote_add_usage,
+	remote_rename_usage,
+	remote_rm_usage,
+	remote_sethead_usage,
+	remote_show_usage,
+	remote_prune_usage,
+	remote_update_usage,
 	NULL
 };
 
-static const char * const builtin_remote_add_usage[] = { REMOTE_ADD_USAGE, NULL };
-static const char * const builtin_remote_rename_usage[] = { REMOTE_RENAME_USAGE, NULL };
-static const char * const builtin_remote_rm_usage[] = { REMOTE_RM_USAGE, NULL };
-static const char * const builtin_remote_sethead_usage[] = { REMOTE_SETHEAD_USAGE, NULL };
-static const char * const builtin_remote_show_usage[] = { REMOTE_SHOW_USAGE, NULL };
-static const char * const builtin_remote_prune_usage[] = { REMOTE_PRUNE_USAGE, NULL };
-static const char * const builtin_remote_update_usage[] = { REMOTE_UPDATE_USAGE, NULL };
+static const char * const builtin_remote_add_usage[] = { remote_add_usage, NULL };
+static const char * const builtin_remote_rename_usage[] = { remote_rename_usage, NULL };
+static const char * const builtin_remote_rm_usage[] = { remote_rm_usage, NULL };
+static const char * const builtin_remote_sethead_usage[] = { remote_sethead_usage, NULL };
+static const char * const builtin_remote_show_usage[] = { remote_show_usage, NULL };
+static const char * const builtin_remote_prune_usage[] = { remote_prune_usage, NULL };
+static const char * const builtin_remote_update_usage[] = { remote_update_usage, NULL };
 
 #define GET_REF_STATES (1<<0)
 #define GET_HEAD_NAMES (1<<1)
-- 
1.6.5.2

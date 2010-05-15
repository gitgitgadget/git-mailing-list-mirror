From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] notes: dry-run and verbose options for prune
Date: Sat, 15 May 2010 15:17:55 -0700
Message-ID: <4BEF1D93.7070305@gmail.com>
References: <ecbe317d2f12d83185f3c3242c0350051e3b4bfa.1273873273.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sun May 16 00:18:06 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODPgL-00013X-N4
	for gcvg-git-2@lo.gmane.org; Sun, 16 May 2010 00:18:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753288Ab0EOWR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 May 2010 18:17:59 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:37855 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009Ab0EOWR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 May 2010 18:17:58 -0400
Received: by pxi5 with SMTP id 5so1929521pxi.19
        for <git@vger.kernel.org>; Sat, 15 May 2010 15:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=kPZEXxTQFSnw5+bEDOOWptADKcsY9VHHzWH84mmvNNM=;
        b=qzFS3XCoT+nQ1wDF0xKdkHVnZxrPrll8IHqhGwVNgnnbu6Mp3+8vwyxeUqWR4jfOGq
         sa9L3p4mF8RUgcA3903Yft9175lH+loyoZEwBCh8pTpKJ7hDmGNBtEQp3VyI+gOZ4Vxd
         VA9CiicBSatZ+7nPcAt0mZgWNDhR8cKxazs+k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=bRHEz4wi1zbJiHkY+CNfEHTtaud44Sp3jjEsU8DG1owoaxNoqHKvv1f/8rDHsv8+y+
         NW6pfmBhqUluU9MxWNvRJ8eTXWQeZWRYPiQSCZq4FZuRuREItt7zFFWUXsR25ZLO/5Sp
         kPcWmOGtX0kzToQPbfuvegcT2rXRHuh6TTYXo=
Received: by 10.115.81.7 with SMTP id i7mr2592798wal.115.1273961877425;
        Sat, 15 May 2010 15:17:57 -0700 (PDT)
Received: from [192.168.1.5] ([24.152.169.138])
        by mx.google.com with ESMTPS id c1sm33351867wam.19.2010.05.15.15.17.56
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 15 May 2010 15:17:56 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9) Gecko/20100423 Thunderbird/3.0.4
In-Reply-To: <ecbe317d2f12d83185f3c3242c0350051e3b4bfa.1273873273.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147167>

On 05/14/2010 02:42 PM, Michael J Gruber wrote:
> @@ -792,7 +792,10 @@ static int remove_cmd(int argc, const char **argv, const char *prefix)
>  static int prune(int argc, const char **argv, const char *prefix)
>  {
>  	struct notes_tree *t;
> +	int show_only, verbose;
>  	struct option options[] = {
> +		OPT_BOOLEAN('n', NULL, &show_only, "do not remove, show only"),
> +		OPT_BOOLEAN('v', NULL, &verbose, "report pruned notes"),
>  		OPT_END()
>  	};
>   

Why not use the standard OPT__DRY_RUN and OPT__VERBOSE macros?

---->8----

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 0f32792..6e53c9a 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -122,10 +122,12 @@ OPTIONS
        is taken to be in `refs/notes/` if it is not qualified.
 
 -n::
+--dry-run::
        Do not remove anything; just report the object names whose notes
        would be removed.
 
 -v::
+--verbose::
        Report all object names whose notes are removed.
 
 
diff --git a/builtin/notes.c b/builtin/notes.c
index 8c2ac51..0ae2561 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -794,8 +794,8 @@ static int prune(int argc, const char **argv, const char *pr
        struct notes_tree *t;
        int show_only, verbose;
        struct option options[] = {
-               OPT_BOOLEAN('n', NULL, &show_only, "do not remove, show only"),
-               OPT_BOOLEAN('v', NULL, &verbose, "report pruned notes"),
+               OPT__DRY_RUN(&show_only),
+               OPT__VERBOSE(&verbose),
                OPT_END()
        };
 

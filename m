From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1] git-p4: Add option to ignore empty commits
Date: Tue, 20 Oct 2015 10:27:18 -0700
Message-ID: <xmqqmvvd8n7t.fsf@gitster.mtv.corp.google.com>
References: <1445280239-39840-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, luke@diamand.org
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Tue Oct 20 19:27:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zoah5-0007E6-6m
	for gcvg-git-2@plane.gmane.org; Tue, 20 Oct 2015 19:27:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752866AbbJTR1W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2015 13:27:22 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33846 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966AbbJTR1U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2015 13:27:20 -0400
Received: by padhk11 with SMTP id hk11so27288155pad.1
        for <git@vger.kernel.org>; Tue, 20 Oct 2015 10:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=yOPHfZLwknhTHl0ouQW3DrX7eKCvI+e/QccBU7gZWMg=;
        b=0QYFsBx4pqakUwadqJitxgsv11B0PWHD72Di+PsYT6QGz9sXNO4lfBnqNwF/cBnfi1
         ekZjdwRhU/aUuLKFqRGThNmbo82iDPF5scr3PeuVc+qQ5sZEoMV3JajYD/K5X/HjlllZ
         aWx4oEk9wHyKyYtpJbfRGL487gO5B1JrsdBtocE6JYn1Cw80r14mTQMcrqcK3LO7UD/y
         kz4J5R3vLpYqeo6U/pr7cetp03z/weEQyBNNpf68yItTiOT6AQ127wie43LVYYgKSDlJ
         WrIIYmJjb2hd0r9iFPjMpk0TiIkaTnajBsa2aVfNFYlpuE5epkrvueJlm2KiV2KBcx0t
         doHQ==
X-Received: by 10.66.227.101 with SMTP id rz5mr5204706pac.123.1445362039869;
        Tue, 20 Oct 2015 10:27:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:e1b1:e6e0:dc10:8032])
        by smtp.gmail.com with ESMTPSA id qa5sm4793858pbc.70.2015.10.20.10.27.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 20 Oct 2015 10:27:19 -0700 (PDT)
In-Reply-To: <1445280239-39840-1-git-send-email-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Mon, 19 Oct 2015 20:43:59
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279927>

larsxschneider@gmail.com writes:

> diff --git a/git-p4.py b/git-p4.py
> index 0093fa3..6c50c74 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -2288,12 +2288,6 @@ class P4Sync(Command, P4UserMap):
>          filesToDelete = []
>  
>          for f in files:
> -            # if using a client spec, only add the files that have
> -            # a path in the client
> -            if self.clientSpecDirs:
> -                if self.clientSpecDirs.map_in_client(f['path']) == "":
> -                    continue
> -
>              filesForCommit.append(f)
>              if f['action'] in self.delete_actions:
>                  filesToDelete.append(f)

Earlier, the paths outside the clientspec were not in filesToDelete
(or filesToRead that is below the context here).  Now they all go to
these arrays, and will hit this loop beyond the context:

        # deleted files...
        for f in filesToDelete:
            self.streamOneP4Deletion(f)

after leaving the above for loop.  I cannot quite see where this
"stream one deletion" is turned into a no-op for paths outside after
this patch gets applied.

Also I have this suspicion that those who do want to use client spec
to get a narrowed view into the history would almost always want
this "ignore empty" behaviour (I'd even say the current behaviour to
leave empty commits by default is a bug).  What are the advantages
of keeping empty commits?  If there aren't many, perhaps git-p4
should by the default skip empties and require p4.keepEmpty
configuration to keep them?

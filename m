From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 11/15] builtin/check-attr: fix a memleak
Date: Fri, 20 Mar 2015 17:28:08 -0700
Message-ID: <1426897692-18322-12-git-send-email-sbeller@google.com>
References: <1426897692-18322-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Mar 21 01:28:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ7HP-0001p5-2W
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 01:28:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752346AbbCUA2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 20:28:34 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:36965 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752325AbbCUA2a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 20:28:30 -0400
Received: by igcqo1 with SMTP id qo1so1490418igc.0
        for <git@vger.kernel.org>; Fri, 20 Mar 2015 17:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mz3oQ1O50Te7nUr8QRCZeUW4YtwXnnY+ubn1W2atlJo=;
        b=UOxT4WAMAjpDvD/+1ZnYrf/UTqK9f6pfYvV3rqmiNICt28UwFyf+qXrQxbatdE9Zm+
         hHXLtiZ6bY6X+AX1uqt8xmdPILqr7k+ml7E+HhN6697+XEQ+1oeQXZjy0hpE2enyGNoC
         6IdQMJyxQ5IgwY7qj3QL/9sBsNNOxLFzNzK9B1qlP7SSug8KbMwHUSoczDMJGhVMaJZr
         +Eu+MP1U6ZNsFgZA7l7k5Ao4SGBWc1qaENiHtJi6RyfJxzuxFYUKiu0j9LP0A4Y4ljOw
         xlHEJw41+kYaiI2LgL1BHVnXDiC/8BIx5hrxgv+uLk9pboG1oONPaPL9ASAZzUwLXHep
         rXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mz3oQ1O50Te7nUr8QRCZeUW4YtwXnnY+ubn1W2atlJo=;
        b=g4qS0Xn1cyroSpiW9WleyGcc7cqRah77Jvpmf7lB6GCGg3vYmJTk7e6Pf+//V/bOB/
         TSv5oFkSQLJZtJMe5/8VtvNrN2rNGGOSHJYJ+q9b1HQcCZvGKMyIYq/1cfLzVaSBy1AP
         pSjCUbh8I6r2TZThaGBJKkTzaavuKFupIUeexPPXeX/ouAMxVjxFYWH3Re3a+4NnI9LT
         feCmlmOIDaLdsu3cNhWQYSkHJDzLUNo/+b4NlkEbXSS6ELKkX8r8sfbr9/TkDiwZXehN
         BQbJeDeeyFmzEHcW36EvFVPhklzxIQBgVusicHhztnh+Mpuy/tIip1AmX9BbHlfNmnpS
         C3Iw==
X-Gm-Message-State: ALoCoQnBztllLIVsQ+39TN4I3BRlPkHtbVXLoWzn8tffHYMG9Y4SJSwriZV6mDxUbfuM0odm6DBE
X-Received: by 10.50.143.42 with SMTP id sb10mr405171igb.49.1426897709676;
        Fri, 20 Mar 2015 17:28:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:c4ad:7c66:d5e8:7112])
        by mx.google.com with ESMTPSA id 13sm4231579iok.29.2015.03.20.17.28.28
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 20 Mar 2015 17:28:29 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1426897692-18322-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265987>

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    I do not quite recall a discussion about such fixes
    when I started doing these fixes like 2 years ago.
    
    As this is a main function of a subcommand the freed
    memory is likely to have no impact as the process
    is done soon, so then it gets freed by the OS which
    is likey to be faster as the OS frees the whole pages
    of the process. Also there is no expected memory
    shortage as the process is going to be done soon
    as opposed to fixing mem leaks early in the process.
    
    An upside of fixes like this one is however to make
    code analysis tools produce less noise, so narrowing
    down the *real* issue may be easier.
    
    I wonder if we could have a 'weak' free which does
    nothing if git is compiled regularly and actually
    frees the memory if it is build with a flag to tell
    it to do so. This would help finding the real issues
    as the noise goes down and it would still be 'fast'
    as it could be when compiled for productive use.
    
    On the other hand I don't like to have another
    'invented here again' systemcall-ish function as
    it would clutter the code and you'd have to remember
    to use that weak free.
    
    I dunno.

 builtin/check-attr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 21d2bed..fa96356 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -182,5 +182,7 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 			check_attr(prefix, cnt, check, argv[i]);
 		maybe_flush_or_die(stdout, "attribute to stdout");
 	}
+
+	free(check);
 	return 0;
 }
-- 
2.3.0.81.gc37f363

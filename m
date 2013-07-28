From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] builtins: search builtin commands via binary search.
Date: Sun, 28 Jul 2013 05:05:00 -0400
Message-ID: <CAPig+cSsUJSd2nx6icfbEgv71hBVnBQM8oxpvoqLzqFPkNY4KA@mail.gmail.com>
References: <1374871850-24323-1-git-send-email-stefanbeller@googlemail.com>
	<20130726205737.GI14690@google.com>
	<51F38997.9010507@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Stefan Beller <stefanbeller@googlemail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 28 11:05:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3Mv5-0007xm-RQ
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jul 2013 11:05:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752621Ab3G1JFF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jul 2013 05:05:05 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:43065 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043Ab3G1JFD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jul 2013 05:05:03 -0400
Received: by mail-la0-f44.google.com with SMTP id fo12so2251126lab.17
        for <git@vger.kernel.org>; Sun, 28 Jul 2013 02:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=YjQAqm+CzzATU4JL6egSserGeax50WN49q3Peq/zt4M=;
        b=B/MxewKrAZgRm1vz4LdWrH1BUKajjDBEOGBMifzwsMwItCByRcNMSBW0zvoEQYD54S
         B1zXGOhNo/n2edZb0OqHvQPHcPpAoies+eMSDT7QirhZXYzHnaMCaaSGBh2LB4XfrjEm
         pPxI+BKalOF4dIlVWqKy/uD24CniC4b52752HDVvJ4jg8OE61biGEiPa22EnOB+cZZhW
         uoakAIPZvEel1IpZ7jjttNL2ZrMDkEoMa6OASOAIsYPf+EjuO0oEc9BKiC81bZ1xTUL6
         H4cy4JyWPe9F4ciEmWyQJ4IwoadfkVRQg62aUehZpRtutBd0nkU3OWtCFlkp1dStg50d
         Sz5Q==
X-Received: by 10.112.97.132 with SMTP id ea4mr23163760lbb.80.1375002300884;
 Sun, 28 Jul 2013 02:05:00 -0700 (PDT)
Received: by 10.114.187.78 with HTTP; Sun, 28 Jul 2013 02:05:00 -0700 (PDT)
In-Reply-To: <51F38997.9010507@googlemail.com>
X-Google-Sender-Auth: eY-Cr68YgCoCUbXsi7k1JsY_Gg4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231262>

On Sat, Jul 27, 2013 at 4:49 AM, Stefan Beller
<stefanbeller@googlemail.com> wrote:
> I was fiddling around with make now to include the suggestion of Eric to
> check the arguments for being sorted in make. However I do not
> seem to fully understand the syntax yet.
> My approach would have been:
>
> sorted_internal_cmds: git.c
>         { awk '/cmd_struct commands/,/};/ { if (match($2,/"/)) print $2 }' <git.c >builtin.actual && \
>         sort <builtin.actual >builtin.expect && \
>         cmp -s builtin.expect builtin.actual && \
>         rm builtin.expect builtin.actual \
>         }
>
> all:: sorted_internal_cmds
>
> But then there is
> $ make
> ...
>         }
> /bin/sh: 5: Syntax error: end of file unexpected (expecting "}")
>
> So I suspect the { within the shell code inside the awk parameter is messing up?

As Andreas noted, you need a semicolon before the closing shell '}',
however it's not clear why you added the braces since they are not
needed. The following works (after fixing whitespace corruption):

-->8--
diff --git a/Makefile b/Makefile
index ef442eb..82e727c 100644
--- a/Makefile
+++ b/Makefile
@@ -1681,6 +1681,15 @@ shell_compatibility_test:
please_set_SHELL_PATH_to_a_more_modern_shell
 strip: $(PROGRAMS) git$X
  $(STRIP) $(STRIP_OPTS) $^

+.PHONY: sorted_internal_cmds
+all:: sorted_internal_cmds
+
+sorted_internal_cmds: git.c
+ @awk '/cmd_struct commands/,/};/ { if (match($$2,/"/)) print $$2 }'
<git.c >builtin.actual && \
+ sort <builtin.actual >builtin.expect && \
+ cmp -s builtin.expect builtin.actual && \
+ rm builtin.expect builtin.actual
+
 ### Target-specific flags and dependencies

 # The generic compilation pattern rule and automatically
-->8--

Note the $$2 in awk expression. Also the .PHONY is a good idea.

However, perhaps, it is better for this check to be part of the test
suite. It might look like this (after fixing whitespace corruption):

-->8--
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 10be52b..e5ba504 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -387,6 +387,14 @@ test_expect_success 'tests clean up even on failures' "
 ################################################################
 # Basics of the basics

+# git.c commands[] of builtins is properly sorted
+test_expect_success 'builtin commands[] sorted' '
+ awk "/cmd_struct commands/,/};/ { if (match(\$2,/\"/)) print \$2 }" \
+ <../../git.c >actual && \
+ sort <actual >expect && \
+ test_cmp expect actual
+'
+
 # updating a new file without --add should fail.
 test_expect_success 'git update-index without --add should fail adding' '
  test_must_fail git update-index should-be-empty
-->8--

I'm not sure that referencing ../../git.c from within the test suite
is kosher. Perhaps Jonathan can say something about that.

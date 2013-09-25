From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] checkout: allow dwim for branch creation for "git checkout $branch --"
Date: Wed, 25 Sep 2013 15:52:07 +0200
Message-ID: <vpqob7huhyw.fsf@anie.imag.fr>
References: <1380113349-19838-1-git-send-email-Matthieu.Moy@imag.fr>
	<CACsJy8AbBrVSz=p+ARxvR_QXtku1BxbtQPv7pz_QCveeUEtwCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>, jc@sahnwaldt.de
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 25 15:52:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOpVr-0004w8-B4
	for gcvg-git-2@plane.gmane.org; Wed, 25 Sep 2013 15:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755515Ab3IYNwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Sep 2013 09:52:15 -0400
Received: from mx2.imag.fr ([129.88.30.17]:43953 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755425Ab3IYNwO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 09:52:14 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r8PDq5dE016839
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 25 Sep 2013 15:52:05 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VOpVf-00084D-Ae; Wed, 25 Sep 2013 15:52:07 +0200
In-Reply-To: <CACsJy8AbBrVSz=p+ARxvR_QXtku1BxbtQPv7pz_QCveeUEtwCQ@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 25 Sep 2013 20:22:39 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 25 Sep 2013 15:52:05 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r8PDq5dE016839
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1380721929.27617@0z/oapsA5yBmry21AG+q8Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235347>

Duy Nguyen <pclouds@gmail.com> writes:

> has_dash_dash is calculated as (argc > 1) && !strcmp(argv[1], "--"),
> so when argc == 1, the has_dash_dash must be zero, the "&&
> !has_dash_dash" is redundant.

Yes, but I'd rather not have to read the detailed definition of
has_dash_dash to understand the code. With my version, the name of the
variable is actually sufficient to understand.

> But it makes me wonder what we do with "git checkout abc def -- xyz".

Ouch. Both old and new say

$ git checkout foo bar --
error: pathspec 'foo' did not match any file(s) known to git.
error: pathspec 'bar' did not match any file(s) known to git.
error: pathspec '--' did not match any file(s) known to git.

Fortunately, this is easy to fix, by adding this on top (or before, it
doesn't matter):

commit 060cf582f5e848c5ca57231d293943a5489c5433 (HEAD, master)
Author: Matthieu Moy <Matthieu.Moy@imag.fr>
Date:   Wed Sep 25 15:41:34 2013 +0200

    checkout: proper error message on 'git checkout foo bar --'
    
    The previous code was detecting the presence of "--" by looking only at
    argument 1. As a result, "git checkout foo bar --" was interpreted as an
    ambiguous file/revision list, and errored out with:
    
    error: pathspec 'foo' did not match any file(s) known to git.
    error: pathspec 'bar' did not match any file(s) known to git.
    error: pathspec '--' did not match any file(s) known to git.
    
    This patch fixes it by walking through the argument list to find the
    "--", and now complains about the number of references given.

diff --git a/builtin/checkout.c b/builtin/checkout.c
index a5a12f6..d958d60 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -882,6 +882,7 @@ static int parse_branchname_arg(int argc, const char **argv,
        unsigned char branch_rev[20];
        const char *arg;
        int has_dash_dash;
+       int i;
 
        /*
         * case 1: git checkout <ref> -- [<paths>]
@@ -925,7 +926,15 @@ static int parse_branchname_arg(int argc, const char **argv,
                return 1;
 
        arg = argv[0];
-       has_dash_dash = (argc > 1) && !strcmp(argv[1], "--");
+       has_dash_dash = 0;
+       for (i = 0; i < argc; i++) {
+               if (!strcmp(argv[i], "--")) {
+                       has_dash_dash = i;
+                       break;
+               }
+       }
+       if (has_dash_dash >= 2)
+               die("only one reference expected, %d given.", has_dash_dash);
 
        if (!strcmp(arg, "-"))
                arg = "@{-1}";
diff --git a/t/t2010-checkout-ambiguous.sh b/t/t2010-checkout-ambiguous.sh
index 7cc0a35..2836a3e 100755
--- a/t/t2010-checkout-ambiguous.sh
+++ b/t/t2010-checkout-ambiguous.sh
@@ -47,4 +47,10 @@ test_expect_success 'disambiguate checking out from a tree-ish' '
        git diff --exit-code --quiet
 '
 
+test_expect_success 'accurate error message with more than one ref' '
+       test_must_fail git checkout HEAD master -- 2>actual &&
+       echo "fatal: only one reference expected, 2 given." >expect &&
+       test_cmp expect actual
+'
+
 test_done

I'll resend, together with tweaks to the first patch.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

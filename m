From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/8] am: suppress error output from a conditional
Date: Sun, 12 May 2013 05:08:43 +0530
Message-ID: <CALkWK0mtJU_fWK7A2BXN3f5VRT4Qh69PE0nfQaTJ6GU1Z5=wig@mail.gmail.com>
References: <1368196005-5354-1-git-send-email-artagnon@gmail.com>
 <1368196005-5354-2-git-send-email-artagnon@gmail.com> <7vhaia51vh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 12 01:39:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbJO3-00007B-KN
	for gcvg-git-2@plane.gmane.org; Sun, 12 May 2013 01:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752318Ab3EKXjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 19:39:25 -0400
Received: from mail-ia0-f174.google.com ([209.85.210.174]:35858 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028Ab3EKXjY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 19:39:24 -0400
Received: by mail-ia0-f174.google.com with SMTP id j3so4780160iae.19
        for <git@vger.kernel.org>; Sat, 11 May 2013 16:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=vUNuhGqEFp/lquzw4C+g53b9zEoslzYrUrDEVyiqTsY=;
        b=kbhij+vKW7AS0xc/fRN1U6WM+pS0lUN12KsxYNQkzqBqoKlhQFpzkh6XhAyvninSyr
         GUyjkNAOaQ26QMYRFzkEB8pJ+WeqoAdRbn+6vFvxdNgoXPOKgJTuunGL/gM+f3jaZKlV
         b59H4HBpj4KrBhWdXSaSsyTvQ/VZMdkT0jX22VfKjA/hOAsr9dhiBGS47wiPTVzmA75i
         yoaXyKI5n/GEBeVjMvdf69rkXQb3T/k5m7VAgU3FniVqh9pYdVgyNynK8ge5JaybI4jH
         94MHz0pe0DB1ZEQ2kuATk5Ksqu+4zu3qQbeSWx8xBr9AcQQhpSaslZ/cs1+lhmyvHZOT
         86WQ==
X-Received: by 10.42.27.146 with SMTP id j18mr10909973icc.54.1368315563958;
 Sat, 11 May 2013 16:39:23 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Sat, 11 May 2013 16:38:43 -0700 (PDT)
In-Reply-To: <7vhaia51vh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224020>

Junio C Hamano wrote:
> If you are introducing "dotest exists but next/last may not be
> present" as a valid new state, it probably should check the presence
> and/or absence of them explicitly,

Um, a test -f preceding the cat?  Why, when cat implicitly checks
existence anyway?

> but more importantly, it is a
> good idea to move "test $# != 0" higher.

This?

diff --git a/git-am.sh b/git-am.sh
index 47c1021..1e10e31 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -446,9 +446,9 @@ done
 # If the dotest directory exists, but we have finished applying all the
 # patches in them, clear it out.
 if test -d "$dotest" &&
+   test $# != 0 &&
    last=$(cat "$dotest/last" 2>/dev/null) &&
    next=$(cat "$dotest/next" 2>/dev/null) &&
-   test $# != 0 &&
    test "$next" -gt "$last"
 then
    rm -fr "$dotest"

> Earlier it did not matter
> because when $dotest existed, next/last were supposed to be there
> and absence of them was an error codepath. Now, missing these files
> is not an error but is a perfectly normal state,

It's not a "normal state" for the purposes of git-am.sh.  There is no
codepath in the program that depends only on $dotest, but not
next/last.  I would frame this as: "checking for $dotest is not a
sufficient prerequisite anymore; we have to additionally look for
next/last".  To git-am.sh, an empty $dotest or just a
$dotest/autostash is equivalent to no $dotest at all.

> so checking what
> can be checked more cheaply makes sense as a general code hygiene.

Yeah, I agree.  See "am: tighten a conditional that checks for
$dotest", where I get away with just checking $dotest/last (and assume
that $dotest/next is present by extension).  How do I apply your
suggestion to this particular patch?

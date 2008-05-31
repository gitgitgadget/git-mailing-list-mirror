From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH] Add test cases for git-am
Date: Sat, 31 May 2008 04:40:27 +0200
Message-ID: <20080531024027.GB5907@leksak.fem-net>
References: <20080530140447.GB10514@leksak.fem-net> <7vy75rh25i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 31 04:41:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2H2Y-0000ef-Qe
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 04:41:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbYEaCkf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 22:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750985AbYEaCkf
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 22:40:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:59040 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750710AbYEaCke (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 22:40:34 -0400
Received: (qmail invoked by alias); 31 May 2008 02:40:32 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp040) with SMTP; 31 May 2008 04:40:32 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/1sc9C/5r1ZaDXMAWtqLji7sX7YZdsM5EbdXhQPu
	TuA/4+lBB6Wqn1
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1K2H19-0002rj-UI; Sat, 31 May 2008 04:40:27 +0200
Content-Disposition: inline
In-Reply-To: <7vy75rh25i.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83364>

Hi,

>     Mail-Followup-To: git@vger.kernel.org, gitster@pobox.com
> 
> Please don't do this "Mail-Followup-To:"; it is rude to others, and it is
> rude to me.

Oh, it was not meant to be rude.
In fact, I didn't even knew that my mutt generates it. ;)
So I deactivated it and I hope it helps you to enjoy your Caipirinha.

Btw, I'm confused whether I should use "List reply" (which only
replies to git@vger.kernel.org) or "Reply to all" (which I used now).
While on some other mailinglists it is discouraged to "reply to all",
it seems to be the common case here.

> > Perhaps it is also useful to swap t4150 and t4151 or to merge them.
> 
> Pehaps.  A single test t4150-am.sh might be enough.

Ok.

> > +test_expect_success setup '
> > +	echo hello >file &&
> > +	git add file &&
> > +	test_tick &&
> > +	git commit -m first &&
> > +	git tag first &&
> > +	echo world >>file &&
> > +	git add file &&
> > +	test_tick &&
> > +	git commit -s -F msg &&
> > +	git tag second &&
> > +	git format-patch --stdout first >patch1 &&
> > +	tail -n +3 msg >file &&
> 
> "tail -n 3" you mean?

No :-)
"tail -n 3" or "tail -n -3" results in the last three lines, but
"tail -n +3" results in the last lines beginning from the third line.

All three cases are POSIX-conform according to the online specs of 
IEEE or OpenGroup, e.g. see
	http://www.opengroup.org/onlinepubs/009695399/utilities/tail.html

> Same for "head -n <n>" in other places.

Here you are right that "head -n 3" equals "head -n +3", since both
result in the first three lines. ("head -n -3" results in all lines
except the last three.)
I kept the '+'-prefix for consistency, but I can remove it if you like.

> > +test_expect_success 'am changes committer and keeps author' '
> > +	test_tick &&
> > +	git checkout first &&
> > +	git am patch2 &&
> > +	! test -d .dotest &&
> > +	test "$(git rev-parse master)" != "$(git rev-parse HEAD)" &&
> > +	test "$(git rev-parse master^)" != "$(git rev-parse HEAD^)" &&
> > +	test "$(git rev-parse master^^)" = "$(git rev-parse HEAD^^)" &&
> > +	test -z "$(git diff master..HEAD)" &&
> > +	test -z "$(git diff master^..HEAD^)" &&
> > +	compare author master HEAD &&
> > +	compare author master^ HEAD^ &&
> > +	! compare committer master HEAD &&
> > +	! compare committer master^ HEAD^
> > +'
> 
> Hmmm.  Checking for inequality does not feel so robust.  You will allow
> "am" to record garbage and will not be able to detect a breakage.

Oh, right.

Does this feel better?
--- a/t/t4151-am.sh
+++ b/t/t4151-am.sh
@@ -123,15 +123,13 @@ test_expect_success 'am changes committer and keeps author' '
 	git checkout first &&
 	git am patch2 &&
 	! test -d .dotest &&
-	test "$(git rev-parse master)" != "$(git rev-parse HEAD)" &&
-	test "$(git rev-parse master^)" != "$(git rev-parse HEAD^)" &&
 	test "$(git rev-parse master^^)" = "$(git rev-parse HEAD^^)" &&
 	test -z "$(git diff master..HEAD)" &&
 	test -z "$(git diff master^..HEAD^)" &&
 	compare author master HEAD &&
 	compare author master^ HEAD^ &&
-	! compare committer master HEAD &&
-	! compare committer master^ HEAD^
+	test "Co M Miter <c.miter@example.com>" = \
+	     "$(git log -1 --pretty=format:"%cn <%ce>" HEAD)"
 '
 
 test_expect_success 'am --signoff adds Signed-off-by: line' '
---
Or better ideas? ;)

> > +test_expect_success 'am --signoff adds Signed-off-by: line' '
> > +	git checkout -b master2 first &&
> > +	git am --signoff <patch2 &&
> > +	test "$(git cat-file commit HEAD | grep -c "^Signed-off-by:")" -eq 1 &&
> > +	test "$(git cat-file commit HEAD^ | grep -c "^Signed-off-by:")" -eq 2
> > +'
> 
> Again, don't you want to check not just "It added something", but "It
> added what we expected it to add"?

Like this?
---
 test_expect_success 'am --signoff adds Signed-off-by: line' '
 	git checkout -b master2 first &&
 	git am --signoff <patch2 &&
 	test "$(git cat-file commit HEAD | grep -c "^Signed-off-by:")" -eq 1 &&
-	test "$(git cat-file commit HEAD^ | grep -c "^Signed-off-by:")" -eq 2
+	test "$(git cat-file commit HEAD^ | grep -c "^Signed-off-by:")" -eq 2 &&
+	git cat-file commit HEAD | grep -q "^Signed-off-by: Co M Miter <c.miter@example.com>$" &&
+	git cat-file commit HEAD^ | grep -q "^Signed-off-by: Co M Miter <c.miter@example.com>$" &&
+	git cat-file commit HEAD^ | grep -q "^Signed-off-by: C O Mitter <committer@example.com>$"
 '
---

Mh, I thought it is not bad to keep the -eq checks just to go sure nothing
is added twice by whatever reason.
 

Thank you!
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F

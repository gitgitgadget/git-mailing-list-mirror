From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git apply: git diff header lacks filename information for git
 diff --no-index patch
Date: Sat, 4 Oct 2008 10:48:08 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0810041031580.3208@nehalem.linux-foundation.org>
References: <500f3d130810021127j570bb540p901f6a73f58a6cb1@mail.gmail.com> <20081004041714.GA12413@coredump.intra.peff.net> <alpine.LFD.2.00.0810040918290.3208@nehalem.linux-foundation.org> <alpine.LFD.2.00.0810041004290.3208@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Imre Deak <imre.deak@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 04 19:49:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmBFu-0002MK-3o
	for gcvg-git-2@gmane.org; Sat, 04 Oct 2008 19:49:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752960AbYJDRsP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Oct 2008 13:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752641AbYJDRsP
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Oct 2008 13:48:15 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54758 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752615AbYJDRsP (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Oct 2008 13:48:15 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m94Hm9q5002683
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 4 Oct 2008 10:48:10 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m94Hm86q025531;
	Sat, 4 Oct 2008 10:48:08 -0700
In-Reply-To: <alpine.LFD.2.00.0810041004290.3208@nehalem.linux-foundation.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.434 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97475>



On Sat, 4 Oct 2008, Linus Torvalds wrote:
> 
> Ahh, never mind, this one is broken.

Ok, so here's a much better version, I think.

It just refuses to use an invalid name for anything visible in the diff.

Now, this fixes the "git diff --no-index --binary a /dev/null" kind of 
case (and we'll end up using "a" as the basename), but some other insane 
cases are impossible to handle. If you do

	git diff --no-index --binary a /bin/echo

you'll still get a patch like

	diff --git a/a b/bin/echo
	old mode 100644
	new mode 100755
	index ...

and "git apply" will refuse to apply it for a couple of reasons, and the 
diff is simply bogus. 

And that, btw, is no longer a bug, I think. It's impossible to know whethe 
the user meant for the patch to be a rename or not. And as such, refusing 
to apply it because you don't know what name you should use is probably 
_exactly_ the right thing to do!

		Linus

----
 diff.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/diff.c b/diff.c
index 9053d4d..197533e 100644
--- a/diff.c
+++ b/diff.c
@@ -1493,6 +1493,10 @@ static void builtin_diff(const char *name_a,
 		b_prefix = o->b_prefix;
 	}
 
+	/* Never use a non-valid filename anywhere if at all possible */
+	name_a = DIFF_FILE_VALID(one) ? name_a : name_b;
+	name_b = DIFF_FILE_VALID(two) ? name_b : name_a;
+
 	a_one = quote_two(a_prefix, name_a + (*name_a == '/'));
 	b_two = quote_two(b_prefix, name_b + (*name_b == '/'));
 	lbl[0] = DIFF_FILE_VALID(one) ? a_one : "/dev/null";

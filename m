From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: Re: John (zzz) Doe <john.doe@xz> (Comment)
Date: Tue, 20 Jan 2009 22:14:46 +0300
Organization: St.Petersburg State University
Message-ID: <20090120191446.GB5721@roro3.zxlink>
References: <7vmydu3yy7.fsf@gitster.siamese.dyndns.org> <20090115194926.GA6899@roro3.zxlink> <7vd4eos3rp.fsf@gitster.siamese.dyndns.org> <20090116080807.GA10792@landau.phys.spbu.ru> <7vd4enacf2.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901161253411.3586@pacific.mpi-cbg.de> <20090118145429.GA27522@roro3.zxlink> <7vmydoxxcr.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 20 20:15:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPM3q-0005d1-Id
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 20:14:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754121AbZATTNa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 14:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753841AbZATTNa
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 14:13:30 -0500
Received: from landau.phys.spbu.ru ([195.19.235.38]:4169 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753815AbZATTN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 14:13:29 -0500
Received: by landau.phys.spbu.ru (Postfix, from userid 509)
	id 05E7217B663; Tue, 20 Jan 2009 22:13:26 +0300 (MSK)
Received: from kirr by landau.phys.spbu.ru with local (Exim 4.69)
	(envelope-from <kirr@roro3.zxlink>)
	id 1LPM3i-0007s2-20; Tue, 20 Jan 2009 22:14:46 +0300
Content-Disposition: inline
In-Reply-To: <7vmydoxxcr.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106509>

On Sun, Jan 18, 2009 at 10:50:12AM -0800, Junio C Hamano wrote:
> So we can separate "John (zzz) Doe <john.doe@xz> (Comment)" into:
> 
> 	AUTHOR_EMAIL=john.doe@xz
>         AUTHOR_NAME="John (zzz) Doe (Comment)"
> 
> and leave it like so, I think.

Ok, here you are:

Subject: [PATCH 1/3] mailinfo: cleanup extra spaces for complex 'From'

As described in RFC822 (3.4.3 COMMENTS, and  A.1.4.), comments, as e.g.

    John (zzz) Doe <john.doe@xz> (Comment)

should "NOT [be] included in the destination mailbox"

On the other hand, quoting Junio:

> The above quote from the RFC is irrelevant.  Note that it is only about
> how you extract the e-mail address, discarding everything else.
>
> What mailinfo wants to do is to separate the human-readable name and the
> e-mail address, and we want to use _both_ results from it.
>
> We separate a few example From: lines like this:
>
> 	Kirill Smelkov <kirr@smelkov.xz>
> ==>	AUTHOR_EMAIL="kirr@smelkov.xz" AUTHOR_NAME="Kirill Smelkov"
>
> 	kirr@smelkov.xz (Kirill Smelkov)
> ==>	AUTHOR_EMAIL="kirr@smelkov.xz" AUTHOR_NAME="Kirill Smelkov"
>
> Traditionally, the way people spelled their name on From: line has been
> either one of the above form.  Typically comment form (i.e. the second
> one) adds the name at the end, while "Name <addr>" form has the name at
> the front.  But I do not think RFC requires that, primarily because it is
> all about discarding non-address part to find the e-mail address aka
> "destination mailbox".  It does not specify how humans should interpret
> the human readable name and the comment.
>
> Now, why is the name not AUTHOR_NAME="(Kirill Smelkov)" in the latter
> form?
>
> It is just common sense transformation.  Otherwise it looks simply ugly,
> and it is obvious that the parentheses is not part of the name of the
> person who used "kirr@smelkov.xz (Kirill Smelkov)" on his From: line.
>
> So we can separate "John (zzz) Doe <john.doe@xz> (Comment)" into:
>
> 	AUTHOR_EMAIL=john.doe@xz
>         AUTHOR_NAME="John (zzz) Doe (Comment)"
>
> and leave it like so, I think.

So let's just correctly remove extra spaces which could be left inside
name.

We need this functionality to pass all RFC2047 based tests in the next commit.

Signed-off-by: Kirill Smelkov <kirr@landau.phys.spbu.ru>
---
 builtin-mailinfo.c  |   21 +++++++++++++++++----
 t/t5100/info0001    |    2 +-
 t/t5100/sample.mbox |    4 ++--
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index dacc8ac..8030823 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -29,6 +29,9 @@ static struct strbuf **p_hdr_data, **s_hdr_data;
 #define MAX_HDR_PARSED 10
 #define MAX_BOUNDARIES 5
 
+static void cleanup_space(struct strbuf *sb);
+
+
 static void get_sane_name(struct strbuf *out, struct strbuf *name, struct strbuf *email)
 {
 	struct strbuf *src = name;
@@ -109,10 +112,14 @@ static void handle_from(const struct strbuf *from)
 	strbuf_add(&email, at, el);
 	strbuf_remove(&f, at - f.buf, el + (at[el] ? 1 : 0));
 
-	/* The remainder is name.  It could be "John Doe <john.doe@xz>"
-	 * or "john.doe@xz (John Doe)", but we have removed the
-	 * email part, so trim from both ends, possibly removing
-	 * the () pair at the end.
+	/* The remainder is name.  It could be
+	 *
+	 * - "John Doe <john.doe@xz>"			(a), or
+	 * - "john.doe@xz (John Doe)"			(b), or
+	 * - "John (zzz) Doe <john.doe@xz> (Comment)"	(c)
+	 *
+	 * but we have removed the email part, so trim from both ends, possibly
+	 * removing the () pair at the end for case 'b'.
 	 */
 	strbuf_trim(&f);
 	if (f.buf[0] == '(' && f.len && f.buf[f.len - 1] == ')') {
@@ -120,6 +127,12 @@ static void handle_from(const struct strbuf *from)
 		strbuf_setlen(&f, f.len - 1);
 	}
 
+	/* Otherwise we want comments to stay. It's just time to cleanup extra
+	 * spaces
+	 */
+	cleanup_space(&f);
+	strbuf_trim(&f);
+
 	get_sane_name(&name, &f, &email);
 	strbuf_release(&f);
 }
diff --git a/t/t5100/info0001 b/t/t5100/info0001
index 8c05277..f951538 100644
--- a/t/t5100/info0001
+++ b/t/t5100/info0001
@@ -1,4 +1,4 @@
-Author: A U Thor
+Author: A (zzz) U Thor (Comment)
 Email: a.u.thor@example.com
 Subject: a commit.
 Date: Fri, 9 Jun 2006 00:44:16 -0700
diff --git a/t/t5100/sample.mbox b/t/t5100/sample.mbox
index 38725f3..4f80b82 100644
--- a/t/t5100/sample.mbox
+++ b/t/t5100/sample.mbox
@@ -2,10 +2,10 @@
 	
     
 From nobody Mon Sep 17 00:00:00 2001
-From: A
+From: A (zzz)
       U
       Thor
-      <a.u.thor@example.com>
+      <a.u.thor@example.com> (Comment)
 Date: Fri, 9 Jun 2006 00:44:16 -0700
 Subject: [PATCH] a commit.
 
-- 
1.6.1.79.g92b9.dirty


Is it ok?

And by the way, please pull the whole updated series from

    git://repo.or.cz/git/kirr.git   for-junio-maint

Kirill Smelkov (3):
      mailinfo: cleanup extra spaces for complex 'From'
      mailinfo: add explicit test for mails like '<a.u.thor@example.com> (A U Thor)'
      mailinfo: tests for RFC2047 examples


Thanks,
Kirill

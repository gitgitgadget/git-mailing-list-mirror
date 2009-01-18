From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: Re: What's cooking in git.git (Jan 2009, #03; Wed, 14)
Date: Sun, 18 Jan 2009 17:54:29 +0300
Organization: St.Petersburg State University
Message-ID: <20090118145429.GA27522@roro3.zxlink>
References: <7vmydu3yy7.fsf@gitster.siamese.dyndns.org> <20090115194926.GA6899@roro3.zxlink> <7vd4eos3rp.fsf@gitster.siamese.dyndns.org> <20090116080807.GA10792@landau.phys.spbu.ru> <7vd4enacf2.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901161253411.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 18 15:54:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOZ2y-0002Yu-0B
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 15:54:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760236AbZAROxO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 09:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759932AbZAROxN
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 09:53:13 -0500
Received: from landau.phys.spbu.ru ([195.19.235.38]:4110 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759681AbZAROxN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 09:53:13 -0500
Received: by landau.phys.spbu.ru (Postfix, from userid 509)
	id E928417B663; Sun, 18 Jan 2009 17:53:10 +0300 (MSK)
Received: from kirr by landau.phys.spbu.ru with local (Exim 4.69)
	(envelope-from <kirr@roro3.zxlink>)
	id 1LOZ2j-0007Qp-3S; Sun, 18 Jan 2009 17:54:29 +0300
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901161253411.3586@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106203>

On Fri, Jan 16, 2009 at 12:54:28PM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Fri, 16 Jan 2009, Junio C Hamano wrote:
> 
> > I thought there is somebody on this list who insists his name is of form:
> > 
> > 	From: A U Thor (MonikeR) <a.u@thor.xz>
> 
> It is Philippe Bruhat (BooK), who sometimes forgets the closing 
> parenthesis, and who is listed in .mailmap without the moniker.

So now I don't understand what to do.

>From one hand RFC822 says '(...)' is a comment, and from the other hand,
we have a use case where one guy wants this to stay.

For the record, here is the questionable patch. Any suggestion?

Thanks,
Kirill


commit 49bebfbe18dac296e5e246884bd98c1f90be9676
Author: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Date:   Tue Jan 13 01:21:04 2009 +0300

    mailinfo: more smarter removal of rfc822 comments from 'From'
    
    As described in RFC822 (3.4.3 COMMENTS, and  A.1.4.), comments, as e.g.
    
        John (zzz) Doe <john.doe@xz> (Comment)
    
    should "NOT [be] included in the destination mailbox"
    
    We need this functionality to pass all RFC2047 based tests in the next commit.
    
    Signed-off-by: Kirill Smelkov <kirr@landau.phys.spbu.ru>

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index dacc8ac..958c905 100644
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
@@ -120,6 +123,33 @@ static void handle_from(const struct strbuf *from)
 		strbuf_setlen(&f, f.len - 1);
 	}
 
+	/* This still could not be finished for emails like
+	 *
+	 *	"John (zzz) Doe <john.doe@xz> (Comment)"
+	 *
+	 * The email part had already been removed, so let's kill comments as
+	 * well -- RFC822 says comments should not be present in destination
+	 * mailbox (3.4.3. Comments  and  A.1.4.)
+	 */
+	while (1) {
+		char *ta;
+
+		at = strchr(f.buf, '(');
+		if (!at)
+			break;
+		ta = strchr(at, ')');
+		if (!ta)
+			break;
+
+		strbuf_remove(&f, at - f.buf, ta-at + (*ta ? 1 : 0));
+	}
+
+	/* and let's finally cleanup spaces that were around (possibly
+	 * internal) comments
+	 */
+	cleanup_space(&f);
+	strbuf_trim(&f);
+
 	get_sane_name(&name, &f, &email);
 	strbuf_release(&f);
 }
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
 

From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git annotate runs out of memory
Date: Tue, 11 Dec 2007 16:02:45 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712111548200.25032@woody.linux-foundation.org>
References: <4aca3dc20712110933i636342fbifb15171d3e3cafb3@mail.gmail.com> <alpine.LFD.0.9999.0712111018540.25032@woody.linux-foundation.org> <4aca3dc20712111109y5d74a292rf29be6308932393c@mail.gmail.com> <alpine.LFD.0.9999.0712111122400.25032@woody.linux-foundation.org>
 <alpine.LFD.0.9999.0712111300440.25032@woody.linux-foundation.org> <7vprxcdhis.fsf@gitster.siamese.dyndns.org> <alpine.LFD.0.9999.0712111523210.25032@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Berlin <dberlin@dberlin.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Davide Libenzi <davidel@xmailserver.org>
X-From: git-owner@vger.kernel.org Wed Dec 12 01:03:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2F4o-0002Dj-4Y
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 01:03:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755103AbXLLAD0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 19:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755115AbXLLAD0
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 19:03:26 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:60877 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755094AbXLLADZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Dec 2007 19:03:25 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBC02kBe004047
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 11 Dec 2007 16:02:47 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBC02jVW015848;
	Tue, 11 Dec 2007 16:02:45 -0800
In-Reply-To: <alpine.LFD.0.9999.0712111523210.25032@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.416 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_13
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67972>



On Tue, 11 Dec 2007, Linus Torvalds wrote:
> 
> and while I suspect xdiff could be optimized a bit more for the cases 
> where we have no changes at the end, that's beyond my skills.

Ok, I lied.

Nothing is beyond my skills. My mad k0der skillz are unbeatable.

This speeds up git-blame on ChangeLog-style files by a big amount, by just 
ignoring the common end that we don't care about, since we don't want any 
context anyway at that point. So I now get:

	[torvalds@woody gcc]$ time git blame gcc/ChangeLog > /dev/null

	real    0m7.031s
	user    0m6.852s
	sys     0m0.180s

which seems quite reasonable, and is about three times faster than trying 
to diff those big files.

Davide: this really _does_ make a huge difference. Maybe xdiff itself 
should do this optimization on its own, rather than have the caller hack 
around the fact that xdiff doesn't handle this common case all that well?

The same thing obviously works for the beginning-of-file too, but then you 
have to play games with line numbers being affected etc, so the end is the 
rather much easier case and is the case that a ChangeLog-style file cares 
about.

Daniel, this is obviously on top of the patches that fix the memory leak.

			Linus

---
diff --git a/builtin-blame.c b/builtin-blame.c
index c158d31..677188c 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -543,6 +551,20 @@ static struct patch *compare_buffer(mmfile_t *file_p, mmfile_t *file_o,
 	return state.ret;
 }
 
+#define BLOCK 1024
+
+static void truncate_common_data(mmfile_t *a, mmfile_t *b)
+{
+	long l1 = a->size, l2 = b->size;
+
+	while ((l1 -= BLOCK) > 0 && (l2 -= BLOCK) > 0) {
+		if (memcmp(a->ptr + l1, b->ptr + l2, BLOCK))
+			break;
+		a->size = l1;
+		b->size = l2;
+	}
+}
+
 /*
  * Run diff between two origins and grab the patch output, so that
  * we can pass blame for lines origin is currently suspected for
@@ -557,6 +579,7 @@ static struct patch *get_patch(struct origin *parent, struct origin *origin)
 	fill_origin_blob(origin, &file_o);
 	if (!file_p.ptr || !file_o.ptr)
 		return NULL;
+	truncate_common_data(&file_p, &file_o);
 	patch = compare_buffer(&file_p, &file_o, 0);
 	num_get_patch++;
 	return patch;

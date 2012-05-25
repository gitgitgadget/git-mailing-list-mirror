From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: fmt-merge-message: add empty line between tag and signature
 verification
Date: Fri, 25 May 2012 09:02:03 -0700 (PDT)
Message-ID: <alpine.LFD.2.02.1205250850001.19607@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 25 18:02:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXwyA-0004EC-1z
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 18:02:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932652Ab2EYQCV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 May 2012 12:02:21 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:48939 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753675Ab2EYQCU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2012 12:02:20 -0400
Received: by pbbrp8 with SMTP id rp8so1934032pbb.19
        for <git@vger.kernel.org>; Fri, 25 May 2012 09:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:x-x-sender:to:cc:subject:message-id:user-agent
         :mime-version:content-type;
        bh=nVJp/Dbq9f02M/+4C7YjcmYUPCZAW9O0swIwLTqMuVY=;
        b=0xYvVsryQxl8zzwz4lJqnD/A4OBAYrCQIPurXdICHy1KqDS7ZHuRC2mQkRVZOQCKm1
         uT4rU3r/3tEr9XzWjAkgfe5GX6Hn3XzDDMmvY1D4X/CNNeuumXfFIalFNpnPhbew3s/0
         zpy6N7w7S+W+wfbXzQ2Kf6bo3izzRHjaV0G1cnjjgSswbmCc0xDGLTReJ2FNFM4BAfRH
         n8oyN/isiPvuw5I+eQIyT8vPpPN4WpHhKs5pqpGPksUh13QoxIEgwkvn35QVxIIe5rFx
         3X/q4q+bESI6Tq9evHBHqN3W/GibDRNg2IfiET8lv8hDxTYujpXnk9VVcmNmmlRj+d9I
         qySg==
Received: by 10.68.226.99 with SMTP id rr3mr33562502pbc.48.1337961739981;
        Fri, 25 May 2012 09:02:19 -0700 (PDT)
Received: from [192.168.1.87] (c-67-168-200-136.hsd1.or.comcast.net. [67.168.200.136])
        by mx.google.com with ESMTPS id uz7sm9456299pbc.35.2012.05.25.09.02.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 25 May 2012 09:02:19 -0700 (PDT)
X-X-Sender: torvalds@i5.linux-foundation.org
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198480>


When adding the information from a tag, put an empty line between the 
message of the tag and the commented-out signature verification 
information.

At least for the kernel workflow, I often end up re-formatting the message 
that people send me in the tag data. In that situation, putting the tag 
message and the tag signature verification back-to-back then means that 
normal editor "reflow parapgraph" command will get confused and think that 
the signature is a continuation of the last message paragraph.

So I always end up having to first add an empty line, and then go back and 
reflow the last paragraph. Let's just do it in git directly.

The extra vertical space also makes the verification visually stand out 
more from the user-supplied message, so it looks a bit more readable to me 
too, but that may be just an odd personal preference.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
This is a throw-away patch - apply or not as you prefer. I thought I'd 
send it out and see what people thought.

I don't feel *that* strongly about it.

Btw, I'd also like to see the merge notes (notably the conflict file list) 
before the generated shortlog, but that seems to really not work with the 
current fmt-merge-message model.  Oh well.

And the strbuf_complete_line() change is entirely independent, but didn't 
seem worth an extra separate patch.  Feel free to take that out, or do it 
independently or whatever.

 builtin/fmt-merge-msg.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index a517f1794a1c..d42015d8672d 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -462,7 +462,10 @@ static void fmt_tag_signature(struct strbuf *tagbuf,
 		strbuf_add(tagbuf, tag_body, buf + len - tag_body);
 	}
 	strbuf_complete_line(tagbuf);
-	strbuf_add_lines(tagbuf, "# ", sig->buf, sig->len);
+	if (sig->len) {
+		strbuf_addch(tagbuf, '\n');
+		strbuf_add_lines(tagbuf, "# ", sig->buf, sig->len);
+	}
 }
 
 static void fmt_merge_msg_sigs(struct strbuf *out)
@@ -627,8 +630,7 @@ int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 		rev.ignore_merges = 1;
 		rev.limited = 1;
 
-		if (suffixcmp(out->buf, "\n"))
-			strbuf_addch(out, '\n');
+		strbuf_complete_line(out);
 
 		for (i = 0; i < origins.nr; i++)
 			shortlog(origins.items[i].string,

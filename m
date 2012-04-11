From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC v2] fast-import doc: cat-blob and ls responses need to be
 consumed quickly
Date: Wed, 11 Apr 2012 16:25:01 -0500
Message-ID: <20120411212501.GH4248@burratino>
References: <20120411143249.GA4140@burratino>
 <7v1ununtb2.fsf@alter.siamese.dyndns.org>
 <20120411171707.GD4248@burratino>
 <7vlim2kwcv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Dmitry Ivankov <divanorama@gmail.com>,
	Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 23:25:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI52R-0000F7-1r
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 23:25:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933413Ab2DKVZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 17:25:08 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51497 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933381Ab2DKVZH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 17:25:07 -0400
Received: by iagz16 with SMTP id z16so1793792iag.19
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 14:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=VfEhoIdDARHcWuCQ3ZwJvkQOxETpOfHTsnDLfa/jfmA=;
        b=nvcSLlQOTmxhuEnNxq4VVrryasDc04dpP2B87SWzFAeggwC13eEzNT5XGnUitmXwBY
         Ts4cLti9rDpl52sEPDxglfCuNADpmj/fgNhy1UN73GsQtfFLmCGgR79BsEa9BHmCZLQe
         c4evIiC03EKR/df3JNQBeNZAYq2fhXkoSWP5Qxu/7ujVQM5Ouer3fpQP+Mlxy9ZdPLbM
         ShzVNkHiAZUEX38Pibs7f7ZMw4anvn0CCCYAdwpGp9HY726nO/60fj7X1AQWvVgrjdtn
         ieAuqLCgZwi/S1nWwZ463eULqrOgIRmHVGCNgC3fNbuq0Qv20m1+OINL0CWgB3UZwu+i
         P4Ug==
Received: by 10.50.42.134 with SMTP id o6mr7083659igl.72.1334179507133;
        Wed, 11 Apr 2012 14:25:07 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id nq4sm10758592igc.5.2012.04.11.14.25.05
        (version=SSLv3 cipher=OTHER);
        Wed, 11 Apr 2012 14:25:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vlim2kwcv.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195265>

If fast-import's command pipe and the frontend's cat-blob/ls response
pipe are both filled, there can be a deadlock.  Luckily all existing
frontends consume any pending cat-blob/ls responses completely before
writing the next command.

Document the requirements so future frontend authors and users can be
spared from the problem, too.  It is not always easy to catch that
kind of bug by testing.

To set the scene, add some words of explanation to help the novice
understand that "cat-blob" and "ls" output are meant for consumption
by the frontend.

Reported-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Junio C Hamano wrote:

> The expected use of --cat-blob-fd is to loop it back to the frontend, and
> that is obvious to _us_, but there is nothing in the existing text (or the
> text added by this patch) that suggests that fact to the first time
> reader.  "Frontends must consume" may not "click" without that knowledge.

True.  Here's a rough attempt (again against "master").

 Documentation/git-fast-import.txt |   44 +++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index ec6ef311..7b220c28 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -98,9 +98,10 @@ OPTIONS
 	options.
 
 --cat-blob-fd=<fd>::
-	Specify the file descriptor that will be written to
-	when the `cat-blob` command is encountered in the stream.
-	The default behaviour is to write to `stdout`.
+	Write responses to `cat-blob` and `ls` queries to the
+	file descriptor <fd> instead of `stdout`.  Allows `progress`
+	output intended for the end-user to be separated from other
+	output.
 
 --done::
 	Require a `done` command at the end of the stream.
@@ -942,6 +943,9 @@ This command can be used anywhere in the stream that comments are
 accepted.  In particular, the `cat-blob` command can be used in the
 middle of a commit but not in the middle of a `data` command.
 
+See ``Responses To Commands'' below for details about how to read
+this output safely.
+
 `ls`
 ~~~~
 Prints information about the object at a path to a file descriptor
@@ -991,6 +995,9 @@ instead report
 	missing SP <path> LF
 ====
 
+See ``Responses To Commands'' below for details about how to read
+this output safely.
+
 `feature`
 ~~~~~~~~~
 Require that fast-import supports the specified feature, or abort if
@@ -1079,6 +1086,35 @@ If the `--done` command line option or `feature done` command is
 in use, the `done` command is mandatory and marks the end of the
 stream.
 
+Responses To Commands
+---------------------
+New objects written by fast-import are not available immediately.
+Most fast-import commands have no visible effect until the next
+checkpoint (or completion).  The frontend can send commands to
+fill fast-import's input pipe without worrying about how quickly
+they will take effect, which improves performance by simplifying
+scheduling.
+
+For some frontends, though, it is useful to be able to read back
+data from the current repository as it is being updated (for
+example when the source material describes objects in terms of
+patches to be applied to previously imported objects).  This can
+be accomplished by connecting the frontend and fast-import via
+bidirectional pipes:
+
+====
+	mkfifo fast-import-output
+	frontend <fast-import-output |
+	git fast-import >fast-import-output
+====
+
+A frontend set up this way can use `progress`, `ls`, and `cat-blob`
+commands to read information from the import in progress.
+
+To avoid deadlock, such frontends must completely consume any
+pending output from `progress`, `ls`, and `cat-blob` before
+performing writes to fast-import that might block.
+
 Crash Reports
 -------------
 If fast-import is supplied invalid input it will terminate with a
-- 
1.7.10

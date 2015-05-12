From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 3/3] cat-file: add --follow-symlinks to --batch
Date: Tue, 12 May 2015 11:07:03 -0700
Message-ID: <xmqqoalpzn3s.fsf@gitster.dls.corp.google.com>
References: <1431384645-17276-1-git-send-email-dturner@twopensource.com>
	<1431384645-17276-4-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: dturner@twopensource.com
X-From: git-owner@vger.kernel.org Tue May 12 20:07:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsEaF-0003LD-H0
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 20:07:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933039AbbELSHH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 14:07:07 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:34091 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932639AbbELSHF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 14:07:05 -0400
Received: by iecmd7 with SMTP id md7so9106999iec.1
        for <git@vger.kernel.org>; Tue, 12 May 2015 11:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=cqEqhRfeiOCaqYcLeZAHVbw+yEQH8FVse8Wk6AvHq04=;
        b=JLY9mw1q8ggquPqgT2v3+7IRkld/FMnkPDHYtODQ0XVsDeazo/f6fNW7iceZjBl5Ql
         o1Lgwc3ccAZy9vxkvME/DFTLY8LB0e+8YdVr8lht+M9nfzlP1IuWw/VBBpuyN9TR3FPx
         sjYWU5FNUY1YcgcoFH/rgb93lfQ6UuoQBNkgkd9OFVoFnWt2I5ZkrTOsFrSnZ24LmkkO
         LSwq/4DTrZbRZhbVLqhq4OHgTiIkGrGZYN1b7zXL0d5ubO0rcxFhCdVyNCaCysriBqDB
         YUQsc8AVOQystaEJLGK5btv04dVLEe89WzQwRUjPtAnqY5b10fa2Ca9kVgCNwEtunc2K
         1sQA==
X-Received: by 10.50.141.164 with SMTP id rp4mr23148501igb.2.1431454025102;
        Tue, 12 May 2015 11:07:05 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1d41:fac7:b879:7542])
        by mx.google.com with ESMTPSA id j2sm12389668ioi.8.2015.05.12.11.07.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 May 2015 11:07:04 -0700 (PDT)
In-Reply-To: <1431384645-17276-4-git-send-email-dturner@twopensource.com>
	(dturner@twopensource.com's message of "Mon, 11 May 2015 18:50:45
	-0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268867>

dturner@twopensource.com writes:

> +--follow-symlinks::
> +	Follow symlinks inside the repository when requesting objects
> +	with extended SHA-1 expressions of the form tree-ish:path-in-tree.
> +	Instead of providing output about the link itself, provide output
> +	about the linked-to object.  This option requires --batch or
> +	--batch-check.  In the event of a symlink loop (or more than
> +	40 symlinks in a symlink resolution chain), the file will be
> +	treated as missing.  If a symlink points outside the tree-ish
> +	(e.g. a link to /foo or a root-level link to ../foo), the
> +	portion of the link which is outside the tree will be printed.
> +	Follow-symlinks will be silently turned off if <object>
> +	specifies an object in the index rather than one in the object
> +	database.
> +
> +	For example, consider the a git repository containing:
> +	f: a file containing "hello\n"
> +	link: a symlink to f
> +	dir/link: a symlink to ../f
> +	plink: a symlink to ../f
> +	alink: a symlink to /etc/passwd
> +
> +	echo HEAD:f |git cat-file --batch --follow-symlinks would print
> +	ce013625030ba8dba906f756967f9e9ca394464a blob 6
> +
> +	echo HEAD:link |git cat-file --batch --follow-symlinks would print
> +	the same thing, as would HEAD:dir/link.
> +	Without follow-symlinks, these would print data about the
> +	symlink itself.  In the case of HEAD:link, you would see
> +	4d1ae35ba2c8ec712fa2a379db44ad639ca277bd blob 1
> +
> +	Both plink and alink point outside the tree, so they would
> +	respectively print:
> +	symlink 4
> +	../f
> +
> +	symlink 11
> +	/etc/passwd
> +
> +
> +

A few points I noticed:

 * It is not clear that this is (currently) only for --batch and
   --batch-check until you read four lines into the description.

   Perhaps start the description like this instead?

   --follow-symlinks::
           When answering `--batch` or `--batch-check` request,
           follow symlinks inside the repository when requesting objects
           with extended SHA-1 expressions of the form tree-ish:path-in-tree.

   Also I'd lose the "This option requires ..." sentence in the middle
   (I'll come back to the reason why later).

 * Is it fundamental that this is only for --batch family, or is it
   just lack of need by the current implementor and implementation?
   "git cat-file --follow-symlinks blob :RelNotes" does not sound
   a nonsense request to me.

 * I am not sure if HEAD:link that points at HEAD:link should be
   reported as "missing".  It may be better to report the original
   without any dereferencing just like a link that points at outside
   the tree? i.e. "symlink 4 LF link".

 * I think "echo :RelNotes | git cat-file --batch --follow-symlinks"
   that does not follow a symlink is a BUG.  Unless there is
   something fundamental that in-index object should never support
   this feature, that is.  But I do not think of a good reason
   why---it feels that this is just the lack of implementation that
   can be addressed by somebody else in the future who finds the
   need for the support.

I do not necessarily think the latter three need to be addressed in
this 3-patch series, but they should be listed as known bugs, I
would think.  That would invite others to fix them and save time for
users to file unnecessary bug reports.

So (now I came back) the last part of the description may want to
become more like this:

	...
	portion of the link which is outside the tree will be printed.

	This option (currently) cannot be used unless `--batch` or
	`--batch-check` is used.

        Also the option does not (currently) work correctly when an
	object in the index is specified (e.g. `:link` instead of
	`HEAD:link`) rather than one in the tree.

We need to also say something about the "missing" vs "loop" case, if
we choose to leave that part broken.  I'd rather see it fixed, but
that is not a very strong preference.

By the way, the text after your patch would not format well thru
AsciiDoc.  See attached for a suggested mark-up fix that can be
squashed.

Thanks.


diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 9bdfced..3226f3e 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -82,31 +82,43 @@ OPTIONS
 	Follow-symlinks will be silently turned off if <object>
 	specifies an object in the index rather than one in the object
 	database.
-
-	For example, consider the a git repository containing:
++
+For example, consider a git repository containing:
++
+--
 	f: a file containing "hello\n"
 	link: a symlink to f
 	dir/link: a symlink to ../f
 	plink: a symlink to ../f
 	alink: a symlink to /etc/passwd
-
-	echo HEAD:f |git cat-file --batch --follow-symlinks would print
+--
++
+For a regular file `f`, `echo HEAD:f | git cat-file --batch` would print
++
+--
 	ce013625030ba8dba906f756967f9e9ca394464a blob 6
-
-	echo HEAD:link |git cat-file --batch --follow-symlinks would print
-	the same thing, as would HEAD:dir/link.
-	Without follow-symlinks, these would print data about the
-	symlink itself.  In the case of HEAD:link, you would see
+--
++
+And `echo HEAD:link | git cat-file --batch --follow-symlinks` would print
+the same thing, as would `HEAD:dir/link`, as they both point at `HEAD:f`.
++
+Without `--follow-symlinks`, these would print data about the
+symlink itself.  In the case of `HEAD:link`, you would see
++
+--
 	4d1ae35ba2c8ec712fa2a379db44ad639ca277bd blob 1
-
-	Both plink and alink point outside the tree, so they would
-	respectively print:
+--
++
+Both `plink` and `alink` point outside the tree, so they would
+respectively print:
++
+--
 	symlink 4
 	../f
 
 	symlink 11
 	/etc/passwd
-
+--
 
 
 OUTPUT
-- 
2.4.0-363-gef77c54

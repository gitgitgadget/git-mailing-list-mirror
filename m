From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git merge <tag>: Spawning an editor can't be disabled
Date: Thu, 9 Feb 2012 13:01:31 -0600
Message-ID: <20120209190131.GG6249@burratino>
References: <20120209153431.GA24033@godiug.sigxcpu.org>
 <20120209160803.GA5742@burratino>
 <7vzkcrx4f2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 09 20:01:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvZFW-000181-Gu
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 20:01:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758273Ab2BITBi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 14:01:38 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:33782 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754136Ab2BITBh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 14:01:37 -0500
Received: by yenm8 with SMTP id m8so1069286yen.19
        for <git@vger.kernel.org>; Thu, 09 Feb 2012 11:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=9VIH5eterede9MJRGJ92p5Fc3ulMq50Sev5Z0Dnz4GY=;
        b=mFwEEhz/F+Duub+T3se/DW0n0wosgaD6bq4VwhxqJpHkmrbPE9fvhtj5tDf7eoxrCp
         e8c6pMpe8c/sKxhAZVEZLqoI8RW7Ss5x+Umz0rSmGN8EvPu+L1njYWv76xP4XEgViZ35
         X8mIs75cH0S9z5Ms//5D/e7HvkUpogj5a26vo=
Received: by 10.50.57.163 with SMTP id j3mr5609253igq.3.1328814096846;
        Thu, 09 Feb 2012 11:01:36 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id f26sm6730361ibc.9.2012.02.09.11.01.35
        (version=SSLv3 cipher=OTHER);
        Thu, 09 Feb 2012 11:01:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vzkcrx4f2.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190306>

Junio C Hamano wrote:

> If the editor is not spawned, there is no way for the user to review the
> result of signature verification before deciding to accept the merge.
> "git merge --no-edit v1.7.2" could error out saying "you cannot create
> this merge without reviewing".  Or it could behave as if it was asked to
> "git merge --no-edit v1.7.2^0", dropping the signature verification and
> recording part altogether.

Others might want to read the tag message and check its signature,
even though the original committer was in a non-interactive rush.

Here's a toy patch (untested) to avoid wasting time verifying a
signature only to throw away the result.  It's not actually a no-op,
since if conflicts are encountered, the operator who intervenes won't
get to see whether the signature was valid when her editor of choice
is launched.

diff --git i/builtin.h w/builtin.h
index 857b9c8a..62dffbdc 100644
--- i/builtin.h
+++ w/builtin.h
@@ -17,6 +17,7 @@ extern void prune_packed_objects(int);
 
 struct fmt_merge_msg_opts {
 	unsigned add_title:1;
+	unsigned skip_tag_verification:1;
 	int shortlog_len;
 };
 
diff --git i/builtin/fmt-merge-msg.c w/builtin/fmt-merge-msg.c
index c81a7fef..e99030d3 100644
--- i/builtin/fmt-merge-msg.c
+++ w/builtin/fmt-merge-msg.c
@@ -316,7 +316,8 @@ static void fmt_tag_signature(struct strbuf *tagbuf,
 	strbuf_add_lines(tagbuf, "# ", sig->buf, sig->len);
 }
 
-static void fmt_merge_msg_sigs(struct strbuf *out)
+static void fmt_merge_msg_sigs(struct strbuf *out,
+			       struct fmt_merge_msg_opts *opts)
 {
 	int i, tag_number = 0, first_tag = 0;
 	struct strbuf tagbuf = STRBUF_INIT;
@@ -332,8 +333,8 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 			goto next;
 		len = parse_signature(buf, size);
 
-		if (size == len)
-			; /* merely annotated */
+		if (size == len || opts->skip_tag_verification)
+			; /* merely annotated, or caller disabled signature check */
 		else if (verify_signed_buffer(buf, len, buf + len, size - len, &sig)) {
 			if (!sig.len)
 				strbuf_addstr(&sig, "gpg verification failed.\n");
@@ -400,7 +401,7 @@ int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 		fmt_merge_msg_title(out, current_branch);
 
 	if (origins.nr)
-		fmt_merge_msg_sigs(out);
+		fmt_merge_msg_sigs(out, opts);
 
 	if (opts->shortlog_len) {
 		struct commit *head;
diff --git i/builtin/merge.c w/builtin/merge.c
index c401106e..75e027b6 100644
--- i/builtin/merge.c
+++ w/builtin/merge.c
@@ -1295,6 +1295,10 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			opts.add_title = !have_message;
 			opts.shortlog_len = shortlog_len;
 
+			assert(0 <= option_edit);
+			if (option_commit && !option_edit)
+				opts.skip_tag_verification = 1;
+
 			fmt_merge_msg(&merge_names, &merge_msg, &opts);
 			if (merge_msg.len)
 				strbuf_setlen(&merge_msg, merge_msg.len - 1);

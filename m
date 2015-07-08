From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v5 00/44] Make git-am a builtin
Date: Wed, 8 Jul 2015 16:19:02 +0800
Message-ID: <20150708081902.GA8606@yoshi.chippynet.com>
References: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
 <xmqqmvz7yuk4.fsf@gitster.dls.corp.google.com>
 <xmqqa8v7yts9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 10:20:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCkaQ-0006D6-7a
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 10:20:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935246AbbGHITi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2015 04:19:38 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:36315 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933023AbbGHITK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 04:19:10 -0400
Received: by pddu5 with SMTP id u5so54147198pdd.3
        for <git@vger.kernel.org>; Wed, 08 Jul 2015 01:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=NpwDjiNCXrLCMKFwrQCieyim4l/+4iNYY88gYY0nvE8=;
        b=OVfmSQn7Un5fU37hoHFMVvXu2dBigJ7UFS9ifvCzfJ1sAA+/kK4Od+KygyJNzOAKOa
         8VGvQiCl/uqFN82pFPeUh0r3NXjP5wGl/sj8ReUzIPG9WrShsvJFDvlWKMGqbTePUaYG
         PbG00bJE1ZVd+Dw2QN/qAZ7JFi3Sepypi6Fk1hgYfHNNjApvWI4+K1lTQGTf1H9hDba1
         6e4rE8/sOFSdtHv8DPPJFLdJXc2XQJG01Fnmy6HpgbRQlPJyVhGM36YOa0g0C8l0QJGT
         1uBQMZHRygf+hTmmF/jxE3h+24WSW4iibScROn/10tDl5Xv/AfV+vqMi0s3NBU8y3Zmb
         IPQw==
X-Received: by 10.68.224.10 with SMTP id qy10mr18185710pbc.23.1436343549174;
        Wed, 08 Jul 2015 01:19:09 -0700 (PDT)
Received: from yoshi.chippynet.com ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id ly7sm1577102pdb.17.2015.07.08.01.19.06
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2015 01:19:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqa8v7yts9.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273653>

On Wed, Jul 08, 2015 at 12:48:06AM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> $ git am -s ./+dt
> ...
> error: patch failed: builtin/update-ref.c:421
> error: builtin/update-ref.c: patch does not apply
> Patch failed at 0007 update-ref and tag: add --create-reflog arg
> The copy of the patch that failed is found in:.git/rebase-apply/patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
> $ git am -3
> git: builtin/am.c:1332: parse_mail: Assertion `!state->author_name'
> failed.
> Aborted (core dumped)

Ah, it's because parse_mail() does not expect to be called while the
authorship and commit msg fields have been filled up. This is a wrong
assumption, of course.

So the fix would be to remove the assert()s, as follows:

diff --git a/builtin/am.c b/builtin/am.c
index c548129..ab560ab 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1327,16 +1327,20 @@ static int parse_mail(struct am_state *state, const char *mail)
 	if (state->append_signoff)
 		append_signoff(&msg, 0, 0);
 
-	assert(!state->author_name);
+	if (state->author_name)
+		free(state->author_name);
 	state->author_name = strbuf_detach(&author_name, NULL);
 
-	assert(!state->author_email);
+	if (state->author_email)
+		free(state->author_email);
 	state->author_email = strbuf_detach(&author_email, NULL);
 
-	assert(!state->author_date);
+	if (state->author_date)
+		free(state->author_date);
 	state->author_date = strbuf_detach(&author_date, NULL);
 
-	assert(!state->msg);
+	if (state->msg)
+		free(state->msg);
 	state->msg = strbuf_detach(&msg, &state->msg_len);
 
 finish:
@@ -1392,7 +1396,9 @@ static void get_commit_info(struct am_state *state, struct commit *commit)
 		die(_("invalid ident line: %s"), sb.buf);
 	}
 
-	assert(!state->author_name);
+	if (state->author_name)
+		free(state->author_name);
+
 	if (ident_split.name_begin) {
 		strbuf_add(&sb, ident_split.name_begin,
 			ident_split.name_end - ident_split.name_begin);
@@ -1400,7 +1406,9 @@ static void get_commit_info(struct am_state *state, struct commit *commit)
 	} else
 		state->author_name = xstrdup("");
 
-	assert(!state->author_email);
+	if (state->author_email)
+		free(state->author_email);
+
 	if (ident_split.mail_begin) {
 		strbuf_add(&sb, ident_split.mail_begin,
 			ident_split.mail_end - ident_split.mail_begin);
@@ -1410,13 +1418,17 @@ static void get_commit_info(struct am_state *state, struct commit *commit)
 
 	author_date = show_ident_date(&ident_split, DATE_NORMAL);
 	strbuf_addstr(&sb, author_date);
-	assert(!state->author_date);
+
+	if (state->author_date)
+		free(state->author_date);
 	state->author_date = strbuf_detach(&sb, NULL);
 
-	assert(!state->msg);
 	msg = strstr(buffer, "\n\n");
 	if (!msg)
 		die(_("unable to parse commit %s"), sha1_to_hex(commit->object.sha1));
+
+	if (state->msg)
+		free(state->msg);
 	state->msg = xstrdup(msg + 2);
 	state->msg_len = strlen(state->msg);
 }

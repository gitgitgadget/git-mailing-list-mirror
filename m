From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Log messages beginning # and git rebase -i
Date: Tue, 28 Jul 2015 11:44:15 -0700
Message-ID: <xmqqtwsodsw0.fsf@gitster.dls.corp.google.com>
References: <loom.20150727T133256-715@post.gmane.org>
	<CAPig+cRT6=YCHz+phfE+84y27ey-6ScjPxP2cHiVqumJmR6mOw@mail.gmail.com>
	<loom.20150728T115023-269@post.gmane.org>
	<vpqsi88qp6q.fsf@anie.imag.fr>
	<xmqqr3nsfdmw.fsf@gitster.dls.corp.google.com>
	<vpq3808p40o.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ed Avis <eda@waniasset.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jul 28 20:44:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK9rS-000224-Sj
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 20:44:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752103AbbG1SoS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 14:44:18 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:35635 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355AbbG1SoR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 14:44:17 -0400
Received: by pdrg1 with SMTP id g1so75035012pdr.2
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 11:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=tTzWwQvC3CnMl6lANmF8tCm1oWYKAJ0WBGp2vWYa19Y=;
        b=uMewX5g+Lzq69eMAeoVIgEpXRZKqNsqClgqQ5kEDJUfnpN++amKT7zWC7c1fWbt6S5
         jKJiMdLzHYCG+yeU5MdopQqp4tEW/Ud7DfPCdfPf8CxyieOCXNM+8EfsRMuE/meguYMx
         bvARsRxbM6dhlfT3YLZcu0EiPvJ8J8xbbpy/xSkAUF7Y8xpQGBuwZiBboZMdQCsD5q2x
         Eo2EhjHYaTa0MqnHXQKv2HHYLLhZMd+F5hS2nO+2RW8HJhePthVTk9omO2panfGgWs1w
         rIWllWHNKEsacWLkZzyaXnyziHirmF6lCQ60fcPFJgJk8DAdvTUtlpmo/XFwlBK8/zAt
         78xA==
X-Received: by 10.70.23.98 with SMTP id l2mr84081111pdf.74.1438109057074;
        Tue, 28 Jul 2015 11:44:17 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e592:68fd:3f1d:35f9])
        by smtp.gmail.com with ESMTPSA id oj15sm36509295pdb.20.2015.07.28.11.44.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 Jul 2015 11:44:16 -0700 (PDT)
In-Reply-To: <vpq3808p40o.fsf@anie.imag.fr> (Matthieu Moy's message of "Tue,
	28 Jul 2015 19:48:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274812>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> A simple escaping scheme like the above can solve both points:
>
> 1) If I want to talk about #include in my commit message, I can spell it
>    \#include and Git would remove the \. The same way, if I want to tell
>    my shell about a " inside a string, I can write "double-quote:\"."
>    and get a litteral double-quote.
>
> 2) A command that pops an editor could add the escaping where needed,
>    pop the editor, and then unescape. A command like "pick" in "rebase
>    -i" could escape the message, and feed it to "git commit" which would
>    unescape it.
> ...
> backslash-escaping special characters seems very natural to me,...

OK.  So the proposal on the table is that a backslash at the
beginning of a line is stripped.

Stripping part should look like this.  To make it work for things
like "git commit --amend", you would need to prefix any line that
comes from the payload that begins with the core.commentchar or a
backslash with a backslash.

diff --git a/builtin/stripspace.c b/builtin/stripspace.c
index 1259ed7..39ecb92 100644
--- a/builtin/stripspace.c
+++ b/builtin/stripspace.c
@@ -52,6 +52,11 @@ void stripspace(struct strbuf *sb, int skip_comments)
 		}
 		newlen = cleanup(sb->buf + i, len);
 
+		if (newlen && sb->buf[i] == '\\') {
+			i++;
+			newlen--;
+		}
+
 		/* Not just an empty line? */
 		if (newlen) {
 			if (empties > 0 && j > 0)

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pretend_sha1_file(): Change return type from int to void
Date: Wed, 07 Oct 2015 14:22:59 -0700
Message-ID: <xmqqa8rutlu4.fsf@gitster.mtv.corp.google.com>
References: <1444133704-29571-1-git-send-email-tklauser@distanz.ch>
	<632cbcf1dc9fa45ce71693a2cfae73e4@dscho.org>
	<20151006135101.GA11304@distanz.ch>
	<ef5b20ed42ea20b2891fc3998a81f339@dscho.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tobias Klauser <tklauser@distanz.ch>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 07 23:23:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjwB1-0001GY-TP
	for gcvg-git-2@plane.gmane.org; Wed, 07 Oct 2015 23:23:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753697AbbJGVXD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2015 17:23:03 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35971 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753111AbbJGVXB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2015 17:23:01 -0400
Received: by pablk4 with SMTP id lk4so31995733pab.3
        for <git@vger.kernel.org>; Wed, 07 Oct 2015 14:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=/12J0DyiWqnBjAD8WNckOrDqJJC4C17ukb0YGAVO33s=;
        b=0pAUnX4J7S+DDsyE1SVAC8f+serC3RUu9g0qOqm9hWAdUT1DsKrcF1ewj3SOdDxFhL
         6cKjCzbH4r2gbKLWJem4ROo+IKqoBOFUq3iZyM21l+DLO9CN4QQFOlDMh6xJcOOwLWxh
         kLcy6uTprkm4UKxPRtMMXbuVSErjTXw4NKpvygwmG6j5wfRKZl06Lyj/T0xod3/szWlg
         gFAZkzeU1b9nOBRaVq8m2lGQuhSuqorwRy5+NQd+jzjgiIDi85Vo44YljtQGsfVuRw24
         EBaBeqmuVbPl3CPDwbfC0xACvJZr4hzGykzjr4G0x7CXXzQ5j9+9QmBe2axPzeSpDjrI
         q73Q==
X-Received: by 10.68.204.134 with SMTP id ky6mr3550012pbc.19.1444252980917;
        Wed, 07 Oct 2015 14:23:00 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:8f0:649c:42a6:426d])
        by smtp.gmail.com with ESMTPSA id z6sm41228426pbt.51.2015.10.07.14.23.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 07 Oct 2015 14:23:00 -0700 (PDT)
In-Reply-To: <ef5b20ed42ea20b2891fc3998a81f339@dscho.org> (Johannes
	Schindelin's message of "Tue, 06 Oct 2015 16:30:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279199>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> As to the patch, I cannot speak for Junio, of course, but my
> preference would be to keep the return type. Traditionally, functions
> that can fail either die() or return an int; non-zero indicates an
> error. In this case, it seems that we do not have any condition
> (yet...) under which an error could occur. It does not seem very
> unlikely that we may eventually have such conditions, though, hence my
> preference.

Perhaps the attached is a better approach.

Even though the current implementation of "pretend" implementation
does not, future generations are allowed to make pretend_sha1_file()
return failure when appropriate.

 builtin/blame.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 203a981..fa24f8f 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2362,7 +2362,8 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 	convert_to_git(path, buf.buf, buf.len, &buf, 0);
 	origin->file.ptr = buf.buf;
 	origin->file.size = buf.len;
-	pretend_sha1_file(buf.buf, buf.len, OBJ_BLOB, origin->blob_sha1);
+	if (pretend_sha1_file(buf.buf, buf.len, OBJ_BLOB, origin->blob_sha1))
+		die("failed to create a fake commit for the working tree version.");
 
 	/*
 	 * Read the current index, replace the path entry with

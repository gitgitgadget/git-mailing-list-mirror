From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 2/5] worktree: refactor find_linked_symref function
Date: Fri, 02 Oct 2015 14:16:12 -0700
Message-ID: <xmqq612p3rab.fsf@gitster.mtv.corp.google.com>
References: <1443786935-81131-1-git-send-email-rappazzo@gmail.com>
	<1443786935-81131-3-git-send-email-rappazzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: sunshine@sunshineco.com, dturner@twopensource.com,
	git@vger.kernel.org
To: Michael Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 02 23:16:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zi7gk-00016K-Ui
	for gcvg-git-2@plane.gmane.org; Fri, 02 Oct 2015 23:16:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbbJBVQP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2015 17:16:15 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33474 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991AbbJBVQO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2015 17:16:14 -0400
Received: by pacex6 with SMTP id ex6so116487997pac.0
        for <git@vger.kernel.org>; Fri, 02 Oct 2015 14:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-type;
        bh=UB1tNnUhUqQHJYWPsLVXL3i4MBKfgDoZmBLdCpaa790=;
        b=kayHqIDon1rIMB9TBPn4JDBRnlmJLXz+jmL0cnAXz6zZYZFcLBb9twTqhQfZPCuaLD
         rw41ODd6lQnjl/c3Q/9MqBw6Xc6bQZVAdvaCbhUCo6z9sucWJkO//1LfKjVEHp4Oqo/P
         O1SzcdVxVUSZZ7dGn7jibKFjjJN4IofNXJskDFTMKiIynPSuNTFaOad+uBJFzhzxyzyM
         IdvXHrqaFY9SZuEO47AiahHQQm5x7WhqtYx+TbEKX5AOOu1w9X86n4ykAkqxy8vPkV++
         erMkwdx8YnGPJ+UnGXZPXhLOxaBM6pU2PuF1zWLT9sJEaeXsLA1RH9qZGuPn3g/QybCW
         BDlg==
X-Received: by 10.68.179.33 with SMTP id dd1mr22793283pbc.134.1443820574160;
        Fri, 02 Oct 2015 14:16:14 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:5831:5c0e:ce5f:86ea])
        by smtp.gmail.com with ESMTPSA id ql5sm13679790pac.46.2015.10.02.14.16.13
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 02 Oct 2015 14:16:13 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278950>

Michael Rappazzo <rappazzo@gmail.com> writes:

> +static int parse_ref(char *path_to_ref, struct strbuf *ref, int *is_detached)
> +{
> +	if (is_detached)
> +		*is_detached = 0;
> +	if (!strbuf_readlink(ref, path_to_ref, 0))
> +		if (!starts_with(ref->buf, "refs/") ||
> +				check_refname_format(ref->buf, 0))
> +			return -1;
> +	else if (strbuf_read_file(ref, path_to_ref, 0) >= 0) {

Which "if" does this "else if" pair with?  I think you would want to
clarify not with indentation but with a brace here.

	if (!strbuf_readlink(...)) {
		/* HEAD is a symlink */
                if (!starts_with(...) || check_refname_format(...))
			return -1; /* malformed */
	} else if (strbuf_read_file(...) >= 0) {
        	/* textual symref */
                ...

Alternatively, you could do it this way.

	if (!strbuf_readlink(...) &&
	    (!starts_with(...) || check_refname_format(...)))
		return -1;
	else if (strbuf_read_file(...) >= 0) {
		...

I do not know which one is more readable, though.  Probably former,
even though it is a bit more verbose, is easier to follow.

> +		if (!starts_with(ref->buf, "ref:"))
> +			if (is_detached)
> +				*is_detached = 1;
> +		else {

Same here.


 worktree.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/worktree.c b/worktree.c
index c049947..f16c082 100644
--- a/worktree.c
+++ b/worktree.c
@@ -17,22 +17,25 @@ static int parse_ref(char *path_to_ref, struct strbuf *ref, int *is_detached)
 {
 	if (is_detached)
 		*is_detached = 0;
-	if (!strbuf_readlink(ref, path_to_ref, 0))
+	if (!strbuf_readlink(ref, path_to_ref, 0)) {
+		/* HEAD is symbolic link */
 		if (!starts_with(ref->buf, "refs/") ||
 				check_refname_format(ref->buf, 0))
 			return -1;
-	else if (strbuf_read_file(ref, path_to_ref, 0) >= 0) {
-		if (!starts_with(ref->buf, "ref:"))
+	} else if (strbuf_read_file(ref, path_to_ref, 0) >= 0) {
+		/* textual symref or detached */
+		if (!starts_with(ref->buf, "ref:")) {
 			if (is_detached)
 				*is_detached = 1;
-		else {
+		} else {
 			strbuf_remove(ref, 0, strlen("ref:"));
 			strbuf_trim(ref);
 			if (check_refname_format(ref->buf, 0))
 				return -1;
 		}
-	} else
+	} else {
 		return -1;
+	}
 	return 0;
 }
 

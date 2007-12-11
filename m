From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git annotate runs out of memory
Date: Tue, 11 Dec 2007 13:54:19 -0800
Message-ID: <7vprxcdhis.fsf@gitster.siamese.dyndns.org>
References: <4aca3dc20712110933i636342fbifb15171d3e3cafb3@mail.gmail.com>
	<alpine.LFD.0.9999.0712111018540.25032@woody.linux-foundation.org>
	<4aca3dc20712111109y5d74a292rf29be6308932393c@mail.gmail.com>
	<alpine.LFD.0.9999.0712111122400.25032@woody.linux-foundation.org>
	<alpine.LFD.0.9999.0712111300440.25032@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Berlin <dberlin@dberlin.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 22:55:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2D41-0001Ai-Qw
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 22:54:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752366AbXLKVyd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 16:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752325AbXLKVyd
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 16:54:33 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61278 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752254AbXLKVyc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 16:54:32 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 62C6E3932;
	Tue, 11 Dec 2007 16:54:25 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 887073930;
	Tue, 11 Dec 2007 16:54:21 -0500 (EST)
In-Reply-To: <alpine.LFD.0.9999.0712111300440.25032@woody.linux-foundation.org>
	(Linus Torvalds's message of "Tue, 11 Dec 2007 13:14:18 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67953>

Linus Torvalds <torvalds@linux-foundation.org> writes:

>  builtin-blame.c |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
>
> diff --git a/builtin-blame.c b/builtin-blame.c
> index c158d31..18f9924 100644
> --- a/builtin-blame.c
> +++ b/builtin-blame.c
> @@ -87,6 +87,14 @@ struct origin {
>  	char path[FLEX_ARRAY];
>  };
>  
>  /*
>   * Given an origin, prepare mmfile_t structure to be used by the
>   * diff machinery
> @@ -558,6 +566,8 @@ static struct patch *get_patch(struct origin *parent, struct origin *origin)
>  	if (!file_p.ptr || !file_o.ptr)
>  		return NULL;
>  	patch = compare_buffer(&file_p, &file_o, 0);
> +	drop_origin_blob(parent);
> +	drop_origin_blob(origin);
>  	num_get_patch++;
>  	return patch;
>  }

While this should be safe (because the user of blob lazily re-fetches),
it feels a bit too aggressive, especially when -C or other "retry and
try harder to assign blame elsewhere" option is used.

Instead, how about discarding after we are done with each origin, like
this?

---
 builtin-blame.c |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index c158d31..eda79d0 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -130,6 +130,14 @@ static void origin_decref(struct origin *o)
 	}
 }
 
+static void drop_origin_blob(struct origin *o)
+{
+	if (o->file.ptr) {
+		free(o->file.ptr);
+		o->file.ptr = NULL;
+	}
+}
+
 /*
  * Each group of lines is described by a blame_entry; it can be split
  * as we pass blame to the parents.  They form a linked list in the
@@ -1274,8 +1282,13 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
 		}
 
  finish:
-	for (i = 0; i < MAXPARENT; i++)
-		origin_decref(parent_origin[i]);
+	for (i = 0; i < MAXPARENT; i++) {
+		if (parent_origin[i]) {
+			drop_origin_blob(parent_origin[i]);
+			origin_decref(parent_origin[i]);
+		}
+	}
+	drop_origin_blob(origin);
 }
 
 /*

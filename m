From: Junio C Hamano <junkio@cox.net>
Subject: Re: index manipulation -- how?
Date: Mon, 21 Nov 2005 21:36:12 -0800
Message-ID: <7v3blpi6r7.fsf@assigned-by-dhcp.cox.net>
References: <20051122050337.46450.qmail@web31808.mail.mud.yahoo.com>
	<7v8xvhi7bi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 22 06:43:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeQpG-0006ui-Bd
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 06:36:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbVKVFgO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 00:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbVKVFgO
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 00:36:14 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:61591 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932328AbVKVFgN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2005 00:36:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051122053508.UIRN26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 22 Nov 2005 00:35:08 -0500
To: Luben Tuikov <ltuikov@yahoo.com>
In-Reply-To: <7v8xvhi7bi.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 21 Nov 2005 21:24:01 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12528>

Junio C Hamano <junkio@cox.net> writes:

> Luben Tuikov <ltuikov@yahoo.com> writes:
>
>> How do I reverse a _single_ "git-update-index" operation?
>> Be it --add or just an update.
>
> Reverting working tree files are "git checkout HEAD the-file"
> (both index and working tree file from the head commit) or "git
> checkout -- the-file" (working tree file from the index), but I
> do not think there is a prepackaged way to revert only a single
> index path offhand.
>
>         git-ls-tree HEAD the-file |
>         sed -e 's/^\([0-7]*\) [^ ]* \(.*\)/\1 \2/' |
>         git-update-index --index-info
>
> should work.
>
> I think changing update-index --index-info so that you can lose
> the sed in between without breaking its other usage (it reads
> from git-apply --index-info, which does not say " blob " which
> is what the sed is stripping out) is a worthwhile thing to do.

And here is the patch to let you say:

	git-ls-tree HEAD the-file | git-update-index --index-info


---

diff --git a/update-index.c b/update-index.c
index 5bbc3de..11b7f6a 100644
--- a/update-index.c
+++ b/update-index.c
@@ -338,7 +338,7 @@ static void read_index_info(int line_ter
 	struct strbuf buf;
 	strbuf_init(&buf);
 	while (1) {
-		char *ptr;
+		char *ptr, *tab;
 		char *path_name;
 		unsigned char sha1[20];
 		unsigned int mode;
@@ -348,12 +348,15 @@ static void read_index_info(int line_ter
 			break;
 
 		mode = strtoul(buf.buf, &ptr, 8);
-		if (ptr == buf.buf || *ptr != ' ' ||
-		    get_sha1_hex(ptr + 1, sha1) ||
-		    ptr[41] != '\t')
+		if (ptr == buf.buf || *ptr != ' ')
 			goto bad_line;
 
-		ptr += 42;
+		tab = strchr(ptr, '\t');
+		if (!tab || tab - ptr < 41)
+			goto bad_line;
+		if (get_sha1_hex(tab - 40, sha1) || tab[-41] != ' ')
+			goto bad_line;
+		ptr = tab + 1;
 
 		if (line_termination && ptr[0] == '"')
 			path_name = unquote_c_style(ptr, NULL);

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] parse_commit_buffer: don't parse invalid commits
Date: Sun, 06 Jan 2008 14:00:57 -0800
Message-ID: <7vbq7y4ns6.fsf@gitster.siamese.dyndns.org>
References: <11996461912682-git-send-email-mkoegler@auto.tuwien.ac.at>
	<11996461913672-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Sun Jan 06 23:01:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBdYq-0005Fs-AN
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 23:01:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753990AbYAFWBJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2008 17:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753642AbYAFWBH
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jan 2008 17:01:07 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34212 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753350AbYAFWBG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2008 17:01:06 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id DD0467E16;
	Sun,  6 Jan 2008 17:01:02 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id F0F357E13;
	Sun,  6 Jan 2008 17:00:58 -0500 (EST)
In-Reply-To: <11996461913672-git-send-email-mkoegler@auto.tuwien.ac.at>
	(Martin Koegler's message of "Sun, 6 Jan 2008 20:03:11 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69748>

Martin Koegler <mkoegler@auto.tuwien.ac.at> writes:

> Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
> ---
>  commit.c |   28 +++++++++++++++++++++-------
>  1 files changed, 21 insertions(+), 7 deletions(-)
>
> diff --git a/commit.c b/commit.c
> index f074811..ffa0894 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -48,19 +48,33 @@ struct commit *lookup_commit(const unsigned char *sha1)
>  	return check_commit(obj, sha1, 0);
>  }
>  
> -static unsigned long parse_commit_date(const char *buf)
> +static unsigned long parse_commit_date(const char *buf, const char* tail)

Should be "const char *tail" in our codebase.

>  {
>  	unsigned long date;
> +	char datebuf[20];
> +	unsigned long len;
>  
> +	if (buf + 6 >= tail)
> +		return 0;
>  	if (memcmp(buf, "author", 6))
>  		return 0;

Even though buf, which is a result from read_sha1_file(), is
always terminated with an extra NUL (outside its object size),
if a bogus commit object ends with "author" (and without the
author information) this part will pass, and ...

> -	while (*buf++ != '\n')
> +	while (buf < tail && *buf++ != '\n')
>  		/* nada */;
> +	if (buf + 9 >= tail)
> +		return 0;

... you catch that here.  That seems like a good change.

>  	if (memcmp(buf, "committer", 9))
>  		return 0;
> -	while (*buf++ != '>')
> +	while (buf < tail && *buf++ != '>')
>  		/* nada */;
> -	date = strtoul(buf, NULL, 10);
> +	if (buf >= tail)
> +		return 0;

Likewise here.

> +	len = tail - buf;
> +	if (len > sizeof(datebuf) - 1)
> +	  len = sizeof(datebuf) - 1;

Broken indentation.

> +	memcpy(datebuf, buf, len);
> +	datebuf[len] = 0;
> +	date = strtoul(datebuf, NULL, 10);

However, as long as buf at this point hasn't go beyond tail,
which you already checked, I think we can rely on strtoul()
stopping at the NUL at the end of buffer (that is one beyond
tail), without this extra memcpy().  Am I mistaken?

> @@ -236,9 +250,9 @@ int parse_commit_buffer(struct commit *item, void *buffer, unsigned long size)
>  		return 0;
>  	item->object.parsed = 1;
>  	tail += size;
> -	if (tail <= bufptr + 5 || memcmp(bufptr, "tree ", 5))
> +	if (tail <= bufptr + 46 || memcmp(bufptr, "tree ", 5) || bufptr[45] != '\n')
>  		return error("bogus commit object %s", sha1_to_hex(item->object.sha1));
> -	if (tail <= bufptr + 45 || get_sha1_hex(bufptr + 5, parent) < 0)
> +	if (get_sha1_hex(bufptr + 5, parent) < 0)
>  		return error("bad tree pointer in commit %s",
>  			     sha1_to_hex(item->object.sha1));
>  	item->tree = lookup_tree(parent);

This hunk is logically a no-op but I like your version better.
It also makes sure tree object name is terminated with a LF.

> @@ -275,7 +289,7 @@ int parse_commit_buffer(struct commit *item, void *buffer, unsigned long size)
>  			n_refs++;
>  		}
>  	}
> -	item->date = parse_commit_date(bufptr);
> +	item->date = parse_commit_date(bufptr, tail);
>  
>  	if (track_object_refs) {
>  		unsigned i = 0;
> -- 
> 1.4.4.4

When already somewhat deep in the rc cycle, looking at a patch
from somebody who uses 1.4.4.4 makes me look at the patch a bit
more carefully than usual ;-)

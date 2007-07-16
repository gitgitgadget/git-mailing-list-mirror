From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] Introduce commit notes
Date: Sun, 15 Jul 2007 22:11:26 -0700
Message-ID: <7vejj96igx.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707152326080.14781@racer.site>
	<Pine.LNX.4.64.0707160022560.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alberto Bertogli <albertito@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, Johan Herland <johan@herland.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 16 07:11:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAIrs-0007bL-AZ
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 07:11:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbXGPFL3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 01:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbXGPFL3
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 01:11:29 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:33793 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182AbXGPFL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 01:11:28 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070716051129.YTMJ1349.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Mon, 16 Jul 2007 01:11:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Q5BS1X00Q1kojtg0000000; Mon, 16 Jul 2007 01:11:28 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52637>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> +core.notesRef::
> +	When showing commit messages, also show notes which are stored in
> +	the given ref.  This ref is expected to contain paths of the form
> +	??/*, where the directory name consists of the first two
> +	characters of the commit name, and the base name consists of
> +	the remaining 38 characters.
> ++
> +If such a path exists in the given ref, the referenced blob is read, and
> +appended to the commit message, separated by a "Notes:" line.  If the
> +given ref itself does not exist, it is not an error, but means that no
> +notes should be print.
> ++
> +This setting defaults to "refs/notes/commits", and can be overridden by
> +the `GIT_NOTES_REF` environment variable.
> +

This design forces "one blob and only one blob decorates a
commit".  It certainly makes the implementation and semantics
simpler -- if I have this note and you have that note on the
same commit, comparing notes eventually should result in a merge
of our notes.  But is it sufficient in real life usage scenarios
(what's the use case)?  One example that was raised on the list
is to collect "Acked-by", "Tested-by", etc., and in that case
perhaps one set "refs/notes/acks" may hold the former while
"refs/notes/tests" the latter.  If we wanted to show both at the
same time, is it the only option to put them in the same "note"
blob and not use "refs/notes/{acks,tests}"?

> diff --git a/commit.c b/commit.c
> index 0c350bc..3529b6a 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -6,6 +6,7 @@
>  #include "interpolate.h"
>  #include "diff.h"
>  #include "revision.h"
> +#include "notes.h"
>  
>  int save_commit_buffer = 1;
>  
> @@ -1254,6 +1255,10 @@ unsigned long pretty_print_commit(enum cmit_fmt fmt,
>  	 */
>  	if (fmt == CMIT_FMT_EMAIL && offset <= beginning_of_body)
>  		buf[offset++] = '\n';
> +
> +	if (fmt != CMIT_FMT_ONELINE)
> +		get_commit_notes(commit, buf_p, &offset, space_p);
> +
>  	buf[offset] = '\0';
>  	free(reencoded);
>  	return offset;

This makes me wonder if there are cases where "notes" need to be
reencoded to honor log_output_encoding.

Since more and more people live in UTF-8 only world, and this is
a _new_ feature anyway, we could declare that "notes" blobs MUST
be encoded in UTF-8 upfront, but even if we did so we would need
reencoding to log_output_encoding, I suspect.

> diff --git a/notes.c b/notes.c
> new file mode 100644
> index 0000000..5d1bb1a
> --- /dev/null
> +++ b/notes.c
> @@ -0,0 +1,64 @@
> +#include "cache.h"
> +#include "commit.h"
> +#include "notes.h"
> +#include "refs.h"
> +
> +static int initialized;
> +
> +void get_commit_notes(const struct commit *commit,
> +		char **buf_p, unsigned long *offset_p, unsigned long *space_p)
> +{
> +	char name[80];
> +	const char *hex;
> +	unsigned char sha1[20];
> +	char *msg;
> +	unsigned long msgoffset, msglen;
> +	enum object_type type;
> +
> +	if (!initialized) {
> +		const char *env = getenv(GIT_NOTES_REF);
> +		if (env) {
> +			if (notes_ref_name)
> +				free(notes_ref_name);
> +			notes_ref_name = xstrdup(getenv(GIT_NOTES_REF));

	xstrdup(env)?

> +		} else if (!notes_ref_name)
> +			notes_ref_name = xstrdup("refs/notes/commits");

We would probably want to give another preprocessor constant for
this hardcoded string, next to GIT_NOTES_REF definition in cache.h.

> +		if (notes_ref_name && read_ref(notes_ref_name, sha1)) {
> +			free(notes_ref_name);
> +			notes_ref_name = NULL;
> +		}
> +		initialized = 1;
> +	}
> +	if (!notes_ref_name)
> +		return;
> +
> +	hex = sha1_to_hex(commit->object.sha1);
> +	snprintf(name, sizeof(name), "%s:%.*s/%.*s",
> +			notes_ref_name, 2, hex, 38, hex + 2);

Too long a notes_ref_name and it won't overrun the buffer but
the failure is not detected, and ...

> +	if (get_sha1(name, sha1))
> +		return;

... this would fail silently, leaving the user scratching his head.

> +
> +	if (!(msg = read_sha1_file(sha1, &type, &msglen)) || !msglen)
> +		return;

What's in "type" at this point?  Having a tree there is not an
error?

> +	/* we will end the annotation by a newline anyway. */
> +	if (msg[msglen - 1] == '\n')
> +		msglen--;
> +	ALLOC_GROW(*buf_p, *offset_p + 14 + msglen, *space_p);
> +	*offset_p += sprintf(*buf_p + *offset_p, "\nNotes:\n");

Fourteen is because...

> +
> +	for (msgoffset = 0; msgoffset < msglen;) {
> +		int linelen = get_line_length(msg + msgoffset, msglen);
> +
> +		ALLOC_GROW(*buf_p, *offset_p + linelen + 6, *space_p);
> +		*offset_p += sprintf(*buf_p + *offset_p,
> +				"    %.*s", linelen, msg + msgoffset);

Six is because...

> +		msgoffset += linelen;
> +	}
> +	ALLOC_GROW(*buf_p, *offset_p + 1, *space_p);
> +	(*buf_p)[*offset_p] = '\n';
> +	(*offset_p)++;
> +	free(msg);
> +}
> +
> +
> diff --git a/notes.h b/notes.h
> new file mode 100644
> index 0000000..aed80e7
> --- /dev/null
> +++ b/notes.h
> @@ -0,0 +1,9 @@
> +#ifndef NOTES_H
> +#define NOTES_H
> +
> +void get_commit_notes(const struct commit *commit,
> +	char **buf_p, unsigned long *offset_p, unsigned long *space_p);
> +
> +#define GIT_NOTES_REF "GIT_NOTES_REF"

Judging from the existing entries in cache.h, it seems that
GIT_NOTES_REF_ENVIRONMENT would be more appropriate preprocessor
symbol for this.  Also let's have this in cache.h next to
GIT_DIR_ENVIRONMENT and friends, with another definition for
"refs/notes/commits".

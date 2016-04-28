From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 03/19] index-helper: new daemon for caching index and related stuff
Date: Thu, 28 Apr 2016 11:58:37 -0700
Message-ID: <xmqq60v15zmq.fsf@gitster.mtv.corp.google.com>
References: <1461787481-877-1-git-send-email-dturner@twopensource.com>
	<1461787481-877-4-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, pclouds@gmail.com,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 20:58:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avr9B-0002vK-UH
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 20:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651AbcD1S6m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Apr 2016 14:58:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61366 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752632AbcD1S6l convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2016 14:58:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9DB6A15C08;
	Thu, 28 Apr 2016 14:58:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=FJRRTNpt1ZRC
	mmAompmhJcIxH2M=; b=WS0qaadR49a8WYnW4dgmtGTrvb6LxfIGhHX3fx+G5Z/M
	6vtQzCbEJsH8c31QA+8LvmNAMLtep5tIpBAJz6PErBQQD8q6GWk/2rqjVHlxS/55
	nn3MjqJn2pYovILbYueHJkU8pzkkDXXKnUAWOPT1ofVYbh9ZfQduHTDOqVoI3cI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=fSkOfd
	fV/KZeBY6C3Sa5SW1RgO4uia92X22BXvDE1whSmpe4RliUM5AbIVenNLONE00oWC
	1AsW1k+GAeQZHMtk+4uWpWoO8lIsjmJu0NhNkq0aNsH15iKaFPj/TYJR4I2iK3oD
	VqKOJD9ZHecxXJPsCI5p3/kGdId+TL33c29kg=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 94A3F15C07;
	Thu, 28 Apr 2016 14:58:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DE0E415C06;
	Thu, 28 Apr 2016 14:58:38 -0400 (EDT)
In-Reply-To: <1461787481-877-4-git-send-email-dturner@twopensource.com> (David
	Turner's message of "Wed, 27 Apr 2016 16:04:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 37C272D0-0D73-11E6-9045-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292934>

David Turner <dturner@twopensource.com> writes:

> From: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
> ...
> The biggest gain is not having to verify the trailing SHA-1, which
> takes lots of time especially on large index files. But this also
> opens doors for further optimiztions:

optimizAtion

> Git can poke the daemon via unix domain sockets to tell it to refresh
> the index cache, or to keep it alive some more minutes. It can't give
> any real index data directly to the daemon. Real data goes to disk
> first, then the daemon reads and verifies it from there. Poking only
> happens for $GIT_DIR/index, not temporary index files.

Is this limited to "poking", or the helper daemon is not involved in
codepaths that handle temporary index at all?  It makes sense if it
is the latter, and it doesn't if it were the former, but it is
unclear in this paragraph.

> $GIT_DIR/index-helper.sock is the socket for the daemon process. The
> daemon reads from the socket and executes commands.
>
> Named pipes were considered for portability reasons, but then command=
s
> that need replies from the daemon would have open their own pipes,

"would have TO open"?

> since a named pipe should only have one reader.  Unix domain sockets
> don't have this problem.

> diff --git a/Documentation/git-index-helper.txt b/Documentation/git-i=
ndex-helper.txt
> new file mode 100644
> index 0000000..77687c0
> --- /dev/null
> +++ b/Documentation/git-index-helper.txt
> @@ -0,0 +1,47 @@
> +git-index-helper(1)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +NAME
> +----
> +git-index-helper - A simple cache daemon for speeding up index file =
access
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'git index-helper' [options]
> +
> +DESCRIPTION
> +-----------
> +Keep the index file in memory for faster access. This daemon is per
> +repository.

Not an objection but a question.  Does this mean "per index file"?

What the users would need to be aware of is that it is not like
running a single daemon instance helps the toplevel project with its
entire 600 submodules checked out you have--you would need that many
instances of the helper, which is already conveyed well with "per
repository".  But I was wondering if it helps users experimenting
with the multiple worktree feature if we said "per index file".  It
would make it more clear that you would run two instances of the
helper daemon when you use another worktree in addition to your
primary repository.

> +... The following commands are used to control the daemon:
> +
> +"refresh"::
> +	Reread the index.
> +
> +"poke":
> +	Let the daemon know the index is to be read. It keeps the
> +	daemon alive longer, unless `--exit-after=3D0` is used.
> +
> +All commands and replies are terminated by a 0 byte.

s/0/NUL/

> diff --git a/cache.h b/cache.h
> index 4180e2b..43fb314 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -334,6 +334,8 @@ struct index_state {
>  	struct cache_time timestamp;
>  	unsigned name_hash_initialized : 1,
>  		 keep_mmap : 1,
> +		 from_shm : 1,
> +		 to_shm : 1,

keep_mmap bit had its own commit, which made it more-or-less
unnecessary to have a separate explanation, but it is unclear how
these two bits are envisioned to be used...

> diff --git a/index-helper.c b/index-helper.c
> new file mode 100644
> index 0000000..976e913
> --- /dev/null
> +++ b/index-helper.c
> @@ -0,0 +1,285 @@
> +#include "cache.h"
> +#include "parse-options.h"
> +#include "sigchain.h"
> +#include "strbuf.h"
> +#include "exec_cmd.h"
> +#include "split-index.h"
> +#include "lockfile.h"
> +#include "cache.h"
> +#include "unix-socket.h"
> +#include "pkt-line.h"
> +
> +struct shm {
> +	unsigned char sha1[20];
> +	void *shm;
> +	size_t size;
> +};
> +
> +static struct shm shm_index;
> +static struct shm shm_base_index;
> +
> +static void release_index_shm(struct shm *is)
> +{
> +	if (!is->shm)
> +		return;
> +	munmap(is->shm, is->size);
> +	unlink(git_path("shm-index-%s", sha1_to_hex(is->sha1)));
> +	is->shm =3D NULL;
> +}
> +
> +static void cleanup_shm(void)
> +{
> +	release_index_shm(&shm_index);
> +	release_index_shm(&shm_base_index);
> +}
> +
> +static void cleanup(void)
> +{
> +	unlink(git_path("index-helper.sock"));
> +	cleanup_shm();
> +}
> +
> +static void cleanup_on_signal(int sig)
> +{
> +	/* We ignore sigpipes -- that's just a client being broken. */

Is it really "a broken" client, in which case we would want to know
about the breakage so that we can fix it?  Or is it a case of "a
client wasn't interested in what we had to say, which is perfectly
fine"?

> +	if (sig =3D=3D SIGPIPE)
> +		return;
> +	cleanup();
> +	sigchain_pop(sig);
> +	raise(sig);
> +}
> +
> +static int shared_mmap_create(int file_flags, int file_mode, size_t =
size,
> +			      void **new_mmap, int mmap_prot, int mmap_flags,
> +			      const char *path)
> +{

I can understand size, new_mmap and path, but do all others need the
customizability?  It is hard to tell at this point in the series as
there is only one caller, which gives a reasonable set of values to
these parameters.  And each of all these "reasonable values" is the
only reasonable value for each of these parameters-- you would ever
want to have mmap_prot without PROT_WRIT as this is creating an
empty region that is mapped to a newly created file, for example.
It is inconceivable that a function named "shared_mmap_create" ever
passes mmap_flags that lack MAP_SHARED, for another example, or
file_flags that is not O_CREAT|O_EXCL|O_RDWR for that matter.

> + ...
> +	if (ftruncate(fd, size))
> +		goto done;
> +	*new_mmap =3D mmap(NULL, size, mmap_prot, mmap_flags, fd, 0);
> ...
> +static void share_index(struct index_state *istate, struct shm *is)
> +{
> +	void *new_mmap;
> +	if (istate->mmap_size <=3D 20 ||
> +	    hashcmp(istate->sha1,
> +		    (unsigned char *)istate->mmap + istate->mmap_size - 20) ||
> +	    !hashcmp(istate->sha1, is->sha1) ||
> +	    shared_mmap_create(O_CREAT | O_EXCL | O_RDWR, 0700,
> +			       istate->mmap_size, &new_mmap,
> +			       PROT_READ | PROT_WRITE, MAP_SHARED,
> +			       git_path("shm-index-%s",
> +					sha1_to_hex(istate->sha1))) < 0)
> +		return;
> +	release_index_shm(is);
> +	is->size =3D istate->mmap_size;
> +	is->shm =3D new_mmap;
> +	hashcpy(is->sha1, istate->sha1);

So "is" is expected to be a valid instance of shm that was obtained
previously.  When we fail to map and return, does it make sense to
retain it?  Because this function does not return any value, the
caller wouldn't be able to tell that shared-mmap-create failed, and
will keep using that stale instance of "is"--I cannot tell if that
is OK in the caller of this thing or not from what I read so far in
this series...

> +static void refresh(void)
> +{
> +	discard_index(&the_index);
> +	the_index.keep_mmap =3D 1;
> +	the_index.to_shm    =3D 1;

Again, mysterious to_shm appears here...

> +		/* Wait for a request */
> +		FD_ZERO(&readfds);
> +		FD_SET(fd, &readfds);
> +		result =3D select(fd + 1, &readfds, NULL, NULL, timeout_p);

I admit that I am old fashioned and am more familiar with select(2)
than poll(2), but I think we try to avoid select(2) in new code.

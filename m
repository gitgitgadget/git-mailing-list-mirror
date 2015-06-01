From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] add_to_alternates_file: don't add duplicate paths
Date: Mon, 1 Jun 2015 06:51:42 -0400
Message-ID: <20150601105142.GC31792@peff.net>
References: <1433096123-14420-1-git-send-email-gjthill@gmail.com>
 <1433096123-14420-2-git-send-email-gjthill@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jim Hill <gjthill@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 12:51:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzNJu-0004H1-Ke
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 12:51:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbbFAKvq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 06:51:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:38713 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751154AbbFAKvp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 06:51:45 -0400
Received: (qmail 29768 invoked by uid 102); 1 Jun 2015 10:51:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Jun 2015 05:51:45 -0500
Received: (qmail 28328 invoked by uid 107); 1 Jun 2015 10:51:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Jun 2015 06:51:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Jun 2015 06:51:42 -0400
Content-Disposition: inline
In-Reply-To: <1433096123-14420-2-git-send-email-gjthill@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270397>

On Sun, May 31, 2015 at 11:15:22AM -0700, Jim Hill wrote:

> Check for an existing match before appending a path to the alternates
> file.  Beyond making git look smart to anyone checking the alternates
> file, this removes the last use of hold_lock_file_for_append.

Makes sense. We don't catch _all_ cases here (e.g., we do not bother to
see if "foo" is a symlink to "bar"), but we at least catch the obvious
ones.

>  void add_to_alternates_file(const char *reference)
>  {
> -	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
> [...]
> +	static struct lock_file lock = {0};

This seems like an unrelated change. I don't mind it in general, but it
should probably go in a separate patch.

> -	int fd = hold_lock_file_for_append(lock, git_path("objects/info/alternates"), LOCK_DIE_ON_ERROR);
>  	char *alt = mkpath("%s\n", reference);
> +	char *alts = git_path("objects/info/alternates");

A minor nit, but I found "alts" and "alt" to be a little bit similar
while reading. I wonder if "our_alts" or "alts_files" would be a little
more clear.

> +	struct strbuf altdata = STRBUF_INIT;
> +	struct string_list lines = STRING_LIST_INIT_NODUP;
> +
> +	if (strbuf_read_file(&altdata, alts, 0) < 0)
> +		if (errno != ENOENT)
> +			die("alternates file unreadable");

Hmm, so we read the whole content in, then split it into a string list
of lines.  Might it be simpler to just read it line by line and compare
as we go? Like (totally untested);

  FILE *in, *out;
  ...

  out = fdopen_lock_file(&lock, "w");
  if (!out)
	die_errno("unable to fdopen alternates lockfile");

  in = fopen(alts, "r");
  if (in) {
	struct strbuf line = STRBUF_INIT;
	int found = 0;

	while (strbuf_getline(&line, in, '\n') != EOF) {
		if (!strcmp(reference, line.buf)) {
			found = 1;
			break;
		}
		fprintf_or_die(out, "%s\n", line.buf);
	}

	strbuf_release(&line);
	fclose(in);

	if (found) {
		rollback_lock_file(&lock);
		return;
	}

  }
  else if (errno != ENOENT)
	  die_errno("unable to read alternates file");

  fprintf_or_die(out, "%s\n", reference);
  /* commit_lock_file, etc; it takes care of the fclose() */


Note that I also fdopen'd the output file, which makes the newline
handling a little easier (I think you can even drop the "alt" variable).
That's optional, and you could use strbuf_getwholeline to retain the
original newlines. But...

> +	strbuf_complete_line(&altdata);

This seems like a nice bugfix that you didn't mention. With the earlier
code, if your alternates file was missing a trailing newline, we would
produce a bogus output. So it makes sense to do (either this way, or the
way I showed above). I think it probably goes in the same commit (it's
part of the refactoring), but you may want to mention it in the commit
message.

> +cleanup:
> +	strbuf_reset(&altdata);

I think you want strbuf_release() here (though it goes away if you
follow my suggestion above).

> diff --git a/t/t5700-clone-reference.sh b/t/t5700-clone-reference.sh
> index 3e783fc..cd9fa34 100755
> --- a/t/t5700-clone-reference.sh
> +++ b/t/t5700-clone-reference.sh
> @@ -29,11 +29,11 @@ git prune'
>  cd "$base_dir"
>  
>  test_expect_success 'cloning with reference (-l -s)' \
> -'git clone -l -s --reference B A C'
> +'git clone -l -s --reference B --reference A --reference B A C'
>  
>  cd "$base_dir"
>  
> -test_expect_success 'existence of info/alternates' \
> +test_expect_success 'existence of info/alternates, no duplicates' \
>  'test_line_count = 2 C/.git/objects/info/alternates'

Generally we prefer a new separate test rather than trying to take over
an existing one (i.e., just add a new one with the clone and line-count
test together).

-Peff

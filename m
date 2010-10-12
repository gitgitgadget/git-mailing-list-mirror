From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 7/7] svn-fe: Use the --report-fd feature
Date: Tue, 12 Oct 2010 18:59:13 -0500
Message-ID: <20101012235913.GJ15587@burratino>
References: <1286891424-2067-1-git-send-email-david.barr@cordelta.com>
 <1286891424-2067-8-git-send-email-david.barr@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 02:03:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5ooG-0006rO-BP
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 02:03:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904Ab0JMACf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 20:02:35 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:63725 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660Ab0JMACe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Oct 2010 20:02:34 -0400
Received: by qyk5 with SMTP id 5so1405088qyk.19
        for <git@vger.kernel.org>; Tue, 12 Oct 2010 17:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=X4Z7YjhbjpYj3zHXhDoyCBIGfLkYQkdxyHi9YQGltOo=;
        b=Qyd0Vzt4avKV5kvMmW/+Q11qgPskF5mI5obKL4jTQHsVMLaErX4R+f+jCgHFsAQpsA
         MRg31HaAOdl9xA/SEJkatIBxMujO1bOz7IVd4yBLlq48aZ2L94HOGPbmDRBxHd8DJrhD
         Lxa3Eprrr23Q1uCgg596E1TPudXqNMC6KYxdY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Bo8FfhaEbk0bYrPegEmkfSNBDXgEIK1khNWtNQIK1jMpNniV62Mj1n4NWiUydoyK4z
         h7Va+kwVd3OwogKtPkhgjcWRtbGNbOM9Ghgqr/n/PD0LSq37AiZvd7osg382gH3NY1Qk
         g+fU0IMaGKNd7oJhUGeWz/817IuYeHzoW0j5k=
Received: by 10.229.91.75 with SMTP id l11mr6857210qcm.24.1286928153691;
        Tue, 12 Oct 2010 17:02:33 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id x9sm3056634qco.34.2010.10.12.17.02.32
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 12 Oct 2010 17:02:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1286891424-2067-8-git-send-email-david.barr@cordelta.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158900>

David Barr wrote:

> On one hand, this makes the interface much uglier.  But on the
> other hand, it makes it possible to retrieve blobs by name, a
> facility we will be using soon.

Stale log message.

> Helped-by: David Barr <david.barr@cordelta.com>

I think you wrote most of the patch at this point.

> --- a/t/t9010-svn-fe.sh
> +++ b/t/t9010-svn-fe.sh
> @@ -34,10 +34,10 @@ test_dump () {
>  		svnadmin load "$label-svn" < "$TEST_DIRECTORY/$dump" &&
>  		svn_cmd export "file://$PWD/$label-svn" "$label-svnco" &&
>  		git init "$label-git" &&
> -		test-svn-fe "$TEST_DIRECTORY/$dump" >"$label.fe" &&
>  		(
> -			cd "$label-git" &&
> -			git fast-import < ../"$label.fe"
> +			cd "$label-git" && mkfifo backflow

Missing && (not that it matters here, just good to get in the habit).

> --- a/test-svn-fe.c
> +++ b/test-svn-fe.c
> @@ -23,10 +23,11 @@ int main(int argc, char *argv[])
>  	if (argc == 5 && !strcmp(argv[1], "-d")) {
>  		struct line_buffer preimage = LINE_BUFFER_INIT;
>  		struct line_buffer delta = LINE_BUFFER_INIT;
> +		struct view preimage_view = {&preimage, 0, STRBUF_INIT};
>  		buffer_init(&preimage, argv[2]);
>  		buffer_init(&delta, argv[3]);
>  		if (svndiff0_apply(&delta, (off_t) strtoull(argv[4], NULL, 0),
> -				   &preimage, stdout))
> +				   &preimage_view, stdout))

This interface change is really neat.  Probably it should get its
own commit.

> --- a/vcs-svn/fast_export.c
> +++ b/vcs-svn/fast_export.c
> @@ -8,8 +8,10 @@
[...]
> +#define REPORT_FILENO 3
>  
>  static uint32_t first_commit_done;
>  
> @@ -30,10 +32,109 @@ void fast_export_modify(uint32_t depth, uint32_t *path, uint32_t mode,
>  	putchar('\n');
>  }
>  
> +static void fast_export_read_bytes(size_t len, char buf[len])
> +{
> +	if (read_in_full(REPORT_FILENO, buf, len) != len)
> +		warning("early eof. Expecting %"PRIu64" bytes", (uint64_t) len);
> +}
> +

Would it make sense for functions like this to use the line_buffer
module?  If we set the O_NONBLOCK flag on the report fd, I think it
could work (with buffer_fdopen()), but I'm not sure how portable that
is.

But maybe it's easier to use fds directly.

> +static void fast_export_expect(const char *string)
> +{
> +	const char *p;
> +	for (p = string; *p; p++) {
> +		char buf[1];
> +		if (xread(REPORT_FILENO, buf, 1) <= 0) {

Might be simpler to read strlen(string) bytes at a time with
read_in_full() (my fault, I know).

[...]
> +static size_t fast_export_read_integer_at_eol(void)
> +{
> +	size_t result = 0;
> +	for (;;) {
> +		char buf[1];
> +		if (xread(REPORT_FILENO, buf, 1) <= 0) {

Could use fscanf() if O_NONBLOCK is usable.  Otherwise I fear
the read(1) is needed. :(

[...]
> +void fast_export_parse_commit(char tree_id[SHA1_HEX_LENGTH])
> +{
> +	size_t len;
> +
> +	fast_export_skip_bytes(SHA1_HEX_LENGTH);
> +	fast_export_expect(" commit ");
> +	len = fast_export_read_integer_at_eol();

I think you mentioned that you'd prefer for this to use

	fast_export_expect(commit_id);

?  Anyway, this functionality is not used in the current patch.

[...]
> +void fast_export_save_blob(FILE *out)
[...]
> +	if (!out) {
> +		warning("cannot open temporary: %s", strerror(errno));
> +		out = fopen("/dev/null", "w");
> +	}
> +	if (!out) {
> +		warning("cannot open /dev/null: %s", strerror(errno));
> +		return;
> +	}

I think the caller should take care of the error message.

[...]
> +	if (ferror(out))
> +		warning("cannot write temporary: %s", strerror(errno));

And this, too, probably (since only the caller knows if it's
temporary).

>  }
>  
> +FILE *preimage = NULL;
> +FILE *postimage = NULL;

static?  And the usual git style is to leave the "= NULL" implicit for
globals.

>  void fast_export_blob(uint32_t mode, uint32_t mark, uint32_t len,
>  			uint32_t delta, uint32_t srcMark, uint32_t srcMode,
>  			struct line_buffer *input)
>  {
> +	struct line_buffer preimage_buf = LINE_BUFFER_INIT;
> +	struct line_buffer postimage_buf = LINE_BUFFER_INIT;
> +	struct view preimage_view = {&preimage_buf, 0, STRBUF_INIT};
> +	long preimage_len = 0;
> +
> +	if (delta) {
> +		if (!preimage)
> +			preimage = tmpfile();

This is not closed until exit() takes care of it, right?

> +		if (srcMark) {
> +			printf("cat :%"PRIu32"\n", srcMark);
> +			fflush(stdout);
> +			if (srcMode == REPO_MODE_LNK)
> +				fwrite("link ", 1, 5, preimage);

strbuf_addstr(&preimage_buf.buf, "link ");

would allow the fast_export_save_blob() to use fd 3 directly,
perhaps.  If so,

> +			fast_export_save_blob(preimage);
> +		}
> +		preimage_len = ftell(preimage);

this would be read from the output of the "cat" command.

Currently we are not using the preimage_len at all as far as I
can tell.  It would not be hard to teach svndiff0_apply() to keep
track of it again.

> +		fseek(preimage, 0, SEEK_SET);
> +		preimage_buf.infile = preimage;
> +		if (!postimage)
> +			postimage = tmpfile();
> +		svndiff0_apply(input, len, &preimage_view, postimage);
> +		strbuf_release(&preimage_view.buf);
> +		len = ftell(postimage);

The postimage has to be a temporary file in the current design, since
we do not know the postimage length to pass to fast-import until we've
written the whole thing out.  The data <<delim form is not usable for
this because there is no forbidden string to use as a delimiter.
A separate pass to add up the postimage lengths from windows would
fail with deltas like those Ram first supplied for the test suite
(though have we checked that those come up in the wild?).

[...]
> +	if (!delta)
> +		buffer_copy_bytes(input, len);
> +	else
> +		buffer_copy_bytes(&postimage_buf, len);

Maintaining support for dumpfilev2.  Nice.

>  	fputc('\n', stdout);
> +
> +	if (preimage) {
> +		fseek(preimage, 0, SEEK_SET);
> +		ftruncate(fileno(preimage), 0);
> +	}
> +
> +	if (postimage) {
> +		fseek(postimage, 0, SEEK_SET);

I think postimage is seeked twice --- are both needed?

[...]
> --- a/vcs-svn/repo_tree.c
> +++ b/vcs-svn/repo_tree.c
> @@ -12,6 +12,9 @@
>  
>  #include "trp.h"
>  
> +/* git hash-object -t tree --stdin </dev/null */
> +#define EMPTY_TREE_HASH "4b825dc642cb6eb9a060e54bf8d69288fbee4904"
> +
>  struct repo_dirent {
>  	uint32_t name_offset;
>  	struct trp_node children;
> @@ -25,6 +28,7 @@ struct repo_dir {
>  
>  struct repo_commit {
>  	uint32_t root_dir_offset;
> +	char tree_id[SHA1_HEX_LENGTH];
>  };

Not needed.

Thanks.

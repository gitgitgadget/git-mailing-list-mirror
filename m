From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 5/5] svn-fe: Use the cat-blob command to apply deltas
Date: Mon, 18 Oct 2010 12:27:01 +0530
Message-ID: <20101018065657.GE22376@kytes>
References: <1287147256-9457-1-git-send-email-david.barr@cordelta.com>
 <1287147256-9457-6-git-send-email-david.barr@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Mon Oct 18 08:58:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7jfV-0006K1-Kg
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 08:58:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753335Ab0JRG5t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Oct 2010 02:57:49 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:57837 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752977Ab0JRG5s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 02:57:48 -0400
Received: by gwaa18 with SMTP id a18so189750gwa.19
        for <git@vger.kernel.org>; Sun, 17 Oct 2010 23:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=JFsgbpIDLTgr4exfhNN+y6zDCZFrw8g0ohEd2z4nHNA=;
        b=JN+0m2Mnk7A0pEWkXrPneGjXgCU3EHn3LQdBmiDkWqo04QCo3VQ/onZxYa+NX9IDEg
         vvGUXKGIQ6577oR3y2YkFCPegVQjHowTj+/XDdQAUFLAVvCTeFlM8DADND8dCNtGXuzt
         KvWcSK0MyJmrkhnXavWWQB9RWBIVOdtRzGsd8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=k9le0tm0m5h1eTyETDfXYcciBG+NfDINQUQVEmCa2GauwQuMP3z+p+YGVoq496b+xN
         z6aNLBLFSOM4epWBVb/e59wVR487UjHkBLcWwesPgr5T/sqx0IwqTNlHJ4MvW9yrM6Jz
         D8rPDVhLvB56UruENXtMX/aVaXj4s+d4KcgOY=
Received: by 10.150.159.9 with SMTP id h9mr6164243ybe.297.1287385067556;
        Sun, 17 Oct 2010 23:57:47 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id p38sm4302286ybk.4.2010.10.17.23.57.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 17 Oct 2010 23:57:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1287147256-9457-6-git-send-email-david.barr@cordelta.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159234>

Hi David,

David Barr writes:
> Use the new cat-blob command for fast-import to extract
> blobs so that text-deltas may be applied.

I like this straightforward approach, and I like the name 'cat-blob'.

> The backchannel should only need to be configured when
> parsing v3 svn dump streams.

Maybe get the synopsis to say this as well?

> Based-on-patch-by: Ramkumar Ramachandra <artagnon@gmail.com>
> Based-on-patch-by: Jonathan Nieder <jrnieder@gmail.com>
> Tested-by: David Barr <david.barr@cordelta.com>
> Signed-off-by: David Barr <david.barr@cordelta.com>
> ---
>  contrib/svn-fe/svn-fe.txt |    6 +++-
>  t/t9010-svn-fe.sh         |    6 ++--
>  vcs-svn/fast_export.c     |   86 +++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 92 insertions(+), 6 deletions(-)
> 
> diff --git a/contrib/svn-fe/svn-fe.txt b/contrib/svn-fe/svn-fe.txt
> index 35f84bd..39ffa07 100644
> --- a/contrib/svn-fe/svn-fe.txt
> +++ b/contrib/svn-fe/svn-fe.txt
> @@ -7,7 +7,11 @@ svn-fe - convert an SVN "dumpfile" to a fast-import stream
>  
>  SYNOPSIS
>  --------
> -svnadmin dump --incremental REPO | svn-fe [url] | git fast-import
> +[verse]
> +mkfifo backchannel &&
> +svnadmin dump --incremental REPO |
> +	svn-fe [url] 3<backchannel |
> +	git fast-import --cat-blob-fd=3 3>backchannel

See above.

>  DESCRIPTION
>  -----------
> diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
> index de976ed..d750c7a 100755
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
> +			cd "$label-git" && mkfifo backchannel && \
> +			test-svn-fe "$TEST_DIRECTORY/$dump" 3< backchannel | \
> +			git fast-import --cat-blob-fd=3 3> backchannel
>  		) &&
>  		(
>  			cd "$label-svnco" &&

Ok.

> diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
> index b017dfb..812563d 100644
> --- a/vcs-svn/fast_export.c
> +++ b/vcs-svn/fast_export.c
> @@ -8,10 +8,17 @@
>  #include "line_buffer.h"
>  #include "repo_tree.h"
>  #include "string_pool.h"
> +#include "svndiff.h"
>  
>  #define MAX_GITSVN_LINE_LEN 4096
> +#define REPORT_FILENO 3
> +
> +#define SHA1_HEX_LENGTH 40
>  
>  static uint32_t first_commit_done;
> +static struct line_buffer preimage = LINE_BUFFER_INIT;
> +static struct line_buffer postimage = LINE_BUFFER_INIT;
> +static struct line_buffer backchannel = LINE_BUFFER_INIT;

Elegant :)

>  void fast_export_delete(uint32_t depth, uint32_t *path)
>  {
> @@ -63,16 +70,91 @@ void fast_export_commit(uint32_t revision, uint32_t author, char *log,
>  	printf("progress Imported commit %"PRIu32".\n\n", revision);
>  }
>  
> +static int fast_export_save_blob(FILE *out)
> +{
> +	size_t len;
> +	char *header;
> +	char *end;
> +	char *tail;
> +
> +	if (!backchannel.infile)
> +		backchannel.infile = fdopen(REPORT_FILENO, "r");
> +	if (!backchannel.infile)
> +		return error("Could not open backchannel fd: %d", REPORT_FILENO);

REPORT_FILENO = 3 is hard-coded. Is this intended? Maybe a
command-line option to specify the fd?

> +	header = buffer_read_line(&backchannel);
> +	if (header == NULL)
> +		return 1;

Note to self: This prints the error "Failed to retrieve blob for delta
application" in the caller.

> +	end = strchr(header, '\0');
> +	if (end - header > 7 && !strcmp(end - 7, "missing"))
> +		return error("cat-blob reports missing blob: %s", header);
> +	if (end - header < SHA1_HEX_LENGTH)
> +		return error("cat-blob header too short for SHA1: %s", header);
> +	if (strncmp(header + SHA1_HEX_LENGTH, " blob ", 6))
> +		return error("cat-blob header has wrong object type: %s", header);
> +	len = strtoumax(header + SHA1_HEX_LENGTH + 6, &end, 10);
> +	if (end == header + SHA1_HEX_LENGTH + 6)
> +		return error("cat-blob header did not contain length: %s", header);
> +	if (*end)
> +		return error("cat-blob header contained garbage after length: %s", header);
> +	buffer_copy_bytes(&backchannel, out, len);
> +	tail = buffer_read_line(&backchannel);
> +	if (!tail)
> +		return 1;

Could you clarify when exactly will this happen?

> +	if (*tail)
> +		return error("cat-blob trailing line contained garbage: %s", tail);
> +	return 0;
> +}
> +
>  void fast_export_blob(uint32_t mode, uint32_t mark, uint32_t len,
>  			uint32_t delta, uint32_t srcMark, uint32_t srcMode,
>  			struct line_buffer *input)
>  {

Note to reviewers: The function looks like this in `master`:
void fast_export_blob(uint32_t mode, uint32_t mark, uint32_t len)

New parameters intrduced in the svn-fe3 series: srcMark, srcMode,
delta, input.

> +	long preimage_len = 0;
> +
> +	if (delta) {
> +		if (!preimage.infile)
> +			preimage.infile = tmpfile();

Didn't you later decide against this and use one tmpfile instead? In
this case, the temporary file will be automatically deleted when
`preimage.infile` goes out of scope.

> +		if (!preimage.infile)
> +			die("Unable to open temp file for blob retrieval");
> +		if (srcMark) {
> +			printf("cat-blob :%"PRIu32"\n", srcMark);
> +			fflush(stdout);
> +			if (srcMode == REPO_MODE_LNK)
> +				fwrite("link ", 1, 5, preimage.infile);

Special handling for symbolic links. Perhaps you should mention it in
a comment here?

> +			if (fast_export_save_blob(preimage.infile))
> +				die("Failed to retrieve blob for delta application");
> +		}
> +		preimage_len = ftell(preimage.infile);
> +		fseek(preimage.infile, 0, SEEK_SET);
> +		if (!postimage.infile)
> +			postimage.infile = tmpfile();

One tmpfile?

> +		if (!postimage.infile)
> +			die("Unable to open temp file for blob application");
> +		svndiff0_apply(input, len, &preimage, postimage.infile);
> +		len = ftell(postimage.infile);

Since you already have a preimage_len, perhaps name this postimage_len
to avoid confusion?

> +		fseek(postimage.infile, 0, SEEK_SET);
> +	}
> +
>  	if (mode == REPO_MODE_LNK) {
>  		/* svn symlink blobs start with "link " */
> -		buffer_skip_bytes(input, 5);
> +		if (delta)
> +			buffer_skip_bytes(&postimage, 5);
> +		else
> +			buffer_skip_bytes(input, 5);
>  		len -= 5;
>  	}
>  	printf("blob\nmark :%"PRIu32"\ndata %"PRIu32"\n", mark, len);
> -	buffer_copy_bytes(input, stdout, len);
> +	if (!delta)
> +		buffer_copy_bytes(input, stdout, len);
> +	else
> +		buffer_copy_bytes(&postimage, stdout, len);
>  	fputc('\n', stdout);

I should have asked this a long time ago: why the extra newline?

> +
> +	if (preimage.infile) {
> +		fseek(preimage.infile, 0, SEEK_SET);
> +	}
> +
> +	if (postimage.infile) {
> +		fseek(postimage.infile, 0, SEEK_SET);
> +	}

Style nits: The extra braces around the `if` statement are unnecessary.

Overall, pleasant read. Thanks for taking this forward.

-- Ram

From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/5] builtin-mailinfo.c infrastrcture changes
Date: Tue, 06 Mar 2007 21:34:31 -0800
Message-ID: <7v8xe9k460.fsf@assigned-by-dhcp.cox.net>
References: <1173218263315-git-send-email-dzickus@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Don Zickus <dzickus@redhat.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 06:34:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOonM-0007NG-06
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 06:34:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbXCGFed (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 00:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751530AbXCGFed
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 00:34:33 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:59254 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243AbXCGFec (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 00:34:32 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070307053430.DKTN26279.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Wed, 7 Mar 2007 00:34:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id XhaX1W00g1kojtg0000000; Wed, 07 Mar 2007 00:34:32 -0500
In-Reply-To: <1173218263315-git-send-email-dzickus@redhat.com> (Don Zickus's
	message of "Tue, 6 Mar 2007 16:57:39 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41651>

Don Zickus <dzickus@redhat.com> writes:

> List of major changes/fixes:
> - can't create empty patch files fix
> - empty patch files don't fail, this failure will come inside git-am
> - multipart boundaries are now handled
> - only output inbody headers if a patch exists otherwise assume those
> headers are part of the reply and instead output the original headers
> - decode and filter base64 patches correctly
> - various other accidental fixes
>
> I believe I didn't break any existing functionality or compatibility (other
> than what I describe above, which is really only the empty patch file).
>
> I tested this through various mailing list archives and everything seemed to
> parse correctly (a couple thousand emails).

Thanks.

> @@ -177,17 +175,35 @@ static int slurp_attr(const char *line, const char *name, char *attr)
>  	return 1;
>  }
>  
> -static int handle_subcontent_type(char *line)
> +struct content_type {
> +	char *boundary;
> +	int boundary_len;
> +};
> +
> +static struct content_type content[]={
> +	{ NULL },
> +	{ NULL },
> +	{ NULL },
> +	{ NULL },
> +	{ NULL },
> +};

The reason why this array has 5 elements (not 4, not 6) is...?

> +
> +static struct content_type *content_top = content;
> +
> +static int handle_content_type(char *line)
>  {
> +	char boundary[256];
> +
> +	if (strcasestr(line, "text/") < 0)
> +		 message_type = TYPE_OTHER;

Did you mean

	if (strncasecmp(line, "text/", 5))

It makes me wonder how a couple thousand mails (or for that
matter our own testsuite) could have passed the test with a
thing like this...

> +	if (slurp_attr(line, "boundary=", boundary + 2)) {
> +		memcpy(boundary, "--", 2);
> +		content_top++;
> +		content_top->boundary_len = strlen(boundary);
> +		content_top->boundary = xmalloc(content_top->boundary_len+1);
> +		strcpy(content_top->boundary, boundary);
>  	}

Does anybody check the content[] stack overflow?

> @@ -341,57 +290,65 @@ static void cleanup_space(char *buf)
>  }
>  
>  static void decode_header(char *it);
> -typedef int (*header_fn_t)(char *);
> -struct header_def {
> -	const char *name;
> -	header_fn_t func;
> -	int namelen;
> +static char *header[10] = {
> +	"From",
> +	"Subject",
> +	"Date",
> +	NULL,
> +	NULL,
> +	NULL,
>  };

Why initialize only three with NULL when you have four more?
What are the 7 entries other than From/Subject/Date for?  Future
extension?  Wouldn't 

	static char *header[] = {
        	"From", "Subject", "Date", NULL,
	};

or even:

	static char *header[] = {
        	"From", "Subject", "Date",
	};

easier to handle (for the latter, you would need your loop with:

	for (i = 0; i < ARRAY_SIZE(header); i++)
        	...

> +	/* Content stuff */
> +	if (!strncasecmp(line, "Content-Type: ", 14)) {

I'd rather not insist SP after colon (I do not think it even has
to exist, but I think we check for isspace() in the current code).

> +static int handle_boundary(void)
> +{
> +again:
> +	if (!memcmp(line+content_top->boundary_len, "--", 2)) {
> +		/* we hit an end boundary */
> +		/* pop the current boundary off the stack */
> +		free(content_top->boundary);
> +		content_top--;
> +		handle_filter("\n");

Stack underflow?

> +static void handle_body(void)
>  {
> ...
> +		switch (transfer_encoding) {
> +		case TE_BASE64:
> +		{
> +			/* binary data most likely doesn't have newlines */
> +			if (message_type != TYPE_TEXT) {
> +				rc=handle_filter(line);
> +				break;
> +			}
> +
> +			/* this is a decoded line that may contain
> +			 * multiple new lines.  Pass only one chunk
> +			 * at a time to handle_filter()
> +			 */
> +
> +			char *op=line;
> +

builtin-mailinfo.c:786: warning: ISO C90 forbids mixed declarations and code.

> @@ -809,18 +833,16 @@ int mailinfo(FILE *in, FILE *out, int ks, const char *encoding,
>  		fclose(cmitmsg);
>  		return -1;
>  	}
> +
> +	p_hdr_data = xcalloc(10, sizeof(char *));
> +	s_hdr_data = xcalloc(10, sizeof(char *));

These tens look unexplained magic...

> diff --git a/git-am.sh b/git-am.sh
> index 2c73d11..8fa466a 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -290,6 +290,7 @@ do
>  		git-mailinfo $keep $utf8 "$dotest/msg" "$dotest/patch" \
>  			<"$dotest/$msgnum" >"$dotest/info" ||
>  			stop_here $this
> +		test -s $dotest/patch || stop_here $this
>  		git-stripspace < "$dotest/msg" > "$dotest/msg-clean"
>  		;;
>  	esac

I think this interface change probably is a good thing.  I
wonder if we need a matching change to applymbox, though.

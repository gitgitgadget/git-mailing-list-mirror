From: Don Zickus <dzickus@redhat.com>
Subject: Re: [PATCH 1/5] builtin-mailinfo.c infrastrcture changes
Date: Wed, 7 Mar 2007 12:17:44 -0500
Message-ID: <20070307171744.GL11029@redhat.com>
References: <1173218263315-git-send-email-dzickus@redhat.com> <7v8xe9k460.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 07 18:20:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOzop-0001dB-19
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 18:20:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422958AbXCGRTz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 12:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422941AbXCGRTY
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 12:19:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46053 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422905AbXCGRTM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 12:19:12 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l27HJ9tI013495;
	Wed, 7 Mar 2007 12:19:09 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l27HJ8KX002492;
	Wed, 7 Mar 2007 12:19:08 -0500
Received: from drseuss.boston.redhat.com (drseuss.boston.redhat.com [172.16.80.234])
	by mail.boston.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id l27HJ8nN028207;
	Wed, 7 Mar 2007 12:19:08 -0500
Received: from drseuss.boston.redhat.com (localhost.localdomain [127.0.0.1])
	by drseuss.boston.redhat.com (8.13.7/8.13.4) with ESMTP id l27HHioS010209;
	Wed, 7 Mar 2007 12:17:44 -0500
Received: (from dzickus@localhost)
	by drseuss.boston.redhat.com (8.13.7/8.13.7/Submit) id l27HHiQ4010208;
	Wed, 7 Mar 2007 12:17:44 -0500
X-Authentication-Warning: drseuss.boston.redhat.com: dzickus set sender to dzickus@redhat.com using -f
Content-Disposition: inline
In-Reply-To: <7v8xe9k460.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41679>

On Tue, Mar 06, 2007 at 09:34:31PM -0800, Junio C Hamano wrote:
> 
> > @@ -177,17 +175,35 @@ static int slurp_attr(const char *line, const char *name, char *attr)
> >  	return 1;
> >  }
> >  
> > -static int handle_subcontent_type(char *line)
> > +struct content_type {
> > +	char *boundary;
> > +	int boundary_len;
> > +};
> > +
> > +static struct content_type content[]={
> > +	{ NULL },
> > +	{ NULL },
> > +	{ NULL },
> > +	{ NULL },
> > +	{ NULL },
> > +};
> 
> The reason why this array has 5 elements (not 4, not 6) is...?

a flip of a coin.  I got lazy and didn't feel like implementing linked
lists.  So instead I decided to use static char arrays.  I can create a
#define <arraysize> with a comment on its intended use.  Or do you prefer
a different approach. 
 
> 
> > +
> > +static struct content_type *content_top = content;
> > +
> > +static int handle_content_type(char *line)
> >  {
> > +	char boundary[256];
> > +
> > +	if (strcasestr(line, "text/") < 0)
> > +		 message_type = TYPE_OTHER;
> 
> Did you mean
> 
> 	if (strncasecmp(line, "text/", 5))
> 
> It makes me wonder how a couple thousand mails (or for that
> matter our own testsuite) could have passed the test with a
> thing like this...

Ooops.  Thanks for catching that.  The default TYPE_TEXT works for almost
all situations, which is why it passes my tests.  The only reason why I
put that code in there is to handle very large base64 binary blobs (that
could overflow the char arrays over 2k bytes).  I didn't have any binary
blobs that large to test so I never ran into this bug.  I'll fix it up.

> 
> > +	if (slurp_attr(line, "boundary=", boundary + 2)) {
> > +		memcpy(boundary, "--", 2);
> > +		content_top++;
> > +		content_top->boundary_len = strlen(boundary);
> > +		content_top->boundary = xmalloc(content_top->boundary_len+1);
> > +		strcpy(content_top->boundary, boundary);
> >  	}
> 
> Does anybody check the content[] stack overflow?

nope.  meant too though.  I'll fix that too.

> 
> > @@ -341,57 +290,65 @@ static void cleanup_space(char *buf)
> >  }
> >  
> >  static void decode_header(char *it);
> > -typedef int (*header_fn_t)(char *);
> > -struct header_def {
> > -	const char *name;
> > -	header_fn_t func;
> > -	int namelen;
> > +static char *header[10] = {
> > +	"From",
> > +	"Subject",
> > +	"Date",
> > +	NULL,
> > +	NULL,
> > +	NULL,
> >  };
> 
> Why initialize only three with NULL when you have four more?
> What are the 7 entries other than From/Subject/Date for?  Future
> extension?  Wouldn't 
> 
> 	static char *header[] = {
>         	"From", "Subject", "Date", NULL,
> 	};
> 
> or even:
> 
> 	static char *header[] = {
>         	"From", "Subject", "Date",
> 	};
> 
> easier to handle (for the latter, you would need your loop with:
> 
> 	for (i = 0; i < ARRAY_SIZE(header); i++)
>         	...
> 

see patch 2/5 for a better idea of the direction I was going with this.
Again another lazy trick to avoid linked lists and instead use static char
arrays to easily handle new content.  Probably wouldn't hurt for me to clean
this up too.


> > +	/* Content stuff */
> > +	if (!strncasecmp(line, "Content-Type: ", 14)) {
> 
> I'd rather not insist SP after colon (I do not think it even has
> to exist, but I think we check for isspace() in the current code).

ok.

> 
> > +static int handle_boundary(void)
> > +{
> > +again:
> > +	if (!memcmp(line+content_top->boundary_len, "--", 2)) {
> > +		/* we hit an end boundary */
> > +		/* pop the current boundary off the stack */
> > +		free(content_top->boundary);
> > +		content_top--;
> > +		handle_filter("\n");
> 
> Stack underflow?

yup.  i'll fix this.

> 
> > +static void handle_body(void)
> >  {
> > ...
> > +		switch (transfer_encoding) {
> > +		case TE_BASE64:
> > +		{
> > +			/* binary data most likely doesn't have newlines */
> > +			if (message_type != TYPE_TEXT) {
> > +				rc=handle_filter(line);
> > +				break;
> > +			}
> > +
> > +			/* this is a decoded line that may contain
> > +			 * multiple new lines.  Pass only one chunk
> > +			 * at a time to handle_filter()
> > +			 */
> > +
> > +			char *op=line;
> > +
> 
> builtin-mailinfo.c:786: warning: ISO C90 forbids mixed declarations and code.

hmm. don't know why gcc 4.1.1 didn't catch that.  anyway, the binary data
part was added much later.  should be easy to fix.

> 
> > @@ -809,18 +833,16 @@ int mailinfo(FILE *in, FILE *out, int ks, const char *encoding,
> >  		fclose(cmitmsg);
> >  		return -1;
> >  	}
> > +
> > +	p_hdr_data = xcalloc(10, sizeof(char *));
> > +	s_hdr_data = xcalloc(10, sizeof(char *));
> 
> These tens look unexplained magic...

i'll create a #define for those too.

> 
> > diff --git a/git-am.sh b/git-am.sh
> > index 2c73d11..8fa466a 100755
> > --- a/git-am.sh
> > +++ b/git-am.sh
> > @@ -290,6 +290,7 @@ do
> >  		git-mailinfo $keep $utf8 "$dotest/msg" "$dotest/patch" \
> >  			<"$dotest/$msgnum" >"$dotest/info" ||
> >  			stop_here $this
> > +		test -s $dotest/patch || stop_here $this
> >  		git-stripspace < "$dotest/msg" > "$dotest/msg-clean"
> >  		;;
> >  	esac
> 
> I think this interface change probably is a good thing.  I
> wonder if we need a matching change to applymbox, though.

that and git-quiltimport too.

I'll send out another draft this afternoon.

Cheers,
Don

From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 4/4] Add a --cover-letter option to format-patch
Date: Wed, 6 Feb 2008 14:02:57 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802061340190.13593@iabervon.org>
References: <alpine.LNX.1.00.0802061141410.13593@iabervon.org> <200802061921.58282.kumbayo84@arcor.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Peter Oberndorfer <kumbayo84@arcor.de>
X-From: git-owner@vger.kernel.org Wed Feb 06 20:04:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMpYf-00017T-OR
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 20:03:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754087AbYBFTDF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 14:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753104AbYBFTDE
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 14:03:04 -0500
Received: from iabervon.org ([66.92.72.58]:35710 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752431AbYBFTDD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 14:03:03 -0500
Received: (qmail 2376 invoked by uid 1000); 6 Feb 2008 19:02:57 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Feb 2008 19:02:57 -0000
In-Reply-To: <200802061921.58282.kumbayo84@arcor.de>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72826>

On Wed, 6 Feb 2008, Peter Oberndorfer wrote:

> On Mittwoch 06 Februar 2008, Daniel Barkalow wrote:
> > If --cover-letter is provided, generate a cover letter message before
> > the patches, numbered 0.
> > 
> > Original patch thanks to Johannes Schindelin
> > 
> > Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> > ---
> > +static int reopen_stdout(const char *oneline, int nr, int total)
> >  {
> >  	char filename[PATH_MAX];
> > -	char *sol;
> >  	int len = 0;
> >  	int suffix_len = strlen(fmt_patch_suffix) + 1;
> >  
> >  	if (output_directory) {
> > -		if (strlen(output_directory) >=
> > +		len = snprintf(filename, sizeof(filename), "%s",
> > +				output_directory);
> > +		if (len >=
> >  		    sizeof(filename) - FORMAT_PATCH_NAME_MAX - suffix_len)
> >  			return error("name of output directory is too long");
> > -		strlcpy(filename, output_directory, sizeof(filename) - suffix_len);
> > -		len = strlen(filename);
> >  		if (filename[len - 1] != '/')
> >  			filename[len++] = '/';
> >  	}
> >  
> *snip*
> > +	if (!filename)
> > +		len += sprintf(filename + len, "%d", nr);
> maybe this should be !oneline instead?

Yup.

> > +	else {
> > +		len += sprintf(filename + len, "%04d-", nr);
> > +		len += snprintf(filename + len, sizeof(filename) - len - 1
> > +				- suffix_len, "%s", oneline);
> >  		strcpy(filename + len, fmt_patch_suffix);
> >  	}
> 
> > +static void make_cover_letter(struct rev_info *rev,
> > +		int use_stdout, int numbered, int numbered_files,
> > +			      struct commit *origin, struct commit *head)
> > +{
> > +	const char *committer;
> > +	const char *origin_sha1, *head_sha1;
> > +	const char *argv[7];
> > +	const char *subject_start = NULL;
> > +	const char *body = "*** SUBJECT HERE ***\n\n\n*** BLURB HERE ***\n";
> I don't know git policy but maybe use
> const char body[] = "*** SUBJECT HERE ***\n\n\n*** BLURB HERE ***\n";
> since you don't change the pointer.
> (or remove the variable)

It's there to make it easy to get the message from somewhere else later, 
with something of the form:

	if (have_cover_letter_text)
		body = cover_letter_text;

Likewise encoding.

> > +	const char *msg;
> > +	const char *extra_headers = rev->extra_headers;
> > +	struct strbuf sb;
> > +	const char *encoding = "utf-8";
> same here
> > +
> > +	if (rev->commit_format != CMIT_FMT_EMAIL)
> > +		die("Cover letter needs email format");
> 
> It might be useful to split the reopen_stdout/get_oneline_for_filename
> into a separate patch.

Perhaps; I mostly just got lazy, since I had these changes together and 
had already finished with my shuffling things around patch.

> When i tried to do this --cover-letter function i went the way to create a 
> empty fake commit and let log_tree_commit do all the formating stuff for me.
> But i don't know if which way is preferred...

This way looks cleaner and more obvious to me, anyway.

> Does you patch set up a reply to chain,
> so patches are in reply to cover letter?
> I remember battling a bit to set it up reasonably.

I believe that, if you use --thread, all of the later messages are replies 
to the first; if you use --cover-letter, the first is the cover letter.

> Greetings Peter
> Who tried to create this --cover-letter function
> but gave up silently when his patch mails never reached the ML :-(
> 
> I don't know if my patches are of any use (do not apply cleanly anymore, 
> reading cover letter message from a file does not honor encoding in any way)
> But i can send them to you if you want...

I think one other person's implementation was sufficient. :)

	-Daniel
*This .sig left intentionally blank*

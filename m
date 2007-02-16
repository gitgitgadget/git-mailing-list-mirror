From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add `git diff2`, a GNU diff workalike
Date: Fri, 16 Feb 2007 15:01:54 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702161447080.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702160500280.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v1wkq8r26.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Feb 16 15:02:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HI3ey-0002Q8-5o
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 15:02:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbXBPOB4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 09:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbXBPOB4
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 09:01:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:40985 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932354AbXBPOB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 09:01:56 -0500
Received: (qmail invoked by alias); 16 Feb 2007 14:01:54 -0000
X-Provags-ID: V01U2FsdGVkX19CkD8e2WZCeDOnxMh7mPnMideeWJeK8jv8n17mI8
	NFKw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v1wkq8r26.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39914>

Hi,

On Fri, 16 Feb 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Git does have a wonderful diff engine. For example, colored diffs
> > really shine, and there are other useful options like --check,
> > --patch-with-stat, etc. I always dreamt of using this diff engine
> > also outside of a git repository.
> >
> > With this commit, you can say
> >
> > 	git diff2 file1 file2
> 
> Why diff2?  I would have expected this to be a new low-level sibling of 
> diff-files and diff-index, which in turn hook into the overall "diff" 
> driver.

I planned this. However, I could not think of any sane way to handle the 
case in an intuitive manner where you want to compare two _tracked_ files. 
How would you do that in a consistent manner?

BTW I also realized that `git diff bla` will _not_ complain when the file 
bla exists, but is untracked. Neither will it show a diff. I did not come 
around to fix that yet.

> > +static int queue_diff(struct diff_options *o,
> > +		const char *name1, const char *name2)
> > +{
> > +	struct stat st;
> > +	int mode1 = 0, mode2 = 0;
> > +
> > +	if (name1) {
> > +		if (stat(name1, &st))
> > +			return error("Could not access '%s'", name1);
> > +		mode1 = st.st_mode;
> > +	}
> > +	if (name2) {
> > +		if (stat(name2, &st))
> > +			return error("Could not access '%s'", name1);
> > +		mode2 = st.st_mode;
> > +	}
> 
> I am still debating myself if these should be lstat(2) instead of 
> stat(2).  The former is more consistent with what git does.

Well, it should probably be lstat(), with an addremove when one or both 
files are links. But they could be identical also.

> > +	if (mode1 && mode2 && S_ISDIR(mode1) != S_ISDIR(mode2))
> > +		return error("file/directory conflict: %s, %s", name1, name2);
> 
> If a/frotz is a file and b/frotz/nitfol is there, I do not think we show 
> an error; we say "a/frotz" was removed (see notes below, though).

Good point. Will fix.

> > +	if (S_ISDIR(mode1) || S_ISDIR(mode2)) {
> > +		char buffer1[PATH_MAX], buffer2[PATH_MAX];
> > +		struct path_list p1 = {NULL, 0, 0, 1}, p2 = {NULL, 0, 0, 1};
> > +		int len1 = 0, len2 = 0, i1, i2, ret = 0;
> > +
> > +		if (name1 && read_directory(name1, &p1))
> > +			return -1;
> > +		if (name2 && read_directory(name2, &p2)) {
> > +			path_list_clear(&p1, 0);
> > +			return -1;
> > +		}
> 
> I suspect your favorite path-list might not be optimal for this kind of 
> codeflow; wouldn't reading everything in an expanding array and sorting 
> them with a single qsort() after reading one directory more efficient?

You are right. But for the moment, I'll leave it, since it is one of the 
least performance critical parts of diff2, _and_ the use of path-list is 
really easy.

> > +		for (i1 = i2 = 0; !ret && (i1 < p1.nr || i2 < p2.nr); ) {
> > +			const char *n1, *n2;
> > +			int comp;
> > +
> > +			if (i1 == p1.nr)
> > +				comp = 1;
> > +			else if (i2 == p2.nr)
> > +				comp = -1;
> > +			else
> > +				comp = strcmp(p1.items[i1].path,
> > +					p2.items[i2].path);
> 
> I think you would want to be consistent with how git sorts paths
> here.  In particular, you can always pretend that a path that is
> a directory has '/' at the end.

At that point, the entries in p1 and p2 are from readdir(), so I do not 
know the type (e->d_type is non-portable according to my man-page here).

BTW I had a memory leak in path_list_insert(xstrdup(...

> The rest looks quite straightforward use of diffcore API, done
> very cleanly.

Thanks!

> > diff --git a/diff.c b/diff.c
> > index c2d9abe..be73621 100644
> > --- a/diff.c
> > +++ b/diff.c
> > @@ -2443,7 +2443,8 @@ static void diff_resolve_rename_copy(void)
> >  				p->status = DIFF_STATUS_RENAMED;
> >  		}
> >  		else if (hashcmp(p->one->sha1, p->two->sha1) ||
> > -			 p->one->mode != p->two->mode)
> > +			 p->one->mode != p->two->mode ||
> > +			 is_null_sha1(p->one->sha1))
> >  			p->status = DIFF_STATUS_MODIFIED;
> 
> I didn't look, but you might also need to teach diffcore-rename
> that two objects both with null object names are not equal.

But would not every diff be marked as a rename then?

Ciao,
Dscho

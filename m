From: Larry D'Anna <larry@elder-gods.org>
Subject: Re: [PATCH v4] add --summary option to git-push and git-fetch
Date: Fri, 29 Jan 2010 19:59:48 -0500
Message-ID: <20100130005948.GA14938@cthulhu>
References: <20090703044801.GA2072@cthulhu>
 <7viqiat965.fsf@alter.siamese.dyndns.org>
 <20090707015948.GA525@cthulhu>
 <h35bda$kgv$1@ger.gmane.org>
 <20090710022415.GA27274@cthulhu>
 <4A56EEBA.3070806@gmail.com>
 <20090711174156.GA17154@cthulhu>
 <7viqhzm454.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 30 02:06:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb1nD-0005Kh-09
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 02:06:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755834Ab0A3BGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 20:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755780Ab0A3BGX
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 20:06:23 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:46878 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755570Ab0A3BGX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 20:06:23 -0500
X-Greylist: delayed 394 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Jan 2010 20:06:23 EST
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id 63525822012; Fri, 29 Jan 2010 19:59:48 -0500 (EST)
Mail-Followup-To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <7viqhzm454.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138415>

I know it's been a while but.....

> > @@ -373,12 +379,15 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
> >  				fputc(url[i], fp);
> >  		fputc('\n', fp);
> >  
> > -		if (ref)
> > -			rc |= update_local_ref(ref, what, note);
> > -		else
> > +		if (ref) {
> > +			*quickref = 0;
> > +			rc |= update_local_ref(ref, what, note, quickref);
> 
> Makes me wonder why update_local_ref() does not put that NUL upon entry.

I'm not sure what you mean.  Could you elaborate?

> > +	init_revisions(&rev, NULL);
> > +	rev.prune = 0;
> > +	assert(!handle_revision_arg(quickref, &rev, 0, 1));
> > +	assert(!prepare_revision_walk(&rev));
> > +
> > +	while ((commit = get_revision(&rev)) != NULL) {
> > +		struct strbuf buf = STRBUF_INIT;
> > +		if (limit == 0) {
> > +			fprintf(stderr, "    ...\n");
> 
> How would you know, when you asked 20 and you showed 20 here, that there
> is no more to come?

If there's more it will print the "...", if there isn't then it won't.

> > +			break;
> > +		}
> 
> > +		if (!commit->buffer) {
> > +			enum object_type type;
> > +			unsigned long size;
> > +			commit->buffer =
> > +				read_sha1_file(commit->object.sha1, &type, &size);
> > +			if (!commit->buffer)
> > +				die("Cannot read commit %s", sha1_to_hex(commit->object.sha1));
> > +		}
> > +		format_commit_message(commit, "    %m %h %s\n", &buf, 0);
> 
> Hmm, why so many spaces before %m and after %m?

So the summary lines are nicely indented with respect to the other output.

> > -static int do_push(const char *repo, int flags)
> > +static int do_push(const char *repo, int flags, int summary)
> 
> Couldn't this be just another bit in the flag?  I didn't check but I
> suspect you wouldn't have to touch the intermediate functions in the call
> chain that way.

It can't just be a bit because the "summary" parameter contains number of
summary lines to print.

> > +test_expect_success 'fetch --summary forced update' '
> > +	mk_empty &&
> > +	(
> > ...
> > +	)
> > +
> > +'
> 
> There are at least two missing combinations. (1) "fetch --summary" to
> fetch a new branch, and (2) "fetch --summary" does not try segfaulting by
> accessing unavailable information after a failed fetch.
> 
> The same comment applies to the push side of the tests.

What would be a good way to induce a failed fetch for this test?


     --larry

From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/5] vcs-svn: Start working on the dumpfile producer
Date: Sat, 22 Jan 2011 15:15:59 +0530
Message-ID: <20110122094556.GB7827@kytes>
References: <1295415899-1192-1-git-send-email-artagnon@gmail.com>
 <1295415899-1192-3-git-send-email-artagnon@gmail.com>
 <7v39olok4l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 22 10:45:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pga1n-0008AP-6o
	for gcvg-git-2@lo.gmane.org; Sat, 22 Jan 2011 10:45:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752478Ab1AVJo5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Jan 2011 04:44:57 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:54642 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752204Ab1AVJo4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jan 2011 04:44:56 -0500
Received: by pwj3 with SMTP id 3so434303pwj.19
        for <git@vger.kernel.org>; Sat, 22 Jan 2011 01:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=VHbvPo6U4dcxewhs5LGG1VKcXDRDolxH0l8qXyhbJQE=;
        b=ATzfUD661cNBW5QkCJJeBRBasFG/w1WYzGOyKFrykmJq2Kw7yCCuB06PMafVu+lDDt
         Nw5Vb/zgKwrfmNaATIWbUzvNNlAS9w0IaBvUkuwVq+IEb/XeGrn0ZypLSqUIlaRc3Ipg
         SJvvwMqzxTTJt77qBnn3p2+uWCykjBwCJ9Ca0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=uSNYWGtOGrJx6qYZMo8AGq1k7laKpQLePa/alvk6yQOR7ocCxIymJo1lCQz4LXzkG7
         acCpGZHW/S3sSw87ZcXXb0FdxZLkMP8DG7r5zz26XMKRsQshnS6NzW7OU+uXIJOTvDna
         /H89+Wz0ugNmylO6tqp5L6VPziOV3shqkjEus=
Received: by 10.142.217.14 with SMTP id p14mr1699887wfg.56.1295689495528;
        Sat, 22 Jan 2011 01:44:55 -0800 (PST)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id c3sm337053wfa.14.2011.01.22.01.44.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 22 Jan 2011 01:44:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7v39olok4l.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165409>

Hi Junio,

Junio C Hamano writes:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
> > Start off with some broad design sketches. Compile succeeds, but
> > parser is incorrect. Include a Makefile rule to build it into
> > vcs-svn/lib.a.
> >
> > Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> 
> I initially thought I should refrain from doing a usual picky review for
> contrib/ material, but realized this does not go to contrib/, so...

Thanks for the review. A new iteration including tests is almost
ready- your review came in at the perfect time :)

> > diff --git a/vcs-svn/dump_export.c b/vcs-svn/dump_export.c
> > new file mode 100644
> > index 0000000..04ede06
> > --- /dev/null
> > +++ b/vcs-svn/dump_export.c
> > ...
> > +void dump_export_begin_rev(int revision, const char *revprops,
> > +			int prop_len) {
> 
> Style. "{" at the beginning of the next line (same everywhere).

Fixed.

> > +void dump_export_node(const char *path, enum node_kind kind,
> > +		enum node_action action, unsigned long text_len,
> > +		unsigned long copyfrom_rev, const char *copyfrom_path) {
> > +	printf("Node-path: %s\n", path);
> > +	printf("Node-kind: ");
> > +	switch (action) {
> > +	case NODE_KIND_NORMAL:
> > +		printf("file\n");
> > +		break;
> > +	case NODE_KIND_EXECUTABLE:
> > +		printf("file\n");
> > +		break;
> > +	case NODE_KIND_SYMLINK:
> > +		printf("file\n");
> > +		break;
> > +	case NODE_KIND_GITLINK:
> > +		printf("file\n");
> > +		break;
> > +	case NODE_KIND_SUBDIR:
> > +		die("Unsupported: subdirectory");
> > +	default:
> > +		break;
> > +	}
> 
> Hmph, is it expected that the repertoire of node-kind stay the same, or
> will it be extended over time?  It might make sense to change the above
> switch a more table-driven one.  The same for node-action that follows
> this part of the code.

I needed more than a lookup table, because I wanted the flexibility to
execute arbitrary statements in each case. It's extended in the latest
version (will come up on the list soon).

> > diff --git a/vcs-svn/svnload.c b/vcs-svn/svnload.c
> > new file mode 100644
> > index 0000000..7043ae7
> > --- /dev/null
> > +++ b/vcs-svn/svnload.c
> > @@ -0,0 +1,294 @@
> > ...
> > +static struct strbuf blobs[100];
> > +	
> 
> Is there a rationale for "100", or is it just a random number that can be
> tweakable at the source level?  Would we want to have a symbolic constant
> for it?
> 
> The "blank" line has a trailing whitespace.

Fixed. I used this to illustrate the problem with persisting blobs- in
this version, I persist 100 blobs; this is totally arbitrary and
inextensible. Since the latest version leverages the --inline-blobs
feature of fast export, this is totally unecessary.

> > +static struct {
> > +	unsigned long prop_len, text_len, copyfrom_rev, mark;
> > +	int text_delta, prop_delta; /* Boolean */
> > ...
> > +static void reset_node_ctx(void)
> > ...
> > +	node_ctx.text_delta = -1;
> > +	node_ctx.prop_delta = -1;
> 
> Does your "Boolean" type take values 0 or -1?  Or is it perhaps a tristate
> false=0, true=1, unknown=-1?  If so, the comment on the type above needs
> to be fixed.

Fixed. Thanks for pointing this out.

> > +	strbuf_reset(&node_ctx.copyfrom_path);
> > +	strbuf_reset(&node_ctx.path);
> > +}
> > +
> > +static void populate_props(struct strbuf *props, const char *author,
> > +			const char *log, const char *date) {
> 
> Style on "{" (look everywhere).

Fixed.

> > +	strbuf_reset(props);	
> 
> Trailing whitespace.

Fixed.

> > ...
> > +	t ++;
> 
> Unwanted SP before "++" (look everywhere).

Fixed.

> > +	tm_time = time_to_tm(strtoul(t, NULL, 10), atoi(tz_off));
> 
> Has your caller already verified tz_off is a reasonable integer?

Fixed.

> > ...
> > +			if (!memcmp(t, "D", 1)) {
> > +				node_ctx.action = NODE_ACTION_DELETE;
> > +			}
> > +			else if (!memcmp(t, "C", 1)) {
> 
> Style: "} else if (...) {".

Fixed.

> > ...
> > +					node_ctx.kind = NODE_KIND_GITLINK;
> > +				else if (!memcmp(val, "040000", 6))
> 
> Is <mode> guaranteed to be a 6-digit octal, padded with 0 to the left?
> 
> The manual page of git-fast-import seems to hint that is the case, but I
> am double checking, as the leading zero is an error in the tree object.

The documentation and commit messages seem to hint that this is the
case. I'm digging to see if there's anything wrong with this.

> > +					node_ctx.kind = NODE_KIND_SUBDIR;
> > +				else {
> > +					if (!memcmp(val, "755", 3))
> > +						node_ctx.kind = NODE_KIND_EXECUTABLE;
> > +					else if(!memcmp(val, "644", 3))
> 
> Style; missing SP after "if/switch" (look everywhere).

Fixed.

> > +						node_ctx.kind = NODE_KIND_NORMAL;
> > +					else
> > +						die("Unrecognized mode: %s", val);
> > +					mode_incr = 4;
> > +				}
> > +				val += mode_incr;
> 
> Hmm, this whole thing is ugly.
> 
> Perhaps a table-lookup, or at least a helper function that translates
> "val" to node-kind (while advancing val as the side effect) may make it
> easier to read?

Fixed. I used a helper function.

> > ...
> > +					to_dump = &blobs[strtoul(val + 1, NULL, 10)];
> 
> Has anybody so far verified the decimal number at (val+1) is a reasonable
> value, or am I seeing a future CVE here?

Fixed.

> Do we care what follows the len of digits on this line?  Does a line in G-F-I
> stream allow trailing garbage (this question is not limited to this part
> of the code)?

Hm, I haven't thought about this hard enough. Currently, both svn-fi
and svn-fe ignore any trailing garbage/ commands they don't
understand. Are there some issues that we haven't anticipated?

> > +int svnload_init(const char *filename)
> > ...
> > +void svnload_deinit(void)
>
> Whoever needs to add an element to rev_ctx must consistently touch reset,
> init and deinit.  Would it help him/her if you moved the code so that
> these functions are close together from the beginning?

Fixed.

-- Ram

From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 06/13] Dump the revprops at the start of every revision
Date: Wed, 7 Jul 2010 14:04:34 -0500
Message-ID: <20100707190434.GA2732@burratino>
References: <1278461693-3828-1-git-send-email-artagnon@gmail.com>
 <1278461693-3828-7-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, avarb@gmail.com,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Bert Huijben <rhuijben@collab.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>, dev@subversion.apache.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 07 21:05:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWZw4-0003LL-Dj
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 21:05:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755899Ab0GGTFT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Jul 2010 15:05:19 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37706 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754804Ab0GGTFR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 15:05:17 -0400
Received: by iwn7 with SMTP id 7so1963iwn.19
        for <git@vger.kernel.org>; Wed, 07 Jul 2010 12:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=jwyX1S5I1bPScz4bD9MY630t/eADFAeQ5hzytJoVjmQ=;
        b=duuJbhp1rjsv6ftLrShBOZ3+cxFzK3dkNXPj8YgEg0QgK+4oME/2uXcy4HovcBpQZp
         SaMSvBh764IKL5T0eydwMcqZVhKuw60oIFXum0blI0ibLGAaoAnbWv8+hJOn/6wfD46G
         hCJlNriOLIkRsVSPp1ENZ1vSeqHTDg5S9fHwM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=oQya4EGOUyT+UGD45UA5CEgLjo4ameUkxZMMi6/eOpcz0LGSYYDzmYcFb1sBLa+EuM
         1PDI3M6jgP57KTfmlu9GrESpj7c9yQW9F2Fd2w7PH6jHoPxsaZiB3YLJOihM34o3SAij
         2xzS0glEQ6sOT6khAP67j9jdVW/8/tQW9NXcs=
Received: by 10.231.35.70 with SMTP id o6mr6618553ibd.92.1278529516737;
        Wed, 07 Jul 2010 12:05:16 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 34sm30008883ibi.18.2010.07.07.12.05.15
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 07 Jul 2010 12:05:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1278461693-3828-7-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150493>

Ramkumar Ramachandra wrote:

> Fill in replay_revstart to dump the revprops at the start of every
> revision. Add an additional write_hash_to_stringbuf helper function.

	A write_hash_to_stringbuf helper does the work of
	converting the property hashtable to dumpfile format.

> +++ b/dumpr_util.c
[...]
> +void write_hash_to_stringbuf(apr_hash_t *properties,
> +			     svn_boolean_t deleted,
> +			     svn_stringbuf_t **strbuf,
> +			     apr_pool_t *pool)

This function looks like:

	void write_hash_to_stringbuf(...
	{
		if (!deleted) {
			for (each prop) {
				append the new value of the prop;
			}
		} else {
			for (each prop) {
				mention that it has been deleted;
			}
		}
	}

It would be simpler to put the body of the loop in its own function,
like this:

	static void write_prop_to_stringbuf(...
	{
		if (deleted) {
			append deletion notice;
			return;
		}
		append new value of prop;
	}

	void write_hash_to_stringbuf(...
	{
		for (each prop)
			write_prop_to_stringbuf(...
	}

Or even:

	static void write_prop(...
	static void write_deleted_prop(...

	void write_prop_data_to_stringbuf(...
	{
		for (each prop)
			write_prop(...
	}
	void write_deleted_prop_data_to_stringbuf(...
	{
		for (each prop)
			write_deleted_prop(...
	}

which would make the arguments from the caller less opaque.

I did not check whether the "return early in the simpler case" is
idiomatic for svn code.  Of course you should respect whatever
convention is prevalent.

> +{
> +	apr_hash_index_t *this;
> +	const void *key;
> +	void *val;
> +	apr_ssize_t keylen;
> +	svn_string_t *value;
> +=09
> +	if (!deleted) {
> +		for (this =3D apr_hash_first(pool, properties); this;
> +		     this =3D apr_hash_next(this)) {
> +			/* Get this key and val. */
> +			apr_hash_this(this, &key, &keylen, &val);
> +			value =3D val;
> +
> +			/* Output name length, then name. */
> +			svn_stringbuf_appendcstr(*strbuf,
> +						 apr_psprintf(pool, "K %" APR_SSIZE_T_FMT "\n",
> +							      keylen));
> +
> +			svn_stringbuf_appendbytes(*strbuf, (const char *) key, keylen);

Is the cast needed?  (The answer might be "yes" if this code is meant
to be usable with C++ compilers.)

> +++ b/svndumpr.c
> @@ -23,6 +23,37 @@ static svn_error_t *replay_revstart(svn_revnum_t r=
evision,
>                                      apr_hash_t *rev_props,
>                                      apr_pool_t *pool)
>  {
> +	/* Editing this revision has just started; dump the revprops
> +	   before invoking the editor callbacks */
> +	svn_stringbuf_t *propstring =3D svn_stringbuf_create("", pool);
> +	svn_stream_t *stdout_stream;

Style: better to say in comments what we are trying to do than what we
actually do.  So:

	/* First, dump revision properties. */

Maybe dumping revision properties should be its own function to make
that comment unnecessary (and make replay_revstart() less daunting as
it grows).

> +
> +	/* Create an stdout stream */
> +	svn_stream_for_stdout(&stdout_stream, pool);

Useless comment.

> +
> +        /* Print revision number and prepare the propstring */
> +	SVN_ERR(svn_stream_printf(stdout_stream, pool,
> +				  SVN_REPOS_DUMPFILE_REVISION_NUMBER
> +				  ": %ld\n", revision));
> +	write_hash_to_stringbuf(rev_props, FALSE, &propstring, pool);
> +	svn_stringbuf_appendbytes(propstring, "PROPS-END\n", 10);

Unhelpful comment.  Maybe:

	/* Revision-number: 19 */
	SVN_ERR(svn_stream_printf(stdout_stream, pool,
				  SVN_REPOS_DUMPFILE_REVISION_NUMBER
				  ": %ld\n", revision));

	write_hash_to_stringbuf(rev_props, FALSE, &propstring, pool);
	svn_stringbuf_appendbytes(propstring, "PROPS-END\n", 10);

	/* Prop-content-length: 13 */
	SVN_ERR(svn_stream_printf(stdout_stream, pool,
				  SVN_REPOS_DUMPFILE_PROP_CONTENT_LENGTH
				  ": %" APR_SIZE_T_FMT "\n", propstring->len));
	...

This would make it particularly easy to grep for a particular header
(even if grepping for SVN_REPOS_DUMPFILE_PROP_CONTENT_LENGTH is not
that hard).

[...]
> +	/* Print the revprops now */
> +	SVN_ERR(svn_stream_write(stdout_stream, propstring->data,
> +				 &(propstring->len)));

Maybe:

	/* Property data. */
	SVN_ERR(svn_stream_write(stdout_stream, propstring->data,
				 &(propstring->len)));

The whole function so far has been about printing revprops.

> +
> +	svn_stream_close(stdout_stream);

This does not actually fclose(stdout), does it?

> @@ -39,6 +70,9 @@ static svn_error_t *replay_revend(svn_revnum_t revi=
sion,
>                                    apr_hash_t *rev_props,
>                                    apr_pool_t *pool)
>  {
> +	/* Editor has finished for this revision and close_edit has
> +	   been called; do nothing: just continue to the next
> +	   revision */

I=E2=80=99d leave out the comment, or:

	/* No resources to free. */

HTH,
Jonathan

From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 03/13] Add debug editor from Subversion trunk
Date: Wed, 7 Jul 2010 12:55:30 -0500
Message-ID: <20100707175530.GA2480@burratino>
References: <1278461693-3828-1-git-send-email-artagnon@gmail.com>
 <1278461693-3828-4-git-send-email-artagnon@gmail.com>
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
X-From: git-owner@vger.kernel.org Wed Jul 07 19:56:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWYr6-0007BM-Px
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 19:56:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756091Ab0GGR4O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Jul 2010 13:56:14 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:55018 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754241Ab0GGR4N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 13:56:13 -0400
Received: by iwn7 with SMTP id 7so8080324iwn.19
        for <git@vger.kernel.org>; Wed, 07 Jul 2010 10:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=H5ox/0Agn6qFuGp2F+H9JnecFNdy3JM2MWrXqidudp8=;
        b=KKhF6L2tmGZ+P1/DUIgJRUSI6PYHCxGIrQhAQm/k6sk0PWK4lmDQphs+X78qKDbrT0
         xhOhorzmIuWBJ8a30IL3BhBEshYHWLA4d0jnhBGxqgyD8rHobs5X9UZOXVSLsYFjAbTb
         fP6+JzC51rDaHbxszVWl6QuFd9dd/Cawy3m2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=xIL2Qsalm1v3r/zPsVn28GcAI0FUD/1+W4Yc1Aw+NSsyRkxo+XDgkBspRPCrXUmDRK
         iUYqp6MltrIhyTbR7VRmfBCgjJgZmW2MwfWJHVyE9rhrLgoVpWmAipE74sbVXW3cB86L
         LAUNzJ/JJ5wmc1iOFN0IwuyJ4vyHcdio24SfE=
Received: by 10.231.187.194 with SMTP id cx2mr6742242ibb.165.1278525372961;
        Wed, 07 Jul 2010 10:56:12 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id e8sm27422501ibb.14.2010.07.07.10.56.11
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 07 Jul 2010 10:56:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1278461693-3828-4-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150487>

Hi again,

Ramkumar Ramachandra wrote:

> Add the debug editor from subversion/libsvn_delta/debug_editor.c alon=
g
> with a header to expose the svn_delta__get_debug_editor function.

The description does not tell what the debug editor is for.  Is it
for tracing?

In what follows, I am going to pretend this is all new code, since
for someone unfamiliar to svn like me, that is easier than reviewing
the differences.  Upshot: you can probably ignore most of what I say. :=
)

> +++ b/debug_editor.c
> @@ -0,0 +1,402 @@
> +/* Licensed under a two-clause BSD-style license.
> + * See LICENSE for details.
> + */

Is this true?

> +
> +#include "svn_pools.h"
> +#include "svn_cmdline.h"
> +#include "svn_client.h"
> +#include "svn_ra.h"
> +
> +#include "debug_editor.h"
> +
> +struct edit_baton
> +{
> +	const svn_delta_editor_t *wrapped_editor;
> +	void *wrapped_edit_baton;
> +
> +	int indent_level;
> +
> +	svn_stream_t *out;
> +};

This object represents context while describing changes in a revision.
The indent_level gets incremented whenever we move to a subdirectory,
wrapped_editor is a set of callbacks to actually do something with
the changes, wrapped_edit_baton its state cookie, and out a stream
to write the debugging information to.

> +
> +struct dir_baton
> +{
> +	void *edit_baton;
> +	void *wrapped_dir_baton;
> +};

Context when traversing a directory.

Maybe the debugger=E2=80=99s state should be consistently before or
consistently after the wrapped state.  But this is just nitpicking.

Another nitpick: Is the prevailing style in subversion to use void *
for related context objects like edit_baton?  If not, I would suggest
using struct edit_baton * to document that that is always its
type; but if so, nothing to see here, please carry on.

> +struct file_baton
> +{
> +	void *edit_baton;
> +	void *wrapped_file_baton;
> +};

Similar.

[...]
> +static svn_error_t *set_target_revision(void *edit_baton,
> +					svn_revnum_t target_revision,
> +					apr_pool_t *pool)
> +{
> +	struct edit_baton *eb =3D edit_baton;
> +
> +	SVN_ERR(write_indent(eb, pool));
> +	SVN_ERR(svn_stream_printf(eb->out, pool, "set_target_revision : %ld=
\n",
> +				  target_revision));
> +
> +	return eb->wrapped_editor->set_target_revision(eb->wrapped_edit_bat=
on,
> +						       target_revision,
> +						       pool);
> +}

This is unfortunately long for how little it does.

C question (I=E2=80=99m just curious): would it be allowed to use

 static svn_Error_t *set_target_revision(struct edit_baton *eb,
	etc

In other words, does C allow a function with struct foo *
argument to be called through a pointer to function with void *
argument?

> +
> +static svn_error_t *open_root(void *edit_baton,
> +			      svn_revnum_t base_revision,
> +			      apr_pool_t *pool,
> +			      void **root_baton)
> +{
> +	struct edit_baton *eb =3D edit_baton;
> +	struct dir_baton *dir_baton =3D apr_palloc(pool, sizeof(*dir_baton)=
);
> +
> +	SVN_ERR(write_indent(eb, pool));
> +	SVN_ERR(svn_stream_printf(eb->out, pool, "open_root : %ld\n",
> +				  base_revision));
> +	eb->indent_level++;
> +
> +	SVN_ERR(eb->wrapped_editor->open_root(eb->wrapped_edit_baton,
> +					      base_revision,
> +					      pool,
> +					      &dir_baton->wrapped_dir_baton));
> +
> +	dir_baton->edit_baton =3D edit_baton;
> +
> +	*root_baton =3D dir_baton;
> +
> +	return SVN_NO_ERROR;
> +}

Similar.  Maybe:

	static svn_error_t *open_root(...
	{
		struct edit_baton *eb =3D edit_baton;
		struct dir_baton *dir_baton;

		SVN_ERR(write_indent...
		SVN_ERR(svn_stream_printf...

		dir_baton =3D apr_palloc(...
		dir_baton->edit_baton =3D eb;
		SVN_ERR(eb->wrapped_editor->open_root(...

		*root_baton =3D dir_baton;
		eb->indent_level++;
		return SVN_NO_ERROR;
	}

[...]
> +static svn_error_t *add_directory(const char *path,
[...]
> +static svn_error_t *open_directory(const char *path,
[...]
> +static svn_error_t *add_file(const char *path,
[...]
> +static svn_error_t *open_file(const char *path,

Similar.

> +static svn_error_t *close_file(void *file_baton,
> +			       const char *text_checksum,
> +			       apr_pool_t *pool)
> +{
> +	struct file_baton *fb =3D file_baton;
> +	struct edit_baton *eb =3D fb->edit_baton;
> +
> +	eb->indent_level--;
> +
> +	SVN_ERR(write_indent(eb, pool));
> +	SVN_ERR(svn_stream_printf(eb->out, pool, "close_file : %s\n",
> +				  text_checksum));
> +
> +	SVN_ERR(eb->wrapped_editor->close_file(fb->wrapped_file_baton,
> +					       text_checksum, pool));
> +
> +	return SVN_NO_ERROR;
> +}

The context pointers for each file and directory in each revision are
collected in a single pool and not freed, well, ever.  I assume that
is not a problem in practice; if it is, one can always start making
subpools later.

> +svn_error_t *svn_delta__get_debug_editor(const svn_delta_editor_t **=
editor,
> +					 void **edit_baton,
> +					 const svn_delta_editor_t *wrapped_editor,
> +					 void *wrapped_edit_baton,
> +					 apr_pool_t *pool)
> +{
> +	svn_delta_editor_t *tree_editor =3D svn_delta_default_editor(pool);
> +	struct edit_baton *eb =3D apr_palloc(pool, sizeof(*eb));
> +	apr_file_t *errfp;
> +	svn_stream_t *out;
> +
> +	apr_status_t apr_err =3D apr_file_open_stderr(&errfp, pool);
> +	if (apr_err)
> +		return svn_error_wrap_apr(apr_err, "Problem opening stderr");

Is there no function for this that returns svn_error_t *?

[...]
> +++ b/debug_editor.h
> @@ -0,0 +1,10 @@
> +#ifndef DEBUG_EDITOR_H_
> +#define DEBUG_EDITOR_H_
> +
> +svn_error_t *svn_delta__get_debug_editor(const svn_delta_editor_t **=
editor,
> +					 void **edit_baton,
> +					 const svn_delta_editor_t *wrapped_editor,
> +					 void *wrapped_edit_baton,
> +					 apr_pool_t *pool);

Usable from other code.  Caller provides the pool.  No example user
yet.

Well, it looks like it should work. :)

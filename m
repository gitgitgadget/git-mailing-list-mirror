From: Daniel Shahaf <daniel@shahaf.name>
Subject: Re: [WIP PATCH 1/7] Add skeleton RA svnclient
Date: Fri, 25 Jun 2010 12:07:31 +0300 (Jerusalem Daylight Time)
Message-ID: <alpine.561.2.00.1006251156180.2064@daniel2.local>
References: <1277310140-16891-1-git-send-email-artagnon@gmail.com> <1277310140-16891-2-git-send-email-artagnon@gmail.com> <20100625001427.GA4683@burratino>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1067593-17826-1277456857=:2064"
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 25 11:06:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OS4ry-00023V-PU
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 11:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752573Ab0FYJGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jun 2010 05:06:38 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:42507 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751858Ab0FYJGg (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jun 2010 05:06:36 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 60325104A9B;
	Fri, 25 Jun 2010 05:06:36 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 25 Jun 2010 05:06:36 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=smtpout; bh=iui3ciof1BeP16ZT75WEew7J4w0=; b=gkX5HjNchoXBnbyKtg27HLA2veIbdZCBcNamgjwm1N9RRuP7abGOvOjsOR7ggLlG4/M5ADBjWkBepmAwYVbSJW/KPkXjU9bfMh3NC+EMcA778ZXc8i0PCPYA9wyTYs3F9JvmimmO1nRVpLeywtPUmxOXLDHI3pBey/tqvbUId/M=
X-Sasl-enc: k2YPpRHy4h1OqCAw0CWFvoDcAgGJ5KGn71QmmJYqkpUWu4n2Jnt/wEiatrDGew 1277456795
Received: from daniel2.local (bzq-79-176-24-110.red.bezeqint.net [79.176.24.110])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B3D1F4E078;
	Fri, 25 Jun 2010 05:06:34 -0400 (EDT)
In-Reply-To: <20100625001427.GA4683@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149675>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1067593-17826-1277456857=:2064
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Jonathan Nieder wrote on Fri, 25 Jun 2010 at 03:14 -0000:
> Ramkumar Ramachandra wrote:
> 
> > In future, it will dump the data in every revision
> > to stdout in dumpfile format (hopefully) without resorting to the FS
> > API.
> 
> For now, just some naïve questions.  Warning: I know nothing about
> svn internals.
> 
> I assume this corresponds to the ra-svn branch of
> <http://github.com/artagnon/svn-dump-fast-export.git>.  Has the
> relevant code changed much since you sent it?
> 
> > --- /dev/null
> > +++ b/debug_editor.c
> > @@ -0,0 +1,413 @@
> > +#include "svn_pools.h"
> > +#include "svn_cmdline.h"
> > +#include "svn_client.h"
> > +#include "svn_ra.h"
> > +
> > +struct edit_baton
> 
> What is a baton?
> 

The context object for a callback.

You call:

    some_function(your_callback_function, your_baton)

which then calls:

    your_callback_function(your_baton, other_arguments)


> [...]
> > +  void *wrapped_edit_baton;
> [...]
> > +  void *edit_baton;
> > +  void *wrapped_dir_baton;
> [...]
> > +  void *edit_baton;
> > +  void *wrapped_file_baton;
> 
> Are these opaque types necessary?
> 

The convention in Subversion's code is to convert the void * to
a concrete_baton_t * only inside the callback.  If you wish to declare
these, e.g., as

    debug_editor_baton_t *wrapped_baton;

You can probably do that too.

> > +
> > +static svn_error_t *
> > +write_indent(struct edit_baton *eb, apr_pool_t *pool)
> > +{
> > +  int i;
> > +
> > +  for (i = 0; i < eb->indent_level; ++i)
> > +    SVN_ERR(svn_stream_printf(eb->out, pool, " "));
> > +
> > +  return SVN_NO_ERROR;
> > +}
> 
> What does this do?  Is SVN_ERR for debugging?

That's how we implement exception throwing in C.  SVN_ERR means "if this
returned a non-NULL svn_error_t *, then return that error to our
caller".

The other pattern does

    svn_error_t *err = svn_stream_printf();

and then inspects err and err->apr_err to decide whether to ignore the
error or return it (possibly wrapped).

> Where does the output go?
> 

SVN_ERR does not print anything.  It may return(), though.

> > +static svn_error_t *
> > +set_target_revision(void *edit_baton,
> > +                    svn_revnum_t target_revision,
> > +                    apr_pool_t *pool)
> [...]
> > +static svn_error_t *
> > +open_root(void *edit_baton,
> [...]
> > +static svn_error_t *
> > +close_edit(void *edit_baton,
> [...]
> 
> I take it these are callbacks?  Is there overview documentation for
> them somewhere?
> 

svn_delta_editor_t in
http://svn.apache.org/repos/asf/subversion/trunk/subversion/include/svn_delta.h

> > +svn_error_t *
> > +svn_delta__get_debug_editor(const svn_delta_editor_t **editor,
> > +                            void **edit_baton,
> > +                            const svn_delta_editor_t *wrapped_editor,
> > +                            void *wrapped_edit_baton,
> > +                            apr_pool_t *pool)
> > +{
> > +  svn_delta_editor_t *tree_editor = svn_delta_default_editor(pool);
> > +  struct edit_baton *eb = apr_palloc(pool, sizeof(*eb));
> > +  apr_file_t *errfp;
> > +  svn_stream_t *out;
> > +
> > +  apr_status_t apr_err = apr_file_open_stderr(&errfp, pool);
> > +  if (apr_err)
> > +    return svn_error_wrap_apr(apr_err, "Problem opening stderr");
> > +
> > +  out = svn_stream_from_aprfile2(errfp, TRUE, pool);
> > +
> > +  tree_editor->set_target_revision = set_target_revision;
> > +  tree_editor->open_root = open_root;
> > +  tree_editor->delete_entry = delete_entry;
> > +  tree_editor->add_directory = add_directory;
> > +  tree_editor->open_directory = open_directory;
> > +  tree_editor->change_dir_prop = change_dir_prop;
> > +  tree_editor->close_directory = close_directory;
> > +  tree_editor->absent_directory = absent_directory;
> > +  tree_editor->add_file = add_file;
> > +  tree_editor->open_file = open_file;
> > +  tree_editor->apply_textdelta = apply_textdelta;
> > +  tree_editor->change_file_prop = change_file_prop;
> > +  tree_editor->close_file = close_file;
> > +  tree_editor->absent_file = absent_file;
> > +  tree_editor->close_edit = close_edit;
> 
> I take it that the fields of svn_delta_editor_t do not have a
> well-defined order?  Ugh.
> 

I don't understand.  It seems that the fields here appear in the same
order as in the definition of struct svn_delta_editor_t.

> In any case, I suspect this would be easier to read rearranged a little:
> 
>  1. declarations for callbacks
>  2. get_debug_editor implementation
>  3. definitions of types not needed in get_debug_editor()
>  4. implementations of callbacks
> 
> That way, a person reading straight through can figure out what’s
> going on a little earlier.
> 
> > --- /dev/null
> > +++ b/svnclient_ra.c
> [...]
> > +int main()
> > +{
> > +	const char url[] = "http://svn.apache.org/repos/asf";
> > +	svn_revnum_t start_revision = 1, end_revision = 5;
> > +	if (svn_cmdline_init ("svnclient_ra", stderr) != EXIT_SUCCESS)
> > +		return 1;
> > +	pool = svn_pool_create(NULL);
> > +
> > +	SVN_INT_ERR(open_connection(url));
> > +	SVN_INT_ERR(replay_range(start_revision, end_revision));
> > +
> > +	close_connection();
> > +	return 0;
> > +}
> 
> What is svn_cmdline_init?

A Subversion API that does some necessary initializations (e.g., calls
apr_initialize()).  See subversion/include/svn_cmdline.h for docs
(and subversion/libsvn_subr/cmdline.c for the implementation).

> Is this code destined for inclusion in svn upstream, and if so, where
> can one find the surrounding code this should fit in with?
> 
> Jonathan
> 
--1067593-17826-1277456857=:2064--

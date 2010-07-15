From: Stefan Sperling <stsp@elego.de>
Subject: Re: [PATCH v2] Add svnrdump
Date: Thu, 15 Jul 2010 21:23:21 +0200
Message-ID: <20100715192321.GA722@ted.stsp.name>
References: <20100709142910.GB20383@debian>
 <20100713201105.GN13310@ted.stsp.name>
 <20100715190220.GI22574@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "dev@subversion.apache.org" <dev@subversion.apache.org>,
	Bert Huijben <rhuijben@collab.net>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Will Palmer <wmpalmer@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 15 21:24:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZU2v-0001Lr-7f
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 21:24:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934427Ab0GOTYc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jul 2010 15:24:32 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:44708 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934384Ab0GOTYb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 15:24:31 -0400
X-Envelope-From: stsp@stsp.name
Received: from ted.stsp.name (ted.stsp.name [217.197.84.186])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id o6FJNQY4020015
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 15 Jul 2010 21:23:26 +0200
Received: from ted.stsp.name (stsp@localhost [127.0.0.1])
	by ted.stsp.name (8.14.3/8.14.3) with ESMTP id o6FJNPjj024738;
	Thu, 15 Jul 2010 21:23:25 +0200 (CEST)
Received: (from stsp@localhost)
	by ted.stsp.name (8.14.3/8.14.3/Submit) id o6FJNLF0032561;
	Thu, 15 Jul 2010 21:23:21 +0200 (CEST)
Mail-Followup-To: Ramkumar Ramachandra <artagnon@gmail.com>,
	"dev@subversion.apache.org" <dev@subversion.apache.org>,
	Bert Huijben <rhuijben@collab.net>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Will Palmer <wmpalmer@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100715190220.GI22574@debian>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151115>

On Thu, Jul 15, 2010 at 09:02:20PM +0200, Ramkumar Ramachandra wrote:
> Stefan Sperling writes:
> > > +};
> > > +
> > > +struct handler_baton
> > > +{
> > > +  svn_txdelta_window_handler_t apply_handler;
> > > +  void *apply_baton;
> > > +  apr_pool_t *pool;
> > 
> > Yet another pool. What's it for?
> 
> See window_handler below :)

Oops, I meant to imply that you should add a docstring :)

> > > +  }
> > > +  else
> > > +    full_path = apr_pstrdup(pool, "/");
> > 
> > Why allocate "/" in a pool? This can be static string unless you
> > intend to write to it.
> 
> Frankly, working with APR pools was quite a nightmare for me- after
> observing many cases of leaks and crashes, I jotted down some notes
> about using them and I made it a point to follow them strictly. This
> alloc adheres to those notes. I'll submit those notes to dev@ once
> I've polished them- new devs will probably find it useful.

It's not that hard once you get used to the concept.
When you send your notes, we can comment on them in case there's
anything you misunderstood.

> > > +  if (val)
> > > +    /* Delete the path, it's now been dumped */
> > > +    apr_hash_set(pb->deleted_entries, path, APR_HASH_KEY_STRING, NULL);
> > 
> > You don't need to set the value to NULL in the hash table.
> > Doing so won't save any memory. I've say just remove the above 3 lines.
> 
> Oh, I'm not doing it to save memory. Although I'm not sure if I still
> need it in my logic, this definitely makes debugging nicer.

Then please say so in the comment:

 /* Small debugging aid: set path to NULL so we crash if we use it again. */

> > > +  /* Write information about the filepath to hb->eb */
> > 
> > s/to hb->eb/from the handler baton to the edit baton/
> 
> Er, I did mean `hb->eb` literally (the editor baton in the handler
> baton).

Ah, right. Though maybe saying "edit baton" is just as clear?

> > > +static int verbose = 0;
> > > +static apr_pool_t *pool = NULL;
> > > +static svn_client_ctx_t *ctx = NULL;
> > 
> > You're only using the client context in open_connection.
> > Make it a local variable there?
> 
> I was actually worried about lifetime issues. If ctx won't be read/
> written after open_connection, this is okay. Otherwise, not. TODO.

The global variables are still wrong.
Just pass the root pool you create in main() down to open_connection()
and use it when creating the client context. There won't be a lifetime
problem.

> > > +    "usage: svnrdump URL [-r LOWER[:UPPER]]\n\n"
> > 
> > This string needs to be marked for localisation like this: _("my string")
> 
> TODO. I'm missing some header: _ is undefined.

#include "svn_private_config.h"

> > > +    "Dump the contents of repository at remote URL to stdout in a 'dumpfile'\n"
> > > +    "v3 portable format.  Dump revisions LOWER rev through UPPER rev.\n"
> > 
> > You don't need to mention the dumpfile format version in the help
> > string.
> 
> Okay. I need to mention somewhere that svnrdump doesn't support
> undeltified dumps though, don't I?

Not yet. My plan is to ask people why we're not using the v3 format
by default. Unless there is a good reason not to do so I'd like to
make v3 the default format for svnadmin dump in 1.7.

> > > +    "LOWER defaults to 1 and UPPER defaults to the highest possible revision\n"
> > > +    "if omitted.\n");
> > > +  for (i = 1; i < argc; i++) {
> > 
> > Please use svn_cmdline__getopt_init() and apr_getopt_long().
> > See svnsync for an example.
> 
> Ouch. Don't you think it's an overkill for the current svnrdump? There
> are no subcommands and just a few command-line arguments.

The point is to have consistent code.

> > Please add a docstring.
> > 
> > > +svn_error_t *
> > > +dump_props(struct dump_edit_baton *eb,
> > > +           svn_boolean_t *trigger_var,
> > > +           svn_boolean_t dump_data_too,
> > > +           apr_pool_t *pool);
> > > +
> > > +#endif
> 
> Fixed. Doxygen-friendly docstrings are a TODO.

You only need to be doxygen-friendly in the public headers,
which are the ones in subversion/include.

> > > +void
> > > +write_hash_to_stringbuf(apr_hash_t *properties,
> > > +                        svn_boolean_t deleted,
> > > +                        svn_stringbuf_t **strbuf,
> > > +                        apr_pool_t *pool)
> > > +{
> > 
> > This function needs a docstring, too.
> 
> Wait. I just need to write the docstrings once, right? In the header?

Right. It goes in the header, unless the function is static. My bad.

> You can see the changes I made after your review in the most recent
> couple of commits on my GitHub [1].
> 
> [1]: http://github.com/artagnon/svn-dump-fast-export/commits/svn-merge

Thanks!

Stefan

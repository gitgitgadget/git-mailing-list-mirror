From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH v5 1/3] Teach revision walking machinery to walk
	multiple times sequencially
Date: Mon, 26 Mar 2012 21:32:52 +0200
Message-ID: <20120326193241.GA41087@book.hvoigt.net>
References: <20120213092541.GA15585@t1405.greatnet.de> <20120213092730.GB15585@t1405.greatnet.de> <7vfwee9p1t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Fredrik Gustafsson <iveqy@iveqy.com>,
	Jens Lehmann <jens.lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 21:33:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCFf3-00052j-Qd
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 21:33:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754944Ab2CZTc4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 15:32:56 -0400
Received: from darksea.de ([83.133.111.250]:49961 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753564Ab2CZTcz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 15:32:55 -0400
Received: (qmail 23863 invoked from network); 26 Mar 2012 21:32:52 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 26 Mar 2012 21:32:52 +0200
Content-Disposition: inline
In-Reply-To: <7vfwee9p1t.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193961>

Hi,

sorry that my reply to this took quite some time.

On Mon, Feb 13, 2012 at 05:33:34PM -0800, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
> > Previously it was not possible to iterate revisions twice using the
> > revision walking api. We add a reset_revision_walk() which clears the
> > used flags. This allows us to do multiple sequencial revision walks.
> >
> > Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> 
> I am kind of surprised that this is already its 5th round.

Well, not this patch in particular but the series so I chose to it for
the whole series.

> Minimally,
> 
>         void clear_object_flags(unsigned flags)
>         {
>                 int i;
> 
>                 for (i = 0; i < obj_hash_size; i++) {
>                         struct object *obj = obj_hash[i];
>                         if (obj && (obj->flags & flags))
>                                 obj->flags &= ~flags;
>                 }
>         }
> 
> I am not sure if the "If there is any bit set we care about, drop them"
> buys us anything, though.

Ok done. And also dropped the "if there is any bit set" condition.

> > +void reset_revision_walk()
> 
> 	void reset_revision_walk(void)

Done.

> > +{
> > +	clear_object_flags(SEEN | ADDED | SHOWN);
> > +}
> 
> But is this really the right API?  After a particular program finishes
> using the revision walker, wouldn't it want to clear both the set of these
> standard flag bits used by the traversal machinery, as well as whatever
> program specific bits it used to mark the objects with?

Well if a program uses extra flags on objects it should clear the flags
it set by using the clear_objects_flags() function itself. For example if
the program wants to reuse those extra flags in a second revision walk
it would not be possible if reset_revision_walk() would clear all flags.

> > diff --git a/revision.h b/revision.h
> > index b8e9223..3535733 100644
> > --- a/revision.h
> > +++ b/revision.h
> > @@ -192,6 +192,7 @@ extern void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ct
> >  ...
> > +extern void reset_revision_walk();
> 
> Likewise, "extern void reset_revision_walk(void);".

Done.

> 
> > diff --git a/submodule.c b/submodule.c
> > index 9a28060..645ff5d 100644
> > --- a/submodule.c
> > +++ b/submodule.c
> > @@ -404,6 +404,7 @@ int check_submodule_needs_pushing(unsigned char new_sha1[20], const char *remote
> >  	while ((commit = get_revision(&rev)) && !needs_pushing)
> >  		commit_need_pushing(commit, &needs_pushing);
> >  
> > +	reset_revision_walk();
> >  	free(sha1_copy);
> >  	strbuf_release(&remotes_arg);
> >  
> > @@ -741,6 +742,7 @@ static int find_first_merges(struct object_array *result, const char *path,
> >  		if (in_merge_bases(b, &commit, 1))
> >  			add_object_array(o, NULL, &merges);
> >  	}
> > +	reset_revision_walk();
> >  
> >  	/* Now we've got all merges that contain a and b. Prune all
> >  	 * merges that contain another found merge and save them in
> 
> These two hunk look like a *BUGFIX* to me (certainly it does not look like
> this is an addition of any new feature).
> 
> What bug does this fix, and how is the current submodule code broken
> without this patch?  Can you describe the problem in the log message, and
> add a test to demonstrate the existing breakage?

There is no breakage I know of. Its rather a cleanup which allows to
call these functions multiple times. I did this to avoid surprises.
Should I put these in a separate patch or just add an explanation into
the current one?

Cheers Heiko

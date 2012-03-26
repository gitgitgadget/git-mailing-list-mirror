From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH v5 2/3] Refactor submodule push check to use string
	list instead of integer
Date: Mon, 26 Mar 2012 21:33:18 +0200
Message-ID: <20120326193317.GB41087@book.hvoigt.net>
References: <20120213092541.GA15585@t1405.greatnet.de> <20120213092900.GC15585@t1405.greatnet.de> <7vbop29jqf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Fredrik Gustafsson <iveqy@iveqy.com>,
	Jens Lehmann <jens.lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 21:33:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCFfR-0005KT-Im
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 21:33:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754404Ab2CZTdU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 15:33:20 -0400
Received: from darksea.de ([83.133.111.250]:49965 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754034Ab2CZTdU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 15:33:20 -0400
Received: (qmail 23873 invoked from network); 26 Mar 2012 21:33:18 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 26 Mar 2012 21:33:18 +0200
Content-Disposition: inline
In-Reply-To: <7vbop29jqf.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193962>

On Mon, Feb 13, 2012 at 07:28:24PM -0800, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> > diff --git a/submodule.c b/submodule.c
> > index 645ff5d..3c714c2 100644
> > --- a/submodule.c
> > +++ b/submodule.c
> > @@ -357,21 +357,20 @@ static void collect_submodules_from_diff(struct diff_queue_struct *q,
> >  					 void *data)
> >  {
> >  	int i;
> > -	int *needs_pushing = data;
> > +	struct string_list *needs_pushing = data;
> >  
> >  	for (i = 0; i < q->nr; i++) {
> >  		struct diff_filepair *p = q->queue[i];
> >  		if (!S_ISGITLINK(p->two->mode))
> >  			continue;
> >  		if (submodule_needs_pushing(p->two->path, p->two->sha1)) {
> > -			*needs_pushing = 1;
> > -			break;
> > +			if (!string_list_has_string(needs_pushing, p->two->path))
> > +				string_list_insert(needs_pushing, p->two->path);
> 
> Does string_list API have "look for this and insert if it doesn't exist
> but otherwise don't do anything"?  Running get_entry_index() to answer
> has_string() once and then calling it again to find where to insert to
> respond to insert() looks a bit wasteful.
> 
> Just wondering.

If I see correctly currently it has no such functionality. I can have a
look at adding another patch implementing this.


> > -
> > -static void commit_need_pushing(struct commit *commit, int *needs_pushing)
> > +static void commit_need_pushing(struct commit *commit, struct string_list *needs_pushing)
> >  {
> >  	struct rev_info rev;
> >  
> > @@ -382,14 +381,15 @@ static void commit_need_pushing(struct commit *commit, int *needs_pushing)
> >  	diff_tree_combined_merge(commit, 1, &rev);
> >  }
> >  
> > -int check_submodule_needs_pushing(unsigned char new_sha1[20], const char *remotes_name)
> > +int check_submodule_needs_pushing(unsigned char new_sha1[20],
> > +		const char *remotes_name, struct string_list *needs_pushing)
> >  {
> >  	struct rev_info rev;
> >  	struct commit *commit;
> >  	const char *argv[] = {NULL, NULL, "--not", "NULL", NULL};
> >  	int argc = ARRAY_SIZE(argv) - 1;
> >  	char *sha1_copy;
> > -	int needs_pushing = 0;
> > +
> >  	struct strbuf remotes_arg = STRBUF_INIT;
> >  
> >  	strbuf_addf(&remotes_arg, "--remotes=%s", remotes_name);
> > @@ -401,14 +401,14 @@ int check_submodule_needs_pushing(unsigned char new_sha1[20], const char *remote
> >  	if (prepare_revision_walk(&rev))
> >  		die("revision walk setup failed");
> >  
> > -	while ((commit = get_revision(&rev)) && !needs_pushing)
> > -		commit_need_pushing(commit, &needs_pushing);
> > +	while ((commit = get_revision(&rev)) != NULL)
> > +		commit_need_pushing(commit, needs_pushing);
> 
> Now the helper function to find list of submodules that need pushing given
> one commit starting to look more and more misnamed.  It used to be "learn
> if something needs pushing", but now it is "find what needs pushing".
> 
> Can somebody think of a good adjective to describe a submodule (or a set
> of submodules) in this state, so that we can name this helper function
> find_blue_submodules(), if the adjective were "blue"?
> 
> "Unpushed" submodule is the word used in the later part of the patch.

So why not use unpushed as the adjective? find_unpushed_submodules()
sound good to me. Will change the patch accordingly. Since we are
already discussing renaming should I also rename commit_need_pushing()
to find_unpushed_submodule_commits()? I think that would make the whole
naming more consistent.

Cheers Heiko

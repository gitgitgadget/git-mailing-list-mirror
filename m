From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH v3 11/19] dir.c: use a single struct exclude_list per
 source of excludes
Date: Sun, 6 Jan 2013 15:20:39 +0000
Message-ID: <20130106152039.GA2396@pacific.linksys.moosehall>
References: <1356575558-2674-1-git-send-email-git@adamspiers.org>
 <1356575558-2674-12-git-send-email-git@adamspiers.org>
 <7v1ue0veww.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 06 16:21:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Trs28-0006pS-J1
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 16:21:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756043Ab3AFPUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 10:20:46 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:45363 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756039Ab3AFPUo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 10:20:44 -0500
Received: from localhost (f.4.d.7.f.d.e.f.f.f.3.7.3.0.a.1.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:1a03:73ff:fedf:7d4f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id ADC152E5D3
	for <git@vger.kernel.org>; Sun,  6 Jan 2013 15:20:40 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7v1ue0veww.fsf@alter.siamese.dyndns.org>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212807>

On Fri, Jan 04, 2013 at 01:03:59PM -0800, Junio C Hamano wrote:
> Adam Spiers <git@adamspiers.org> writes:
> 
> > diff --git a/builtin/clean.c b/builtin/clean.c
> > index 0c7b3d0..bd18b88 100644
> > --- a/builtin/clean.c
> > +++ b/builtin/clean.c
> > @@ -97,9 +97,10 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
> >  	if (!ignored)
> >  		setup_standard_excludes(&dir);
> >  
> > +	add_exclude_list(&dir, EXC_CMDL);
> >  	for (i = 0; i < exclude_list.nr; i++)
> >  		add_exclude(exclude_list.items[i].string, "", 0,
> > -			    &dir.exclude_list[EXC_CMDL]);
> > +			    &dir.exclude_list_groups[EXC_CMDL].ary[0]);
> 
> This looks somewhat ugly for two reasons.
> 
>  * The abstraction add_exclude() offers to its callers is just to
>    let them add one pattern to the list of patterns for the kind
>    (here, EXC_CMDL); why should they care about .ary[0] part?

Because the caller has to decide which exclude list the new exclude
should be added to; that is how it has been for a long time, and I am
not proposing we change that.

There are currently three callers:

  builtin/clean.c:    cmd_clean()
  builtin/ls-files.c: option_parse_exclude()
  dir.c:              add_excludes_from_file_to_list()

The first two add to EXC_CMDL, but the latter could be adding to
numerous different possible lists, e.g.

    - .git/info/exclude (EXC_FILE)
    - core.excludesfile (EXC_FILE)
    - any of the per-directory .gitignore lists (EXC_DIRS)

>    Are
>    there cases any sane caller (not the implementation of the
>    exclude_list_group machinery e.g. add_excludes_from_... function)
>    may want to call it with .ary[1]?

Effectively yes, although it is not written like ".ary[1]".  For
example prep_exclude() calls add_excludes_from_file_to_list() for each
new .gitignore file

>    Shouldn't the public API function add_exclude() take a pointer to
>    the list group itself?

Typically EXC_DIRS and EXC_FILE will contain excludes from multiple
sources, whereas EXC_CMDL will contain excludes from a single source.

Therefore when transitioning to exclude_list_groups, I had to make a
choice whether to keep EXC_CMDL as a singleton list, or split it out
into a separate field in struct dir_struct, e.g.:

	struct exclude_list exclude_list_cmdl;
	struct exclude_list exclude_list[2];
#define EXC_DIRS 0
#define EXC_FILE 1

I decided it was cleaner to use a singleton list, because this
preserved the design that excludes in earlier members of
exclude_list[3] take priority over excludes in later members of
exclude_list[3].  That way, this loop in last_exclude_matching():

	for (i = EXC_CMDL; i <= EXC_FILE; i++) {

still makes sense.

>  * When naming an array of things, we tend to prefer naming it
> 
>      type thing[count]
> 
>    so that the second element can be called "thing[2]" and not
>    "things[2]".  dir.exclude_list_group[EXC_CMDL] reads beter.

OK, I will change that.

> > diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> > index ef7f99a..c448e06 100644
> > --- a/builtin/ls-files.c
> > +++ b/builtin/ls-files.c
> > @@ -420,10 +420,10 @@ static int option_parse_z(const struct option *opt,
> >  static int option_parse_exclude(const struct option *opt,
> >  				const char *arg, int unset)
> >  {
> > -	struct exclude_list *list = opt->value;
> > +	struct exclude_list_group *group = opt->value;
> >  
> >  	exc_given = 1;
> > -	add_exclude(arg, "", 0, list);
> > +	add_exclude(arg, "", 0, &group->ary[0]);
> 
> This is another example where the caller would wish to be able to say
> 
> 	add_exclude(arg, "", 0, group);
> 
> instead.

Why?  The caller needs to decide which exclude list the exclude should
go on, because that determines matching priority.  Specifying an
exclude_list_group is insufficient information to determine that.

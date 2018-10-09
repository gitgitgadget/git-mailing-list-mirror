Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D84011F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 13:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbeJIVI2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 17:08:28 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:9987 "EHLO
        mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726445AbeJIVI2 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 9 Oct 2018 17:08:28 -0400
X-IronPort-AV: E=Sophos;i="5.54,360,1534802400"; 
   d="scan'208";a="281560780"
Received: from 89-157-201-244.rev.numericable.fr (HELO hadrien) ([89.157.201.244])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2018 15:51:23 +0200
Date:   Tue, 9 Oct 2018 15:51:22 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git log -S or -G
In-Reply-To: <87lg77cmr1.fsf@evledraar.gmail.com>
Message-ID: <alpine.DEB.2.21.1810091549530.2430@hadrien>
References: <alpine.DEB.2.21.1810061712260.2402@hadrien> <CACBZZX6PmG=-8563eYE4z98yvHePenZf_Kz1xgpse0ngjB5QyA@mail.gmail.com> <xmqqd0smvay0.fsf@gitster-ct.c.googlers.com> <alpine.DEB.2.21.1810070719200.2347@hadrien> <xmqq8t38t4r7.fsf@gitster-ct.c.googlers.com>
 <20181009032124.GE6250@sigill.intra.peff.net> <xmqqwoqrr8y2.fsf@gitster-ct.c.googlers.com> <87lg77cmr1.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-402867390-1539093083=:2430"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-402867390-1539093083=:2430
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT



On Tue, 9 Oct 2018, Ævar Arnfjörð Bjarmason wrote:

>
> On Tue, Oct 09 2018, Junio C Hamano wrote:
>
> > Jeff King <peff@peff.net> writes:
> >
> >> I think that is the best we could do for "-S", though, which is
> >> inherently about counting hits.
> >>
> >> For "-G", we are literally grepping the diff. It does not seem
> >> unreasonable to add the ability to grep only "-" or "+" lines, and the
> >> interface for that should be pretty straightforward (a tri-state flag to
> >> look in remove, added, or both lines).
> >
> > Yeah, here is a lunchtime hack that hasn't even been compile tested.
> >
> >  diff.c             |  4 ++++
> >  diff.h             |  2 ++
> >  diffcore-pickaxe.c | 22 ++++++++++++++++++++--
> >  3 files changed, 26 insertions(+), 2 deletions(-)
> >
> > diff --git a/diff.c b/diff.c
> > index f0c7557b40..d1f2780844 100644
> > --- a/diff.c
> > +++ b/diff.c
> > @@ -5068,6 +5068,10 @@ int diff_opt_parse(struct diff_options *options,
> >  	}
> >  	else if (!strcmp(arg, "--pickaxe-all"))
> >  		options->pickaxe_opts |= DIFF_PICKAXE_ALL;
> > +	else if (!strcmp(arg, "--pickaxe-ignore-add"))
> > +		options->pickaxe_opts |= DIFF_PICKAXE_IGNORE_ADD;
> > +	else if (!strcmp(arg, "--pickaxe-ignore-del"))
> > +		options->pickaxe_opts |= DIFF_PICKAXE_IGNORE_DEL;
> >  	else if (!strcmp(arg, "--pickaxe-regex"))
> >  		options->pickaxe_opts |= DIFF_PICKAXE_REGEX;
> >  	else if ((argcount = short_opt('O', av, &optarg))) {
> > diff --git a/diff.h b/diff.h
> > index a30cc35ec3..147c47ace7 100644
> > --- a/diff.h
> > +++ b/diff.h
> > @@ -358,6 +358,8 @@ int git_config_rename(const char *var, const char *value);
> >  				 DIFF_PICKAXE_KIND_OBJFIND)
> >
> >  #define DIFF_PICKAXE_IGNORE_CASE	32
> > +#define DIFF_PICKAXE_IGNORE_ADD	64
> > +#define DIFF_PICKAXE_IGNORE_DEL 128
> >
> >  void diffcore_std(struct diff_options *);
> >  void diffcore_fix_diff_index(struct diff_options *);
> > diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
> > index 800a899c86..826dde6bd4 100644
> > --- a/diffcore-pickaxe.c
> > +++ b/diffcore-pickaxe.c
> > @@ -16,6 +16,7 @@ typedef int (*pickaxe_fn)(mmfile_t *one, mmfile_t *two,
> >
> >  struct diffgrep_cb {
> >  	regex_t *regexp;
> > +	struct diff_options *diff_options;
> >  	int hit;
> >  };
> >
> > @@ -23,9 +24,14 @@ static void diffgrep_consume(void *priv, char *line, unsigned long len)
> >  {
> >  	struct diffgrep_cb *data = priv;
> >  	regmatch_t regmatch;
> > +	unsigned pickaxe_opts = data->diff_options->pickaxe_opts;
> >
> >  	if (line[0] != '+' && line[0] != '-')
> >  		return;
> > +	if ((pickaxe_opts & DIFF_PICKAXE_IGNORE_ADD) &&	line[0] == '+')
> > +		return;
> > +	if ((pickaxe_opts & DIFF_PICKAXE_IGNORE_DEL) &&	line[0] == '-')
> > +		return;
> >  	if (data->hit)
> >  		/*
>
> Looks good, but I wonder if a more general version of this couldn't be
> that instead of returning early if the line doesn't start with +/-
> above, we have an option to skip that early return.
>
> Then you can simply specify a regex that starts by matching a + or - at
> the start of the line, but you also get the poweruser tool of matching
> lines around those lines, as tweaked by the -U option. I.e. this:
>
> diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
> index 800a899c86..90625a110c 100644
> --- a/diffcore-pickaxe.c
> +++ b/diffcore-pickaxe.c
> @@ -24,15 +24,13 @@ static void diffgrep_consume(void *priv, char *line, unsigned long len)
>         struct diffgrep_cb *data = priv;
>         regmatch_t regmatch;
>
> -       if (line[0] != '+' && line[0] != '-')
> -               return;
>         if (data->hit)
>                 /*
>                  * NEEDSWORK: we should have a way to terminate the
>                  * caller early.
>                  */
>                 return;
> -       data->hit = !regexec_buf(data->regexp, line + 1, len - 1, 1,
> +       data->hit = !regexec_buf(data->regexp, line, len, 1,
>                                  &regmatch, 0);
>  }
>
> That patch obviously breaks existing -G, so it would need to be
> optional, but allows me e.g. on git.git to do:
>
>     ~/g/git/git --exec-path=/home/avar/g/git log -G'^ .*marc\.info' -p -U2 -- README.md
>
> To find a change whose first line of context is a line mentioning
> marc.info, and then I can use -G'^\+<rx>' to find added lines matching
> <rx> etc.

Do -G's accumulate?  I had the impression that only the last one was taken
into account, but I didn't check the code on that.

julia

>
> Then the --pickaxe-ignore-add and --pickaxe-ignore-del options in your
> patch could just be implemented in terms of that feature, i.e. by
> implicitly adding a "^-" or "^\+" to the beginning of the regex,
> respectively, and implicitly turning on a new --pickaxe-raw-lines or
> whatever we'd call it.
>
> >  		 * NEEDSWORK: we should have a way to terminate the
> > @@ -45,13 +51,20 @@ static int diff_grep(mmfile_t *one, mmfile_t *two,
> >  	xpparam_t xpp;
> >  	xdemitconf_t xecfg;
> >
> > -	if (!one)
> > +	if (!one) {
> > +		if (o->pickaxe_opts & DIFF_PICKAXE_IGNORE_ADD)
> > +			return 0;
> >  		return !regexec_buf(regexp, two->ptr, two->size,
> >  				    1, &regmatch, 0);
> > -	if (!two)
> > +	}
> > +	if (!two) {
> > +		if (o->pickaxe_opts & DIFF_PICKAXE_IGNORE_DEL)
> > +			return 0;
> >  		return !regexec_buf(regexp, one->ptr, one->size,
> >  				    1, &regmatch, 0);
> > +	}
> >
> > +	ecbdata.diff_options = o;
> >  	/*
> >  	 * We have both sides; need to run textual diff and see if
> >  	 * the pattern appears on added/deleted lines.
> > @@ -113,6 +126,11 @@ static int has_changes(mmfile_t *one, mmfile_t *two,
> >  {
> >  	unsigned int one_contains = one ? contains(one, regexp, kws) : 0;
> >  	unsigned int two_contains = two ? contains(two, regexp, kws) : 0;
> > +
> > +	if (o->pickaxe_opts & DIFF_PICKAXE_IGNORE_ADD)
> > +		return one_contains > two_contains;
> > +	if (o->pickaxe_opts & DIFF_PICKAXE_IGNORE_DEL)
> > +		return one_contains < two_contains;
> >  	return one_contains != two_contains;
> >  }
> >
>
--8323329-402867390-1539093083=:2430--

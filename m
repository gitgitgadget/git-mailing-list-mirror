From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Fix mkpath abuse in dwim_ref/sha1_name.c
Date: Wed, 15 Oct 2008 08:20:40 +0200
Message-ID: <20081015062039.GA3775@blimp.localdomain>
References: <81b0412b0810140923x5cf58bb9x5acd1517a19e9847@mail.gmail.com> <7viqru6a1r.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 08:27:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kpzql-0004Ic-4b
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 08:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbYJOGZ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 02:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbYJOGZ6
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 02:25:58 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.182]:37209 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbYJOGZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 02:25:58 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :Pm0FVUW6aauhRGJJc5OfA4AU8DM8ZlijdmJYxKn/UQvEQQx9CE89oqE=
Received: from tigra.home (Fa961.f.strato-dslnet.de [195.4.169.97])
	by post.webmailer.de (klopstock mo47) (RZmta 17.11)
	with ESMTP id K0178bk9F4fBsi ; Wed, 15 Oct 2008 08:25:55 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp.localdomain (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id D3222277C8;
	Wed, 15 Oct 2008 08:25:54 +0200 (CEST)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 749BF36D28; Wed, 15 Oct 2008 08:20:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7viqru6a1r.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98235>

Junio C Hamano, Wed, Oct 15, 2008 01:17:52 +0200:
> "Alex Riesen" <raa.lkml@gmail.com> writes:
> >
> > Otherwise the function sometimes fail to resolve obviously correct refnames,
> > because the string data pointed to by "ref" argument were reused.
> >
> But your patch instead rewrites the computation of str2 by bypassing the
> call to "another_function_that_uses_get_pathname()" and duplicating its
> logic, which I do not think is a viable approach in the longer term.

There is not enough logic to bypass there. It's just a dumb sprintf!
I actually saved a useless call (two, if automatic inlining
optimization doesn't work).

> > diff --git a/sha1_name.c b/sha1_name.c
> > index 41b6809..b5b53bf 100644
> > --- a/sha1_name.c
> > +++ b/sha1_name.c
> > @@ -242,6 +242,7 @@ int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
> >  {
> >  	const char **p, *r;
> >  	int refs_found = 0;
> > +	char fullref[PATH_MAX];
> >  
> >  	*ref = NULL;
> >  	for (p = ref_rev_parse_rules; *p; p++) {
> > @@ -249,7 +250,8 @@ int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
> >  		unsigned char *this_result;
> >  
> >  		this_result = refs_found ? sha1_from_ref : sha1;
> > -		r = resolve_ref(mkpath(*p, len, str), this_result, 1, NULL);
> > +		snprintf(fullref, sizeof(fullref), *p, len, str);
> > +		r = resolve_ref(fullref, this_result, 1, NULL);
> >  		if (r) {
> >  			if (!refs_found++)
> >  				*ref = xstrdup(r);
> 
> I suspect that I am grossly misleading the code, but I wonder why this xstrdup()
> is not protecting us from the reusing of "the string data pointed to by
> "ref" argument".  Are you fixing the overwriting of the string pointed to
> by "str" argument instead?

Yes, I mistyped. xstrdup's called after the breakage happened.

> What specific call chain has this breakage you found?

That's up to this function from builtin_rev_parse and resolve_ref
we're about to call.

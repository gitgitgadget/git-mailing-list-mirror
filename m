From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] diff: Support diff.color-words config option
Date: Tue, 20 Jan 2009 18:28:14 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901201819490.5159@intel-tinevez-2-302>
References: <alpine.DEB.1.00.0901162208180.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901200031350.3586@pacific.mpi-cbg.de> <200901192017.54163.bss@iguanasuicide.net> <200901192145.21115.bss@iguanasuicide.net> <alpine.DEB.1.00.0901201058520.3586@pacific.mpi-cbg.de>
 <7vskndkip9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	=?ISO-8859-15?Q?Santi_B=E9jar?= <santi@agolina.net>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Teemu Likonen <tlikonen@iki.fi>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 20 18:29:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPKQF-0001nM-Ty
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 18:29:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758190AbZATR2b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 12:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757069AbZATR2b
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 12:28:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:44876 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756151AbZATR2a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 12:28:30 -0500
Received: (qmail invoked by alias); 20 Jan 2009 17:28:28 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp038) with SMTP; 20 Jan 2009 18:28:28 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19rZxAayxlrB0Nw/TGk0pGFIWrke1R4lmvlWZwY+y
	fdOIAOIbBR2M0y
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7vskndkip9.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106500>

Hi,

On Tue, 20 Jan 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> @@ -92,6 +93,8 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
> >>  	}
> >>  	if (!strcmp(var, "diff.external"))
> >>  		return git_config_string(&external_diff_cmd_cfg, var, value);
> >> +	if (!strcmp(var, "diff.color-words"))
> >
> > I'd call it diff.wordregex, because that's what it is.
> 
> If we want to add a new word-oriented option to diff that is not about 
> coloring the word differences, is it safe and sane to reuse the same 
> definition?  That is, "git diff --color-words" would be affected when 
> diff.wordregex is set to some value, so does any new word-oriented 
> operation we will add, and the single regex configured would be used as 
> the default value to define how a word would look like.
> 
> I think it makes sense; I do not think of a case offhand where you would 
> want to define what a word is for the purpose of coloring diffs in one 
> way, and would want to use a different definition for another 
> word-oriented operation.

Why not cross that bridge when we're there?  Should we ever feel the need 
for different word regexes, we would just introduce color.wordregex.

> >> @@ -1550,6 +1553,8 @@ static void builtin_diff(const char *name_a,
> >>  				o->word_regex = userdiff_word_regex(one);
> >>  			if (!o->word_regex)
> >>  				o->word_regex = userdiff_word_regex(two);
> >> +			if (!o->word_regex)
> >> +				o->word_regex = diff_color_words_cfg;
> >
> > IMHO this is the wrong order.  config should not override attributes, 
> > which are by definition more specific.
> 
> Isn't it merely giving a fallback value when attributes does not give one?

Yep.  Boyd (or Stephen, as he wants to be called, making it hard to guess 
from his email address, but that's all part of the fun, in't it?) already 
realized that I was up too late and got the order wrong myself.

> By the way, wouldn't it make sense to optimize the precontext of that 
> hunk by doing _something_ like:
> 
> 	if (!o->word_regex && strcmp(one->path, two->path))
>         	o->word_regex = userdiff_word_regex(two);
> 
> "Something like" comes from special cases like /dev/null for new/deleted
> files, etc.

You mean to avoid the cost of initializing the regex in case one and the 
same file is diffed against itself?  But that would be better handled 
before calling builtin_diff(), don't you think?

I do not know off-hand if diffcore_std() handles that already, so that the 
diff_flush() ... builtin_diff() cascade is not even called.

But you raise a valid concern: the regular expression is initialized every 
time we look at a file.  We probably should have a member 
word_regex_compiled in diff_options, then, and only initialize it the 
first time.

Ciao,
Dscho "who does not have the time to work on Git right now"

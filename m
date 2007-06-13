From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Interpret :/<pattern> as a regular expression
Date: Wed, 13 Jun 2007 12:10:42 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706131143590.4059@racer.site>
References: <Pine.LNX.4.64.0706130148080.4059@racer.site>
 <7vr6ogh2w7.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 13:14:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyQnj-0004p6-Qk
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 13:14:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756675AbXFMLOH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 07:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756281AbXFMLOG
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 07:14:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:43680 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755082AbXFMLOF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 07:14:05 -0400
Received: (qmail invoked by alias); 13 Jun 2007 11:14:02 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp041) with SMTP; 13 Jun 2007 13:14:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX196wrtcIdt62nGcR+ErDx0dX7neL7tT32N4fbSzsD
	ckO2fKAPTPQ5tp
X-X-Sender: gene099@racer.site
In-Reply-To: <7vr6ogh2w7.fsf@assigned-by-dhcp.pobox.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50046>

Hi,

On Tue, 12 Jun 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > diff --git a/sha1_name.c b/sha1_name.c
> > index d9188ed..f1ba194 100644
> > --- a/sha1_name.c
> > +++ b/sha1_name.c
> > @@ -611,6 +611,8 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1)
> >  {
> >  	struct commit_list *list = NULL, *backup = NULL, *l;
> >  	int retval = -1;
> > +	regex_t regexp;
> > +	regmatch_t regmatch[1];
> >  
> >  	if (prefix[0] == '!') {
> >  		if (prefix[1] != '!')
> 
> Because you are not extracting any match substring, I do not
> think you would need regmatch[] there.

I explicitely want to anchor the match at the beginning of the message 
(otherwise, most of the interesting patterns would match a merge pulling 
that commit in), and therefore I have to check where the match was. Alas, 
that's only possible with regmatch.

> > @@ -622,6 +624,8 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1)
> >  	for_each_ref(handle_one_ref, &list);
> >  	for (l = list; l; l = l->next)
> >  		commit_list_insert(l->item, &backup);
> > +	if (regcomp(&regexp, prefix, REG_EXTENDED))
> > +		return error("invalid regexp: %s", prefix);
> >  	while (list) {
> >  		char *p;
> >  		struct commit *commit;
> 
> Why EXTENDED?

Sorry. Old habit. Will fix.

> Also you probably want REG_NEWLINE.

No. If I look for something in the body of the message (like I showed in 
the two examples), I'd like to say ':/.*Blub'. Of course, you could always 
say

	git diff ':/[ -~
]*Blub'

with REG_NEWLINE, to match newlines also. But frankly, it is much more 
often that I want to match something in the whole message than just in the 
oneline. And if I _do_ want the match only in the oneline, I can still go 
and do

	git diff ':/[^
]*Blub'

when REG_NEWLINE is disabled. If you can teach me a better way to do both 
things, matching in the oneline _or_ matching the whole message, _with_ 
REG_NEWLINE, I'll gladly change it, and provide an example in the commit 
message as well as the documentation for equally clueless subjects as me.

> > @@ -630,7 +634,9 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1)
> >  		parse_object(commit->object.sha1);
> >  		if (!commit->buffer || !(p = strstr(commit->buffer, "\n\n")))
> >  			continue;
> > -		if (!prefixcmp(p + 2, prefix)) {
> > +		if (!regexec(&regexp, p + 2, 1, regmatch, 0) &&
> > +				printf("match: %d\n", regmatch[0].rm_so) &&
> > +				regmatch[0].rm_so == 0) {
> >  			hashcpy(sha1, commit->object.sha1);
> >  			retval = 0;
> >  			break;
> 
> Do we want to detect return value other than REG_NOMATCH from
> regexec() when it does not return zero?

I am not well versed in the multitude of POSIX and other standards we have 
on this planet, therefore I just read my man page. And it says, quote:

	regexec() returns zero for a successful match or REG_NOMATCH for 
	failure.

Tertium non datur. At least according to my man page here. Am I mistaken 
in my assumption (which seems to be somewhat supported from my limited 
reading of the man page) that all errors should be caught at regcomp() 
time?

> Please lose the debugging printf() before submitting.

Ouch. Sorry.

> > @@ -639,6 +645,7 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1)
> >  	free_commit_list(list);
> >  	for (l = backup; l; l = l->next)
> >  		clear_commit_marks(l->item, ONELINE_SEEN);
> > +	regfree(&regexp);
> >  	return retval;
> >  }
> >  
> 
> Also I think you would want to fix get_sha1_oneline() so that it
> not to refuse to work without save_commit_buffer.

You're right, will fix.

I'll resubmit shortly. However, feel free to enlighten me with insights 
into working _with_ REG_NEWLINE, and I'll gladly submit another version of 
the patch with REG_NEWLINE enabled, along with the additions to the 
documentation.

Thanks,
Dscho

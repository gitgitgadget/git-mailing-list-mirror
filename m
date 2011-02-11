From: Libor Pechacek <lpechacek@suse.cz>
Subject: Re: [PATCH v4] Sanity-check config variable names
Date: Fri, 11 Feb 2011 19:52:06 +0100
Message-ID: <20110211185205.GB7406@localhost.suse.cz>
References: <20110119141112.GD8034@fm.suse.cz> <20110120232232.GA9442@sigill.intra.peff.net> <20110121100212.GE19715@fm.suse.cz> <20110121102339.GG19715@fm.suse.cz> <20110121162318.GC21840@sigill.intra.peff.net> <20110127142815.GC6312@fm.suse.cz> <7voc72ge4j.fsf@alter.siamese.dyndns.org> <20110128145323.GE1849@fm.suse.cz> <20110130194041.GA25033@fm.suse.cz> <7v7hd733q6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 11 19:52:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pny6L-0006wj-38
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 19:52:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757830Ab1BKSwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Feb 2011 13:52:11 -0500
Received: from cantor2.suse.de ([195.135.220.15]:37154 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757162Ab1BKSwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Feb 2011 13:52:09 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id 9249F8738D;
	Fri, 11 Feb 2011 19:52:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7v7hd733q6.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166568>

On Thu 10-02-11 14:49:05, Junio C Hamano wrote:
> Libor Pechacek <lpechacek@suse.cz> writes:
> 
> > diff --git a/builtin/config.c b/builtin/config.c
> > index ca4a0db..dd17029 100644
> > --- a/builtin/config.c
> > +++ b/builtin/config.c
> > @@ -168,17 +167,30 @@ static int get_value(const char *key_, const char *regex_)
> > ...
> >  		key_regexp = (regex_t*)xmalloc(sizeof(regex_t));
> >  		if (regcomp(key_regexp, key, REG_EXTENDED)) {
> >  			fprintf(stderr, "Invalid key pattern: %s\n", key_);
> >  			goto free_strings;
> 
> This is not a new issue introduced by this series, but isn't this goto
> leaking "key" by jumping over free(key) later in the function but before
> its target?

Yes, sure and not only there.  A few lines below there is the compilation of
the value regex.  Freeing the memory allocated for key storage obviously needs
a little bit more work and I'd like to post the fix as a separate patch.

> >  		}
> > +	} else {
> > +		if (git_config_parse_key(key_, &key, NULL))
> > +			goto free_strings;
> 
> This seemingly has the same issue but is worse than that.  You allocate
> and overwrite "key" in git_config_parse_key(), so by calling the function
> after allocating key in the caller, you immediately leak it.  The new copy
> allocated inside the callee is freed at its end upon error return, so
> jumping over free(key) in the caller does not leak, though.

Negligence on my part, thanks for catching it.

> > @@ -1124,59 +1187,22 @@ int git_config_set(const char *key, const char *value)
> > ...
> > +	ret = -git_config_parse_key(key, &store.key, &store.baselen);
> > +	if (ret)
> >  		goto out_free;
> 
> This '-' is very easy to miss; I'd rather see it spelled out with an
> explanation.

Agree.  It would be yet better to get rid this weird transformation at all.

> But looking at the bigger picture, don't you think that an internal
> function like git_config_set() should return negative on error, and
> we should make it the caller's responsibility to turn it to a value
> suitable for feeding exit(3)?  It obviously is a separate topic.

Agree and not only that.  The exit codes are inconsistent between "set" and
"get" operation[1].  IMHO it's also questionable to feed exit(3) with negative
values.

Would you be in favor of getting the exit codes consistent and documented?

> Here is a minimum fix-up on top of your patch.

Squashed into my patch, with the exception of the memleak fix, which I'm going
to post separately.

> Thanks.

Thanks for the opportunity to contribute. :)

Libor

[1] $ ./git-config x.x x [; echo $?
    error: invalid pattern: [
    6
    $ ./git-config --get x.x [; echo $?
    Invalid pattern: [
    255

-- 
Libor Pechacek
SUSE L3 Team, Prague

From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [PATCH 1/2] rev-parse --glob
Date: Wed, 20 Jan 2010 13:08:44 +0200
Message-ID: <20100120110843.GA11343@Knoppix>
References: <1263980906-11058-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <7vska13wt0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 12:08:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXYQf-0004ef-NO
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 12:08:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954Ab0ATLIt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 06:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751874Ab0ATLIt
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 06:08:49 -0500
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:58978 "EHLO
	emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081Ab0ATLIs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 06:08:48 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh02-2.mail.saunalahti.fi (Postfix) with SMTP id 4BD0EEF57C;
	Wed, 20 Jan 2010 13:08:47 +0200 (EET)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A05A35407E3; Wed, 20 Jan 2010 13:08:47 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 24181E51AD;
	Wed, 20 Jan 2010 13:08:45 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <7vska13wt0.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137544>

On Wed, Jan 20, 2010 at 02:17:15AM -0800, Junio C Hamano wrote:
> Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:
> 
> Looks fairly competently done.  Does this mean you've abandoned the --namespace
> series?  I don't mind reverting them from 'next'.

Pretty much.
 
> > +static int filter_refs(const char* ref, const unsigned char *sha, int flags,
> > +	void* data)
> > +{
> > +	struct ref_filter *filter = (struct ref_filter*)data;
> > +	if (fnmatch(filter->pattern, ref, 0))
> > +		return 0;
> 
> In many places (not just refs) we use "If leading path component matches,
> or fnmatch() says Ok" (e.g. builtin-for-each-ref.c, builtin_grep.c), and
> in some other places we only use fnmatch().  I think it is better to pick
> one convention, and adjust the other one to match, and my gut feeling is
> that "leading path or fnmatch()", while theologically might be messier,
> would be more useful in practice.  And that was why I did my "like this"
> patch http://article.gmane.org/gmane.comp.version-control.git/137492 that way.

That pattern of course has been edited before (and the namespace behavoiour
is implemented that way).

> My longer term desire is to consolidate these fnmatch() users to call a
> single helper function, and then perhaps replace fnmatch() in that helper
> function with something more powerful.  Although I do not personally care
> too much, people often wanted to have "path/**/leaf-that-is-deep" matcher.

Extended globs? Except that:

'git check-ref-format refs/heads/X+\(a\|b\) ; echo $?' => 0

And '+(a|b)' is wildcard in extended glob (not expressible with standard
glob operators). 

Extended globbing in gitignore would be useful as some have asked if there
is way to use regular expressions there (nope). At least extended globs
are equivalent to regular expressions in power.

 
> > @@ -674,6 +691,35 @@ int for_each_replace_ref(each_ref_fn fn, void *cb_data)
> >  	return do_for_each_ref("refs/replace/", fn, 13, 0, cb_data);
> >  }
> >  
> > +int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data)
> > +{
> > +	struct strbuf real_pattern = STRBUF_INIT;
> > +	struct ref_filter filter;
> > +	const char *has_glob_specials;
> > +	int ret;
> > +
> > +	if (prefixcmp(pattern, "refs/"))
> > +		strbuf_addstr(&real_pattern, "refs/");
> > +	strbuf_addstr(&real_pattern, pattern);
> > +
> > +	has_glob_specials = strpbrk(pattern, "?*[");
> 
> Would the need for this code hopefully disappear if we take the "leading
> path or fnmatch()" check?  If we still need this, we probably would want
> to add a has_glob_special() helper function not as a hardcoded srpbrk(),
> but in terms of is_glob_special() in git-compat-util.h.

'--glob=remotes/origin' and '--glob=remotes/origin*' are not the same. The
first gets DWIMed to '--glob=refs/remotes/origin/*'. The usual case for
globbing is globbing entiere namespace (name of one remote can be prefix
of another).

-Ilari

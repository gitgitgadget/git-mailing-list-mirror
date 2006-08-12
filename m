From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Different colours for tags and heads
Date: Sat, 12 Aug 2006 02:12:19 +0200
Organization: At home
Message-ID: <ebj6c3$4cj$1@sea.gmane.org>
References: <20060811151224.177110@gmx.net> <ebi81l$qu$1@sea.gmane.org> <7vodurrlg8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Aug 12 02:12:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBh6u-0003Wv-LF
	for gcvg-git@gmane.org; Sat, 12 Aug 2006 02:12:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbWHLAMN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Aug 2006 20:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932408AbWHLAMN
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Aug 2006 20:12:13 -0400
Received: from main.gmane.org ([80.91.229.2]:20153 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932377AbWHLAMM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Aug 2006 20:12:12 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GBh6i-0003Vk-Hv
	for git@vger.kernel.org; Sat, 12 Aug 2006 02:12:04 +0200
Received: from host-81-190-24-83.torun.mm.pl ([81.190.24.83])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 12 Aug 2006 02:12:04 +0200
Received: from jnareb by host-81-190-24-83.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 12 Aug 2006 02:12:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-83.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25244>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:

>> I've planned on patch which does something similar to
>> yours, but in slightly different way: instead of two calls 
>> to git_get_referencing (format_mark_referencing[*1*] after rename)
>> and two calls to read_info_ref (git_get_references after rename)
>> in your patch, read_info_ref would always add full name, of
>> which first component is the type of the tag.
> 
> get_referencing to get, and format_ref to format perhaps?

Thanks for a suggestion. I've decided on git_get_references, and
format_ref_marker,but it isn't cast in stone.
 
>> I am wondering if to do this like in my abovementioned patch,
>> putting references in single string, separated by ':' (':' cannot
>> be part of valid ref name), or use array (anonymous array reference
>> to be more exact). 
> 
> Two things and half come to mind.
> 
> get_referencing could get and return the full refname without
> abbreviation ('heads/jn/web' or 'tags/v1.0'), and the caller can
> do whatever with them (e.g. see what the name begins with to
> tell heads and tags apart).  This is probably the most flexible
> if we do not want to cast the categorization of refs in stone.
> 
> Otherwise, return an arrayref, like ['tag', 'v1.0', 'v1.0'] or
> ['head', 'web', 'jn/web'], to say what kind, short name and full
> name.

Perhaps I have not said things clearly. The problem I meant to solve is the
fact that there might be more than one ref pointing to a given object.
Currently read_info_ref does not its job joining references pointing to
given object (referenced object is key of a hash) using " / ", i.e.
creating the "joined tag".

In dropped patch I've mentioned I joined references using ':' as it can't be
part of valid ref name, then split it on ':' on formatting.

But they can be put into anonymous arrayref (e.g. ['heads/next',
'heads/autoconf'] at the start of 'autoconf' branch, or ['heads/master',
'heads/next', 'tags/v1.4.2'], not 'heads/master:heads/next:tags/v1.4.2'
my patch did.

> I've always wondered if the span that shows the short refname
> could have an on-hover pop-up (title attribute is often shown
> that way) to show the full name.  Then you could do something
> like:
> 
>     $long_name = 'heads/jn/web'; # or 'tags/v1.0'
>     $kind = ($long_name =~ /^heads/) ? 'head' : 'tag';
>     $long_name = s|^[^/]*/||;
>     ($short_name = $long_name) =~ s|.*/||;
>     $long_name = esc_html($long_name);
>     $short_name = esc_html($short_name);
>     return " <span class='$kind' title='$long_name'>$short_name</span>";

Currently (in core-git) besides 'heads' and 'tags' there might be
'remotes' (when using --use-separate-remote' option of git-clone), all
following the rule of being plural (in English) to the type of tag, so one
could use
        $ref =~ m|(^[^/])*s?/|;
        $kind = $1;
for kind.

By the way, is it really usefull to have shortened ref name, e.g. 'web' for
'jn/web'? That is what gitweb does currently (only without giving ling name
at all). It is probably bad practice, but I've had branches ab/sth and
zz/sth, with the same shortname.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

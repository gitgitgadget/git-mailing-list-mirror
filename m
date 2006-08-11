From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Different colours for tags and heads
Date: Fri, 11 Aug 2006 14:50:31 -0700
Message-ID: <7vodurrlg8.fsf@assigned-by-dhcp.cox.net>
References: <20060811151224.177110@gmx.net> <ebi81l$qu$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Thomas Kolejka" <Thomas.Kolejka@gmx.at>
X-From: git-owner@vger.kernel.org Fri Aug 11 23:51:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBeu4-0007YU-IW
	for gcvg-git@gmane.org; Fri, 11 Aug 2006 23:50:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbWHKVuf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Aug 2006 17:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750862AbWHKVuf
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Aug 2006 17:50:35 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:14035 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750951AbWHKVud (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Aug 2006 17:50:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060811215032.MSOD18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 11 Aug 2006 17:50:32 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ebi81l$qu$1@sea.gmane.org> (Jakub Narebski's message of "Fri, 11
	Aug 2006 17:34:42 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25240>

Jakub Narebski <jnareb@gmail.com> writes:

> By the way, please do not put "Hello," in the commit message
> part of patch. You can put your comments (like which branch
> and/or commit is the batch based on) either after "---" and
> before the patch itself, or at the beginning and separate them
> from the commit message by "+++" (this separator is supported
> by git tools,...

???

> I've planned on patch which does something similar to
> yours, but in slightly different way: instead of two calls 
> to git_get_referencing (format_mark_referencing[*1*] after rename)
> and two calls to read_info_ref (git_get_references after rename)
> in your patch, read_info_ref would always add full name, of
> which first component is the type of the tag.

get_referencing to get, and format_ref to format perhaps?

> I am wondering if to do this like in my abovementioned patch,
> putting references in single string, separated by ':' (':' cannot
> be part of valid ref name), or use array (anonymous array reference
> to be more exact). 

Two things and half come to mind.

get_referencing could get and return the full refname without
abbreviation ('heads/jn/web' or 'tags/v1.0'), and the caller can
do whatever with them (e.g. see what the name begins with to
tell heads and tags apart).  This is probably the most flexible
if we do not want to cast the categorization of refs in stone.

Otherwise, return an arrayref, like ['tag', 'v1.0', 'v1.0'] or
['head', 'web', 'jn/web'], to say what kind, short name and full
name.

I've always wondered if the span that shows the short refname
could have an on-hover pop-up (title attribute is often shown
that way) to show the full name.  Then you could do something
like:

    $long_name = 'heads/jn/web'; # or 'tags/v1.0'
    $kind = ($long_name =~ /^heads/) ? 'head' : 'tag';
    $long_name = s|^[^/]*/||;
    ($short_name = $long_name) =~ s|.*/||;
    $long_name = esc_html($long_name);
    $short_name = esc_html($short_name);
    return " <span class='$kind' title='$long_name'>$short_name</span>";

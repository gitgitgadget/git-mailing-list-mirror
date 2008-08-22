From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] gitweb: ref markers link to named shortlogs
Date: Fri, 22 Aug 2008 09:21:55 +0200
Message-ID: <cb7bb73a0808220021w5d30d3c8i88ad85611035d2c5@mail.gmail.com>
References: <1219341860-4913-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <200808212332.07095.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@ucw.cz>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 09:23:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWQz7-0002vQ-55
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 09:23:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbYHVHV5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 03:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbYHVHV5
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 03:21:57 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:29815 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828AbYHVHV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 03:21:56 -0400
Received: by yx-out-2324.google.com with SMTP id 8so207832yxm.1
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 00:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=1sEmFRP25wSXxW2+BxFN8besmBJNwT89hUfEwhSOM2I=;
        b=w796GonHzHFk1UZUm5TT9Xhhzc8wYXL3hY/c1+srziw0a8WI7jzaY+Vw2dG19LPpZR
         YBkJZd0Lvia13FHS+PvkmTEF1W+FA91PSuQgbjXX08QJhdSCjq7oop8bWFScNsFfAEBE
         X+j9CzlN/rNsNvIq5TPZ9GPSmCc4LstTARGuA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Zr8Jxgagf1JDHBaj3lMJVh8QfCgReDu787Eu/WTdRRV2pYOY69GtSNIELcqCrVKJAz
         KLzvHnBkKZbRlQPwgnsw23tp0EHcCEaM4bdIwYlij5URjonJoS0afjwSdNJsZQOb0Evu
         CXBFmRMb2xkYoe1TTRKEIPZooaFUoZjkimjNw=
Received: by 10.150.154.6 with SMTP id b6mr1331171ybe.28.1219389715522;
        Fri, 22 Aug 2008 00:21:55 -0700 (PDT)
Received: by 10.150.155.12 with HTTP; Fri, 22 Aug 2008 00:21:55 -0700 (PDT)
In-Reply-To: <200808212332.07095.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93262>

> It is a good idea, but not so good solution.

Ok, let's see if I can find a better way to do it 8-)

>> --- a/gitweb/gitweb.css
>> +++ b/gitweb/gitweb.css
>
>> +span.refs span a {
>> +     text-decoration: none;
>> +     color: inherit;
>> +}
>
> Possible improvement:
>
> We would probably want to make this link discoverable, by adding
> underline on :hover, like for other "hidden links" in gitweb (for
> example in commitdiff view).

Can do that.

>>                       my ($type, $name) = qw();
>> +                     my $git_type = git_get_type($ref);
>>                       # e.g. tags/v2.6.11 or heads/next
>>                       if ($ref =~ m!^(.*?)s?/(.*)$!) {
>>                               $type = $1;
>
> git_get_type calls 'git cat-file -t', so for each ref shown you make
> *additional call* to git command (additional fork).  Not good, especially
> that you can get information if a ref is a tag (indirect reference)
> or not one can get from within git_get_references; which in turn
> uses "git show-refs --dereference" and used to use either
> "git peek-remote ." or ".git/info/refs" file.  If there is <name>^{},
> then <name> is indirect reference: is a tag.
>
> As we display ref markers only for log-like views, marker can be tag
> or can be "lightweight reference" and be only a commit (in theory
> we could show ref markers also for tree and blob items, but it is not
> important now).

By looking at git_get_reference() what I see is basically the use of
the same field as $type in format_ref_marker(). I can probably use
that, although it means that any future extensions to ref marker
display will need to hack the routine too. (This would mean that the
patch would be more similar to my original patch
http://marc.info/?l=git&m=121769155017642&w=2 ).

If this is not what you're suggesting, then I'm afraid I don't fully
grasp your idea.


-- 
Giuseppe "Oblomov" Bilotta

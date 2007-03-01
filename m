From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] Quick description of possible gitattributes system
Date: Thu, 1 Mar 2007 11:06:00 -0500
Message-ID: <CF579EA9-04AB-4B39-809F-650E611A8D6B@silverinsanity.com>
References: <200703011206.47213.andyparkins@gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: GIT list <git@vger.kernel.org>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 17:06:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMnnR-0000Up-9c
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 17:06:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965312AbXCAQGE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 11:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965315AbXCAQGD
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 11:06:03 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:57766 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965312AbXCAQGB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 11:06:01 -0500
Received: from [IPv6???1] (localhost [127.0.0.1])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id C289E1FFC142;
	Thu,  1 Mar 2007 16:06:00 +0000 (UTC)
In-Reply-To: <200703011206.47213.andyparkins@gmail.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41101>


On Mar 1, 2007, at 7:06 AM, Andy Parkins wrote:

> The ideas in this document come primarily from the "unresolved issues"
> thread from the git mailing list.  gmane/28388.  In particular, from:
>  - Brian Gernhardt

I still get a kick out of seeing my name mentioned on the list.  :-)   
And if I'm getting some of the blame on me, (ew, get it off) I should  
probably put in my $0.02.

> +   For example:
> +
> +   ------------------------------------
> +   [attributes "*.png"]
> +       attribute = image/png
> +   [attributes "*.c"]
> +       attribute = text/plain
> +	   attribute = source-file
> +   ------------------------------------
> +
> +   (This is pretty ugly, because of the "*" and "." in the section  
> name,
> +   however I can't think of another way of doing this without  
> resorting to
> +   just copying the format of the .gitattributes file; like

Perhaps:

[attribute "image/png"]
    path = *.png
    show = "open %path%"
[attribute "text/plain"]
    path = *.c
    checkout = eol_to_local

I also think that this is a better way for handlers to be  
specified...  see below.

> +== Handlers
> +
> +At this point git would be in a position to answer the question "what
> +attributes does this file have?" for any file in the tree.
> +
> +The handler system will allow us to specify operations that should be
> +performed on files with particular attributes.  For example, we might
> +want to have text files automatically filtered to match local line
> +ending conditions.
> +
> +----------------------------------------
> +[handler "fix-line-endings"]
> +  attribute = text/plain
> +  infilter = eol_lf
> +  outfilter = eol_local
> +----------------------------------------
> +
> +This definition creates a handler named "fix-line-endings" (don't  
> suppose
> +they actually need names) that would run the "eol_lf" filter on check
> +in, and the "eol_local" filter on checkout.
> +

I think it would be better to directly associated these with the  
attribute, and have handler sections as shortcuts:

[handler "fix-line-endings"]
    infilter = eol_lf
    outfilter = eol_local
[attribute "text/plain"]
    handler = fix-line-endings
[attribute "text/source"]
    patch = *.source
    handler = fix-line-endings
    infilter = prettypatch

The file type (attribute, whatever) is the more user-important thing  
here.  It should, therefore, be the most visible thing when editing.   
I wouldn't want to have to read through the entirety of my config to  
find all of the handlers which affect a type, and it gathers all the  
options in one place.  Plus, it saves us from having to figure out in  
what order multiple handler sections on the same attribute get run  
in.  They get run in whatever order they're specified in the  
attribute's section.

> +=== Handler Types

[snip]

> +=== Filter list

[snip]

Both of these lists look right at first glance, although I think I  
prefer something simple like "show" to "prettyfilter".  And we might  
want a "reject" or "none" for merges...  Attempting to merge a bitmap  
is madness, so the system should just output a <file>- 
<head>.<extension> or similar.

> +== Problems
> +
> + - Initial Checkout
> +   The .gitattributes file is not in the working directory, so how  
> git
> +   find out what to apply to a file?  The potential solution might  
> be to
> +   use the in-repo .gitattributes for checking out; and the  
> working-tree
> +   .gitattributes when checking in.
> + - Merge of .gitattributes
> +   What happens when .gitattributes conflicts during a merge?

We may have to special case .gitattributes.  Force a checkout of it  
before any files in the directory or subdirectories, and not just on  
the initial checkout.  Checking out .gitattributes first during  
merges and pulls might be required and unmerged .gitattributes causes  
a big warning that it has to be resolved, and causes the rest of the  
repo to conform to the new attributes when it's resolved (possibly  
causing more merge conflicts).

> + - Change of .gitattributes without change of files.
> +   What happens when .gitattributes changes, but the files that  
> would be
> +   affected by that change do not?  Those files really should be  
> checked
> +   out again, to apply any new outfilter settings.

Actually, shouldn't the files also be run through the infilter to  
check for changes caused by that, too?

Maybe this is a more like a nickel,
~~ Brian

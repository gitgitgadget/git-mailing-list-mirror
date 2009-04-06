From: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
Subject: Re: [EGIT] [PATCH RFC v1 0/5] Add (static) ignore functionality to
 EGit
Date: Mon, 06 Apr 2009 18:46:20 +0200
Message-ID: <49DA31DC.3070903@pelagic.nl>
References: <cover.1238102327.git.ferry.huberts@pelagic.nl> <20090405210248.GA23604@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Apr 06 18:48:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqrzL-0003Fd-Pv
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 18:48:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbZDFQq0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 12:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751009AbZDFQq0
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 12:46:26 -0400
Received: from hupie.xs4all.nl ([82.95.241.251]:58895 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751195AbZDFQqZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Apr 2009 12:46:25 -0400
Received: from [192.168.0.51] (unknown [192.168.0.51])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id 3CFC058BD9F;
	Mon,  6 Apr 2009 18:46:21 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <20090405210248.GA23604@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115852>

Shawn O. Pearce wrote:
> Ferry Huberts <ferry.huberts@pelagic.nl> wrote:
>> This is the first - early - code that adds ignore functionality to EGit.
>> Currently it reads in all ignore patterns upon workspace startup into an
>> ignore cache. From this cache the ignore state of a resource is evaluated
>> in the same fashion as git does.
>>
>> The code does not yet react to changes in ignore files but I'm planning to add
>> that soon and I can share a lot of code for that.
>>
>> I send this code to receive feedback and to give you insight into what I'm
>> doing with it. I'm new both to EGit programming and Eclipse programming so
>> there might be things that could be done more elegantly :-)
> 
> Ok, I finally got a chance to review this series.
> 
> 
> We really want as much of the Git specific logic as we can in JGit
> under the BSD license.  This has already been raised elsewhere in
> this thread.
> 
ack.

> JGit and EGit are holding the line on Java 5 support; that means
> that String.isEmpty() must be spelled as String.length() == 0
> (isEmpty was added in Java 6).
ok

> 
> Style nit: Don't put /* Constructors */, /* Methods */ or
>   / * Public Methods */ comments in code, e.g.
>   IgnoreProjectCache l.52-54 or GitIgnoreData l.58-61.
> 
ok

> Style nit: Don't assign fields to their default values.
> 
>   E.g. Exclude.java l.25,33,42,.. these are being set to the
>   same value that the JRE sets the field to if the field is not
>   explicitly initialized.  We find it much easier to read code when
>   the defaults are assumed.
> 
ok

> Style nit: Don't use "this." to refer to members.
> 
>   Your IDE should highlight field references differently than
>   parameters, and a parameter should never shadow a field name,
>   thus "this." is unnecessary and makes the code much more verbose
>   to read.  E.g. see Exclude.java 's constructor on l.87-108; I can't
>   see the forest (the code) due to all the trees (this.) appearing.
> 
ok

> IgnoreFileOutside: Ugh, our own implementation of IFile ?
> 
>   I'm worried about the long-term stability of the IFile API.
>   Is it really frozen enough that we can implement it ourselves?
>   Of course, this may be moot if much of the code was moved back
>   to JGit.
> 
when we convert the code to be in jgit we will not use this api.
this will disappear.

> IgnoreRepositoryCache: Why not put this into RepositoryMapping?
> 
>   Instead of caching it inside a static HashMap of GitIgnoreData,
>   wouldn't it be better to put it into RepositoryMapping?
>   The TrackOperation for example already has the RepositoryMapping
>   handle in scope, saving a few lookup operations, and avoiding
>   needing to manage this new additional static HashMap against leaks.
> 
ok

> 
> I kind of wanted to tie exclude processing (and attribute processing)
> into a TreeWalk, so that we can do an n-way merge against trees and
> working directories by tossing all of their AbstractTreeIterators
> into a single walk, possibly apply a path filter, and let the walk
> handle the per-directory ignore rules as it goes.
> 
ok. but I need much more input than that from you on how to go about
moving the code into jgit. If you have ideas on what the rough
architecture should be of the ignore processing in jgit then please let
me know, I don't know that code at all and also don't know the approach
you'd like to take there with its architecture.

I've been thinking on and off about how to free the ignore processing
from eclipse specific apis ever since the egit/jgit issue came up. I
think it's not that hard to do, depending on the approach you'd like to
take.

you talk about TreeWalk. but what is it's prupose, in what context is it
called? etc. You can probably much faster explain that to me than I can
find out from the code (the egit code is much easier to place in context
than the jgit code I think)

> Most of your code seems to be built around the Eclipse IResource
> model, and the idea that it gets called for a single file path
> at a time, which may make it less efficient when we put it into a
> TreeWalk and apply the notion of entering and exiting a subdirectory.
> 
the way it works now is more efficient than git itself (most of the
time), since we have a cache of the ignore patterns. I compared traces
of git itself and the plugin against eachother.

> 
> OK, that's about all I have for now.  Its reasonable, but still an
> early series.
>  
yep.
please let's discuss moving it into jgit asap. so that I can complete
the feature.

BTW
In the meantime I've also added ignore preferences to the plugin on
which the user can specify whether the Eclipse Team Ignored Resources
should be taken into account. It defaults to yes. When set to no the
ignore processing complies strict to git behaviour.

looking forward to your input!

Ferry

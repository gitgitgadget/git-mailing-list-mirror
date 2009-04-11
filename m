From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] process_{tree,blob}: Remove useless xstrdup calls
Date: Fri, 10 Apr 2009 21:34:12 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904102129510.6741@xanadu.home>
References: <20090408112854.GA8624@atjola.homenet>
 <alpine.LFD.2.00.0904101517520.4583@localhost.localdomain>
 <alpine.LFD.2.00.0904101714420.4583@localhost.localdomain>
 <alpine.LFD.2.00.0904101806340.4583@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, david@lang.hm,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Apr 11 03:37:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsS9O-0006pN-MW
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 03:36:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbZDKBeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Apr 2009 21:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022AbZDKBeV
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Apr 2009 21:34:21 -0400
Received: from relais.videotron.ca ([24.201.245.36]:20593 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918AbZDKBeV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Apr 2009 21:34:21 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KHW00E9SXN9NNC2@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 10 Apr 2009 21:33:09 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.2.00.0904101806340.4583@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116288>

On Fri, 10 Apr 2009, Linus Torvalds wrote:

> 
> 
> On Fri, 10 Apr 2009, Linus Torvalds wrote:
> > 
> > Here's a less trivial thing, and slightly more dubious one.
> 
> I'm starting to like it more.
> 
> In particular, pushing the "path_name()" call _into_ the show() function 
> would seem to allow
> 
>  - more clarity into who "owns" the name (ie now when we free the name in 
>    the show_object callback, it's because we generated it ourselves by 
>    calling path_name())
> 
>  - not calling path_name() at all, either because we don't care about the 
>    name in the first place, or because we are actually happy walking the 
>    linked list of "struct name_path *" and the last component.
> 
> Now, I didn't do that latter optimization, because it would require some 
> more coding, but especially looking at "builtin-pack-objects.c", we really 
> don't even want the whole pathname, we really would be better off with the 
> list of path components.
> 
> Why? We use that name for two things:
>  - add_preferred_base_object(), which actually _wants_ to traverse the 
>    path, and now does it by looking for '/' characters!
>  - for 'name_hash()', which only cares about the last 16 characters of a 
>    name, so again, generating the full name seems to be just unnecessary 
>    work.
> 
> Anyway, so I didn't look any closer at those things, but it did convince 
> me that the "show_object()" calling convention was crazy, and we're 
> actually better off doing _less_ in list-objects.c, and giving people 
> access to the internal data structures so that they can decide whether 
> they want to generate a path-name or not.

YES!

I didn't look at the patch really closely, but this fits pretty well 
with the philosophy behind pack v4 where path components are stored in a 
separate table (instead of being duplicated in every tree objects for 
the same path), hence generating path names on demand would be a real 
win for those cases where it is not needed.


Nicolas

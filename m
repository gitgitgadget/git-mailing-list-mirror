From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Remote corruption issue, linked to thin pack code?
Date: Wed, 25 Aug 2010 22:42:51 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1008252107070.622@xanadu.home>
References: <201008252253.26521.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git list <git@vger.kernel.org>, Jonas Thiem <contact@eloxoph.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Aug 26 04:42:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoSQc-0004MA-7q
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 04:42:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752848Ab0HZCmx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 22:42:53 -0400
Received: from relais.videotron.ca ([24.201.245.36]:61825 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752447Ab0HZCmw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 22:42:52 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L7Q00ISONJF0E90@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 25 Aug 2010 22:42:52 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <201008252253.26521.trast@student.ethz.ch>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154501>

On Wed, 25 Aug 2010, Thomas Rast wrote:

> Hi *,
> 
> This one sounds fairly similar to
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/123244/
> 
> which was never resolved.

I don't think it actually is the same issue.

> Jonas reported repo corruption on IRC along the lines of
> 
>   $ make gitpush
>   cd dist && git push ssh://<user>@eloxoph.com/repos/mainrepo/bla.git master
>    
>     -  W e l c o m e   t o   E L O X O P H  -
>                friendly landlord
> 
>   <user>@eloxoph.com's password: 
>   Counting objects: 201, done.
>   Delta compression using up to 2 threads.
>   Compressing objects: 100% (132/132), done.
>   Writing objects: 100% (133/133), 1.01 MiB, done.
>   Total 133 (delta 118), reused 0 (delta 0)
>   fatal: pack has 114 unresolved deltas

So... out of 118 deltas, 114 were relying on the remote to already have 
base objects for them (or some of them are deltas against unresolved 
deltas).  In any case, the remote is missing some objects it advertised 
it should have.

> The respective repos show no errors with git-fsck.

What about 'git fsck --full'?  Given git v1.5.4 on the remote, you 
should try --full with 'git fsck' as this wasn't the default back then.

> Jonas kindly
> provides a download link for both:
> 
>   http://eloxoph.com/localrepo.zip
>   http://eloxoph.com/remoterepo.zip

$ wget http://eloxoph.com/remoterepo.zip
--2010-08-25 21:24:52--  http://eloxoph.com/remoterepo.zip
Resolving eloxoph.com... 85.214.104.74
Connecting to eloxoph.com|85.214.104.74|:80... connected.
HTTP request sent, awaiting response... 404 Not Found
2010-08-25 21:24:52 ERROR 404: Not Found.

> What's even stranger is that fetching from the repo is also not
> possible:
> 
>   fatal: git-upload-pack: cannot find object e28ae6b61c384732c506544626c5083557dd2d75:
>   fatal: The remote end hung up unexpectedly
> 
> despite the object being there.

How do you know it is there while git (on the remote) is telling you it 
is not?

What about 'git cat-file -t e28ae6b61c384732c506' ?

> What's also strange is that while there is a temporary pack inside
> objects/, I get
> 
>   $ git index-pack --stdin < objects/tmp_pack_oEUkIc
>   fatal: pack has 114 unresolved deltas
>   $ git index-pack --fix-thin -v --stdin < objects/tmp_pack_oEUkIc
>   Receiving objects: 100% (133/133), 1.01 MiB, done.
>   Resolving deltas: 100% (118/118), completed with 63 local objects.
>   pack    061120577b0a1fec7ba636d6e3162f95f83543aa
> 
> So it seems the remote side got a thin pack and can't cope. 

Hmmm... in this case it must be because git v1.5.4 is buggy.

/me looks

Well... apparently no.  In receive-pack.c:unpack() there is this code:

                keeper[0] = "index-pack";
                keeper[1] = "--stdin";
                keeper[2] = "--fix-thin";
                keeper[3] = hdr_arg;
                keeper[4] = keep_arg;
                keeper[5] = NULL;

so --fix-thin is always unconditionally passed to index-pack.  This is 
also more or less the same code in v1.7.2.

> But a4503a1 (Make --no-thin the default in git-push to save server 
> resources, 2007-09-09), merged way back in 1.5.3.2, claims to enable 
> --no-thin all the time.  So how did a thin pack get there?

Well, this was added back by accident a long time ago, and since then I 
also changed my mind about this, especially since 'git gc --auto' is 
executed on the remote after a push these days, so I never pushed a 
"fix" for it.

Regardless, the receiving end of a push shouldn't care either ways and 
always complete a thin pack.

So there are 2 mysteries here:

1) Why can't the remote repo be fetched? The error from git-upload-pack 
   is straight forward and has nothing to do with any thin packs.

2) Why adding --fix-thin to a manual invocation of index-pack does work 
   while the invocation from receive_pack which should have it doesn't?

Also, what is the OS version and filesystem used on the remote machine?

> Any ideas?

Maybe after I can reproduce this issue locally.


Nicolas

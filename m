From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix branches file configuration
Date: Wed, 26 Mar 2008 00:29:36 -0700
Message-ID: <7v4paugcyn.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0803251931500.19665@iabervon.org>
 <7v3aqel5ms.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0803260240570.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Mar 26 08:30:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeQ5g-0006Ol-Ai
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 08:30:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821AbYCZH3u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 03:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751569AbYCZH3u
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 03:29:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38179 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219AbYCZH3u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 03:29:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5FEFB20C7;
	Wed, 26 Mar 2008 03:29:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 802221FFE; Wed, 26 Mar 2008 03:29:44 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.00.0803260240570.19665@iabervon.org> (Daniel
 Barkalow's message of "Wed, 26 Mar 2008 02:51:28 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78269>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Tue, 25 Mar 2008, Junio C Hamano wrote:
>
>> ...  I am reasonably sure about "fetching from $URL/bar"
>> part, but I am unsure about "store in foo/bar" part.
>> 
>> Any Cogito survivers out there who knows how this was supposed to have
>> worked?  We can go back and look at git-fetch.sh (in contrib/examples),
>> but I'd rather be lazy ;-)
>
> This code actually is from Linus, nearly 2 years ago, converting 
> git-push.sh; I then moved it from builtin-push.c to remote.c and later 
> added support to remote.c for the fetch side aspects while leaving that 
> part of the code alone. Of course, I didn't realize at any point that, as 
> a fetch configuration, a branches configuration ever stored things 
> anywhere, and it looks like it didn't with a slash. (See line 115 of 
> 755225de:git-parse-remote.sh)

Yeah, it slowly comes back to me.

I think the Penguin desire that triggered this mysterious syntax was
something like defining:

 $ echo >.git/branches/garzik git://git.kernel.org/pub/scm/linux/kernel/jgarzik

and being able to say:

 $ git fetch garzik/netdev-2.6 for-linus
 $ git fetch garzik/libata-dev master

> So I guess there should be:
>
>> >  	add_url_alias(remote, p);
>> > -	add_fetch_refspec(remote, branch);
>         if (!slash)
>> > +	strbuf_addf(&branch, ":refs/heads/%s", remote->name);
>> > +	add_fetch_refspec(remote, strbuf_detach(&branch, 0));
>> >  	remote->fetch_tags = 1; /* always auto-follow */
>> >  }

Yeah, sounds like it.  Will queue in 'next', for eventual inclusion in
'maint'.  This is a 1.5.4 regression fix, together with "push --tags" fix
we discussed today.

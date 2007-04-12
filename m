From: Junio C Hamano <junkio@cox.net>
Subject: Re: One more shallow tree weirdness - tag not pulled?
Date: Wed, 11 Apr 2007 18:32:36 -0700
Message-ID: <7vbqhuml6z.fsf@assigned-by-dhcp.cox.net>
References: <20070412011616.GB18378@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Thu Apr 12 03:32:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HboBF-0000vZ-AS
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 03:32:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161441AbXDLBci (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 21:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161442AbXDLBci
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 21:32:38 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:64126 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161441AbXDLBci (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 21:32:38 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070412013238.MKXI1218.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Wed, 11 Apr 2007 21:32:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id m1Yd1W00H1kojtg0000000; Wed, 11 Apr 2007 21:32:37 -0400
In-Reply-To: <20070412011616.GB18378@curie-int.orbis-terrarum.net> (Robin
	H. Johnson's message of "Wed, 11 Apr 2007 18:16:16 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44302>

"Robin H. Johnson" <robbat2@gentoo.org> writes:

> One other bit of weirdness I ran into.  On a shallow clone that is extended to
> full depth, there is a tag missing (that was in the non-shallow clone).
>
> Testcase
>> git clone git://git.kernel.org/pub/scm/git/git.git git-0
>> git clone --depth 1 git://git.kernel.org/pub/scm/git/git.git git-1
>> cd git-1 && git pull --depth 10000000

This is easily explained, and I do not think it has anything to
do with shallow clones.

The initial clone gets all tags, regardless of reachability.
Subsequent fetches however only _follows_ tags that point at
something you have in the repository.  The blob that holds my
GPG public key is not part of any commit, so you would not have
that object in your repository, and subsequent "tag following"
will not see it.

	$ git fetch --tags

is always your friend.

> I created 'git-$N.list' with:
> find git-$N ! -type d  | sort |egrep -v '\.git/(objects/pack/|index$|logs/)' \
>  | tr '\n' '\0' | xargs -0 md5sum | sed 's,git-$N/,,g' >git-$N.list

I do not know what you wanted to do, but I suspect you
reinvented a rather expensive

	git ls-remote git-$N

perhaps?

>
> --- git-0.list	2007-04-11 18:12:25.000000000 -0700
> +++ git-1.list	2007-04-11 18:12:32.000000000 -0700
> @@ -28,7 +28,6 @@
>  bc94cbd02df32d07b7fd230d7aba42e8  .git/refs/tags/gitgui-0.6.3
>  91521cca8d3f177e2f0cb4a586dac6be  .git/refs/tags/gitgui-0.6.4
>  c56d1ac72d959f87ba0dd92721de36de  .git/refs/tags/gitgui-0.6.5
> -b9c7a4533d41dfedd0a0d23bbfb3fed8  .git/refs/tags/junio-gpg-pub
>  43ceb81bf4c131a8a882025a676aa22e  .git/refs/tags/v0.99
>  072e3055bf33ff1ba5aa4697f2b539fb  .git/refs/tags/v0.99.1
>  85916310d7d0a86818033ac95f32b234  .git/refs/tags/v0.99.2
>
> -- 
> Robin Hugh Johnson
> Gentoo Linux Developer & Council Member
> E-Mail     : robbat2@gentoo.org
> GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

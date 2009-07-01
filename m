From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/v2] Remove filename from conflict markers
Date: Wed, 01 Jul 2009 13:57:54 -0700
Message-ID: <7vljn8f7e5.fsf@alter.siamese.dyndns.org>
References: <20090628154559.GA29049@old.homeip.net>
	<7v63ed5pvi.fsf@alter.siamese.dyndns.org>
	<20090701123310.6117@nanako3.lavabit.com>
	<20090701075634.GA18326@old.homeip.net>
	<7vljn8ls0c.fsf@alter.siamese.dyndns.org>
	<20090701161651.GA29393@old.homeip.net>
	<20090701201804.GA16876@old.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Martin Renold <martinxyz@gmx.ch>
X-From: git-owner@vger.kernel.org Wed Jul 01 22:58:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MM6si-0006mP-5L
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 22:58:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753393AbZGAU5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2009 16:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752817AbZGAU5x
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jul 2009 16:57:53 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:59111 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345AbZGAU5w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2009 16:57:52 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090701205755.JZBY20430.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 1 Jul 2009 16:57:55 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id Akxu1c00A4aMwMQ04kxuTG; Wed, 01 Jul 2009 16:57:55 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=FKjP3o1w7WsA:10 a=vWC9mcd_r7eoDwPO0WMA:9
 a=9CVBqi76Nm2R49A0lqMA:7 a=YWmqVLWnAFlGW-tzzB_rGRFPslgA:4
 a=IumQJTCgq9KiQUQy:21 a=kGIXidAuaAvqlzEL:21
X-CM-Score: 0.00
In-Reply-To: <20090701201804.GA16876@old.homeip.net> (Martin Renold's message of "Wed\, 1 Jul 2009 22\:18\:04 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122600>

Martin Renold <martinxyz@gmx.ch> writes:

> Put filenames into the conflict markers only when they are different.
> Otherwise they are redundant information clutter.
>
> Print the filename explicitely when warning about a binary conflict.

I think we are getting closer.

> -	grep "Cannot merge binary files: HEAD:binary-file vs. F:binary-file" \
> -		merge.err
> +	grep "Cannot merge binary files: binary-file (HEAD vs. F)" merge.err

In the original code, if you are not in "merge renamed" situation, you
would see something like this.

    "Cannot merge binary files: HEAD:porn.jpg vs F:porn.jpg"

And the patch changes it to

    "Cannot merge binary files: porn.jpg (HEAD vs F)"

which is an improvement.  I have to wonder, if it even necessary to say
HEAD vs F when no rename is involved, though.  Probably it is, as this is
about binary files, and the user may need to extract the contents with
something like "git cat-file blob HEAD:porn.jpg >tmp1.jpg".

When you are indeed in "merge renamed" situation, it gets a bit more
interesting.  The original said

    "Cannot merge binary files: HEAD:porn.jpg vs F:porn112.jpg"

which makes it clear that what is merged with what, but did not say where
the resulting merge will go.  The updated output would say something like
this

    "Cannot merge binary files: porn.jpg (HEAD:porn.jpg vs F:porn112.jpg)"

which adds information and is probably better.

So overall, I like what the change does, but I'd probably wait for a few
more days just in case there are objections from different corners,
primarily because I am somewhat concerned that this change might affect
users of mergetool (which I do not use myself) in some negative way.

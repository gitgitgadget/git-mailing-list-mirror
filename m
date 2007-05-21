From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 07/16] git-read-tree: take --submodules option
Date: Mon, 21 May 2007 12:01:43 -0700
Message-ID: <7vr6pac86g.fsf@assigned-by-dhcp.cox.net>
References: <11795163061588-git-send-email-skimo@liacs.nl>
	<20070518215312.GB10475@steel.home>
	<20070518220826.GM942MdfPADPa@greensroom.kotnet.org>
	<20070518224209.GG10475@steel.home>
	<7vd50x1n0r.fsf@assigned-by-dhcp.cox.net>
	<20070519130542.GR942MdfPADPa@greensroom.kotnet.org>
	<7v4pm8y8tf.fsf@assigned-by-dhcp.cox.net>
	<20070520155407.GC27087@efreet.light.src>
	<7vbqgfmjki.fsf@assigned-by-dhcp.cox.net>
	<20070521165938.GA4118@efreet.light.src>
	<20070521180506.GP942MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jan Hudec <bulb@ucw.cz>, Alex Riesen <raa.lkml@gmail.com>,
	git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Mon May 21 21:01:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqD8j-0005ro-Qf
	for gcvg-git@gmane.org; Mon, 21 May 2007 21:01:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756707AbXEUTBq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 15:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756759AbXEUTBq
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 15:01:46 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:39599 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756707AbXEUTBp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 15:01:45 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070521190146.VQX6556.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Mon, 21 May 2007 15:01:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1v1k1X00K1kojtg0000000; Mon, 21 May 2007 15:01:45 -0400
In-Reply-To: <20070521180506.GP942MdfPADPa@greensroom.kotnet.org> (Sven
	Verdoolaege's message of "Mon, 21 May 2007 20:05:06 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48042>

Sven Verdoolaege <skimo@kotnet.org> writes:

> On Mon, May 21, 2007 at 06:59:38PM +0200, Jan Hudec wrote:
>> We could store the GIT_DIR of submodule within the GIT_DIR of the
>> superproject instead of the submodule directory itself. So instead of:
>>  /
>>  /.git
>>  /subdir
>>  /subdir/.git
>> 
>> There would be:
>>  /
>>  /.git
>>  /subdir
>>  /.git/submodules/submodule-name.git
>
> I have this already, except that I use /.git/submodules/submodule-name/.git
> because I was too lazy to figure out how to get clone to use the above
> without using --bare, because --bare disables separate-remotes.
>
> Is there any good reason, btw for --bare not to do separate-remotes ?

Traditinoally, the purpose of --bare is to set up distribution
points, either CVS style "shared public repository that
everybody pushes into and fetches from", or "owned by me and I
push my change into it to publish".  In either case, there is no
point of even having an upstream in such a repository, let
alone refs/remotes/origin/ hierarchy.

So that's the "good reason" part.

Having said that, last night I was thinking about making the
layout after a clone a bit more flexible and orthogonal to
existence of working tree.  What got me thinking about it was
different from your motivation, though.

If you have an ordinary working tree, and if you want to have a
clone of that working tree that you can work in, independently
(i.e. not treating the repository you cloned from any specially
from other repositories by marking it "origin"), currently there
is no straightforward way to do so, other than doing 
something like:

 (1) do a --bare clone, which would create "project.git";

 (2) mkdir "project" && mv "project.git" "project/.git";

 (3) edit "project/.git/config" and mark it as a non-bare
     repository.

 (4) "git checkout -f HEAD".

I'd call this a "pure" clone.  It is as close as the original
repository you would get without copying other per-repository
data such as .git/info, .git/config, so that you can start using
it as an _independent _repository.  It is like a --bare clone
but with a working tree associated with it.

What you want is probably the opposite.  A bare, but non-pure
clone.  By non-pure, what I mean is:

 (1) it has an upstream ("origin"), hence
 (2) it has refs/remotes/origin, and "remotes.origin.*"

If the word "non-pure" has a negative connotation, you could
call it "a follower repository".

In short, the current behaviour of --bare is "bare and pure",
and clone without --bare is "not bare, and a follower".  What I
wanted was "not bare, but pure", and I think what you want is
"bare, but a follower".

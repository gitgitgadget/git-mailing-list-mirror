From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/4] Automatically detect a bare git repository.
Date: Sat, 30 Dec 2006 21:46:51 -0800
Message-ID: <7v8xgok46s.fsf@assigned-by-dhcp.cox.net>
References: <3ffc8ddd9b500c2a34d2bd6ba147dc750d951bcd.1167539318.git.spearce@spearce.org>
	<20061231043019.GC5823@spearce.org>
	<7vy7ook5xj.fsf@assigned-by-dhcp.cox.net>
	<20061231052606.GA5722@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 06:47:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0tXD-0000yV-90
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 06:47:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932934AbWLaFqx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 00:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932948AbWLaFqx
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 00:46:53 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:47088 "EHLO
	fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932934AbWLaFqw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Dec 2006 00:46:52 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061231054651.XZLV18767.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>;
          Sun, 31 Dec 2006 00:46:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 5Hm51W00Q1kojtg0000000; Sun, 31 Dec 2006 00:46:06 -0500
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20061231052606.GA5722@spearce.org> (Shawn Pearce's message of
	"Sun, 31 Dec 2006 00:26:06 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35673>

Shawn Pearce <spearce@spearce.org> writes:

> Junio C Hamano <junkio@cox.net> wrote:
> ...
>
> If GIT_DIR is set we call is_git_directory(); if that returns 1
> then the checks passed.  In this case the old code returned NULL
> and ignored nongit_ok.  We do the same in the new code.

Ok.

>> >  	for (;;) {
>> > -		if (is_toplevel_directory())
>> > +		if (is_git_directory(".git"))
>> >  			break;
>> >  		chdir("..");
>> >  		do {
>> >  			if (!offset) {
>> > +				if (is_git_directory(cwd)) {
>> > +					if (chdir(cwd))
>> > +						die("Cannot come back to cwd");
>> > +					setenv(GIT_DIR_ENVIRONMENT, cwd, 1);
>> > +					return NULL;
>> > +				}
>> >  				if (nongit_ok) {
>> >  					if (chdir(cwd))
>> >  						die("Cannot come back to cwd");
>> 
>> I do not know what the new behaviour of this part of the code is
>> trying to do.  This is supposed to see if "." is the toplevel
>> (equivalently, ".git" is the git_dir, in your implementation),
>> otherwise chdir("..") repeatedly until it finds one, and the
>> normal return condition is for the working directory of the
>> process to be at the toplevel.  So chdir(cwd) you introduced is
>> obviously changing the behaviour.
>
> No, its not.

Ah, "changing the behaviour" is the correct thing to do, because
the code is now allowing a new fallback to allow the original
directory to be a bare git repository, and the new chdir/setenv
makes perfect sense.  Thanks for clarification.

For a short time I wondered if this should be a fallback
position, or we might want to make this the very first thing to
check, but I think adding this as the last ditch fallback
position as you did is much safer than making it the first thing
to check.

Thanks.

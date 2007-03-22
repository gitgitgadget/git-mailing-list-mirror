From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC/PATCH] Bisect: implement "git bisect run <cmd>..." to automatically bisect.
Date: Thu, 22 Mar 2007 22:59:48 +0100
Message-ID: <200703222259.49089.chriscool@tuxfamily.org>
References: <20070322070859.a86c0cb4.chriscool@tuxfamily.org> <7vejnhwy0y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 22 22:51:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUVC7-00085t-0H
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 22:51:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161094AbXCVVvg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 22 Mar 2007 17:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161113AbXCVVvg
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 17:51:36 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:54012 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161094AbXCVVvf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Mar 2007 17:51:35 -0400
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 9C9F1B59B3;
	Thu, 22 Mar 2007 22:51:33 +0100 (CET)
User-Agent: KMail/1.9.5
In-Reply-To: <7vejnhwy0y.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42883>

Junio C Hamano a =E9crit :

[...]

> > +      # Check for really bad run error.
> > +      if [ $res -lt 0 -o $res -ge 128 ]; then
> > +	  echo >&2 "bisect run failed:"
> > +	  echo >&2 "exit code $res from '$@' is < 0 or >=3D 128"
> > +	  exit $res
> > +      fi
>
> I am not sure if this flexibility/leniency is desirable.  It
> certainly allows a sloppily written shell script that exits with
> any random small-positive values to report a badness, which may
> be handy, but allowing sloppiness might lead to wasted time
> after all.  I dunno.  A more strict convention that says the run
> script should exit 1 to signal "bad, please continue", 0 for
> "good, please continue" and other values for "no good, abort"
> might be less error prone.

Perhaps, but when running "git bisect run make" to automatically find t=
he=20
commit that broke the build, it would fail because make will usually re=
turn=20
2 in case of error.=20

It seems that there are few standards for exit code, so whatever conven=
tion=20
we choose will not work in all cases.

> In any case, the exit status convention needs documentation.

Yes, I will work on it.

[...]

> > +      # Use "git-bisect good" or "git-bisect bad"
> > +      # depending on run success or failure.
> > +      # We cannot use bisect_good or bisect_bad functions
> > +      # because they can exit.
> > +      if [ $res -gt 0 ]; then
> > +	  next_bisect=3D'git-bisect bad'
> > +      else
> > +	  next_bisect=3D'git-bisect good'
> > +      fi
> > +
> > +      $next_bisect > "$GIT_DIR/BISECT_RUN"
>
> If their exiting, and possibly variable assignments, are the
> only problem, you can run that in subshell, can't you?  Like:
>
> 	( $next_bisect >"$GIT_DIR/BISECT_RUN" )

You are right. I will submit an updated patch with this change and some=
=20
documentation.

Thanks,
Christian.

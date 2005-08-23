From: Junio C Hamano <junkio@cox.net>
Subject: Re: Multi-head pulling series
Date: Mon, 22 Aug 2005 22:37:40 -0700
Message-ID: <7virxxw6vv.fsf@assigned-by-dhcp.cox.net>
References: <7vek8rlnbn.fsf@assigned-by-dhcp.cox.net>
	<200508181245.58250.Josef.Weidendorfer@gmx.de>
	<7vfyt4l9q9.fsf@assigned-by-dhcp.cox.net>
	<200508221835.31275.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 23 07:38:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7RTm-0004O6-80
	for gcvg-git@gmane.org; Tue, 23 Aug 2005 07:37:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbVHWFhn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 01:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbVHWFhn
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 01:37:43 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:6535 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750722AbVHWFhn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2005 01:37:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050823053741.WOVU16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 23 Aug 2005 01:37:41 -0400
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200508221835.31275.Josef.Weidendorfer@gmx.de> (Josef
	Weidendorfer's message of "Mon, 22 Aug 2005 18:35:31 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

> I think that both, default and non-default persistant
> mappings, are only a handy convenience issue for less
> typing. If GIT core is not doing this, some (most?) porcelains
> will invent their own way for storing these mappings.

Suppose I have something like this in $GIT_DIR/remotes/ko:

    URL: master.kernel.org:/pub/scm/git/git.git/
    Pull: master:ko-master rc:ko-rc pu:ko-pu
    Push: master:master pu:pu rc:rc
    Default-Pull: master rc

That is, "Pull/Push" describe only the default mappings, and
"Default-Pull/Default-Push" names the refs pulled or pushed when
only the shorthand (ko) is specified.  I think that is what your
proposal boils down to.  Lack of "Default-Push" just means use
the heads listed on "Push" line for the default.

Am I reading you right so far?

With that definition, what these would do would be intuitive and
obvious:

    $ git push ko  ;# my master, rc, and pu goes there, under
                    # the same name.
    $ git fetch ko ;# their master comes to my ko-master, rc to my ko-rc
                    # pu is not touched.

But now, what should this do?

    $ git fetch ko master

(1) does it use "Pull" mappings and use their "master" to fast
    forward my "ko-master"?

or

(2) does it obey "the command line overrides the configuration
    file" principle and fetch their "master" but not touch my
    local refs (remember, refspec "master" without colon is
    equivalent to "master:" in fetch, which means "get the
    objects to complete it, but do not store the ref locally")?

If (1), then I would need to say "master:something" on the
command line almost all the time, because the point of remotes/
configuration file is that I do not have to remember which
remote head corresponds to my local head, and by definition I
would not (and should not have to) know if "master" has the
default mappings specified there and to which head, so even that
"something" happens to be exactly what is in the remotes/ file,
I would end up typing that explicitly.  Which means that it
defeats the point of having the configuration file to begin
with.

If (2), then I would again need to say master:ko-master if I
wanted to mean "usually I pull from some heads (I do not
remember which ones offhand, but my .git/remotes/ file would
know), but this time I want to only pull from master and update
ko-master".

What this suggests to me is that making set of default refs to
be pulled from and set of ref mappings orthgonal sounds like a
good and clean way in theory, but would not be that much useful
in practice.

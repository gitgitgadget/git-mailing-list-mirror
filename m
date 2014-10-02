From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: $GIT_CONFIG should either apply to all commands, or none at all
Date: Wed, 1 Oct 2014 18:15:46 -0700
Message-ID: <20141002011546.GR1175@google.com>
References: <20141002001034.24160.11848.reportbug@fabul.fbriere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?iso-8859-1?B?RnLpZOlyaWMgQnJp6HJl?= <fbriere@fbriere.net>
X-From: git-owner@vger.kernel.org Thu Oct 02 03:15:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZUzq-0001w2-IS
	for gcvg-git-2@plane.gmane.org; Thu, 02 Oct 2014 03:15:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753520AbaJBBPu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Oct 2014 21:15:50 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:33253 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753300AbaJBBPt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2014 21:15:49 -0400
Received: by mail-pd0-f174.google.com with SMTP id y13so1139929pdi.33
        for <git@vger.kernel.org>; Wed, 01 Oct 2014 18:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=TJ7zURHcjLqxb96viBdY2oMkzKYk38Mpe+oBa1cEWEo=;
        b=HHl2XRFGip4rIK3gvyaVjT2oUx7LVXvQNn/0kIKuqFoLQhE6ThqLD4zXNWOWwwYKJ9
         +7uT/h31OUsjtPx2PPU6X4LQREELR8Nil9xRF6mk7PMJWJKr9Qhv2quIZ159cDtCX4q7
         c++VI3qIRoDLz87jApPENtXh5kSUlsXA5RmhLkJB+ogWmnRws/s0Ma4M+0FjPa/tf1JT
         AMP3DG9uFBgOuFMyznBBNyV4KU2EvHyXUQdYKx1yFnA0REntGkFuccZedXdt+ZLucBG1
         eGnqgEREGcLJob8XYEWbQMJDYd8xxpCEWY4+cJI/Y0lobX9IfOIycUhHtKHOIMDQ/nw0
         jACw==
X-Received: by 10.66.225.141 with SMTP id rk13mr82679723pac.112.1412212549246;
        Wed, 01 Oct 2014 18:15:49 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id zf5sm2045411pbc.44.2014.10.01.18.15.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 01 Oct 2014 18:15:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141002001034.24160.11848.reportbug@fabul.fbriere.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257770>

Hi,

=46r=E9d=E9ric Bri=E8re wrote[1]:

> This kind of stuff caused me a lot of hair-pulling:
>
>   $ git config core.abbrev
>   32
>   git log --pretty=3Doneline --abbrev-commit
>   89be foo
>
> Here's the source of the discrepancy:
>
>   $ grep abbrev $GIT_CONFIG .git/config
>   git.conf:	abbrev=3D32
>   .git/config:	abbrev=3D4
>
> Since dc87183, $GIT_CONFIG is ignored by any other Git command, but i=
t
> *still* applies to git-config.  This basically means that values
> obtained via git-config are not necessarily those which are actually =
in
> effect.
>
> The really frustrating part (for me, at least) is that for any tool
> (gitweb in my case) which uses git-config, values from $GIT_CONFIG wi=
ll
> take effect for that tool, but not for any subsequent Git command.
>
> git-config(1) doesn't make this clear either; it mentions $GIT_CONFIG=
 as
> "the configuration", without saying explicitly that this environment
> variable only applies to git-config.

Yep.  One possibility would be to do something like the following (A):

 1) advertise in the git-config(1) manpage that the GIT_CONFIG
    environment variable only affects the behavior of the 'git config'
    command

 2) introduce an environment variable GIT_I_AM_PORCELAIN.  (If doing
    this, we could come up with a better name, but this is just an
    illustration.)  Set and export that envvar in git-sh-setup.sh.
    When that environment variable is set, make git-config stop paying
    attention to GIT_CONFIG.

    That way, git commands that happen to be scripts would not be
    affected by the GIT_CONFIG setting any more.

 3) Warn when 'git config' is called with GIT_CONFIG set, explaining
    that support will eventually be removed and that callers should
    pass --file=3D instead.

 4) Once we're confident there are no scripts in the wild relying on
    that envvar, remove support for it.

Another possibility (B):

 1) Teach git's commands in C to respect the GIT_CONFIG environment
    variable.  Semantics: only configuration from that file would be
    respected and all other configuration will be ignored.  Advertise
    it in the git(1) manpage.

 2) Gnash teeth a little but continue to support it.

Yet another possibility (C):

 1) Just skip to step (4) from plan (A).

C is kind of temping.  Do you know if there are scripts in the wild
that rely on the GIT_CONFIG setting working?

Thanks for reporting,
Jonathan

[1] http://bugs.debian.org/763712

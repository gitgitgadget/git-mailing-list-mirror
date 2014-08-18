From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Relative submodule URLs
Date: Mon, 18 Aug 2014 13:55:05 -0700
Message-ID: <20140818205505.GA20185@google.com>
References: <CAHd499CRNjp-UzXiTt=xgDJWGOEqew+AuPFmrF3-VsEGefXiuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 18 22:55:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJTxe-0003hT-2o
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 22:55:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979AbaHRUzN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2014 16:55:13 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:58154 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941AbaHRUzM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2014 16:55:12 -0400
Received: by mail-pa0-f53.google.com with SMTP id rd3so8547231pab.12
        for <git@vger.kernel.org>; Mon, 18 Aug 2014 13:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=NBOKBcphBu3Sz49etSMrZOL5b1btREHDhB8ptj96zLI=;
        b=eiG07P/jXySnU92QyYzu5A5fG4NjaXu2b86V4NxxmrXc5WdSmVDayDBishnZs/jzX7
         V31ikCHiJqm8siomCqlAtcJWkWEc1rT3b36GsXhPXlnfPPELHOD1wBhVt30I0+vEmCAL
         nk19ol63SfSmO37kZexdyw3iaFOwsyH2b2KR0+bSm4dvpD2ne8eFwxcaSAjOU9Gywilz
         vduPP2SLi2MD797IabiUK7FVp3OKLV/er3/XJu30fDBDFu5slqxpYFcCXopwnEVFZGWO
         fPXTrYi2P8xBBKRzj77k7V7JJBTwANGg6wTNCV/o3wZm5h8NkuyAP/iAtRvq1cm+DXeS
         0ubg==
X-Received: by 10.66.102.40 with SMTP id fl8mr13454346pab.147.1408395311980;
        Mon, 18 Aug 2014 13:55:11 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:a15c:f8:8036:3f5e])
        by mx.google.com with ESMTPSA id fw9sm8174689pdb.45.2014.08.18.13.55.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 18 Aug 2014 13:55:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAHd499CRNjp-UzXiTt=xgDJWGOEqew+AuPFmrF3-VsEGefXiuA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255409>

Hi,

Robert Dailey wrote:

> The documentation wasn't 100% clear on this, but I'm assuming by
> "remote origin", it says that the relative URL is relative to the
> actual remote *named* origin (and it is not using origin as just a
> general terminology).

Thanks for reporting.  The remote used is the default remote that "git
fetch" without further arguments would use:

	get_default_remote () {
		curr_branch=$(git symbolic-ref -q HEAD)
		curr_branch="${curr_branch#refs/heads/}"
		origin=$(git config --get "branch.$curr_branch.remote")
		echo ${origin:-origin}
	}

The documentation is wrong.  git-fetch(1) doesn't provide a name for
this thing.  Any ideas for wording?

> Is there a way to specify (on a per-clone basis) which named remote
> will be used to calculate the URL for submodules?

Currently there isn't, short of reconfiguring the remote used by
default by "git fetch".

> Various co-workers use the remote named "central" instead of
> "upstream" and "fork" instead of "origin" (because that just makes
> more sense to them and it's perfectly valid).
>
> However if relative submodules require 'origin' to exist AND also
> represent the upstream repository (in triangle workflow), then this
> breaks on several levels.

Can you explain further?  In a triangle workflow, "git fetch" will
pull from the 'origin' remote by default and will push to the remote
named in the '[remote] pushdefault' setting (see "remote.pushdefault"
in git-config(1)).  So you can do

	[remote]
		pushDefault = whereishouldpush

and then 'git fetch' and 'git fetch --recurse-submodules' will fetch
from "origin" and 'git push' will push to the whereishouldpush remote.

It might make sense to introduce a new

	[remote]
		default = whereishouldfetch

setting to allow the name "origin" above to be replaced, too.  Is that
what you mean?

Meanwhile it is hard to fork a project that uses relative submodule
URLs without also forking the submodules (or, conversely, to fork some
of the submodules of a project that uses absolute submodule URLs).
That's a real and serious problem but I'm not sure how it relates to
the names of remotes.  My preferred fix involves teaching git to read
a refs/meta/git (or similarly named) ref when cloning a project with
submodules and let settings from .gitmodules in that ref override
.gitmodules in other branches.  Is that what you were referring to?

Curious,
Jonathan

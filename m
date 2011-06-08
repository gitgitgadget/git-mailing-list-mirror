From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 03/19] t5800: document some non-functional parts of
 remote helpers
Date: Wed, 8 Jun 2011 14:28:51 -0500
Message-ID: <20110608192850.GF27715@elie>
References: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
 <1307558930-16074-4-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 21:29:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUOR5-0001k1-B9
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 21:29:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754946Ab1FHT26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 15:28:58 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44953 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754492Ab1FHT25 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 15:28:57 -0400
Received: by iyb14 with SMTP id 14so690760iyb.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 12:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=TO5+9mGtttS78mDz5w37nvjV/5QfaDyH43e16OhVEdI=;
        b=LrAPmb3Wl8v0m9TTMfHBsd/mETTuDbUJLGWW7WwNHqgNe4YxcwlSTh5atr+dfumfm8
         fsE1LMgbbXow5Y45vtqicUCTghb8OsiJRITf/G9y4uMZnKd0ygnk8fd2IGhWUkhy0C7O
         jdMoDY3+J6AB7iA5wue1nwOyNW6WrFjxvVCK4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=thylWfICUmJv7/6u78ZVAombUO25RcVzsJe9kboyUfvgVSVUVTGViOEqcXFcFkXmAa
         tygypUioclv50AQ2A9xBwBSLkO1byoT/hCUrygb3OBxCxy4mv137IWS+bjG+YoBNWyDX
         8TYF3HfGeU8eshO4/m5MoEKklnRlfZYAMjiww=
Received: by 10.42.29.137 with SMTP id r9mr13124441icc.227.1307561336650;
        Wed, 08 Jun 2011 12:28:56 -0700 (PDT)
Received: from elie (adsl-69-209-61-87.dsl.chcgil.ameritech.net [69.209.61.87])
        by mx.google.com with ESMTPS id d8sm678830icy.9.2011.06.08.12.28.53
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 12:28:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1307558930-16074-4-git-send-email-srabbelier@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175447>

Sverre Rabbelier wrote:

[....]
> The fifth test is the most complex, and does not have a fix
> in this series. It tests pushing a ref via the export
> mechanism to a new name on the remote side (i.e.,
> "git push $remote old:new").

Thanks.  Makes sense up to here (and the previous two patches are
obviously good, too).

> The problem is that we push all of the work of generating
> the export stream onto fast-export,

Here "we" means remote-testgit, not transport-helper, right?

> but we have no way of
> communicating to fast-export that this name mapping is
> happening.

It's not just name mapping, no?  E.g., I could try

	git push testgit::/path/to/repo $(git rev-parse HEAD):new

So I think the current implementation of "export" by testgit
is just wrong. ;-)

[...]
> There are two possible solutions:
>
>   1. Indicate the mapping to fast-export, so that it can
>      generate the "mapped" names. Unfortunately, this is
>      somewhat difficult due to the way fast-import is
>      implemented. It feeds its revision parameters to the
>      regular rev-walking machinery

This seems like a reasonable solution.  One way would be to teach
fast-export about refspecs; another way would be to set up refs in a
private namespace and then munge the stream that fast-export spits out
before passing it back to the transport-helper; another (more ugly and
hackish) way would be to set up a private repository with the real
repository set up as an alternate, put the appropriate refs there, and
point fast-export to that.

Anyway, I don't think this should be in the commit message for the new
test which doesn't even know about the remote helper protocol. :)

> --- a/t/t5800-remote-helpers.sh
> +++ b/t/t5800-remote-helpers.sh
> @@ -81,4 +81,51 @@ test_expect_success PYTHON_24 'pushing remote local repo' '
>  	compare_refs clone HEAD server HEAD
>  '
>  
> +test_expect_failure PYTHON_24 'fetch new branch' '

Side note: this repeated PYTHON_24 implementation detail as a
prerequisite feels wrong.  Would it make sense to do something like

	if test_have_prereq PYTHON_24
	then
		test_set_prereq REMOTE_TESTGIT
	fi

at the start and use that?

[...]
> +test_expect_failure PYTHON_24 'push new branch with old:new refspec' '
> +	(cd clone &&
> +	 git push origin new-name:new-refspec
> +	) &&
> +	compare_refs clone HEAD server refs/heads/new-refspec
> +'

It would also be interesting to test tag pushes and pushes by object
name.

	(cd clone &&
	 git tag -a -m 'example tag' example-tag &&
	 git push origin tag example-tag
	) &&
	compare_refs clone example-tag server refs/tags/example-tag

	(cd clone &&
	 file_blob=$(git rev-parse --verify HEAD:file) &&
	 git push origin "$file_blob":refs/blobs/file
	) &&
	compare_refs clone HEAD:file server refs/blobs/file

	(cd clone &&
	 echo more >>file &&
	 git add file &&
	 file_blob=$(git rev-parse --verify :file) &&
	 git push origin "$file_blob":refs/blobs/newfile
	) &&
	compare_refs clone :file server refs/blobs/newfile

	(cd clone &&
	 echo more >>file &&
	 git commit -a -m another &&
	 git push origin HEAD^0:master
	) &&
	compare_refs clone HEAD server HEAD

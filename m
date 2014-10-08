From: David Aguilar <davvid@gmail.com>
Subject: Re: configure names for temporary files
Date: Wed, 8 Oct 2014 01:22:30 -0700
Message-ID: <20141008082228.GA78852@gmail.com>
References: <CALpL35mjtg9ge321Vz_kS1wzbYz+z9H5R3L8FcpVSNO3AtZzVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Sergio Ferrero <sferrero@ensoftcorp.com>
X-From: git-owner@vger.kernel.org Wed Oct 08 10:22:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbmVT-0002uk-4x
	for gcvg-git-2@plane.gmane.org; Wed, 08 Oct 2014 10:21:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754786AbaJHIVy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2014 04:21:54 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:43773 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753639AbaJHIVw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2014 04:21:52 -0400
Received: by mail-pd0-f177.google.com with SMTP id v10so6490182pde.36
        for <git@vger.kernel.org>; Wed, 08 Oct 2014 01:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ht6ao21HErNIzvApEjpt9bzj74Jv2vt1vTc6FdAViIc=;
        b=f/q44t2pMu13rQMsBpy6HgjD+39G9TDz3zLE7wFcLFJyAMKWxOXjI2yt3oFERbhSIh
         VK3TI0bov0uz/eSP0fqD5s1GLkCB1N2YomVROP34EAH2N26aA/ED87wZkChrvl7sUy0i
         jn5brHd/dbs1phKYsBrcL76rag3dNp9NRz4S1KwD/NygJDjAG797Ztq8/60mAyM/haPS
         HZ+bZ9iw1v45CzY2qZQQO+gyO2MUeD5brLmd84l+3jXZjOspFdPAaDDlaalX4QtBqy9m
         vL43PK6rEt/6s6uGQl3CoGGyPEBDbh5y1VeSCHYaak8umBNkvOUxFWquGs0yDk9FHmIm
         cvXg==
X-Received: by 10.68.231.228 with SMTP id tj4mr2734832pbc.126.1412756511831;
        Wed, 08 Oct 2014 01:21:51 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id m2sm11050023pdl.14.2014.10.08.01.21.50
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 08 Oct 2014 01:21:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALpL35mjtg9ge321Vz_kS1wzbYz+z9H5R3L8FcpVSNO3AtZzVA@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 07, 2014 at 11:33:16AM -0300, Sergio Ferrero wrote:
> Hello,
> 
> I'd like to configure git with a specific merge tool to merge Simulink
> model files.
> I have followed the steps to configure the merge tool successfully.
> 
> I typed the following on Git Bash:
> 
>    git config --system mergetool.<merge_tool_name>.cmd '"<merge_tool_path>"
> -base "$BASE" -local "$LOCAL" -remote "$REMOTE" -merged "$MERGED"'
> 
> where:
> 
>    - <merge_tool_name> is the name of the specific merge tool
>    - <merge_tool_path> is the full path to the .exe file for the merge tool
>    - the merge tool accepts the -base, -local, -remote and -merged arguments
> 
> 
> Then, after a merge detects conflicts on a Simulink model, I run the
> following command on the Git Bash:
> 
>    git mergetool -t <merge_tool_name> <model_name>.mdl
> 
> 
> This command properly launches the GUI of the merge tool, however it
> indicates that provided file names are invalid. They are of the form:
> <model_name>.mdl.<revision>.#.mdl,
> where <revision> is either LOCAL, REMOTE or BASE and # is a number.
> 
> The merge tool needs to open the model in MATLAB and MATLAB does not allow
> opening models with '.' in their names.
> 
> Thus, is there a way to configure Git so that temporary models are of the
> form <model_name>_mdl_<revision>_#.mdl instead of <
> model_name>.mdl.<revision>.#.mdl?

No such option exists.

In theory you could come up with a way to make this configurable.
A configuration variable could define a file pattern, for example.

The downside is making it configurable means supporting some
micro-format and the implementation would probably be ugly and
require eval. I don't think it needs to be configurable.

Right now the code flow is roughly:

	MERGED=foo/bar.baz

	ext="$$$(expr "$MERGED" : '.*\(\.[^/]*\)$')"
	BACKUP="./$MERGED.BACKUP.$ext"
	LOCAL="./$MERGED.LOCAL.$ext"
	REMOTE="./$MERGED.REMOTE.$ext"
	BASE="./$MERGED.BASE.$ext"

This results in a path that looks like:

	./foo/bar.baz.BASE.81001.baz

I think we can do better by default.
A more conservative result would something like:

	./foo/bar_BASE_81001.baz

Consequently, matlab (and perhaps other overly-picky tools) are
more likely to accept this path since it fits into their
windows-esque worldview where filenames can have at most 1 dot.

You should also email matlab support and kindly ask them to fix
their buggy software! ;-P foo.bar.baz is a perfectly valid
filename.

In any case, it might be worth adjusting mergetool to use a more
conservative path (underscores instead of dots) since there
doesn't seem to be much downside to doing so.
-- 
David

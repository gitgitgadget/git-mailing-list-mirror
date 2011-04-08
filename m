From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFH] eol=lf on existing mixed line-ending files
Date: Fri, 08 Apr 2011 11:36:20 +0200
Message-ID: <4D9ED714.80307@drmicha.warpmail.net>
References: <20110407231556.GA10868@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Mislav Marohnic <mislav@github.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 08 11:36:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q887A-00021A-MO
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 11:36:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755385Ab1DHJgX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 05:36:23 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:44561 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754554Ab1DHJgW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Apr 2011 05:36:22 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 2169320B8F;
	Fri,  8 Apr 2011 05:36:22 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Fri, 08 Apr 2011 05:36:22 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=AsGAe5L9c1qG3ag4Y1ixF05jYw0=; b=MNaAMxZKX+MrmrueE+WUvATHBkN+PBzX0z+qy86iduASoEQ3aL7Q4tYL2c+OV3gl7ied7NsMgmJSWFbxh34ncHiY4Xk+m55ghqPTDidVPJPIwL/WKFCVSeuMBL9iav5oGJK1csATQk42V70uCjgAGW2pTv/UBQg8iasrHHwUjSE=
X-Sasl-enc: zEDUaHc4IUNAQWJrs1WWf5QiJDKbJLuvF419pGeFJEcO 1302255381
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 647F0449A50;
	Fri,  8 Apr 2011 05:36:21 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <20110407231556.GA10868@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171119>

Jeff King venit, vidit, dixit 08.04.2011 01:15:
> I investigated some odd git behavior with the EOL gitattributes today,
> and I'm curious to hear what others on the list think of what git does.
> In particular, index raciness means git produces non-deterministic
> results in this case.
> 
> The repo in question has a gitattributes file with "* crlf=input" (which
> we would spell "eol=lf" these days, but the results are the same), but
> still contains some files with mixed line endings. Which you can
> reproduce with:
> 
>   git init repo &&
>   cd repo &&
>   {
>     printf 'one\n' &&
>     printf 'two\r\n'
>   } >mixed &&
>   git add mixed &&
>   git commit -m one &&
>   echo '* eol=lf' >.gitattributes
> 
> Now if we run "git status" or "git diff", it will let us know that
> "mixed" is modified, insofar as adding and committing it would perform
> the LF conversion.
> 
> Now we come to the first confusing behavior. Generally one would expect
> the working directory to be clean after a "git reset --hard". But not
> here:
> 
>   git reset --hard &&
>   git status
> 
> will still show "mixed" as modified. Because of course we are checking
> out the version from HEAD into the index and working tree, which has the
> mixed line endings. So we rewrite the identical file.
> 
> So that kind of makes sense. But it isn't all that helpful, if I just
> want to reset my working tree to something sane without making a new
> commit (more on this later).
> 
> But here's an extra helping of confusion on top. Every once in a while,
> doing the reset _won't_ keep "mixed" as modified. I can trigger it
> reliably by inserting an extra sleep into git:
> 
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 500ebcf..735b13e 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -223,6 +223,7 @@ static int check_updates(struct unpack_trees_options *o)
>  		}
>  	}
>  	stop_progress(&progress);
> +	sleep(1);
>  	if (o->update)
>  		git_attr_set_direction(GIT_ATTR_CHECKIN, NULL);
>  	return errs != 0;
> 
> That puts a delay between when reset writes the "mixed" file, and when
> we write out the refreshed index. So next time we look at the index
> (e.g., in "status"), we will see that the "mixed" entry has up-to-date
> stat information and not look at its actual contents.
> 
> But in the original case (without the sleep), that doesn't happen.
> There, we usually end up writing the file and the index in the same
> second. So when status looks at the index, the "mixed" entry is racily
> clean, and we actually check it again.
> 
> So we get two different outcomes, depending on the index raciness. Which
> one is right, or is it right for it to be non-deterministic?
> 
> And one final question. Let's say I don't immediately convert this mixed
> file to the correct line-endings. Instead, it persists over a large
> number of commits, some of them even changing the "mixed" file but not
> fixing the line endings[1]. We can simulate that with:
> 
>   mv .gitattributes tmp
>   echo three >>mixed &&
>   git commit -a -m three &&
>   mv tmp .gitattributes
> 
> Now imagine I am somebody who has cloned this repo; the clone will tend
> to end the race condition in the "clean" state, since it will often take
> more than 1 second to write out all of the files (at least for a
> normal-sized project). We can simulate using our sleep-patched reset:
> 
>   git reset --hard
> 
> to get a "clean" repo. Now let's say I want to explore old history, so I
> go to a detached HEAD, but using normal git, not the sleep-patched one:
> 
>   git checkout HEAD^
> 
> And, of course, now we think "mixed" is modified. After I'm done
> exploring, I want to go back to "master", but I can't:
> 
>   $ git checkout master
>   error: Your local changes to the following files would be overwritten by checkout:
>           mixed
> 
> What is the best way out of this situation? You can't use "reset --hard"
> to fix the working tree. I guess "git checkout -f" is the best option.
> 
> Hopefully my example made sense and was reproducible. The real repo
> which triggered this puzzle was jquery. You can try:
> 
>   git clone git://github.com/jquery/jquery.git &&
>   cd jquery &&
>   git checkout 1.4.2 &&
>   git checkout master
> 
> which will fail (but may succeed racily on a slow enough machine).
> Obviously they need to fix the mixed line-ending files in their repo.
> But that fix would be on HEAD, and "git checkout 1.4.2" will be forever
> broken. Is there a way to fix that?
> 
> -Peff
> 
> [1] The one thing still puzzling me about the jquery repo is how they
> managed to make so many commits (including ones to mixed line ending
> files) without seeing the dirty working tree state and committing it. Is
> there some combination of config that makes this not happen?

When did they introduce the .gitattributes file?
Also, maybe they're jgit users.

Michael

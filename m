From: Fabian Ruch <bafain@gmail.com>
Subject: Re: [PATCH v1 07/19] rebase -i: log the replay of root commits
Date: Mon, 04 Aug 2014 23:21:41 +0200
Message-ID: <53DFF965.8020808@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1406589435.git.bafain@gmail.com> <7389745946359e0d9d8c6f1e8f2ebc78033132e6.1406589435.git.bafain@gmail.com> <20140802000405.GB20040@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 04 23:21:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEPhV-0007cB-Vx
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 23:21:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124AbaHDVVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 17:21:46 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:38725 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724AbaHDVVo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 17:21:44 -0400
Received: by mail-wg0-f44.google.com with SMTP id m15so25236wgh.15
        for <git@vger.kernel.org>; Mon, 04 Aug 2014 14:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=zs5x16APM4tO3jT1wyTsahOB1KXvaKyXcibsNd+14Ck=;
        b=ZkgGhRkZAXYlZavheH/cqOkhvAYWUuVN2zHtBazGT76QE0HywVC0MzJuUSRIHPfmoJ
         Artajbd31S3+utqNhXM9Sbnb3ELVids0tYv4d3ANIkTsZO5TlaSWzHeiXc2PQpgChP58
         e5SF7yLnoXdb4fLwMA2/bij++15hUQQtD+pKWTRtGJ+pWVjEzSNtObz+HzHgXkJ4gyPJ
         z8Da87JymIrZTaiwhUngtWZBAGspcERABtfuGrjiEBJ3c2Te9YGXSeCn8JW0KZwSOUwL
         iC9ic04MeomUg64sbSIstCOwgKvceEemFypzrbZCug09lU2qwR/oTD0f5rGibTmrNgYV
         dRIg==
X-Received: by 10.194.109.71 with SMTP id hq7mr8648765wjb.114.1407187303397;
        Mon, 04 Aug 2014 14:21:43 -0700 (PDT)
Received: from client.googlemail.com (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id y10sm763827wie.18.2014.08.04.14.21.41
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 04 Aug 2014 14:21:42 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <20140802000405.GB20040@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254785>

Hi,

Jeff King writes:
> On Tue, Jul 29, 2014 at 01:18:07AM +0200, Fabian Ruch wrote:
>> The command line used to recreate root commits specifies the option
>> `-q` which suppresses the commit summary message. However,
>> git-rebase--interactive tends to tell the user about the commits it
>> creates in the final history, if she wishes (cf. command line option
>> `--verbose`). The code parts handling non-root commits and squash
>> commits all output commit summary messages. Do not make the replay of
>> root commits an exception. Remove the option to make the report of
>> the rebased history complete.
>>
>> It is OK that the commit summary is still suppressed when git-commit
>> is used to initialize the authorship of the sentinel commit because
>> this additional commit is an implementation detail hidden from the
>> final history. The removed `-q` option was probably introduced as a
>> copy-and-paste error stemming from that part of the root commit
>> handling code.
> 
> I'm confused. This implies that we should be seeing summaries for other
> commits, but not root commits, and this patch is bring them into
> harmony.  But if I have a repo like this:
> 
>   git init -q repo &&
>   cd repo &&
>   for i in one two; do
>     echo $i >file &&
>     git add file &&
>     git commit -q -m $i
>   done
> 
> then using stock git gives me this:
> 
>   $ GIT_EDITOR=true git rebase -i --root 2>&1 | perl -pe 's/\r/\\r\n/g'
>   Rebasing (1/2)\r
>   Rebasing (2/2)\r
>   Successfully rebased and updated refs/heads/master.
> 
> but with your patch, I get:
> 
>   $ GIT_EDITOR=true git.compile rebase -i --root 2>&1 | perl -pe 's/\r/\\r\n/g'
>   Rebasing (1/2)\r
>   [detached HEAD 60834b3] one
>    Date: Fri Aug 1 20:00:05 2014 -0400
>    1 file changed, 1 insertion(+)
>    create mode 100644 file
>   Rebasing (2/2)\r
>   Successfully rebased and updated refs/heads/master.
> 
> Am I misunderstanding the purpose of the patch?

Thanks for laying out the differences in the user visible output. With
stock git we are seeing summaries for other commits, but not root
commits, _with the --verbose option_. It's the fault of my patch to show
the summary even in non-verbose mode. This is now fixed by wrapping the
relevant command in 'output', a shell function defined in git-rebase.sh
as follows:

> output=$("$@" 2>&1 )
> status=$?
> test $status != 0 && printf "%s\n" "$output"
> return $status

The problem that git-rebase--interactive has is that the redirection of
stdin to a variable (or a file) does not work reliably with commands
that invoke the log message editor, that is 'reword' and 'squash'
produce their output both in verbose and non-verbose mode. I wouldn't
know how to fix this but

1) invoking $GIT_EDITOR from git-rebase--interactive.sh, but to make
this right there should be a built-in command for shell scripts and an
interface for git-commit that prepare the editor contents like
git-commit does now, or

2) forcing $GIT_EDITOR and git-commit to print on distinct file
descriptors, which would involve temporarily wrapping the $GIT_EDITOR
call in a shell script that redirects stdin to some other file
descriptor similar to what t/test-lib.sh does, or

>         cat >"$state_dir"/editor.sh <<EOF
> #!/bin/sh
> $(git var GIT_EDITOR) \$* >&3
> EOF
>         chmod +x "$state_dir"/editor.sh
>         (
>                 export GIT_EDITOR="$state_dir"/editor.sh
>                 "$@" 3>&1 >"$state_dir"/output 2>&1
>         )

3) passing the --quiet option in non-verbose mode and omitting it in
verbose mode, which would cover the '$status != 0' above for if a
command fails, it should indicate its error status despite being asked
to be silent.

Options 2) and 3) seem attainable within this patch series and 3) sounds
like the cleanest option but I'm uncertain if I'm missing something
here. The only command line that is wrapped in 'output' and that doesn't
support a --quiet option seems to be a 'warn' line which could simply be
skipped in non-verbose mode. (Johannes Schindelin is cc'd as the
original author of git-rebase--interactive.sh and 'output' in particular).

   Fabian

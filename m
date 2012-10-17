From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: feature request
Date: Wed, 17 Oct 2012 11:00:37 +1100
Message-ID: <CAH5451k4SQdbzx5euuFg2eNisiMXRG6jXGS76pbgqA+djoFy+A@mail.gmail.com>
References: <CAB9Jk9AwTVM4TPwPg1Gmi8TCnnXWUsMAfaz8DdfcEhBNW_15Ug@mail.gmail.com>
 <CAH5451=1VU6oUzAyGXZvOW-Pk3+Os1mq1neum572venNjRfT+g@mail.gmail.com> <CAB9Jk9DaJnN9wmzi-4P3+PqBOobOapnU50y5zkKV9-1CNpV3Yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 02:01:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOH4Q-0008O5-Kw
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 02:01:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755631Ab2JQABA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 20:01:00 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:49325 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755506Ab2JQAA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 20:00:59 -0400
Received: by mail-qc0-f174.google.com with SMTP id o22so1616946qcr.19
        for <git@vger.kernel.org>; Tue, 16 Oct 2012 17:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=eCUTp5FQ6/1xOOvWCT8BOkL0zNzs5lrCKwZ+8x4BvZQ=;
        b=FYlwT2SMYU+/GpDcqsYx5NE9/Ss2SCZO/vNeCNOtzt5hHzBTsT2PHB8VDSJdVV2vBl
         LkyMV6ZSPyIa10QldRxbSapFd2Eqp8Y9gbsfRAT9NrO0o1OVL5PfhRA79xtkHpqKXJUG
         zwC6gas/CqBpb7Aq5X4tY79/tngN0u9xseTOsd5tBlHEIh0tbte9/VuUarFpyB23aLlM
         gETAfyZ+davnK+brWaNiuQzMSksXlqMnWqmzubqTGqzgLDFHkZ8JPj4hsIlQRNcUfkjI
         LSqNNGxcrlXg0Hxxn/iHGPv/lR+00wDNQy+MeMLChO8pSiqZD9qQu6tJb0Wmug1WXpWL
         X/4w==
Received: by 10.229.106.166 with SMTP id x38mr7825069qco.75.1350432058352;
 Tue, 16 Oct 2012 17:00:58 -0700 (PDT)
Received: by 10.49.58.225 with HTTP; Tue, 16 Oct 2012 17:00:37 -0700 (PDT)
In-Reply-To: <CAB9Jk9DaJnN9wmzi-4P3+PqBOobOapnU50y5zkKV9-1CNpV3Yw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207887>

On 17 October 2012 04:27, Angelo Borsotti <angelo.borsotti@gmail.com> wrote:
> Hi Andrew,
>
> one nice thing is to warn a developer that wants to modify a source
> file, that there is somebody else changing it beforehand. It is nicer
> than discovering that at push time.
> Take into account that there are changes in files that may be
> incompatible to each other, or that can be amenable to be
> automatically merged producing wrong results. So, knowing it could
> help.
>
> -Angelo

If you simply want to know when a file has been changed by someone
else, git already has this capability, but as you note it only occurs
when you try to push. Unless you force push, you have to merge changes
before committing to upstream. In a distributed situation you can only
inform the user when they 'touch-base' with the server, and if that is
what you want than one of the locking systems others have proposed
might be a good choice.

There are two concerns to deal with here. The first is when any
conflicts at all will cause problems, as there is no way to merge
them. This often happens with binary files, and is a good reason to
use a locking system. The second concern is situations where a merge
happens 'silently' (i.e. no conflicts) thus allowing potential logic
bugs to be introduced even though semantically the merge was fine. For
this situation the best option is to require whoever is merging to
check the merge output for logical errors. This has to happen anyway,
as it is possible for logical errors to be introduced across different
files, although it's probably more common to see logic conflicts
within the one file. To make it easier to discover such changes early
in the process you could write a tool that did some (or all) of the
following:
1. Automatically fetch changes from remote repositories at a regular interval.
2. Compare files changed in the working tree and index to changes
fetched from remote repositories. This would need to find the merge
base of the two and compare files touched since then.
3. Notify the user of the files that have been changed through some fashion.
4. Automatically push changes to a 'wip' branch so that others can see
what you are modifying. Alternatively, automatically publish a list of
changed files for the same purpose, though this seems a lot more hacky
(though both options are surely hacky).

2 and 3 could be combined into a single tool run whenever the user
wants to check for potential logic changes down the track. Automating
it would allow for this information to be communicated a bit faster.
Running it after each fetch would be a nice to have. Pushing the work
in progress branch is something I am not sure is a good idea, but it
would be the only way to know when someone else is working on
something before they commit and push it manually. Pushing a single
file with files being worked on is less invasive, but would require
the other aspects of the tool to use it as well (hence forming a
stronger coupling and reducing the usefulness of the other components
as standalone tools).


There is no way that I know of to force merge to stop every time the
file is changed on both theirs and ours (regardless of whether or not
it is an actual conflict or not). It could potentially be done with a
pre-merge hook, but no such hook exists to my knowledge. If this were
implemented, using it would make merging a potentially tiresome
affair, however I could see its usefulness for people who were very
concerned about introducing logic errors with merges on the same file.

The best solution is in my opinion to check what is going to be merged
before you merge it, but a tool to warn that someone else is modifying
the same file would have its uses.

Regards,

Andrew Ardill

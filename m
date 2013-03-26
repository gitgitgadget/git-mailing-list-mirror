From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Composing git repositories
Date: Tue, 26 Mar 2013 13:26:33 +0530
Message-ID: <CALkWK0=CsuAWQwk5Guf0pbC4_ZEoZiwQpamcRvBGz5LJ0QGKHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Mar 26 08:57:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKOlA-00028w-6n
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 08:57:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759494Ab3CZH5E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 03:57:04 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:50709 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757404Ab3CZH5C (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 03:57:02 -0400
Received: by mail-ie0-f169.google.com with SMTP id qd14so7022184ieb.14
        for <git@vger.kernel.org>; Tue, 26 Mar 2013 00:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to:cc
         :content-type;
        bh=obCl+rHiziNejrvi/SY6r/N6wcz3j//WG5rCgmN2rQU=;
        b=RiSt95rUrKR4AUHYR1O87J+7axt29mz4MZ1wkr4ar9vLIME9TM5X7s+p2EXkeOxSE0
         ROBfGWUOd/JlHeS/4kxsDdFr77RQ5TR2h5ZjTZSIM2ZhDaQlvL5dvAJiP2w7Wwweq409
         KZNR/fT6o6YDtiQ5S85Pw1DczpAw+RQlCdIyR/AGHY2R9Kov2lgThNiMY9vVVXOj2fPH
         JgNBOVqYcPtw2K5TiTfnOpDtAiLuJnJ4YKVS8X/2ho7FefW1UYz3H9r0o4g60JwNKIsN
         JswO6hlQNKK/yjOs1fVRvJgmCkN7AH9SCsJhdHLztTva4m6pdtACTQArL5jgYKfNtG0Z
         d1XA==
X-Received: by 10.50.50.71 with SMTP id a7mr695953igo.14.1364284621798; Tue,
 26 Mar 2013 00:57:01 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Tue, 26 Mar 2013 00:56:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219141>

(Changed subject)
(+CC: Peff; I suspect he'll be interested in the repository
composition discussion)

Jens Lehmann wrote:
> Am 25.03.2013 20:57, schrieb Ramkumar Ramachandra:
>> Okay, I'll do it step-by-step now, with a live example:
>> [...]
>>  What is going on, seriously?
>
> Pilot error, mostly omitting the --recursive option and some
> - fixable - usability issues. Patches welcome.

As a user inexperienced with recursive submodules (I've only used them
in this repository), I found it highly confusing.  Thanks for clearing
them up.

It was highly exaggerated and dramatized to make the following points clear:

1. With the current limitation of cd-to-toplevel, it's extremely
unpleasant to work with many levels of nesting.

2. I thought no operation could be performed without cd-to-toplevel,
as even 'git submodule foo' complains about this (instead of saying
"command not found").  Having to go to each submodule subdirectory to
perform operations is just horrible.

3. To change a submodule, I'll have to propagate the change upwards,
creating new commits in each of the outer submodules, and the
superproject.

Apart from the implementation glitches, I don't like the design;
submodules don't compose well:

1. There's an inherent asymmetry between the superproject and each of
the subprojects, because the superproject owns all the object stores.
Why is it absolutely necessary to relocate the object stores?

2. The metadata is tracked as a file (.gitmodules) in the git
repository.  While it makes it possible for different branches to have
different submodules, it's impossible to say 'git submodule sync
a/b/c/d' (see: 'repo sync'), where b, c haven't been initialized.

3. The current implementation only allows me to compose with commit
objects, but what if I want to compose with refs?  ie. What if I want
to track the tip of the 'master' of a submodule in a superproject?  I
don't want to commit-cascade everytime I make a minor change in a
deeply nested submodule.

Other solutions such as repo (see: depot_tools) solve different
problems but are huge failures when it comes to composability; repo
uses a central manifest repository, for example.  Is it impossible to
build a tool that can truly compose git repositories?  I think
submodules gets a lot of things Right, and we'd have to start from
there.

>> This is just two levels of nesting: with more levels of nesting,
>> things only get worse.
>
> Yes, you cannot have the cake and eat it. Either you incorporate
> everything into a single repo (e.g. using subtree) and loose the
> strong distinction which content belongs to which upstream repo
> (which AFAIK is a valid choice unless you want to contribute back
> to the submodule's upstream) or you'll have to cope with the
> submodule borders showing up from time to time, reminding you
> which part of the work tree has another upstream.

I don't think it's impossible.  We just haven't thought hard enough
about composition.

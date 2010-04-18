From: Nick Edelen <sirnot@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2010, #05; Wed, 14)
Date: Mon, 19 Apr 2010 00:12:06 +0100
Message-ID: <w2ic77435a81004181612u53c5bfbdzd0a138f35a3d81f9@mail.gmail.com>
References: <7vy6gpmwr4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 19 01:12:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3dex-0001Ae-Jl
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 01:12:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609Ab0DRXMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Apr 2010 19:12:10 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:59301 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437Ab0DRXMJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Apr 2010 19:12:09 -0400
Received: by wwb24 with SMTP id 24so2196843wwb.19
        for <git@vger.kernel.org>; Sun, 18 Apr 2010 16:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type;
        bh=AvOSCfhJZneH/c1iBgBAiO1PSarRXqPYwj/2Y5qaFko=;
        b=pZOHp/068MmSfbLXPsMwIVmNxrOysgXfm2Fb0XIQmfcaXZxaeiYuPhco/CX14LpBQG
         hYY3QAp0z7y3cMbCKrGePyZ3aRKZXRFdSqi0hVWWt9LMgVOCLgqodxzSBEorulfHi0zR
         UVyxQzAi/51kVGtk3tZBnEnBbufq/MpFsBOCs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=nJ0qcfJiBIp3khhWcQj2OdvD307OP6AuHTuyfn1o7UGav4ohovtQYmzICu/c/6vB9a
         q/+qvgeQMEvw5pWtxF79444n3lv1gF4ZGNtfMp9Z6jEeDRqbXx4xg80y3Abd0pNfvwBq
         BVbFFieq4wjqQfB4XF4zbFhUq7/n1lb+W0eZY=
Received: by 10.216.177.212 with HTTP; Sun, 18 Apr 2010 16:12:06 -0700 (PDT)
In-Reply-To: <7vy6gpmwr4.fsf@alter.siamese.dyndns.org>
Received: by 10.216.172.194 with SMTP id t44mr5875076wel.207.1271632326340; 
	Sun, 18 Apr 2010 16:12:06 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145258>

>* ne/rev-cache (2010-04-05) 7 commits
> . graft awareness
> . object name support
> . integration into revision walker
> . administrative api and tools
> . support for non-commit objects
> . basic api and porcelain
> . man page and technical docs
>
>For some reason this was extremely hard to read, partly because it had too
>many distracting style violations and too many long lines.

What sort of style violations?  I tried to be quite careful about
that, but evidently I wasn't successful :-/

I'm sorry about the long lines -- all but a handful should fit on a
standard xga resolution screen, which I figured was something of a
minimum for screen width now?

>This duplicates quite a similar traversal logic and hijacks the control
>from sideways in a very core part of the revision walker, making it a
>maintenance nightmare.

I realize that might be a problem, but it seems to be sorta
unavoidable.  The goal is to allow highly-efficient retrieval of
metadata in revision walking, and in order to figure out what metadata
is required (preferably with minimum redundancy), at least some
portion of the revision walker is going to be duplicated.

It was intended to something of an alternative walker in its own
right, which could supplement standard revision traversal by passing
control back and forth based on what was available in the caches.  In
this way the API was to additionally provide a possible doorway for
third-parties to have ready, fast access to the commit tree, without
trudging through individual object files.

I don't think maintenance would really be that nightmarish.  First,
rev-cache is quite distinct from git's core, and is only (tentatively)
integrated by a few lines of code.  It keeps its own cache-slice
format independent from git's objects, and is transparent to almost
every git function (so, e.g., completely changing git's daemon would
have no influence on the rev-cache's effectiveness, as long as
revision walking is not significantly altered).

Second, the key logic is does duplicate (= mainly the interestingness)
is so fundamental that any large change would require a huge rewrite
of most of gits internals anyway, let alone rev-cache.  Other
duplication (e.g. max/min dates) is no harder to alter than in
revision.c; indeed, most of the time it'd be simpler.  Additionally,
for anything more complicated than simple traversal (e.g. pruning)
revision caching is disabled.

Care is taken to make it as unobtrusive as possible: if it can provide
extra help, it will, but as far as git's concerned it dosn't exist.

>After I noticed that it still writes/reads
>structures with bitfields directly on-disk, which I pointed out number of
>times is a no-no during the initial review

Unless I missed something, I had thought I specifically addressed this
issue.  I even went so far as to prevent direct structure writes of
any kind (contrary to the read-cache.c functions, my initial guide for
such strictness), explicitly converting structures to/from char
arrays.

 - Nick

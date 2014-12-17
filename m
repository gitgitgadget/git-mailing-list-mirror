From: Craig Silverstein <csilvers@khanacademy.org>
Subject: Saving space/network on common repos
Date: Tue, 16 Dec 2014 22:58:05 -0800
Message-ID: <CAGXKyzEYhR69w1=4q-xtBagVBwOPqNA9C=AD0bAorB+5eRtVRg@mail.gmail.com>
Reply-To: csilvers@khanacademy.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 17 07:58:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y18Yn-0000cB-F0
	for gcvg-git-2@plane.gmane.org; Wed, 17 Dec 2014 07:58:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899AbaLQG6I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2014 01:58:08 -0500
Received: from mail-ig0-f177.google.com ([209.85.213.177]:56936 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792AbaLQG6H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2014 01:58:07 -0500
Received: by mail-ig0-f177.google.com with SMTP id z20so8418593igj.10
        for <git@vger.kernel.org>; Tue, 16 Dec 2014 22:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=khanacademy.org; s=google;
        h=mime-version:reply-to:date:message-id:subject:from:to:content-type;
        bh=q383x03Afmv4RVrqXLdMyu4pd1AmiFeQLPQOiI0Nygk=;
        b=B8rXQZGrM2Vbr9izdbsJxo/X2PPSbvGOGRY2juPVj6HbqORWBenCQOxwQcieF0LJXG
         2Wcu9jL3WZQMNrPolPp/DtijH/q7LVaBjk0OAcZRFNi3d127SutlSClmEBqUo+Exa8AE
         tE4tPp0JU5cDcWHAEMU3eeRSwAcfjjbCiNzrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:reply-to:date:message-id:subject
         :from:to:content-type;
        bh=q383x03Afmv4RVrqXLdMyu4pd1AmiFeQLPQOiI0Nygk=;
        b=LVLk3GJGeFiZj4/0GJmBrQr0AaaoFjb2BdQw85SaRtmRyPk+SBapuoAeLl95bhVp7s
         4INkHLPGunlhN8tPz3qi8Gjy2IdaNXGkvsanjvQHUUU4STudtKcfr4LL8kdg7kjlzcKY
         aMdld9ueXG5nVBE32pNvha+SDclJpJN9cNoUA5T0uKTQK7DFUdbskb3uRF9v/mVivOUG
         m3YRP4JIMJ44wS2P96Tdt5v02loBq1ao3S9DEcVm30PkziY1KzkwPg0sfddTw4c7sOfD
         RyBrHWldgb5IMZUFTPdEo4tOXCs5t22Fze/cNeYy0p8dod50op/mL0EoKI0wwwGx8a19
         hI5g==
X-Gm-Message-State: ALoCoQnJke4lW/qgoUuH3/yx1WwxCGaFoPy171RJYEyx2p+Eg4qxBfjz4jaRx7q+kaImjtfV544T
X-Received: by 10.50.30.33 with SMTP id p1mr6781311igh.22.1418799485618; Tue,
 16 Dec 2014 22:58:05 -0800 (PST)
Received: by 10.107.7.159 with HTTP; Tue, 16 Dec 2014 22:58:05 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261475>

At Khan Academy, we are running a Jenkins installation as our build
server.  By design, our Jenkins machine has several different
directories that each hold a copy of the same git repository.  (For
instance, Jenkins may be running tests on our repo at several
different commits at the same time.)  When Jenkins decides to run a
test -- I'm simplifying a bit -- it will pick one of the copies of the
repo, do a 'git fetch origin && git checkout <some commit>' and the
run the tests.

Our repo has a lot of churn and some big files, and this git fetch can
take a long time. I'd like to reduce both the time to fetch and the
disk space used by sharing objects between the repo copies.

My research has turned up three techniques that try to address this use case:
* git clone --reference
* git clone --shared
* git clone <local repo>, which creates hard links

I can probably use any of these approaches, but git clone --reference
would be the easiest to set up.  I would do so by creating a 'cache'
repo that is just created to serve as a reference and not used in any
other way, so I wouldn't have to worry about the dangers with pruning,
accidentally deleting the repo, etc.

My big concern is that all these methods seem to just affect clone.  So:

Question 1) If I do 'git clone --reference, will the reference repo be
used for subsequent fetches as well?  What about 'git clone --shared'?

Question 2) If I git clone a local repo, will subsequent fetches also
create hard links?

Question 3) If the answer to any of the above is yes, how does this
work with packing?  Say I pack the reference repo (being careful not
to prune anything).  Will subsequent fetches still be able to get the
objects they need from the reference repo?

An added complication is submodules.  We have a submodule that is as
big and slow to fetch as our main repository.

Question 4) Is there a practical way to set up submodules so they can
use the same object-sharing framework that the main repo does?

I'm not keen on rewriting .gitmodules in each of my repos, so probably
something that uses info/alternates is the most workable.  I have a
scheme for setting that up that maybe will work, but it's a moot point
if info/alternates doesn't work for fetching.

I'm wondering if the best approach for us might be to use
GIT_OBJECT_DIRECTORY: set GIT_OBJECT_DIRECTORY to the shared cached
directory for each of our repos, so they all fetch to the same place.

Question 5) I haven't seen this mentioned anywhere else, so I'm
guessing it won't work.  Am I missing a big problem?

Question 6) Will git be sad if two different repos that share an
object directory, both do 'git fetch' at the same time?  I could maybe
protect fetches with an flock, but jenkins can do git operations
behind my back so it would be easier if I didn't have to worry about
locking.

Question 7) Is GIT_OBJECT_DIRECTORY supposed to work with subrepos?
In my experimentation, it looks like it doesn't: when I run
'GIT_OBJECT_DIRECTORY=../obj git submodule update --init' it still
puts the objects in .git/modules/<submodule>/objects/.  Is this a bug?
 Is there any way to work around it?

Any suggestions would be appreciated!  It feels to me like this is
something that git should support pretty easily given its
architecture, but I just don't see a way to do it.

Thanks,
craig

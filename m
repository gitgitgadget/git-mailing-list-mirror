From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: fetch: tag following too ambitious?
Date: Mon, 28 Oct 2013 13:42:35 +0100
Message-ID: <526E5BBB.6080306@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 28 13:49:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VamGY-0003vH-Ug
	for gcvg-git-2@plane.gmane.org; Mon, 28 Oct 2013 13:49:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756518Ab3J1Mtv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Oct 2013 08:49:51 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:52800 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755989Ab3J1Mtj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Oct 2013 08:49:39 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Oct 2013 08:49:39 EDT
X-AuditID: 1207440d-b7f4c6d000004a16-e8-526e5bbc7a69
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 30.6C.18966.CBB5E625; Mon, 28 Oct 2013 08:42:36 -0400 (EDT)
Received: from [192.168.69.9] (p4FDD4EA3.dip0.t-ipconnect.de [79.221.78.163])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r9SCgYNe001236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Mon, 28 Oct 2013 08:42:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqLsnOi/I4EqntkXXlW4mB0aPz5vk
	AhijuG2SEkvKgjPT8/TtErgzOi9+ZiuYyVPx6sZjlgbGfZxdjJwcEgImEn9+PGGDsMUkLtxb
	D2YLCVxmlJhw2KGLkQvIfs4ksffJLiaQBK+AtsTbQ72sIDaLgKrE4hUzwBrYBHQlFvU0g9WI
	CoRILFx1nB2iXlDi5MwnLCC2CFDNrmdXweqFBXQkJn3YD1bPDGS/63vADGHLS2x/O4d5AiPv
	LCTts5CUzUJStoCReRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrpFebmaJXmpK6SZGSDDx7mD8
	v07mEKMAB6MSD++GtblBQqyJZcWVuYcYJTmYlER5+yLzgoT4kvJTKjMSizPii0pzUosPMUpw
	MCuJ8HrYA+V4UxIrq1KL8mFS0hwsSuK8akvU/YQE0hNLUrNTUwtSi2CyMhwcShK83VFAjYJF
	qempFWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGgCIsvBsYYSIoHaO8BkHbe4oLEXKAoROsp
	Rl2OeV8+fGMUYsnLz0uVEuddDVIkAFKUUZoHtwKWOl4xigN9LMw7B6SKB5h24Ca9AlrCBLRk
	DwvYkpJEhJRUA2Psw59MFXbvbn7eout44vjVG3eWfLN0ZV70MdhryynXS3uEtFU3rjm7Vu20
	vUu3zNLtK3v9mZ9zhgloaRy6vcH589mH5xJ1rrZpL/7Ck/dySwDbUv9XL/8yvarknf9HJF8j
	8WWDYYneP5Ge+xsehEY2btm5UHXr54MJ/fI7QyZOMWA71OIv2XZPiaU4I9FQi7mo 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236829>

When investigating the exact semantics of tag-following, I discovered
that the tag auto-following behavior of "git fetch" is more ambitious
than I would have expected: it fetches any tag that references an object
that is known to the local repository, *even if that object is not
currently reachable* (i.e., neither reachable before the fetch or after
the fetch of non-auto-followed references).  This makes it hard to
renounce interest in a branch.

Suppose there is a remote repo with

    o---o---o        <- master
     \
      o---A---B      <- pu

When I clone this repo, of course I get all of the commits and both
branches.

Now suppose I decide I'm not interested in "branch" anymore, so I delete
its remote-tracking branch from my repository and change the config to
only fetch "master":

    git config remote.origin.fetch \
            '+refs/heads/master:refs/remotes/origin/master'
    git update-ref -d refs/remotes/origin/pu

It looks like I'm free of the "pu" branch, right?

But if a week later somebody pushes a tag "t" to origin that points at
commit A, and then I do

    git fetch origin

then Git (un)helpfully fetches tag "t" into my repo, because even though
commit "A" isn't reachable in my repo, it hasn't been pruned yet from
the object database.

I admit this is not likely to be a serious problem in practice, but I
found it surprising and strangely disturbing.  I would call it a bug.

Thoughts?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/

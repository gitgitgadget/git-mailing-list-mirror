From: "Ben Lynn" <benlynn@gmail.com>
Subject: git bugs
Date: Tue, 10 Jun 2008 01:41:34 -0700
Message-ID: <832adb090806100141n69c086a2v2f59fe94b2f4ead3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 10 10:42:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5zR3-0006Jr-Nl
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 10:42:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754416AbYFJIlj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 04:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754432AbYFJIlj
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 04:41:39 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:30728 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754391AbYFJIli (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 04:41:38 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1733949fgg.17
        for <git@vger.kernel.org>; Tue, 10 Jun 2008 01:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=EHBMMKX5j+Xm7B/62QANF3p+M61YeLK3Sea1unH0Y10=;
        b=Sg8+cS/WEYJ8n0/B+PYagB3sFnQmvYzXjXaS/XQCvQZUr87DD/oPAErbgPbhIZxCQS
         gmDyMhrlfSXoSXkzA6Y3oDWFHDH2IeFCxw86Fcu2mFb9noJ6kZlCAp/p3ZgLS2cJFor3
         6XwIAv8RmNwaozJYdn0APjgKCoL26rasyTZbk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=lvnpHcYnxeXx2na39HFPxhpmWbi9c+lVoINbn12S+z/W4PvYYUqMJEy1jKTPoEKj2p
         RHQkpz1rHYOinqbFbEJlWefWj+fEvm0wqiVs0h2cDFBwjdbcK0KKiWtjhisoxUl+tYjB
         MdOYuOkp6YZ9AcLi1AtBUvi46asRRtUnv4bDc=
Received: by 10.86.100.19 with SMTP id x19mr5345922fgb.61.1213087294206;
        Tue, 10 Jun 2008 01:41:34 -0700 (PDT)
Received: by 10.86.79.17 with HTTP; Tue, 10 Jun 2008 01:41:34 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84485>

I've come across a couple of bugs. Most users will probably never
encounter them, but I think they ought to be fixed. Apologies if
they're well-known issues. I haven't read much of this list.

1. The import/export language poorly handles distinct initial commits
on the same branch, because given two commits with same branch name,
it assumes the latter is the descendant of the former (if there are no
"from" commands).

Normally this is what you want. But if your project, like git, ever
merges distinct initial commits, then all but the first will
unexpectedly gain parents, corrupting all their descendants' hashes.
For example:

$ git clone git://git.kernel.org/pub/scm/git/git.git
$ git checkout -b test 60ea0fdd7de001405fcc7591beb18a66a1f0dd09
$ git fast-export test > /tmp/x
$ cd /some/empty/dir
$ git init
$ git fast-import < /tmp/x
$ git checkout test

Importing a pristine export, we discover Linus did not in fact make
the first commit to the git project:

$ git log d154ebcc23bfcec2ed44e365af9e5c14c6e22015

As a workaround, I have a custom importer that knows that
git-fast-export omits the "from" command in initial commits. But there
should be a command to specify that the current commit is an initial
commit, allowing reliable export of projects such as git.

2. Kudos to everyone who figured out the nasty race condition and its
complex solution as described in Documentation/technical/racy-git.txt
and the comments of read-cache.c. It took me a while to get my head
around it.

Unfortunately, the solution isn't perfect. Try this:

$ echo xyzzy > file
$ git update-index --add file   # don't zero size since contents match
$ echo frotz > file             # all stats still match, contents don't
$ echo nitfol > other  # can be done much earlier
$ git update-index --add other  # now the cached size is zeroed
$ : > file                      # zero the file size muahahaha
$ # Type fast! The above must take place within the same second! ;-)
$ sleep 2
$ echo filfre > other
$ git update-index --add other  # stats of "file" match, hash is wrong

Essentially, we trigger two index writes that avoid operations on
"file": one immediately after "file" is first committed and identified
as racily clean, and the second some time later, after we have
sneakily zeroed the file behind git's back (after previously editing
its contents in place). We defeat the safeguards and end up with a bad
hash in the index that appears valid.

The"other" file merely causes index writes without reading the "file"
entry. It is also racily clean in the above, but this is irrelevant.

It's unlikely this sequence of operations would occur in real usage,
but I'd sleep better if this index corruption bug were eliminated. One
practical but unsatisfactory easy "fix" is to mark racily clean
entries with SIZE_MAX instead of 0. Who uses git to track to files of
this size?

A better solution would be to introduce a new per-entry flag. Let's
call it "dodgy". Then during a cache entry update, we set "dodgy" if
the mtime is bigger or equal to the index timestamp. And during cache
entry reads, we check "dodgy": if clear, then we trust the hatch,
otherwise we don't trust the hash and recompute it, again setting
"dodgy" if necessary (i.e. if the mtime matches the index timestamp
again).

Although this solution does require adding a flag per index entry, we
no longer have to scan through the index on every index write to
perform the size zero hack.

-Ben

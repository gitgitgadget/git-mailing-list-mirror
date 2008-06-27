From: "Robert Anderson" <rwa000@gmail.com>
Subject: An alternate model for preparing partial commits
Date: Thu, 26 Jun 2008 23:50:06 -0700
Message-ID: <9af502e50806262350t6e794a92g7751147f1882965@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 27 08:51:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KC7np-0005E2-Dp
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 08:51:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759076AbYF0GuL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 02:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759044AbYF0GuK
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 02:50:10 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:38930 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754547AbYF0GuI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 02:50:08 -0400
Received: by fg-out-1718.google.com with SMTP id 19so181806fgg.17
        for <git@vger.kernel.org>; Thu, 26 Jun 2008 23:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=U3YCnNTiJGRbvZg65IH3aMrcvw3J20mBujQhXVJQTn8=;
        b=xjerFJEXxkh4jkp7j/xnOryDGO7Ir++5+epkAGQ+5vdvq8M2aRh3o9DC9AjqRwPH9r
         EZZxBSWhjzarcHV9zn+scPfTB0xZiz0TQdSsZpMfYwZLxMVTu0DZRi2ch5kmigIfD8DL
         fN2fAZM1HfNWP5smrnw70dwRyJKHNi/ben/eM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=d22i31E6bU2R0S7P8v6CbmYpglEQFnlK8AqpLxUxBm8O68M6r/C7gskfqF9wcN0xMb
         tFII8xFm6ACJCctaMtthLO7YaIJqmLRzk8dQaZaD+7uj9IhJdtIk1unEKm0M3wtjtVHs
         TCzdZRlJEIObGPds9UOMDf7dnteNiDj1abhVA=
Received: by 10.86.36.11 with SMTP id j11mr1360452fgj.7.1214549406641;
        Thu, 26 Jun 2008 23:50:06 -0700 (PDT)
Received: by 10.86.4.6 with HTTP; Thu, 26 Jun 2008 23:50:06 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86524>

Seems to me the concept of the "index" is a half-baked version of what
I really want, which is the ability to factor a working tree's changes
into its constituent parts in preparation for committing them.  The
index provides some very nice facilities to factor out changes in a
working tree into a "staging area", but the fundamental flaw of this
in my view is that this "staging area" is not instantiated as a tree,
so it cannot be compiled and/or tested before committing.

Consider a facility where the state you want to commit next is built
up in the current working directory, and the original set of changes
exists in some proto-space like the index currently inhabits, where
you can query and manipulate that state, but it isn't instantiated in
your working tree.

Imagine a session like this:

You've got a couple of conflated changes in your working tree, that
you think you can break up into two orthogonal changes, each of which
will compile and pass a set of tests you've got.  You think.  You'd
like to verify the build and test before you commit each piece.

git prep

where "prep" means "prepare commit".  Don't get hung up on command or
option names I'm using as placeholders, I just made that up without
much deep thought about what to call it.

Now my tree appears clean (and git diff returns nothing).  I can now
start adding the changes I had in my working tree that I want to
include in the next commit, using git add (which would know I am in
the "prep" mode).  I can examine those original working dir changes I
am choosing from with:

git diff --prep

which, at this point, shows the same output that "git diff" did before
I ran "git prep."  Now I want to add some subset of my original
changes:

git add newfile.c
git add -i
<add a couple of hunks of the changes from file modfile.c>

Now I have a working tree state that I think I want to commit.  I can
examine it with:

git diff

and I can compile and test it.  Yep, it works and passes my test suite
(an option I did not have if I had added these changes to the index).
So now I want to commit:

git commit -a -m "made change A"

I think the commit should probably "pop" the rest of the changes I did
not commit back into the working directory.  If I want to pull another
subset of changes again, I can repeat the process with another "git
prep".

Does this idea resonate with anyone else?

Thanks,
Bob Anderson

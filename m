From: Brent Goodrick <bgoodr@gmail.com>
Subject: How do I qualify paths in the .gitignore file w.r.t. the repo root 
	directory?
Date: Mon, 23 Feb 2009 22:47:13 -0800
Message-ID: <e38bce640902232247t63a37f63x9f403fbda0744cfd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 07:48:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbr61-0000e1-OG
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 07:48:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754095AbZBXGrS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 01:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753985AbZBXGrR
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 01:47:17 -0500
Received: from mail-gx0-f174.google.com ([209.85.217.174]:51376 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753865AbZBXGrQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 01:47:16 -0500
Received: by gxk22 with SMTP id 22so6360133gxk.13
        for <git@vger.kernel.org>; Mon, 23 Feb 2009 22:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=L+T1WeZl1q5UugvrAXAHrGhhuoRXYYVHebpiPfrxTHs=;
        b=ue/oCZdBO2/jYpK4b1yvsbDT8Yjx76JMJBpBMLOVMqvY+DH9mkSTbCu/wdApYD5z/k
         Mh7JEkXzID2xYKQzDxhi6p9sQVfYhoy+27WmR6WOndtiyNDduyVo9gOOh/WkQPy9e++9
         Kps1HT0bIRyNNs+nNlRCErdoouK5YRFGGG5Hg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=EuC4gEEiqeKbqX5RxpuGUHvFBFqGNnuZJUmxjlCqULQ9rCE2+TRU3ymCuKo6PSGt1J
         9R1IeCxZrwtXVlpHNDOmOu9Cog8pdlie/RhZgkCgK5rmY5FHH20V/qA0kVnFf/dG+jbv
         pQFWoXjRKMhjU0B3cQdMdp+v7sr8G9iEytL3U=
Received: by 10.90.90.4 with SMTP id n4mr1977748agb.65.1235458033543; Mon, 23 
	Feb 2009 22:47:13 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111223>

Say I have these files and directories [2]:

  /home/smart_tator/misc_files/.gitignore
  /home/smart_tator/misc_files/foo/
  /home/smart_tator/misc_files/bar/
  /home/smart_tator/misc_files/bar/baz/foo/
  /home/smart_tator/misc_files/bar/baz/real/

then I do:

  cd /home/smart_tator/misc_files/; git init

and say I have this line in that .gitignore file:

  foo/

And then I naively execute:

  git add bar/

then the bar/baz/real/ is added, but these are dutifully ignored:

  /home/smart_tator/misc_files/foo/
  /home/smart_tator/misc_files/bar/baz/foo/

But consider in my real repo, I have thousands of files, versus the
Tinker Toy example shown above. And consider that I don't know about
that bar/baz/foo/ exists ahead of time, because I'm not the only
developer checking in content to the repo that might contain precious
"foo/"'s to keep. I can't move my top level foo/, as I have tools that
rely upon that foo/ being in its place.

That means that we can't solve this problem efficiently/effectively
with the negation operator in the .gitignore file:

  foo/
  !bar/baz/foo/

because sooner or later someone is going to get surprised as to why
their foo/ isn't being added in some other subdirectory, and they will
"fix it" by committing a change where they have removed the foo/ from
the .gitignore file, thus causing the top level foo/ to show up as
candidates for addition in git status output.

Is there some way to express that the foo/ that is to be ignored is
always the one in /home/smart_tator/misc_files/ directory, but all
other foo/ subdirectories in any other directory under consideration
should still continue to participate in adds and merges, all without
having to "over-express" the exceptions with negation operators?

Maybe the imaginary .gitignore syntax I am thinking of would be one of
the following (most of these are just silly/fun):

  </>foo/  # <-- Huh?
  <top>foo/  # <-- What the ...?
  //foo/  # <-- Smells like Perforce or Windows UNC paths
  /foo/ # <-- No! Matches UNIX root filesystem directory paths!
  >foo/  # <-- You can't have a > character in DOS or Unix paths, can you?
  $root/foo/  # <-- I like this syntax the best [1]

Thanks,
bg

[1] Maybe there are other "variables" besides $root that might be
    useful to be added in the future, like $HOME.
[2] By "repo root directory", I mean whatever "$GIT_DIR/.." resolves to.

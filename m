From: Brent Goodrick <bgoodr@gmail.com>
Subject: Re: [PATCH] Fix file mark handling and sort side-effects in git.el
Date: Thu, 12 Feb 2009 09:08:02 -0800
Message-ID: <18836.22386.987021.484807@hungover.brentg.com>
References: <18834.27724.991388.339214@hungover.brentg.com>
	<87hc31kzrb.fsf@wine.dyndns.org>
	<e38bce640902120738h7b9bb75o42e1524cbfd95169@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 12 18:09:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXf4E-0006ln-IH
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 18:09:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757122AbZBLRIL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 12:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756312AbZBLRIL
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 12:08:11 -0500
Received: from rv-out-0506.google.com ([209.85.198.227]:48289 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755270AbZBLRIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 12:08:09 -0500
Received: by rv-out-0506.google.com with SMTP id g37so358469rvb.1
        for <git@vger.kernel.org>; Thu, 12 Feb 2009 09:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:mime-version
         :content-type:content-transfer-encoding:message-id:date:to:subject
         :in-reply-to:references:x-mailer;
        bh=CQ6XBZOLk8+c1u6Rpo+YRRWr0tvRT9CWc/5MieZ5fJk=;
        b=Qzyg9/6KyfAusM3tYdPKn/UTkL4kGyF/OjfyZj7HMUAu0RqrYHs8/BMr9qdTWOoNz4
         yZlLdH17XD1EFkpJ4eaASv50PGaSbYZWQBQ2WZD9lnGT/gIyTk8Bbx07NPN9eSRAFzmk
         9X4mUnm+lbkRYX4RIcKfpUP8A3oxjrf8Qafck=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:mime-version:content-type:content-transfer-encoding:message-id
         :date:to:subject:in-reply-to:references:x-mailer;
        b=FWuKrg4zr3h0RSgaQRjTyrI5AMGHFd1hESSWo/cCZHY3ItkJpZOjHanBKBExVzbqnW
         wFkWm3SbdsdX/UEfqex9Z0hLXC8a27vhU2d53VZ/yga2n6F8tS/ufLuz9mlpf8cnZ6F7
         /ux+AndYy5qeAUWkY1HmJWzXJqaozsrj8h934=
Received: by 10.140.164.6 with SMTP id m6mr658900rve.144.1234458488394;
        Thu, 12 Feb 2009 09:08:08 -0800 (PST)
Received: from hungover.brentg.com.thisisbogus.com ([76.14.208.3])
        by mx.google.com with ESMTPS id b8sm492889rvf.8.2009.02.12.09.08.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 12 Feb 2009 09:08:07 -0800 (PST)
In-Reply-To: <e38bce640902120738h7b9bb75o42e1524cbfd95169@mail.gmail.com>
X-Mailer: VM viewmail-609 under 23.0.60.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109631>


Hi Alexandre (Warning: Incoming long-in-the-tooth email),

See my comments below:

 > From: Alexandre Julliard <julliard@winehq.org>
 > 
 > Brent> The `sort' Elisp function works destructively, causing anomalies where
 > Brent> operations on multiple files would be performed on one file.  This
 > Brent> checkin works around that by doing a deep copy with `append'.
 > 
 Alexandre> This shouldn't be necessary, it's OK for git-status-update-files to
 Alexandre> destroy the list. If there are callers that want the list to be
 Alexandre> preserved they should save it themselves.

Let me demonstrate the issue with the destructive sort showing that it
is a problem (but only part of the problem). This long sequence shows
my reasoning as to what led me to make this patch:

1. I created a scratch throwaway branch called
   bg/scratch-elisp-testing off of master in my git repo. In Emacs I
   executed M-x git-statux of my work area showing a couple of files
   that I do not want to git-add which I will leave alone, but
   otherwise there are no edits applied yet on the
   bg/scratch-elisp-testing throw away branch:

,----
| git status
| # On branch bg/scratch-elisp-testing
| # Untracked files:
| #   (use "git add <file>..." to include in what will be committed)
| #
| #	Documentation/share/
| #	patch
| nothing added to commit but untracked files present (use "git add" to track)
`----

2. I make editing changes to git.c and progress.c, but will refrain
   from executing git-add on those edits at this point.  Then I
   execute M-x git-status from within Emacs and see:

,----
| Directory:  ~/git_from_source/git/
| Branch:     bg/scratch-elisp-testing
| Head:       f6b98e46bd - git-web--browse: Fix check for /bin/start
| 
|      Unknown      Documentation/share/
|      Modified     git.c
|      Unknown      patch
|      Modified     progress.c
| 
`----

This corresponds to git status output that looks like this:

,----
| git status
| # On branch bg/scratch-elisp-testing
| # Changed but not updated:
| #   (use "git add <file>..." to update what will be committed)
| #   (use "git checkout -- <file>..." to discard changes in working directory)
| #
| #	modified:   git.c
| #	modified:   progress.c
| #
| # Untracked files:
| #   (use "git add <file>..." to include in what will be committed)
| #
| #	Documentation/share/
| #	patch
| no changes added to commit (use "git add" and/or "git commit -a")
`----

3. I would like those changes to be a part of the commit that I make,
   so I position the Emacs point onto "git.c" and type "m" to mark
   git.c, and do the same for progress.c. At this point, the
   *git-status* buffer shows as:

,----
| Directory:  ~/git_from_source/git/
| Branch:     bg/scratch-elisp-testing
| Head:       f6b98e46bd - git-web--browse: Fix check for /bin/start
| 
|      Unknown      Documentation/share/
|    * Modified     git.c
|      Unknown      patch
|    * Modified     progress.c
| 
`----

4. I now type "a" to add the marked files (my expectation is that
   git-add will be executed on "git.c" and "progress.c" but not the
   other two files which I did not mark). But instead I see in the
   minibuffer a prompt asking about which files to apply the git-add:

,----
| File to add: ~/git_from_source/git/
`----

5. I debugged a bit and thought all I needed to do was add the
   'modified symbol to the call to git-marked-files-state as this diff
   shows:

--- cut here ---
diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index fcbe2d9..b8c268b 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -1041,7 +1041,7 @@ Return the list of files that haven't been handled."
 (defun git-add-file ()
   "Add marked file(s) to the index cache."
   (interactive)
-  (let ((files (git-get-filenames (git-marked-files-state 'unknown 'ignored))))
+  (let ((files (git-get-filenames (git-marked-files-state 'modified 'unknown 'ignored))))
     ;; FIXME: add support for directories
     (unless files
       (push (file-relative-name (read-file-name "File to add: " nil nil t)) files))
--- cut here ---

6. I ran "git reset git.c progress.c" to reset the state in git. So
   now git status reports similar to what it was when I started (but
   git.el is modified to add the 'modified symbol to the call to
   git-marked-fiels-state above):

,----
| git status
| # On branch bg/scratch-elisp-testing
| # Changed but not updated:
| #   (use "git add <file>..." to update what will be committed)
| #   (use "git checkout -- <file>..." to discard changes in working directory)
| #
| #	modified:   contrib/emacs/git.el
| #	modified:   git.c
| #	modified:   progress.c
| #
| # Untracked files:
| #   (use "git add <file>..." to include in what will be committed)
| #
| #	Documentation/share/
| #	patch
| no changes added to commit (use "git add" and/or "git commit -a")
`----

7. Kill the *git-status* buffer to get a clean slate (hopefully, that
   is all one has to do to reset git.el's state).

8. I ran M-x git-status again and saw:

,----
| Directory:  ~/git_from_source/git/
| Branch:     bg/scratch-elisp-testing
| Head:       f6b98e46bd - git-web--browse: Fix check for /bin/start
| 
|      Unknown      Documentation/share/
|      Modified     contrib/emacs/git.el
|      Modified     git.c
|      Unknown      patch
|      Modified     progress.c
| 
`----

9. I marked git.c and progress.c using "m" again and saw:

,----
| Directory:  ~/git_from_source/git/
| Branch:     bg/scratch-elisp-testing
| Head:       f6b98e46bd - git-web--browse: Fix check for /bin/start
| 
|      Unknown      Documentation/share/
|      Modified     contrib/emacs/git.el
|    * Modified     git.c
|      Unknown      patch
|    * Modified     progress.c
| 
`----

10. I then saw only one message output:

,----
| Added progress.c
`----

I should see two messages here, one for git.c and another for
progress.c. This is the reason for the addition of the append function
calls to copy the files list before sort sees it, as that is how they
are reported. But that is not the whole story, as I show below.

11. Looking at the *git-status* buffer, I do not see any status change
    for the files I have just added:

,----
| Directory:  ~/git_from_source/git/
| Branch:     bg/scratch-elisp-testing
| Head:       f6b98e46bd - git-web--browse: Fix check for /bin/start
| 
|      Unknown      Documentation/share/
|      Modified     contrib/emacs/git.el
|    * Modified     git.c
|      Unknown      patch
|    * Modified     progress.c
| 
`----

That seems confusing (but see my response to your comment below about
the three conceptual states that git has that the other SCM's I've
used (CVS, Perforce) don't seem to have).

12. I ran git status outside of Emacs and saw that the files were
indeed added:

,----
| # On branch bg/scratch-elisp-testing
| # Changes to be committed:
| #   (use "git reset HEAD <file>..." to unstage)
| #
| #	modified:   git.c
| #	modified:   progress.c
| #
| # Changed but not updated:
| #   (use "git add <file>..." to update what will be committed)
| #   (use "git checkout -- <file>..." to discard changes in working directory)
| #
| #	modified:   contrib/emacs/git.el
| #
| # Untracked files:
| #   (use "git add <file>..." to include in what will be committed)
| #
| #	Documentation/share/
| #	patch
`----

My rationale for adding append function calls to the sort calls is to
leave the callers value alone since the caller needs to make use of
the list value in subsequent operations, especially for issuing
messages.

 > 
 > > Also, git-add-file needed to pass 'modified to git-marked-files-state,
 > > as otherwise, files that are modified but not yet in the index would
 > > not show up in the git-marked-files-state return value, which would
 > > then cause a prompt for file to show up when the files are clearly
 > > marked in the status buffer.
 > 
 > Not sure what you mean here, it should not be possible for a file to be
 > in modified state but not in the index.

Yep. Shouldn't be but I think I have demonstrated that was the case
above. Let me know what I missed in my reasoning.

 > If you mean using git-add-file to do an update-index on an already
 > tracked file, that's not what it's meant to do.

That would be fine in, say, Perforce where once a file is added it
stays added even if the user mades additional edits. I don't agree
that is the best approach in the case the Emacs interface to git in
git.el, since there is that "third" state where I could have added the
file, then edited it, then forgot that I had edited it and proceeded
naively to commit, only to be surprised later that the subsequent edit
to the file was not committed. 

In my view, there are three conceptual states that a file in git can
have:

 - The file is modified in the working tree but not yet added to the
   index (Locally-modified in my sample view below),

 - The file is modified, but also added to the index for the next
   commit and does not have any subsequent edits in the working tree
   (Ready-for-commit in my sample view below),

 - The file is added to the index previously, but the user made
   additional changes to the file that are not yet in the index, which
   means it potentially needs another add (Modified-but-has-edits in
   my sample view below).

I need have the *git-status* buffer to visually reflect those three
conceptual states. Otherwise there isn't much point to having M-x
git-status when I have to constantly run "git status" from the shell
to double-check what the *git-status* buffer should have been telling
me all along.

,----
| Directory:  ~/git_from_source/git/
| Branch:     bg/scratch-elisp-testing
| Head:       f6b98e46bd - git-web--browse: Fix check for /bin/start
| 
|      Unknown                       Documentation/share/
|      Locally-modified              contrib/emacs/git.el
|    * Modified-but-has-edits        git.c
|      Unknown                       patch
|    * Ready-for-commit              progress.c
| 
`----

I'm not insisting that the names "Locally-modified",
"Modified-but-has-edits", and "Ready-for-commit" be the ones actually
used (perhaps you can come up with names that better befit the git
environment), but something like the above would be better than just
having them all show up as "modified" for all three states.

Thanks,
Brent

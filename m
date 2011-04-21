From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Fork or branch?
Date: Thu, 21 Apr 2011 17:39:00 -0500
Message-ID: <20110421223845.GA3993@elie>
References: <1303390999618-6293910.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Dmitry Potapov <dpotapov@gmail.com>
To: adam_kb <a-kyle@hotmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 22 00:39:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QD2Wo-0001WJ-H3
	for gcvg-git-2@lo.gmane.org; Fri, 22 Apr 2011 00:39:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755439Ab1DUWjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2011 18:39:08 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37142 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753658Ab1DUWjH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2011 18:39:07 -0400
Received: by iyb14 with SMTP id 14so133695iyb.19
        for <git@vger.kernel.org>; Thu, 21 Apr 2011 15:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=h9BP/jVNy6tv0EQV+few6wdX/xCISbIZAsfy8Xk6Mow=;
        b=FWT7DaaqrV/G9GaIGlixju4bxtKSGf9t9+vxLfkcfNGZvLdb+O5cR1Fn83WWv+SeS3
         r0rjM/v8HouBf+HkiovEEaIsu6oeYNirU7btF0sbWjXsHAKDkKt+MsOlCAs7sQSAYW25
         4KRVb7uA9x0swpUrTpmAOg4ZF1AB6rn9n+GoE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=l5Ktk9CQf8xrBv2d+Ok2XSynXzVOdpIydQDDAsLqtfQnBhMSCFxUV24F/V/mE/YPYA
         W5ltdzG4jCk9LOagEuE5q+JnQ2IGUsuIFa0z3U64iD1qu76fbTcpLvHPoZYgov17D+Ud
         IbNiyrykVcgHhBLW/95CJat7pii0JatPxTwJ8=
Received: by 10.42.158.67 with SMTP id g3mr571346icx.94.1303425546980;
        Thu, 21 Apr 2011 15:39:06 -0700 (PDT)
Received: from elie (adsl-69-209-64-141.dsl.chcgil.sbcglobal.net [69.209.64.141])
        by mx.google.com with ESMTPS id g16sm911721ibb.3.2011.04.21.15.39.05
        (version=SSLv3 cipher=OTHER);
        Thu, 21 Apr 2011 15:39:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1303390999618-6293910.post@n2.nabble.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171925>

Hi,

adam_kb wrote:

> I am new to git and understand most of it except for merge. My question is -
> if I have project X on branch master and its coded in python but I then want
> to take that same project and code it in say C or C++ would I fork or branch
> the project? 

It depends what you would like the resulting history to look like
("gitk --all" can help a lot here).

In practice, rewriting a project in another language tends to be a big
step, almost as big as starting a new project.  None of the original
code gets kept.  It can take a long time before the rewrite gains all
the functionality of the original.

So let's imagine a few different scenarios.

1. Replacing pieces of the Python project with C++ incrementally
----------------------------------------------------------------

Perhaps I am writing an extension module or a standalone helper that the
Python code calls.  When finished, I'll be able to discard the Python
skeleton.

In this case, it is a perfect opportunity to use a topic branch (see
gitworkflows(7) for what this means).  To start out, I make a new
branch:

	git checkout -b go-faster

Now I hack as usual, telling git about my changes as I go:

	... hack hack hack ...
	git add .
	git add -u
	git diff --cached;	# looks good?
	make
	... test test test ...
	git commit;	# all right, commit the first change.

	... hack hack hack ...

Suppose I notice a bug that already existed in the original Python
implementation.  I fix it there first, since the C++ changes are up in
the air:

	git checkout master
	... fix fix fix ...
	git add -A
	make test
	git diff --cached;	# looks good?
	git commit;	# ok, describe the fix.
	... test test test ...;	# one final test.

But I want to make sure the bugfix works well with the C++ changes,
too:

	git checkout go-faster
	git merge master;	# merge in the bugfix

The code the bugfix touched might overlap with my changes, in which
case I should look at the conflicts with "git diff" and figure out
how to resolve them (see the user manual and git-merge(1) for details
on this process).  Hopefully the result works well.  If it does not,
I might go back to "master" and rethink the fix or use "git commit
--amend" to tweak the merge resolution.

When all looks good, I run

	git push

to publish my changes.  This does not automatically push the go-faster
branch, which has not been made public yet; once I have announced it, I
might use

	git push origin go-faster

to make it public, and then plain "git push" will push it from that
point on.

2. Reimplementing with the Python code as an inspiration
--------------------------------------------------------

Now suppose I instead want to start the C version from scratch, adding
features one at a time from the Python version.

In this case, it is probably simplest to start a new repository.

	git init project-x-c
	cd project-x-c

Eventually it is time to tell users of project-x that project-x-c is
working as well or better and that project-x will be abandoned.  Git
does not care.

3. Reimplementing in the context of a larger project
----------------------------------------------------

Lastly, suppose I want to reimplement the Python version in C in one
go, but this is just one file of many in a larger project.

This is conceptually very similar to case (2).  It can make sense to
at first treat the reimplementation as a new and separate feature
(maintaining both side-by-side within the same tree), and only once
the reimplementation is finished eliminating the old version.  This is
how the migration from the old ide_* to the new libata_* drivers in
Linux has been proceeding, for example.

Another alternative is to do the reimplementation in one commit,
replacing the old command at the same time.

Both methods have happened in the history of git itself a few times.
Various commands written in Python or Perl were rewritten in C; one
can find some examples with

	git log --diff-filter=D -- 'git-*.sh' 'git-*.perl' 'git-*.py'

using git 1.7.5.

Hope that helps.
Jonathan

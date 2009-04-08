From: Elijah Newren <newren@gmail.com>
Subject: [ANNOUNCE] git_fast_filter
Date: Tue, 7 Apr 2009 21:35:10 -0600
Message-ID: <51419b2c0904072035u1182b507o836a67ac308d32b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 08 05:36:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrOak-00033C-NC
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 05:36:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753384AbZDHDfO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 23:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753321AbZDHDfN
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 23:35:13 -0400
Received: from mail-gx0-f160.google.com ([209.85.217.160]:37813 "EHLO
	mail-gx0-f160.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753271AbZDHDfM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 23:35:12 -0400
Received: by gxk4 with SMTP id 4so6640838gxk.13
        for <git@vger.kernel.org>; Tue, 07 Apr 2009 20:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=wPGIEBRPfkcYPpIz8Dm3g5P7eeNvTWw936s0GHJgumM=;
        b=Aa01rE9npNxtdFwdQrRPeQICjsLnGH5+nQZ1M/SAJlN8veSEpeetLjynqtRZ54Ax1v
         goET2fQuzrLZu+268tkF4LjcLCFZimdg4tDdTqbz97QRQ9lZbSSHLVFSRAlLleid63b9
         /h3p6jLsfthuro15c9MI5J+9If/twPEkWqoXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=Bq29KxeI6K0sd1MXKFcNxatDBfH9NWGY7tkPz5tBLDwExl4zPTLZIN5FWZCUt0FMeI
         SI4hHgv/0lWVphxW8cuFZCzrPzXUAv5OLoD6T24BT4BReNwG4QkvJXmQzPwhZLqP/+sD
         ThAtjB9IKQTelm1sJsEUK+TT2tCn4RVVtaQ9Y=
Received: by 10.231.14.196 with SMTP id h4mr268815iba.36.1239161710911; Tue, 
	07 Apr 2009 20:35:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116028>

Just thought I'd make this available, in case there's others with
niche needs that find it useful...


git_fast_filter assists with quickly rewriting the history of a repository
by making it easy to write scripts whose purpose is to serve as safe
filters between fast-export and fast-import.  git_fast_filter comes with
example programs, a basic test-suite, and a double your money back
satisfaction guarantee.  (I love free software.)  You can get it from

  git://gitorious.org/git_fast_filter/mainline.git

In more detail...

=== Purpose ===

git_fast_filter is designed to make it easy to filter or rewrite the
history of a repository.  As such, it fills the same role as
git-filter-branch, and was written primarily to overcome the sometimes
severe speed shortcomings of git-filter-branch.  In particular, using
git_fast_filter can avoid thousands or millions of new process forks, and
can allow you to rewrite the same file only one time instead of 50,000
times.  However, while using git_fast_filter is fairly simple and quick, it
is hard to beat writing a simple git-filter-branch one-liner for efficiency
of human time.  Also, the two tools use very different methods of rewriting
history and do not have exactly overlapping feature sets, so the best tool
for a particular job is going to be very problem dependent.

As human time is often more important than computer time, especially for
one-shot rewrites, git-filter-branch will probably continue to be the more
common tool.  However, git_fast_filter is useful in cases where computer
time of a rewrite matters (particularly larger repositories and more
involved rewrites that need to be run and tested many times on large data
sets).  Also git_fast_filter has a couple features that may come in handy
in special cases (assisting with generating fast-export output from
scratch, interleaving commits from seperate repositories, and bidirectional
collaboration between filtered and unfiltered repositories).

=== Idea ===

The way git_fast_filter works is by providing a simple python library,
git_fast_filter.py.  This library can be used in simple python scripts to
create a filter for the output of git-fast-export.  Thus, the typical
calling convention is of the form:

    git fast-export | filter_script.py | git fast-import

=== Example ===

An example script that renames the 'master' branch to 'other is shown
below (this is similar to the example in the git-fast-export manpage, but
is safe against the string 'refs/heads/master' appearing in some file or
commit message in the repository):

  #!/usr/bin/python

  from git_fast_filter import Commit, FastExportFilter

  def my_commit_callback(commit):
    if commit.branch == "refs/heads/master":
      commit.branch = "refs/heads/other"

  filter = FastExportFilter(commit_callback = my_commit_callback)
  filter.run()

The user can then run this script by:
  $ mkdir target && cd target && git init
  $ (cd /PATH/LEADING/TO/source && git fast-export --all) \
       | /PATH/TO/filter_script.py | git fast-import

(Note: The user can have the script take care of the git init, the cd's,
and the invocations of git fast-export and git fast-import by just passing
directory names to FastExportFilter.run; however, writing out the details
explicitly as in the above example makes it clearer what is going on.)


Elijah

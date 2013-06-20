From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Splitting a rev list into 2 sets
Date: Thu, 20 Jun 2013 16:56:26 +0530
Message-ID: <CALkWK0=6ZofURGvC-FtS81765yDsA9+0wW94riPZUPudc_nDyw@mail.gmail.com>
References: <CAC9WiBi-E+LN4hKGeu0mG7ihJWCaTg-W1Dx_PWmX_vsx-uLOaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 13:27:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Upd1F-000443-LS
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 13:27:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965249Ab3FTL1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 07:27:08 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:52013 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965093Ab3FTL1G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 07:27:06 -0400
Received: by mail-ie0-f177.google.com with SMTP id aq17so16160991iec.22
        for <git@vger.kernel.org>; Thu, 20 Jun 2013 04:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=2iVb5OiOpgLbSKySTPUKPT96de7Md4wMH3tmA6K4E1U=;
        b=CwMzbS42Kd+/X7cfIwrjbzGq28cE/BfvHhCX7ureuO8SVJgX9qkFpGpC1ZNCnqjr9I
         24VMQSBOy7bLEc84Kvx7Uui7io+UHrWi59gIDpKNQjIVhdLQ4+XDIJM69Il0ZJjBhJiQ
         z1NYs9+W3Q6pG+vJogT+eOAea0dW54y6qwsAMfzgBk6fxzBx4U3Zim5PNObsc0OBzQj0
         uoIjP0nhH7Lmjqr2HVjvRsxjhfoBgFcph8OAitx6HMsZs6jMg0JZ91BB/bvC75VwkNjc
         maOJgKT6S6PXLIgIng54t0FMX6UERixy3STk3CwOwpyVOG6ZoFq7z7VKtptkjkooRDaM
         QvAA==
X-Received: by 10.42.80.9 with SMTP id t9mr2964074ick.14.1371727626578; Thu,
 20 Jun 2013 04:27:06 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Thu, 20 Jun 2013 04:26:26 -0700 (PDT)
In-Reply-To: <CAC9WiBi-E+LN4hKGeu0mG7ihJWCaTg-W1Dx_PWmX_vsx-uLOaw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228481>

Francis Moreau wrote:
> To get the commit set which can't be reached by master (ie commits
> which are specific to branches other than master) I would do:
>
>   # "$@" is the range spec passed to the script
>   git rev-list "$@" ^master | check_other_commit
>
> But I don't know if it's possible to use a different git-rev-list
> command to get the rest of the commits, ie the ones that are reachable
> by the specified range and master.
>
> One way to do that is to record the first commit set got by the first
> rev-list command and check that the ones returned by "git rev-list $@"
> are not in the record.

I don't fully understand your query, because almost anything is
possible with rev-list:

  $ git rev-list foo..bar master # reachable from master, bar, not foo

What I _suspect_ you're asking is for help when you can't construct
this "foo..bar master" programmatically (or when you cannot express
your criterion as arguments to rev-list).  You want an initial commit
set, and filter it at various points in your program using various
criteria, right?  In that case, I'd suggest something like this:

    # Returns a list of commits given a committish that `rev-list`
    # accepts.
    def self.list_commits(committish)
        commits = []
        revlist = execute("git", "rev-list", "--reverse", "--date-order",
                          "--simplify-merges", committish).chomp.split("\n")

        # do it in batches of 1000 commits
        while revlist
            these_revs = revlist.first(1000).join("\n")
            this_chunk = execute({ :in => these_revs }, "git",
                               "cat-file", "--batch")

            # parse_cat_file parses the chunk and updates @commit_index
            parse_cat_file(this_chunk) { |struct| commits << struct }

            revlist = revlist[1000 .. revlist.length - 1]
        end
        return commits
    end

    # Filters a list of commits with the precondition that it exists
    # in the committish.  :sha1 is used to uniquely identify a commit.
    def self.filter_commits(commits, committish)
        revlist = execute("git", "rev-list", "--simplify-merges",
                                 committish).split("\n")
        allowed_commits = revlist.map { |sha1| @commit_index[sha1.hex] }
        return commits & allowed_commits
    end

In essence, I use '&' to filter and it's extremely fast.  The trick is
to shell out to git sparingly, store the data you get in a sensible
manner, and build fast custom filters based on what you want.  Here
are a few more examples:

    # Filters a list of commits with the precondition that it is a
    # first-parent commit in a given committish.
    def self.filter_fp_commits(commits, committish)
        revlist = execute("git", "rev-list", "--first-parent",
                          "--simplify-merges", committish).split("\n")
        allowed_commits = revlist.map { |sha1| @commit_index[sha1.hex] }
        return commits & allowed_commits
    end

    # Slice a list of commits using a start_hex and end_hex, which
    # may both be nil.
    def self.slice_commits(commits, start_commit, end_commit)
        start_idx = commits.index(start_commit)
        end_idx = commits.index(end_commit)
        start_idx = 0 if start_idx.nil?
        end_idx = commits.size - 1 if end_idx.nil?
        return commits[start_idx..end_idx]
    end

    def self.filter_commits_tree_path(commits, path)
        commit_chunk = (commits.map { |commit| commit.sha1 }).join("\n")
        commit_chunk = "#{commit_chunk}\n"
        diff_tree_chunk = execute({ :in => commit_chunk }, "git", "diff-tree", \
                                  "-m", "-r", "-s", "--stdin", path)
        matching_sha1s = diff_tree_chunk.split("\n")
        allowed_commits = matching_sha1s.map { |sha1| @commit_index[sha1.hex] }
        return commits & allowed_commits
    end

Did that help?

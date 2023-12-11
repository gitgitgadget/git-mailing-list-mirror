Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DK8593bP"
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978E2CD
	for <git@vger.kernel.org>; Sun, 10 Dec 2023 22:21:05 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-54dca2a3f16so7423771a12.0
        for <git@vger.kernel.org>; Sun, 10 Dec 2023 22:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702275663; x=1702880463; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dx36tC5LnULAdjZ0Se5lKsl45Byy9EfGuSaYiBnSdr4=;
        b=DK8593bP78gZlgFyPo+xe2NJ7p/LeubOceW6gXBE+XQHRW7yvipMi9Zr8p3XvyYkQJ
         ZDpjEA4GaYDxKZ2yc21XZVmRGOAL7BjMaiPTHxWYa9nrxOh4D0eX3cztnEL8YSD+xXjp
         2xKEpdHJqkavwx/Sl6CUKF8eGAC7iT0tzGjJt9cM03rVOrhdeCWtz1NYORBYnzLN8GkS
         83qlSyFC3wnR+1EoftrvgUMCb1zTzVM6jifLr11fuCAEbRBqN8yQ39fF8IkN5M7OCfeb
         KUzko+8C8OED4dCb8LwoDA9Una7Ue8jl6bcbwjjphWl9oATWnis9zwCZ5fzCy9hvzxh8
         qCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702275664; x=1702880464;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dx36tC5LnULAdjZ0Se5lKsl45Byy9EfGuSaYiBnSdr4=;
        b=RpIVjhj4w87dZNNrQbzMZfp2ueKH1TRmnQONqROqxEaM2dREDh7KtG+RBilaao1tEz
         OlYBs11WoiH96k+jr0Qj9yOG4dAVR7fAl6g8cWep466qQXLFGOGjBB9xTu8Kvq0FPOCN
         kB8YL7kV35hZmjGapbgbnHjhdgNQHKhI5QHrsZXyeX1FcM0EtlzCQzQ+VHOnYiLKYUf2
         rrPR9NJ7BKGBRvpfTlKxYbFVKnPal3Rj0dFr3JrVcE6OfZu7yBpTmWysWw8OkyVjEIga
         MfmxXw682pARUqoBVXm05N8aT8mZgGgJ5pBwL/2pLZRtoqvINdCuCNvZw63VDyo85BjY
         lcow==
X-Gm-Message-State: AOJu0YyQ4VGIE4J4w7RXwUw/Q3eHghbN4M54Zt6+I7zFpsSwk3fDL5F2
	I8Qyt0eOjAYcaOfXAd9lWXIe3WE5b7pE8d3zNJb39+ZEpg0=
X-Google-Smtp-Source: AGHT+IFEW7dh8QqWdj59o8s/0e4Lict2zC1yEEiUIQJUADnJR6qGByKBNB1Ct/nYSRc0imOdTJq3mhEXdwfeBY9xSEk=
X-Received: by 2002:a17:906:9588:b0:a1c:c2f9:980d with SMTP id
 r8-20020a170906958800b00a1cc2f9980dmr3692997ejx.27.1702275662924; Sun, 10 Dec
 2023 22:21:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Britton Kerin <britton.kerin@gmail.com>
Date: Sun, 10 Dec 2023 21:20:51 -0900
Message-ID: <CAC4O8c-KmafnX2z_6JK5YxjWcegykwZvk9xx2OuYdLLR5gVk_g@mail.gmail.com>
Subject: [BUG] git bisect start gives incorrect error message when good/bad swapped
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When good/bad are entirely swapped git bisect says:

     $ git bisect start initial_commit latest_master_commit
     Some good revs are not ancestors of the bad rev.
     git bisect cannot work properly in this case.
     Maybe you mistook good and bad revs?

But that's not true because when good is a non-ancestor from a branch
a common ancestor is automatically selected:

     $ git bisect start latest_master_commit latest_unmerged_branch_commit
     Bisecting: a merge base must be tested
     [b93212577c2e8603ed7285b55a0931dcf552c628] I'm yet another test commit

In this case latest_unmerged_branch_commit is not an ancestor of
latest_master_commit but a common ancestor is selected automatically
with a message, and when the branch point is marked as bad git
correctly indicates that the problem has been fixed on the branch (and
bisection stops):

     $ git bisect bad
     The merge base b93212577c2e8603ed7285b55a0931dcf552c628 is bad.
     This means the bug has been fixed between
b93212577c2e8603ed7285b55a0931dcf552c628 and
[1b4470e66cb26244be9aa5f68cca042a0ef4270e].

I suspect what the message at the top should be saying is that the bad
rev *is* an ancestor of some good rev but I haven't thought/tested
carefully enough to feel sure that's the case.

I think this is worth fixing somehow because the wrong message gives a
wrong idea of git capabilities and might make the case when a common
ancestor is automatically selected more unexpected and so more
confusing.

On a more minor note the use of 'merge base' to refer to the common
ancestor is unfortunate since these messages are produced when working
on branches that aren't actually merged.  It would be better to use
'common ancestor' (as the merge-base man page does).

Britton

From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 00/44] Ruby support
Date: Sat, 28 Sep 2013 17:03:25 -0500
Message-ID: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 29 00:10:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2iA-0002bs-Kg
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 00:10:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755086Ab3I1WJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 18:09:59 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:54782 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755070Ab3I1WJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 18:09:57 -0400
Received: by mail-oa0-f53.google.com with SMTP id i7so3001226oag.12
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 15:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=zXWQInCzuMfbKUCybf72y/6C9+7PK5XSTJedrL6A6jc=;
        b=FqWj+xTx+ZYTklkXBXJOhQgKFHzNcSyBn/nsabtHo+3+ccpBbv5VOB32U38wJmoxjN
         Od+yAylsVI6W89bWOjydcA9oCh6Dy0cgxWB1OMBm9HTryYO/H3M76v6eyU/y+Znm0/we
         szOlpUIvRag8anNSNLdLeXkLgCgQrwM69TXaKZ61YshetGyHOkoqZkLxvI6vcM02rQPE
         0kKPbAD3Rn2KTc4/l+IN6J7l7Kxi8myw8/BgBr9K+ABuFkf4EEJkzW4IbnMW/7xWZ/oL
         uGy84m1d6ZyQ0RdWL+8j//0vLmNYJL13c79sR2yLU4ne4AoQMy2Ebux358UPV9DuNncg
         dJqA==
X-Received: by 10.60.65.227 with SMTP id a3mr12266266oet.13.1380406196803;
        Sat, 28 Sep 2013 15:09:56 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id s14sm25468210oeo.1.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 15:09:55 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235520>

This is a different patch series that tries a different approach.

First, this series allows external scripts to also access libgit through Ruby
bindings:

  git ruby <<EOF
  for_each_ref() do |name, sha1, flags|
    puts "%s: %s" % [name, sha1_to_hex(sha1)]
  end
  EOF

This way third party script writers can write Ruby code that resembles Git's
internal C code, but in a much simpler way.

Since the importance of the contrib area is fading, and it's important to move
all Git commands to C, it's helpful to have tools that allows third parties to
rewrite scripts that are easier to rewrite to C.

In addition, this would help Git developers to create quick prototypes and test
new code.

Finally, and perhaps most importantly, Ruby scripts can be intermediaries
between perl/shell scripts, and the final desired C code.

I already argued this, but here is a clear demonstration.

I took git-request-pull.sh, converted it to Ruby and incrementally moodified it
until the resulting code was essentially what the code would look like in C,
and then, finally, the rewrite to C, which follows the exact same logic of the
Ruby script.

In the progress of doing this, it was clear the shell script was buggy, so it
was fixed, and the C code needed fixes as well.

If we are serious about converting *all scripts* to C, clearly a powerful tool
is needed, and Ruby bindings fit the bill.

Ruby scripts could be provided alongside the perl/shell alternatives, so people
that build with NO_RUBY=y don't loose any functionality. And eventually the
Ruby scripts (and originals) get removed once the conversion to C is completed.

Even if Ruby is not used as an intermediary tool, and no official Git scripts are
converted to C this way, the bindings would still be useful to third parties.

Who wouldn't benefit from adding this support?

Felipe Contreras (44):
  Add support for ruby commands
  ruby: add support for internal ruby programs
  request-pull: fix annotated tag check
  request-pull: fix for specific branch
  request-pull: use appropriate ref
  request-pull: fix exact match checking
  request-pull: trivial simplification
  request-pull: t: trivial whitespace style fixes
  request-pull: t: add missing cat
  ruby: rewrite 'request-pull'
  ruby: request-pull: rewrite perl script
  ruby: request-pull: trivial simplifications
  ruby: bind setup_git_directory()
  ruby: bind dwim_ref()
  ruby: request-pull: use native dwim_ref()
  ruby: bind git_config()
  ruby: request-pull: use native git_config()
  ruby: bind read_ref()/peel_ref()
  ruby: bind get_sha1()
  ruby: request-pull: simplify tag fetching
  ruby: request-pull: use get_sha1()
  ruby: add Commit class
  ruby: bind get_merge_bases()
  ruby: request-pull: use get_merge_bases()
  ruby: request-pull: trivial cleanups
  ruby: bind remote and transport stuff
  ruby: request-pull: use native remote and transport
  ruby: bind find_unique_abbrev()
  ruby: request-pull: use native commit info
  ruby: bind read_sha1_file()
  ruby: request-pull: use read_sha1_file()
  revision: add missing include
  shortlog: add missing declaration
  shortlog: split builtin from common code
  ruby: add RevInfo and DiffOptions
  ruby: bind shortlog()
  ruby: request-pull: use shortlog()
  ruby: bind diff_tree_sha1()
  ruby: bind log_tree_diff_flush()
  ruby: request-pull: use native diff_tree stuff
  ruby: request-pull: remove rescue block
  ruby: remove GIT_PAGER from environment
  ruby: add simpler option parser
  request-pull: rewrite to C

 .gitignore              |   1 +
 Makefile                |  31 ++-
 builtin.h               |   1 +
 builtin/request-pull.c  | 275 +++++++++++++++++++++++
 builtin/shortlog.c      | 184 +--------------
 git-rb-setup.rb         | 109 +++++++++
 git-request-pull.sh     | 162 --------------
 git.c                   |   1 +
 revision.h              |   1 +
 ruby.c                  | 584 ++++++++++++++++++++++++++++++++++++++++++++++++
 shortlog.c              | 181 +++++++++++++++
 shortlog.h              |   8 +
 t/t10000-ruby.sh        | 233 +++++++++++++++++++
 t/t5150-request-pull.sh |  81 +++++--
 14 files changed, 1492 insertions(+), 360 deletions(-)
 create mode 100644 builtin/request-pull.c
 create mode 100644 git-rb-setup.rb
 delete mode 100755 git-request-pull.sh
 create mode 100644 ruby.c
 create mode 100644 shortlog.c
 create mode 100755 t/t10000-ruby.sh

-- 
1.8.4-fc

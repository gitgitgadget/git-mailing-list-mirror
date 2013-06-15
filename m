From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 00/12] Fix some reference-related races
Date: Sat, 15 Jun 2013 21:13:06 +0100
Message-ID: <51BCCAD2.9070106@ramsay1.demon.co.uk>
References: <1370987312-6761-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Jun 15 22:32:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Unx95-0007Ta-FR
	for gcvg-git-2@plane.gmane.org; Sat, 15 Jun 2013 22:32:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754536Ab3FOUcA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jun 2013 16:32:00 -0400
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:36569 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754517Ab3FOUb7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jun 2013 16:31:59 -0400
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 988C938407C;
	Sat, 15 Jun 2013 21:31:56 +0100 (BST)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id E0394384080;
	Sat, 15 Jun 2013 21:31:54 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;
	Sat, 15 Jun 2013 21:31:53 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <1370987312-6761-1-git-send-email-mhagger@alum.mit.edu>
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227969>

Michael Haggerty wrote:
> *This patch series must be built on top of mh/reflife.*
> 

[...]

> The other problem was that the for_each_ref() functions will die if
> the ref cache that they are iterating over is freed out from under
> them.  This problem is solved by using reference counts to avoid
> freeing the old packed ref cache (even if it is no longer valid) until
> all users are done with it.

Yes, I found exactly this happened to me on cygwin, earlier this week,
with the previous version of this code. After seeing this mail, I had
decided not to describe the failure on the old version, but wait and
test this version instead.

This version is a great improvement, but it still has some failures on
cygwin. So, it may be worth (briefly) describing the old failure anyway!
Note that several tests failed, but I will only mention t3211-peel-ref.sh
tests #7-8.

  $ pwd
  /home/ramsay/git/t/trash directory.t3211-peel-ref
  $

  $ ../../bin-wrappers/git show-ref -d
  d1ff1c9224ae5e58a7656fb9ecc95865d42ed71e refs/heads/master
  eb0e854c2cd2511c7571b1a5e3c8b8146193fb30 refs/outside/foo
  d1ff1c9224ae5e58a7656fb9ecc95865d42ed71e refs/outside/foo^{}
        5 [main] git 3540 _cygtls::handle_exceptions: Error while dumping state (p
  robably corrupted stack)
  Segmentation fault (core dumped)
  $

The stack-trace for the faulting code looks something like:

  cmd_show_ref()
    for_each_ref(show_ref, NULL)
      do_for_each_ref(&ref_cache, "", show_ref, 0, 0, NULL)
        do_for_each_entry(&ref_cache, "", do_one_ref, &data)
          do_for_each_entry_in_dirs(packed_dir, loose_dir, do_one_ref, &data)
            *dfeeid() recursive calls*
              do_one_ref(entry, &data)
                show_ref("refs/outside/foo", sha1, NULL) [2nd match]
                  peel_ref("refs/outside/foo", sha1)
                    peel_entry(entry, 0)
                      peel_object(name, sha1)
                        deref_tag_noverify(o)
                          parse_object(sha1 <eb0e854c2...>)
                            lookup_replace_object(sha1)
                              do_lookup_replace_object(sha1)
                                prepare_replace_object()

  [un-indent here!]
      for_each_replace_ref(register_replace_ref, NULL)
        do_for_each_ref(&ref_cache, "refs/replace", fn, 13, 0, NULL)
          do_for_each_entry(&ref_cache, "refs/replace", fn, &data)
            get_packed_refs(&ref_cache)
              clear_packed_ref_cache(&ref_cache) *free_ref_entries etc*
  ** return to show_ref() [2nd match] above **
  ** return to recursive dfeeid() call in original iteration
  ** dir1->entries has been free()-ed and reused => segmentation fault
  [dir1->entries == 0x64633263 => dc2c => part of sha1 for refs/outside/foo]

So, the nested "replace-reference-iteration" causes the ref_cache to be
freed out from under the initial show-ref iteration, so this works:

  $ GIT_NO_REPLACE_OBJECTS=1 ../../bin-wrappers/git show-ref -d
  d1ff1c9224ae5e58a7656fb9ecc95865d42ed71e refs/heads/master
  eb0e854c2cd2511c7571b1a5e3c8b8146193fb30 refs/outside/foo
  d1ff1c9224ae5e58a7656fb9ecc95865d42ed71e refs/outside/foo^{}
  d1ff1c9224ae5e58a7656fb9ecc95865d42ed71e refs/tags/base
  eb0e854c2cd2511c7571b1a5e3c8b8146193fb30 refs/tags/foo
  d1ff1c9224ae5e58a7656fb9ecc95865d42ed71e refs/tags/foo^{}
  $

You may be wondering why clear_packed_ref_cache() is called? Well, that
is because stat_validity_check() *incorrectly* indicates that the
packed-refs file has changed. Why does it do that? Well, this is one
more example of the problems caused by the cygwin schizophrenic stat()
functions. :( [ARGHHHHHHHHH]

At this point, I tried running 'git show-ref' with core.checkstat set
on the command line; but that didn't work! I had to fix show-ref and
re-build git, and then, this works:

  $ ../../bin-wrappers/git -c core.checkstat=minimal -c core.trustctime=f
  alse show-ref -d
  d1ff1c9224ae5e58a7656fb9ecc95865d42ed71e refs/heads/master
  eb0e854c2cd2511c7571b1a5e3c8b8146193fb30 refs/outside/foo
  d1ff1c9224ae5e58a7656fb9ecc95865d42ed71e refs/outside/foo^{}
  d1ff1c9224ae5e58a7656fb9ecc95865d42ed71e refs/tags/base
  eb0e854c2cd2511c7571b1a5e3c8b8146193fb30 refs/tags/foo
  d1ff1c9224ae5e58a7656fb9ecc95865d42ed71e refs/tags/foo^{}
  $

Now, turning to the new code, t3211-peel-ref.sh test #7 now works, but
test #8 still fails...

  $ ./t3211-peel-ref.sh -i -v

  ...

  ok 7 - refs are peeled outside of refs/tags (old packed)

  expecting success:
          git pack-refs --all &&
          cp .git/packed-refs fully-peeled &&
          git branch yadda &&
          git pack-refs --all &&
          git branch -d yadda &&
          test_cmp fully-peeled .git/packed-refs

  fatal: internal error: packed-ref cache cleared while locked
  not ok 8 - peeled refs survive deletion of packed ref
  #
  #               git pack-refs --all &&
  #               cp .git/packed-refs fully-peeled &&
  #               git branch yadda &&
  #               git pack-refs --all &&
  #               git branch -d yadda &&
  #               test_cmp fully-peeled .git/packed-refs
  #
  $ cd trash\ directory.t3211-peel-ref/
  $ ../../bin-wrappers/git pack-refs --all
  fatal: internal error: packed-ref cache cleared while locked
  $ ls
  actual  base.t  expect
  $ ls .git
  COMMIT_EDITMSG  branches/  description      index  logs/     packed-refs
  HEAD            config     hooks-disabled/  info/  objects/  refs/
  $ ls -l .git/packed-refs
  -rw-r--r-- 1 ramsay None 296 Jun 14 20:34 .git/packed-refs
  $ cat .git/packed-refs
  # pack-refs with: peeled
  d1ff1c9224ae5e58a7656fb9ecc95865d42ed71e refs/heads/master
  eb0e854c2cd2511c7571b1a5e3c8b8146193fb30 refs/outside/foo
  d1ff1c9224ae5e58a7656fb9ecc95865d42ed71e refs/tags/base
  eb0e854c2cd2511c7571b1a5e3c8b8146193fb30 refs/tags/foo
  ^d1ff1c9224ae5e58a7656fb9ecc95865d42ed71e
  $

Now, I have a test-stat program which prints the difference between
the two stat implementations used in cygwin git, thus:

  $ ../../test-stat .git/packed-refs
  stat for '.git/packed-refs':
  *dev:   -1395862925, 0
  *ino:   166044, 0
  *mode:  100644 -rw-, 100600 -rw-
   nlink: 1, 1
  *uid:   1005, 0
  *gid:   513, 0
  *rdev:  -1395862925, 0
   size:  296, 296
   atime: 1371238550, 1371238550 Fri Jun 14 20:35:50 2013
   mtime: 1371238469, 1371238469 Fri Jun 14 20:34:29 2013
   ctime: 1371238469, 1371238469 Fri Jun 14 20:34:29 2013
  $ ../../bin-wrappers/git -c core.checkstat=minimal pack-refs --all
  fatal: internal error: packed-ref cache cleared while locked
  $

Hmmm, that should have worked! Wait, fix 'git pack-refs' to support
setting config variables on the command line, rebuild and:

  $ ../../bin-wrappers/git -c core.checkstat=minimal pack-refs --all
  $ cat .git/packed-refs
  # pack-refs with: peeled fully-peeled
  d1ff1c9224ae5e58a7656fb9ecc95865d42ed71e refs/heads/master
  eb0e854c2cd2511c7571b1a5e3c8b8146193fb30 refs/outside/foo
  ^d1ff1c9224ae5e58a7656fb9ecc95865d42ed71e
  d1ff1c9224ae5e58a7656fb9ecc95865d42ed71e refs/tags/base
  eb0e854c2cd2511c7571b1a5e3c8b8146193fb30 refs/tags/foo
  ^d1ff1c9224ae5e58a7656fb9ecc95865d42ed71e
  $

I haven't checked the remaining test failures to see if they are
caused by this code (I don't think so, but ...), but this failure
is clearly a cygwin specific issue.

HTH

ATB,
Ramsay Jones

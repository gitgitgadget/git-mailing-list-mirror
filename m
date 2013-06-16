From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 00/12] Fix some reference-related races
Date: Sun, 16 Jun 2013 07:50:42 +0200
Message-ID: <51BD5232.20205@alum.mit.edu>
References: <1370987312-6761-1-git-send-email-mhagger@alum.mit.edu> <51BCCAD2.9070106@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Jun 16 07:51:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uo5rm-0005XQ-QI
	for gcvg-git-2@plane.gmane.org; Sun, 16 Jun 2013 07:51:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754850Ab3FPFus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Jun 2013 01:50:48 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:44806 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754111Ab3FPFur (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Jun 2013 01:50:47 -0400
X-AuditID: 1207440f-b7f786d000001f20-23-51bd5236e4ad
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 33.1C.07968.6325DB15; Sun, 16 Jun 2013 01:50:46 -0400 (EDT)
Received: from [192.168.69.140] (p57A255AA.dip0.t-ipconnect.de [87.162.85.170])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5G5ogkT014688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 16 Jun 2013 01:50:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <51BCCAD2.9070106@ramsay1.demon.co.uk>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBKsWRmVeSWpSXmKPExsUixO6iqGsWtDfQoPOBqEXXlW4mi4beK8wW
	8+7uYrL40dLDbLF72gI2B1aPSy+/s3k8693D6HHxkrLH44knWD0+b5ILYI3itklKLCkLzkzP
	07dL4M6Y9LmDreB/WMXtCTeZGhgvOncxcnJICJhIHPx5hxHCFpO4cG89WxcjF4eQwGVGiQcT
	30I555kkvqz8wARSxSugKfGy9S+YzSKgKnHg6CWwbjYBXYlFPc1gcVGBMIn3y6ayQtQLSpyc
	+YQFxBYBqlk87yQzyFBmgSZGidsXVoMVCQtYS3x+/JIZxBYSyJL41/kTLM4pYCxx+cd+sAXM
	AjoS7/oeMEPY8hLb385hnsAoMAvJjllIymYhKVvAyLyKUS4xpzRXNzcxM6c4NVm3ODkxLy+1
	SNdELzezRC81pXQTIyTM+Xcwdq2XOcQowMGoxMNbIL43UIg1say4MvcQoyQHk5Io7wQfoBBf
	Un5KZUZicUZ8UWlOavEhRgkOZiUR3qWyQDnelMTKqtSifJiUNAeLkjiv+hJ1PyGB9MSS1OzU
	1ILUIpisDAeHkgQvVyBQo2BRanpqRVpmTglCmomDE2Q4l5RIcWpeSmpRYmlJRjwoWuOLgfEK
	kuIB2rs7AGRvcUFiLlAUovUUozHH5LNb3jNyHPgBJIVY8vLzUqXEea+ClAqAlGaU5sEtgiW4
	V4ziQH8L834DqeIBJke4ea+AVjEBrYo7tgtkVUkiQkqqgTFwTtGiwrDPiet32b5pP7dVdRWv
	TRv3iagcIcdJh83Dcn+qdnmvyXjiV3XnTdgEg4ZZpeu2Bt9/1J12n+n/pNhT8yMe 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227988>

Thanks for all of the information.

On 06/15/2013 10:13 PM, Ramsay Jones wrote:
> Michael Haggerty wrote:
>> *This patch series must be built on top of mh/reflife.*
>>
> 
> [...]
> 
>> The other problem was that the for_each_ref() functions will die if
>> the ref cache that they are iterating over is freed out from under
>> them.  This problem is solved by using reference counts to avoid
>> freeing the old packed ref cache (even if it is no longer valid) until
>> all users are done with it.
> 
> Yes, I found exactly this happened to me on cygwin, earlier this week,
> with the previous version of this code. After seeing this mail, I had
> decided not to describe the failure on the old version, but wait and
> test this version instead.
> 
> This version is a great improvement, but it still has some failures on
> cygwin. So, it may be worth (briefly) describing the old failure anyway!
> Note that several tests failed, but I will only mention t3211-peel-ref.sh
> tests #7-8.
> 
>   $ pwd
>   /home/ramsay/git/t/trash directory.t3211-peel-ref
>   $
> 
>   $ ../../bin-wrappers/git show-ref -d
>   d1ff1c9224ae5e58a7656fb9ecc95865d42ed71e refs/heads/master
>   eb0e854c2cd2511c7571b1a5e3c8b8146193fb30 refs/outside/foo
>   d1ff1c9224ae5e58a7656fb9ecc95865d42ed71e refs/outside/foo^{}
>         5 [main] git 3540 _cygtls::handle_exceptions: Error while dumping state (p
>   robably corrupted stack)
>   Segmentation fault (core dumped)
>   $
> 
> The stack-trace for the faulting code looks something like:
> 
>   cmd_show_ref()
>     for_each_ref(show_ref, NULL)
>       do_for_each_ref(&ref_cache, "", show_ref, 0, 0, NULL)
>         do_for_each_entry(&ref_cache, "", do_one_ref, &data)
>           do_for_each_entry_in_dirs(packed_dir, loose_dir, do_one_ref, &data)
>             *dfeeid() recursive calls*
>               do_one_ref(entry, &data)
>                 show_ref("refs/outside/foo", sha1, NULL) [2nd match]
>                   peel_ref("refs/outside/foo", sha1)
>                     peel_entry(entry, 0)
>                       peel_object(name, sha1)
>                         deref_tag_noverify(o)
>                           parse_object(sha1 <eb0e854c2...>)
>                             lookup_replace_object(sha1)
>                               do_lookup_replace_object(sha1)
>                                 prepare_replace_object()
> 
>   [un-indent here!]
>       for_each_replace_ref(register_replace_ref, NULL)
>         do_for_each_ref(&ref_cache, "refs/replace", fn, 13, 0, NULL)
>           do_for_each_entry(&ref_cache, "refs/replace", fn, &data)
>             get_packed_refs(&ref_cache)
>               clear_packed_ref_cache(&ref_cache) *free_ref_entries etc*
>   ** return to show_ref() [2nd match] above **
>   ** return to recursive dfeeid() call in original iteration
>   ** dir1->entries has been free()-ed and reused => segmentation fault
>   [dir1->entries == 0x64633263 => dc2c => part of sha1 for refs/outside/foo]
> 
> So, the nested "replace-reference-iteration" causes the ref_cache to be
> freed out from under the initial show-ref iteration, so this works:
> 
>   $ GIT_NO_REPLACE_OBJECTS=1 ../../bin-wrappers/git show-ref -d
>   d1ff1c9224ae5e58a7656fb9ecc95865d42ed71e refs/heads/master
>   eb0e854c2cd2511c7571b1a5e3c8b8146193fb30 refs/outside/foo
>   d1ff1c9224ae5e58a7656fb9ecc95865d42ed71e refs/outside/foo^{}
>   d1ff1c9224ae5e58a7656fb9ecc95865d42ed71e refs/tags/base
>   eb0e854c2cd2511c7571b1a5e3c8b8146193fb30 refs/tags/foo
>   d1ff1c9224ae5e58a7656fb9ecc95865d42ed71e refs/tags/foo^{}
>   $
> 
> You may be wondering why clear_packed_ref_cache() is called? Well, that
> is because stat_validity_check() *incorrectly* indicates that the
> packed-refs file has changed. Why does it do that? Well, this is one
> more example of the problems caused by the cygwin schizophrenic stat()
> functions. :( [ARGHHHHHHHHH]
> 
> At this point, I tried running 'git show-ref' with core.checkstat set
> on the command line; but that didn't work! I had to fix show-ref and
> re-build git, and then, this works:
> 
>   $ ../../bin-wrappers/git -c core.checkstat=minimal -c core.trustctime=f
>   alse show-ref -d
>   d1ff1c9224ae5e58a7656fb9ecc95865d42ed71e refs/heads/master
>   eb0e854c2cd2511c7571b1a5e3c8b8146193fb30 refs/outside/foo
>   d1ff1c9224ae5e58a7656fb9ecc95865d42ed71e refs/outside/foo^{}
>   d1ff1c9224ae5e58a7656fb9ecc95865d42ed71e refs/tags/base
>   eb0e854c2cd2511c7571b1a5e3c8b8146193fb30 refs/tags/foo
>   d1ff1c9224ae5e58a7656fb9ecc95865d42ed71e refs/tags/foo^{}
>   $

So if I understand correctly, all of the above is *without* the
refcounting changes introduced in mh/ref-races?  Is so, then it is not
surprising, as this is exactly the sort of problem that the reference
counting is meant to solve.

> Now, turning to the new code, t3211-peel-ref.sh test #7 now works, but
> test #8 still fails...
> 
>   $ ./t3211-peel-ref.sh -i -v
> 
>   ...
> 
>   ok 7 - refs are peeled outside of refs/tags (old packed)
> 
>   expecting success:
>           git pack-refs --all &&
>           cp .git/packed-refs fully-peeled &&
>           git branch yadda &&
>           git pack-refs --all &&
>           git branch -d yadda &&
>           test_cmp fully-peeled .git/packed-refs
> 
>   fatal: internal error: packed-ref cache cleared while locked
>   not ok 8 - peeled refs survive deletion of packed ref
>   #
>   #               git pack-refs --all &&
>   #               cp .git/packed-refs fully-peeled &&
>   #               git branch yadda &&
>   #               git pack-refs --all &&
>   #               git branch -d yadda &&
>   #               test_cmp fully-peeled .git/packed-refs
>   #
>   $ cd trash\ directory.t3211-peel-ref/
>   $ ../../bin-wrappers/git pack-refs --all
>   fatal: internal error: packed-ref cache cleared while locked

These "internal error: packed-ref cache cleared while locked" failures
result from an internal consistency check that clear_packed_ref_cache()
is not called while the write lock is held on the packed-refs file.  A
call to c_p_r_c() could result from

* a programming error

* a determination based on the packed-refs file stat that the file needs
to be re-read

Judging from what you said about cygwin, I assume that the latter is
happening.  It should be impossible, because the current process is
holding packed-refs.lock, and therefore other git processes should
refuse to change the packed-refs file.

But if the stat information is not reliable, then the current process
would *think* that the packed-refs file has been changed even though it
hasn't, then it would call c_p_r_c() even though it holds the lock on
packed-refs, and the internal consistency check would fail.

So apparently in these cases cygwin is reporting that the packed-refs
stat information has changed (in the sense defined by the new
stat_validity_check() function, which does essentially the same checks
as the old ce_match_stat_basic() function).

>   $ ls
>   actual  base.t  expect
>   $ ls .git
>   COMMIT_EDITMSG  branches/  description      index  logs/     packed-refs
>   HEAD            config     hooks-disabled/  info/  objects/  refs/
>   $ ls -l .git/packed-refs
>   -rw-r--r-- 1 ramsay None 296 Jun 14 20:34 .git/packed-refs
>   $ cat .git/packed-refs
>   # pack-refs with: peeled
>   d1ff1c9224ae5e58a7656fb9ecc95865d42ed71e refs/heads/master
>   eb0e854c2cd2511c7571b1a5e3c8b8146193fb30 refs/outside/foo
>   d1ff1c9224ae5e58a7656fb9ecc95865d42ed71e refs/tags/base
>   eb0e854c2cd2511c7571b1a5e3c8b8146193fb30 refs/tags/foo
>   ^d1ff1c9224ae5e58a7656fb9ecc95865d42ed71e
>   $
> 
> Now, I have a test-stat program which prints the difference between
> the two stat implementations used in cygwin git, thus:
> 
>   $ ../../test-stat .git/packed-refs
>   stat for '.git/packed-refs':
>   *dev:   -1395862925, 0
>   *ino:   166044, 0
>   *mode:  100644 -rw-, 100600 -rw-
>    nlink: 1, 1
>   *uid:   1005, 0
>   *gid:   513, 0
>   *rdev:  -1395862925, 0
>    size:  296, 296
>    atime: 1371238550, 1371238550 Fri Jun 14 20:35:50 2013
>    mtime: 1371238469, 1371238469 Fri Jun 14 20:34:29 2013
>    ctime: 1371238469, 1371238469 Fri Jun 14 20:34:29 2013

Yikes!  ECYGWINFAIL.  I have no doubt they have reason why they cannot
implement this correctly, but this is rather limiting.  (I has assumed
that the #ifdef magic that was already in ce_match_stat_basic() would
have papered over the problems in stat, but I guess that is not the case.)

You say that there are two stat references in cygwin.  Is there a way to
ensure that the same one is used in both cases?  Or is it so hopelessly
broken that there is no point?

Or let me step back and pose a slightly more abstract question:

How, under cygwin, can we implement a quick check of whether a file
might have changed?  The check should not have any false negatives
(claiming that a file is unchanged when actually it was rewritten via
the usual lock_file mechanism) nor should it have any "strong" false
positives (claiming that a file has changed even though it has never
been touched), though a "weak" false positive would be OK (claiming that
a file has changed even though it was replaced by a version with
identical contents).

If such a check is possible, then we should build it into the
implementation of match_stat_data().  If not, we have to think of
another way to implement the checks of packed-refs cache up-to-dateness.

(One horrible hack would be: when in doubt, read the packed-refs file
into a temporary ref_dir, then compare *the contents* to the version in
the cache.  If they are the same, then discard the newly-read version,
update the stat_validity, and continue to use the old version.  If they
are different, *then* verify that the lock file was not held, call
clear_packed_ref_cache(), and start using the new version.)

>   $ ../../bin-wrappers/git -c core.checkstat=minimal pack-refs --all
>   fatal: internal error: packed-ref cache cleared while locked
>   $
> 
> Hmmm, that should have worked! Wait, fix 'git pack-refs' to support
> setting config variables on the command line, rebuild and:
> 
>   $ ../../bin-wrappers/git -c core.checkstat=minimal pack-refs --all
>   $ cat .git/packed-refs
>   # pack-refs with: peeled fully-peeled
>   d1ff1c9224ae5e58a7656fb9ecc95865d42ed71e refs/heads/master
>   eb0e854c2cd2511c7571b1a5e3c8b8146193fb30 refs/outside/foo
>   ^d1ff1c9224ae5e58a7656fb9ecc95865d42ed71e
>   d1ff1c9224ae5e58a7656fb9ecc95865d42ed71e refs/tags/base
>   eb0e854c2cd2511c7571b1a5e3c8b8146193fb30 refs/tags/foo
>   ^d1ff1c9224ae5e58a7656fb9ecc95865d42ed71e
>   $
> 
> I haven't checked the remaining test failures to see if they are
> caused by this code (I don't think so, but ...), but this failure
> is clearly a cygwin specific issue.

Thanks again for the testing and analysis,
Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/

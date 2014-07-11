From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4 v6] cache-tree: subdirectory tests
Date: Fri, 11 Jul 2014 08:27:07 -0700
Message-ID: <xmqqbnsv6hmc.fsf@gitster.dls.corp.google.com>
References: <1405038686-1138-1-git-send-email-dturner@twitter.com>
	<1405038686-1138-3-git-send-email-dturner@twitter.com>
	<CAPig+cQVjy5eBtGLsX3uaTEsHyvyjhqCMFaLDn9Upueis-z1eQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, David Turner <dturner@twitter.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 17:27:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5cjH-0000DZ-3V
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 17:27:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753910AbaGKP1P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 11:27:15 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56041 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753331AbaGKP1O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 11:27:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0B716265EA;
	Fri, 11 Jul 2014 11:26:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fH0bUNr1uRIsoM7KTd78KKthkh0=; b=ijku8O
	OauBK92If3DTTaGMGndnv4P2QzLrg+1cN5PMFE6rRW9UHcaknJvpwhE3Yw5LrWy9
	gdynsYoByXScwJI5Yt7nBglVZCaiE0Mp2EUXTP/9EB3E18o06Cix31c9RW4/Libf
	LxRIvS9q7mzrEUihTmsEpiOLwo8WHPFlG5fRc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Fj4A2nwj1u/meFCrXO/qYYFHA94KLzHh
	b/lIHHV5A+wpTUM66KxUEeoS8pWWN76eRz3ztdkaG3JRAaUczezxiKCfPUPOlUoG
	W7wLVaQ22MKhOnYhfh6v5mkA6RqrEPyyeeA/sudaKONf0CvMqJ9O0XQ//5C4Vtqt
	Fu7NIhTVL0Y=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 002D6265E9;
	Fri, 11 Jul 2014 11:26:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 913E2265E1;
	Fri, 11 Jul 2014 11:26:53 -0400 (EDT)
In-Reply-To: <CAPig+cQVjy5eBtGLsX3uaTEsHyvyjhqCMFaLDn9Upueis-z1eQ@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 11 Jul 2014 02:03:44 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C9667642-090F-11E4-8E02-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253282>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Thu, Jul 10, 2014 at 8:31 PM, David Turner <dturner@twopensource.com> wrote:
>> Add tests to confirm that invalidation of subdirectories neither over-
>> nor under-invalidates.
>>
>> Signed-off-by: David Turner <dturner@twitter.com>
>> ---
>>  t/t0090-cache-tree.sh | 26 +++++++++++++++++++++++---
>>  1 file changed, 23 insertions(+), 3 deletions(-)
>>
>> diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
>> index 98fb1ab..3a3342e 100755
>> --- a/t/t0090-cache-tree.sh
>> +++ b/t/t0090-cache-tree.sh
>> @@ -22,9 +22,10 @@ test_shallow_cache_tree () {
>>  }
>>
>>  test_invalid_cache_tree () {
>> -       echo "invalid                                   (0 subtrees)" >expect &&
>> -       printf "SHA #(ref)  (%d entries, 0 subtrees)\n" $(git ls-files|wc -l) >>expect &&
>> -       cmp_cache_tree expect
>> +       printf "invalid                                  %s ()\n" "" "$@" >expect &&

Hmm.  This will always expect that the top-level is invalid, even
when $# is 0.  It is OK if you never need to use this to test that a
cache-tree is fully valid, but is it something we want to check?

Existing tests are mostly about "cache-tree is populated fully at a
few strategic, well known and easy places and then it degrades over
time", but after all your series is adding more places to that set
of "a few places", so we may want to make sure that future breakages
to the new code paths that "repair" the cache-tree are caught by
these tests.

>> +       test-dump-cache-tree | \
>
> nit: unnecessary backslash

Good eyes ;-)

>> +       sed -n -e "s/[0-9]* subtrees//" -e '/#(ref)/d' -e '/^invalid /p' >actual &&

Is the second one to remove "#(ref)", which appears for a good
"reference" cache tree entry shown for comparison, necessary?  Do
they ever begin with "invalid"?  If they ever begin with "invalid"
that itself may even be a noteworthy breakage to catch, no?

>> +       test_cmp expect actual
>>  }
>>
>>  test_no_cache_tree () {
>> @@ -49,6 +50,25 @@ test_expect_success 'git-add invalidates cache-tree' '
>>         test_invalid_cache_tree
>>  '
>>
>> +test_expect_success 'git-add in subdir invalidates cache-tree' '
>> +       test_when_finished "git reset --hard; git read-tree HEAD" &&
>> +       mkdir dirx &&
>> +       echo "I changed this file" >dirx/foo &&
>> +       git add dirx/foo &&
>> +       test_invalid_cache_tree
>> +'
>> +
>> +test_expect_success 'git-add in subdir does not invalidate sibling cache-tree' '
>> +       git tag no-children &&
>> +       test_when_finished "git reset --hard no-children; git read-tree HEAD" &&
>> +       mkdir dir1 dir2 &&
>> +       test_commit dir1/a &&
>> +       test_commit dir2/b &&
>> +       echo "I changed this file" >dir1/a &&
>> +       git add dir1/a &&
>> +       test_invalid_cache_tree dir1/
>> +'
>> +
>>  test_expect_success 'update-index invalidates cache-tree' '
>>         test_when_finished "git reset --hard; git read-tree HEAD" &&
>>         echo "I changed this file" >foo &&
>> --
>> 2.0.0.390.gcb682f8

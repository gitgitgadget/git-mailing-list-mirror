From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] diff: avoid stack-buffer-read-overrun for very long name
Date: Tue, 24 Apr 2012 18:09:35 +0200
Message-ID: <87397t862o.fsf@rho.meyering.net>
References: <87ty0jbt5p.fsf@rho.meyering.net> <20120416222713.GA2396@moj>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git list <git@vger.kernel.org>
To: Marcus Karlsson <mk@acc.umu.se>
X-From: git-owner@vger.kernel.org Tue Apr 24 18:09:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMiJJ-0000de-Je
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 18:09:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755977Ab2DXQJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 12:09:45 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:51740 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755503Ab2DXQJo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 12:09:44 -0400
Received: from mx.meyering.net (unknown [88.168.87.75])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 80ABAD4813B
	for <git@vger.kernel.org>; Tue, 24 Apr 2012 18:09:37 +0200 (CEST)
Received: from rho.meyering.net (localhost.localdomain [127.0.0.1])
	by rho.meyering.net (Acme Bit-Twister) with ESMTP id CD6CA60146;
	Tue, 24 Apr 2012 18:09:35 +0200 (CEST)
In-Reply-To: <20120416222713.GA2396@moj> (Marcus Karlsson's message of "Tue,
	17 Apr 2012 00:27:17 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196224>

Marcus Karlsson wrote:
> On Mon, Apr 16, 2012 at 05:20:02PM +0200, Jim Meyering wrote:
>>
>> Due to the use of strncpy without explicit NUL termination,
>> we could end up passing names n1 or n2 that are not NUL-terminated
>> to queue_diff, which requires NUL-terminated strings.
>> Ensure that each is NUL terminated.
>>
>> Signed-off-by: Jim Meyering <meyering@redhat.com>
>> ---
>> After finding strncpy problems in other projects, I audited
>> git for the same and found only these two.
>>
>>  diff-no-index.c |    2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/diff-no-index.c b/diff-no-index.c
>> index 3a36144..5cd3ff5 100644
>> --- a/diff-no-index.c
>> +++ b/diff-no-index.c
>> @@ -109,6 +109,7 @@ static int queue_diff(struct diff_options *o,
>>  				n1 = buffer1;
>>  				strncpy(buffer1 + len1, p1.items[i1++].string,
>>  						PATH_MAX - len1);
>> +				buffer1[PATH_MAX-1] = 0;
>>  			}
>>
>>  			if (comp < 0)
>> @@ -117,6 +118,7 @@ static int queue_diff(struct diff_options *o,
>>  				n2 = buffer2;
>>  				strncpy(buffer2 + len2, p2.items[i2++].string,
>>  						PATH_MAX - len2);
>> +				buffer2[PATH_MAX-1] = 0;
>>  			}
>>
>>  			ret = queue_diff(o, n1, n2);
>> --
>> 1.7.10.169.g146fe
>
> Are there any guarantees that len1 and len2 does not exceed PATH_MAX?
> Because if there aren't any then that function looks like it could need
> even more improvements.

Hi Marcus,

You're right to ask.
I've just confirmed that there is such a guarantee.  The question
is whether either of queue_diff's name1 or name2 parameters may have
strlen larger than PATH_MAX, in which case, this code would misbehave,
passing a negative length to strncpy:

				strncpy(buffer1 + len1, p1.items[i1++].string,
						PATH_MAX - len1);
				buffer1[PATH_MAX-1] = 0;

queue_diff is called from only two places:

  - from itself, recursively
  - from diff_no_index

The latter looks fine, since it's called with already-vetted names:

	if (queue_diff(&revs->diffopt, revs->diffopt.pathspec.raw[0],
		       revs->diffopt.pathspec.raw[1]))

The recursive call is reachable only when both name1 and name2 are lstat'able.
If they're not (assuming they're non-trivial), this get_mode call fails:

    static int queue_diff(struct diff_options *o,
                    const char *name1, const char *name2)
    {
            int mode1 = 0, mode2 = 0;

            if (get_mode(name1, &mode1) || get_mode(name2, &mode2))
                    return -1;

Thus, as long as a file with name longer than PATH_MAX is not
lstat'able (what about hurd?), we're ok.

However, a further improvement is possible if you care what happens
when a very long newly-formed name is truncated by that use of strncpy.
When that happens, in a pathological case in which the truncated
name exists as well as the original, queue_diff could print totally
bogus results.

I.e., if dir/.../.../some-name is 5 bytes too long,
and the truncated "n1" formed in queue_diff, "dir/.../.../some"
refers to a file that actually exists, queue_diff will mistakenly
use the truncated file name.

From: Brandon Casey <bcasey@nvidia.com>
Subject: Re: [PATCH 04/11] sequencer.c: recognize "(cherry picked from ..."
 as part of s-o-b footer
Date: Wed, 28 Nov 2012 17:28:33 -0800
Message-ID: <50B6BA41.7070402@nvidia.com>
References: <1353894359-6733-1-git-send-email-drafnel@gmail.com> <1353894359-6733-5-git-send-email-drafnel@gmail.com> <7v8v9ltgxn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Brandon Casey <drafnel@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"pclouds@gmail.com" <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 02:28:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tdsvq-0007NB-GV
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 02:28:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932827Ab2K2B2f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 20:28:35 -0500
Received: from hqemgate03.nvidia.com ([216.228.121.140]:6680 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932476Ab2K2B2e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 20:28:34 -0500
Received: from hqnvupgp07.nvidia.com (Not Verified[216.228.121.13]) by hqemgate03.nvidia.com
	id <B50b6baff0000>; Wed, 28 Nov 2012 17:31:43 -0800
Received: from hqemhub03.nvidia.com ([172.17.108.22])
  by hqnvupgp07.nvidia.com (PGP Universal service);
  Wed, 28 Nov 2012 17:28:19 -0800
X-PGP-Universal: processed;
	by hqnvupgp07.nvidia.com on Wed, 28 Nov 2012 17:28:19 -0800
Received: from [172.17.130.240] (172.20.144.16) by hqemhub03.nvidia.com
 (172.20.150.15) with Microsoft SMTP Server id 8.3.279.1; Wed, 28 Nov 2012
 17:28:33 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <7v8v9ltgxn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210806>

On 11/28/2012 4:02 PM, Junio C Hamano wrote:
> Brandon Casey <drafnel@gmail.com> writes:
>
>> -static int ends_rfc2822_footer(struct strbuf *sb, int ignore_footer)
>> +static int is_rfc2822_line(const char *buf, int len)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < len; i++) {
>> +		int ch = buf[i];
>> +		if (ch == ':')
>> +			break;
>> +		if (isalnum(ch) || (ch == '-'))
>> +			continue;
>> +		return 0;
>> +	}
>> +
>> +	return 1;
>> +}
>> +
>> +static int is_cherry_pick_from_line(const char *buf, int len)
>> +{
>> +	return (strlen(cherry_picked_prefix) + 41) <= len &&
>> +		!prefixcmp(buf, cherry_picked_prefix);
>> +}
>> +
>> +static int has_conforming_footer(struct strbuf *sb, int ignore_footer)
>>   {
>> -	int ch;
>>   	int hit = 0;
>> -	int i, j, k;
>> +	int i, k;
>>   	int len = sb->len - ignore_footer;
>>   	const char *buf = sb->buf;
>>
>> @@ -1039,15 +1061,9 @@ static int ends_rfc2822_footer(struct strbuf *sb, int ignore_footer)
>>   			; /* do nothing */
>>   		k++;
>>
>> -		for (j = 0; i + j < len; j++) {
>> -			ch = buf[i + j];
>> -			if (ch == ':')
>> -				break;
>> -			if (isalnum(ch) ||
>> -			    (ch == '-'))
>> -				continue;
>> +		if (!(is_rfc2822_line(buf+i, k-i) ||
>> +			is_cherry_pick_from_line(buf+i, k-i)))
>>   			return 0;
>> -		}
>>   	}
>>   	return 1;
>>   }
>
> Refactored code looks vastly more readable, but I think the
> is_cherry_pick_from_line() function (by the way, shouldn't it be
> named is_cherry_picked_from_line()?

Yes.

> ) shows its ambivalence.  It
> insists that the line has to be long enough to hold 40-hex object
> name plus a closing parenthesis, but it only makes sure that the
> prefix matches, without checking if the line has 40-hex object name,
> or the object name is immediately followed by a closing parenthesis.
> It also does not care if there are other garbage after it.
>
> If the code is trying to be strict to avoid misidentification, then
> the check should be tightened (i.e. require the known fixed length,
> make sure get_sha1_hex() is happy, 41st byte is a close parenthesis
> that is followed by the end of line).  If the code is trying to be
> more lenient to allow people hand-editing the cherry-picked-from
> line that was generated, the check could be loosened (people may
> truncate the 40-hex down to 12-hex or something).
>
> I cannot read from this code which one was intended; the code must
> make up its mind, whichever way (I do not have a strong preference).

The intention was a stricter-type match, but implemented somewhat
lazily.  Part of me doesn't think that anyone should need to modify
the string that 'cherry-pick -x' adds and that a strict match is
appropriate.  The other part of me doesn't want to reject a line that
looks like "(cherry picked from ...)" line that has a trimmed sha1
inside.

I think I'll submit a somewhat loosened check.

>> +test_expect_success 'cherry-pick -x -s adds sob when last sob doesnt match committer' '
>
> Is the title of this test appropriate?  It looks like it is making
> sure we do not add an extra blank line after the existing footer to
> me.

It's really just part of the series of tests that checks for correct
operation when "the last sob doesn't match committer".  This test
has a few elements in it:

    * existing sob footer contains the committer's sob, but not last.
      ensure that we don't refrain from appending a sob just because
      one already exists in the footer.
    * ensure extra blank isn't inserted after existing footer and
      "(cherry picked from..."
    * ensure a blank isn't inserted between "(cherry picked from..."
      and new sob

The title of the test is me trying to fit "correctly adds \"(cherry
picked from...\" and sob when footer contains committer's sob but
not last" within a single line.

>> +	pristine_detach initial &&
>> +	sha1=`git rev-parse mesg-with-footer^0` &&
>> +	git cherry-pick -x -s mesg-with-footer &&
>> +	cat <<-EOF >expect &&
>> +		$mesg_with_footer
>> +		(cherry picked from commit $sha1)
>> +		Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
>> +	EOF
>> +	git log -1 --pretty=format:%B >actual &&
>> +	test_cmp expect actual
>> +'
>> +
>
>> +test_expect_success 'cherry-pick -x -s adds sob even when trailing sob exists for committer' '
>> +	pristine_detach initial &&
>> +	sha1=`git rev-parse mesg-with-footer-sob^0` &&
>> +	git cherry-pick -x -s mesg-with-footer-sob &&
>> +	cat <<-EOF >expect &&
>> +		$mesg_with_footer_sob
>> +		(cherry picked from commit $sha1)
>> +		Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
>> +	EOF
>> +	git log -1 --pretty=format:%B >actual &&
>> +	test_cmp expect actual
>> +'
>
> For people on the sideline, $mesg_with_footer_sob ends with s-o-b by
> the same "$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" we are adding
> here.  This is probably a sensible thing to do.
>
> One thing I am not so happy about this whole "(cherry picked from"
> thing (and I am again agreeing with Linus who made me change the
> default long time ago not to add this line by default) is this.  If
> you use "cherry-pick -s -x $commit" to transplant a commit from an
> unrelated part of the history, you will get the object name in the
> resulting commit.  But you can do the same in at least two different
> ways.  The easiest is:
>
>      git format-patch -1 --stdout $commit | git am -s3
>
> and a bit closer to what "cherry-pick" does is:
>
>      git checkout $commit^0 &&
>      git rebase --onto @{-1} HEAD^ &&
>      git checkout -B @{-1}
>
> i.e. rebase the single commit on top of the branch you were on.
>
> In either way, you don't get "cherry picked from", even though you
> just did the moral equivalent of it.  Also we need to realize that
> the first one is essentially what happens all the time here; the "|"
> is implemented by the mailing list.  And nobody misses "cherry
> picked from" to point at the original commit object, which is
> useless for the recipient of the resulting commit.
>
> But that is an orthogonal issue.

Are you suggesting that people shouldn't use 'cherry-pick -x' at all?

I agree that it is useless to use -x when the commit that will be
referenced will not be available as part of the permanent history
of the project.

I do however think it is useful to add a reference to the original
commit when back- or forward- porting a commit.  I think it adds
a little visibility to the commit to say that it was not originally
implemented on top of the base it is built on.  I find it helpful
to examine the original implementation (the referenced commit) when
verifying the correctness or attempting to understand the ported
commit.

-Brandon



-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------

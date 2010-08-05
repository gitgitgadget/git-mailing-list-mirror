From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v2 2/3] stash: Allow git stash branch to process commits 
	that look like stashes but are not stash references.
Date: Thu, 5 Aug 2010 17:50:12 +1000
Message-ID: <AANLkTi=FbF3X83uLjBDoCYUCuig3udTzZCXuE=1_w-Ld@mail.gmail.com>
References: <1280831775-30759-1-git-send-email-jon.seymour@gmail.com>
	<1280831775-30759-3-git-send-email-jon.seymour@gmail.com>
	<7vwrs6djie.fsf@alter.siamese.dyndns.org>
	<AANLkTikA0_Og4bzB8AHo3s2cLCvf6pc9=wC4w_8emuxU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 09:50:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgvDZ-00078i-IA
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 09:50:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759849Ab0HEHuQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Aug 2010 03:50:16 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:64929 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758296Ab0HEHuO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Aug 2010 03:50:14 -0400
Received: by qwh6 with SMTP id 6so3702177qwh.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 00:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QmzFrrM7femeHpK2WvgjPkaCGp/y11Y0RDSgZX8jx/A=;
        b=sj9rZBq55wjHVH1VulAKHfL+luLQFOgJseSYxnlFGjcZPj7XRSaeH5T2SSnfFSl77i
         5/nWQwan6m1aSXu5SaX0O8+THmWcjJC1mt1JFw5Chd7CAIXahKyoDMIL+H+0FEE2WlXW
         L/+XKW0/RBrqyBpSFtUX0SnYIVpy/h2PVSf5g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uxVlOjwME8Qb0VY/oWtg44aIywDw1iNlehY8DjDbnIycI8D8JeOwqmcnoeErlxXDCZ
         jA8Wh2n7ha56N6Kd0lZJpWhJ8XehEp7oBF6ASrCLIFFbDuWcg9N7xCkuoRsIkWmwlDn/
         GzXAFQxfL5ndjNeq7BzEMxg1CUMM06uo9oQvE=
Received: by 10.229.131.160 with SMTP id x32mr3116185qcs.203.1280994612998; 
	Thu, 05 Aug 2010 00:50:12 -0700 (PDT)
Received: by 10.229.222.13 with HTTP; Thu, 5 Aug 2010 00:50:12 -0700 (PDT)
In-Reply-To: <AANLkTikA0_Og4bzB8AHo3s2cLCvf6pc9=wC4w_8emuxU@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152619>

One question about test patches. Are you ok with test_expect_failure
tests that document the expected failure of a feature yet to be
developed, followed by the feature, followed by the patch that makes
the tests into test_expect_success tests, or would you prefer to see
the pre- and post- test patches rolled into a single test that is
delivered after the feature patch?

On Thu, Aug 5, 2010 at 3:23 PM, Jon Seymour <jon.seymour@gmail.com> wro=
te:
> Junio,
>
> Thanks for the feedback. I'll rework along the lines you suggest. If
> it makes sense to make the other stash commands tolerant of non-stash
> entry references I'll add tests, support and documentation for that.
>
> jon.
>
> On Thu, August 2010 at 9:51 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> Jon =C2=A0Seymour <jon.seymour@gmail.com> writes:
>>
>>> This patch allows git stash branch to work with stash-like commits =
created by git stash create.
>>>
>>> Two changes were required:
>>>
>>> * relax the pre-condition so that a stash stack is required if and =
only if a stash argument is not specified
>>> * don't attempt to drop a stash argument that doesn't look like a s=
tash reference.
>>>
>>>
>>> Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
>>
>> Please wrap very long lines.
>>
>>> diff --git a/git-stash.sh b/git-stash.sh
>>> index 1d95447..432ddae 100755
>>> --- a/git-stash.sh
>>> +++ b/git-stash.sh
>>> @@ -225,6 +225,12 @@ show_stash () {
>>> =C2=A0 =C2=A0 =C2=A0 git diff $flags $b_commit $w_commit
>>> =C2=A0}
>>>
>>> +if_stash_ref() {
>>> + =C2=A0 =C2=A0 ref=3D"$1"
>>> + =C2=A0 =C2=A0 shift
>>> + =C2=A0 =C2=A0 test "${ref#stash}" =3D "${ref}" -a "${ref#$ref_sta=
sh}" =3D "${ref}" || "$@"
>>> +}
>>
>> The interface to this function looks a rather bad taste to me; would=
n't it
>> look more natural if the callers can say:
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if stash_ref $it
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0then
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0do this
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0fi
>>
>> Your criteria used here is that the given parameter does not begin w=
ith
>> "stash" nor "refs/stash". =C2=A0If it begins with either of these tw=
o strings,
>> the "test" fails and "$@" is run. =C2=A0Wouldn't this produce a fals=
e hit if
>> you kept a handcrafted stash-looking commit with a tag "stash-42" or
>> something?
>>
>> It may make more sense to give "stash drop" an option to be silent i=
f
>> the given parameter is not on the list to begin with, perhaps?
>>
>>
>

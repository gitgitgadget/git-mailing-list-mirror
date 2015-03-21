From: Yurii Shevtsov <ungetch@gmail.com>
Subject: Re: [PATCH/RFC][GSoC] diff-no-index: transform "$directory $file"
 args to "$directory/$file $file"
Date: Sat, 21 Mar 2015 21:08:26 +0200
Message-ID: <CAHLaBN+q8T6XJ-aJNu1HsNdnKDrR_5PFeY20vmj8RUDTX8PNew@mail.gmail.com>
References: <CAHLaBN+x3SVL9+jDzeSEMapVd2BVrwQuVx_7ENspjbUPrium_A@mail.gmail.com>
	<xmqqsicyciz2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 21 20:10:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZOlJ-0002rx-UR
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 20:08:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751609AbbCUTI3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2015 15:08:29 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:36412 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571AbbCUTI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2015 15:08:27 -0400
Received: by obdfc2 with SMTP id fc2so98925494obd.3
        for <git@vger.kernel.org>; Sat, 21 Mar 2015 12:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=SZNQzGrmELSfY3BwKBXLEDlzKIEs4EpQqbKqmrLOOYg=;
        b=GSTwoGDVDjYHmcTQRiUpN+VUVWXXUBBR8hVe18fWnvZZMcDOJGjsFpxiBDpj07dsxa
         B2/+RizWzSJw6FxNFWe0GsFUgr9UVOsiNTewFjP5JrUt1aOMPMI9mKNfHjXgj87IM7AU
         BgHlVD/+OF0MUzkhMeMC6nvwCxO8K7MxqRWS7PIOH3N3FuETfrEeFtlBxm+YuqLJV4YB
         iiV38dD0vfS/1VSKNsWCMMm4pB/ni/4K897U/91hdt4rwQItjzHHREU4OP5KmftFGFaM
         S3E+jpS6pNWKSUBhqoJIqPmi8kXr08HU+XEzwcsdaqIfKnYnAt2C2MuCRtuHX2IhGU7N
         6xbA==
X-Received: by 10.202.55.4 with SMTP id e4mr3330998oia.45.1426964907050; Sat,
 21 Mar 2015 12:08:27 -0700 (PDT)
Received: by 10.76.10.170 with HTTP; Sat, 21 Mar 2015 12:08:26 -0700 (PDT)
In-Reply-To: <xmqqsicyciz2.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266032>

>> diff --git a/diff-no-index.c b/diff-no-index.c
>> index 265709b..9a3439a 100644
>> --- a/diff-no-index.c
>> +++ b/diff-no-index.c
>> @@ -97,8 +97,39 @@ static int queue_diff(struct diff_options *o,
>>      if (get_mode(name1, &mode1) || get_mode(name2, &mode2))
>>          return -1;
>>
>> -    if (mode1 && mode2 && S_ISDIR(mode1) != S_ISDIR(mode2))
>> -        return error("file/directory conflict: %s, %s", name1, name2);
>> +    if (mode1 && mode2 && S_ISDIR(mode1) != S_ISDIR(mode2)) {
>> +        struct strbuf path;
>> +        const char *dir, *file;
>> +        char *filename, *dirname = 0;
>> +        int i, ret = 0;
>
> If you have two directories, a and b, under which there are two
> files a/sub/file and b/sub (i.e. 'sub' in a/ is a directory and b/
> is a file), and if you say "git diff --no-index a b", what happens?
>
>  - the caller of this function gives a and b in name1 and name2;
>
>  - we do not come in this codepath as both are directories;
>
>  - we read from a/ and b/ and fill p1 and p2 with names of paths in
>    the directories -- p1 and p2 will both have 'sub';
>
>  - queue_diff() is recursively called to compare a/sub and b/sub;
>
>    - now we have name1 = a/sub and name2 = b/sub;
>
>    - we come in this codepath, and they are turned into comparison
>      between a/sub/sub and b/sub.
>
> The last step is simply crazy.

It won't try to compare a/sub/sub and b/sub, since git diff with this
patch falls before with error message, as I planned (if it did compare
I would get 'Couldn't access a/sub/sub'). I tested my code! Original
git diff also stops comparing when hits folder and file with same
names. So my patch allows to pass 'D F' args, and doesn't affect other
logic.

> Hmmmm, is vger reinjecting an old message, or you sent an older and
> wrong version of a patch by mistake?  We discussed why doing this in
> queue_diff() is wrong in the thread that has $gmane/265543 in it,
> and I was expecting to see a logic like this in the caller.
>
> Puzzled...

Yes, we discussed it, but, as I mentioned in commit message, I think
my solution much better fits in queue_diff()

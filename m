From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Support pathspec magic :(exclude) and its short form :-
Date: Thu, 21 Nov 2013 09:10:50 +0700
Message-ID: <CACsJy8AeL+EVZme3BPocXDfRqPpqKDA8nCuwx3buiS66L7G4fA@mail.gmail.com>
References: <xmqqsix3z8ie.fsf@gitster.dls.corp.google.com> <1384911691-11664-1-git-send-email-pclouds@gmail.com>
 <xmqqhab663ef.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 21 03:11:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjJk1-0004Ml-Dx
	for gcvg-git-2@plane.gmane.org; Thu, 21 Nov 2013 03:11:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754336Ab3KUCLW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Nov 2013 21:11:22 -0500
Received: from mail-qc0-f174.google.com ([209.85.216.174]:60149 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753698Ab3KUCLV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Nov 2013 21:11:21 -0500
Received: by mail-qc0-f174.google.com with SMTP id r5so2609703qcx.33
        for <git@vger.kernel.org>; Wed, 20 Nov 2013 18:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=PPlwIfoVLaheecQ/ZPjyfa75Dh84SWCp7RhixTQVDxM=;
        b=LNd5GOUnRjqqY8SoJ8i+20jEVSpr426sH5TqVscu7ZWLu1gHRiqm7cq+Exr1+LCJj/
         RefQ3rm4hpeloiRSeD4XuXdrAdCC5CzzB0iXrePJbGay6fXeUr9i4UaMYSwrpnHivJat
         BW4r9TjeN0LL6tX2Yi/1Qkj0PNgd1FQDUlwb55e4VTYdRhI53aLaM98aBGptj+Fh+5my
         TBzbWFCjZzAhxxMgIR2XXjCA+ZmRPO5HMGCGaNH3cps9d2E6SCLe0/LEyHqfne1MAQGI
         Egbvhg6NQCpStVt155YOeTLylumA6g97vCX4mb/B0Xlv3k0ClEAfs5kIWfU9P/NDJCLq
         ZLOA==
X-Received: by 10.224.32.66 with SMTP id b2mr7207145qad.80.1384999880561; Wed,
 20 Nov 2013 18:11:20 -0800 (PST)
Received: by 10.96.134.68 with HTTP; Wed, 20 Nov 2013 18:10:50 -0800 (PST)
In-Reply-To: <xmqqhab663ef.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238108>

On Thu, Nov 21, 2013 at 6:48 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>  We don't have many options that say "negative" in short form.
>>  Either '!', '-' or '~'. '!' is already used for bash history expansion.
>>  ~ looks more like $HOME expansion. Which left me '-'.
>
> I agree with your decision to reject ~, but "!not-this-pattern" is
> very much consistent with the patterns used in .gitignore (and the
> "--exclude <pattern>" option), so avoiding "!" and introducing an
> inconsistent "-" only to appease bash leaves somewhat a funny taste
> in my mouth.

The thing about '!'  is it's history expansion in bash and I suspect
not many people are aware of it. So "git log -- :!something" may
recall the last command that has "something" in it, which is confusing
for those new people and may potentially be dangerous (multiple
command in one line, separated by semicolon). Compared to ":git log --
(exclude)somethign" the worst that could happen is a syntax error
message from bash.

Other than that I'm fine with '!' being the shortcut.

Btw I'm thinking of extending pathspec magic syntax a bit to allow
path completion. Right now the user has to write

git log -- :-Documentation

which does not play well with path completion. I'm thinking of accepting

git log -- :- Documentation

In other words, if there's no path (or pattern) component after the
magic, then the next argument must contain the path. This enables path
completion and I haven't seen any drawbacks yet..

>> @@ -427,6 +430,10 @@ void parse_pathspec(struct pathspec *pathspec,
>>               pathspec->magic |= item[i].magic;
>>       }
>>
>> +     if (nr_exclude == n)
>> +             die(_("There is nothing to exclude from by :(exclude) patterns.\n"
>> +                   "Perhaps you forgot to add either ':/' or '.' ?"));
>
> ;-).

Hey it was originally not there, then I made a mistake of typing "git
log -- :-po" and wondered why it shows nothing. Intuitively, if "git
log" shows every path, then "git log -- :-po" should show every path
except 'po' and the user should not be required to type "git log -- :/
:-po". parse_pathspec() can do that, but it's more work and I'm lazy
so I push that back to the user until they scream :)

>> +enum interesting tree_entry_interesting(const struct name_entry *entry,
>> +                                     struct strbuf *base, int base_offset,
>> +                                     const struct pathspec *ps)
>> +{
>> +     enum interesting positive, negative;
>> +     positive = tree_entry_interesting_1(entry, base, base_offset, ps, 0);
>> +
>> +     /*
>> +      *   #  | positive | negative | result
>> +      * -----+----------+----------+-------
>> +      * 1..4 |   -1     |    *     |  -1
>> +      * 5..8 |    0     |    *     |   0
>> +      *   9  |    1     |   -1     |   1
>> +      *  10  |    1     |    0     |   1
>> +      *  11  |    1     |    1     |   0
>> +      *  12  |    1     |    2     |   0
>> +      *  13  |    2     |   -1     |   2
>> +      *  14  |    2     |    0     |   2
>> +      *  15  |    2     |    1     |   0
>> +      *  16  |    2     |    2     |  -1
>> +      */
>
> Not sure what this case-table means...

Sorry, because tree_entry_interesting_1() returns more than "match or
not", we need to combine the result from positive pathspec with the
negative one to correctly handle all_not_interesting and
all_interesting. This table sums it up. I'll add more explanation in
the next patch.
-- 
Duy

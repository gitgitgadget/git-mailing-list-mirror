From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 1/2] version-gen: cleanup
Date: Fri, 13 Sep 2013 07:16:56 -0500
Message-ID: <CAMP44s23dDGK3ymMNR6u7BNR3uD5E_aE14att5AyBeSv-UKpqg@mail.gmail.com>
References: <1379035046-6688-1-git-send-email-felipe.contreras@gmail.com>
	<1379035046-6688-2-git-send-email-felipe.contreras@gmail.com>
	<xmqqy571j7t6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 13 14:17:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKSJ4-0007SY-Bh
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 14:17:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754365Ab3IMMQ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 08:16:58 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:33740 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805Ab3IMMQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Sep 2013 08:16:57 -0400
Received: by mail-lb0-f169.google.com with SMTP id z5so1975759lbh.14
        for <git@vger.kernel.org>; Fri, 13 Sep 2013 05:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=s2EvYrXgeMHC6baZr4i1GMDpZOXbypusEVP9+Aa1Bvk=;
        b=THrCAVzJBs0EUkZAoUOrGb8jeeF+MOLRYn3Oq3LWwcnlpmDhkRjWU3xkX0rdaoB4/K
         A/fOYwqB/qR2kjV9dVtumm+oZyHrUtlQ+/jMIdAtnC/827xd0psZcfOZ0wVuJ5PCNnOn
         CEx7fbUEZq63IvqeMtCGfJkr5+n2tVH8zfjsqhRXOTj5SlT2nezAJ6JsF7VvIRmhF5ln
         z7PkQoNgOMN/JvhQFwRu5w0R1KNSL4BmLH6vfKtpASPVZ0Mck1VF41IO4ZhjwO22+1V7
         1vXAF2D5BZwPzUG+LErtYPdhQbV5BeHkwYLUqtzmFdhwGyo6FUZYN4wAa5p98+IV94j9
         36cg==
X-Received: by 10.112.168.170 with SMTP id zx10mr11657669lbb.0.1379074616436;
 Fri, 13 Sep 2013 05:16:56 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Fri, 13 Sep 2013 05:16:56 -0700 (PDT)
In-Reply-To: <xmqqy571j7t6.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234749>

On Fri, Sep 13, 2013 at 1:10 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> +describe () {
>> +     VN=$(git describe --match "v[0-9]*" --abbrev=7 HEAD 2>/dev/null) || return 1
>>       case "$VN" in
>> +     *$LF*)
>> +             return 1
>> +             ;;
>>       v[0-9]*)
>>               git update-index -q --refresh
>>               test -z "$(git diff-index --name-only HEAD --)" ||
>> +             VN="$VN-dirty"
>> +             return 0
>> +             ;;
>>       esac
>> +}
>> +
>> +# First see if there is a version file (included in release tarballs),
>> +# then try 'git describe', then default.
>> +if test -f version
>> +then
>> +     VN=$(cat version) || VN="$DEF_VER"
>> +elif test -d ${GIT_DIR:-.git} -o -f .git && describe
>>  then
>
> Makes sense; using a helper function makes the primary logic easier
> to read.
>
>> -test "$VN" = "$VC" || {
>> -     echo >&2 "GIT_VERSION = $VN"
>> -     echo "GIT_VERSION = $VN" >$GVF
>> -}
>> -
>> -
>> +test "$VN" = "$VC" && exit
>> +echo >&2 "GIT_VERSION = $VN"
>> +echo "GIT_VERSION = $VN" >$GVF
>
> The point of this part is "if the version file is already up to
> date, do not rewrite it only to smudge the mtime to confuse make",
> so it would be much easier to read to write it like so:
>
>         if test "$VN" != "$VC"
>         then
>                 ... two echoes ...
>         fi
>
> compared to "exiting in the middle" which is harder to follow,
> especially if we consider that we may have to grow the remaining two
> lines in the future.

No, it's much easier to follow, the code clearly says "if the version
is up to date, there's nothing else to do".

-- 
Felipe Contreras

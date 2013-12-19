From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git add -A fails in empty repository since 1.8.5
Date: Thu, 19 Dec 2013 07:49:57 +0700
Message-ID: <CACsJy8BYDYUvpNwR4iSg+hiJGyZF2u75-y9XHg_qwJ4Xrxa+DA@mail.gmail.com>
References: <CAEcj5uWHpem+5os+3Mc_a42pk6f30i4UiV=LRPdXkoqiy1jQ_w@mail.gmail.com>
 <CALWbr2wXxSU4qD_Gj5P7aYxB39tEVBa-TDALVepuwZLh+RNU1Q@mail.gmail.com>
 <CACsJy8DY7eZm7-P=azJF-jEiBKM_QPf_GXG3uzbuw5C1vq1Q5A@mail.gmail.com> <xmqqhaa5ho7x.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 19 01:50:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtRov-0001p3-Gl
	for gcvg-git-2@plane.gmane.org; Thu, 19 Dec 2013 01:50:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752391Ab3LSAu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 19:50:29 -0500
Received: from mail-qc0-f172.google.com ([209.85.216.172]:36732 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140Ab3LSAu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 19:50:28 -0500
Received: by mail-qc0-f172.google.com with SMTP id e16so381815qcx.3
        for <git@vger.kernel.org>; Wed, 18 Dec 2013 16:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=q6xfNvHL8TW+CFsChGqAZihipXw34YMeJ1irCzL/lLc=;
        b=bi+go9nXBDcUn6YAb221gBfDf2SLqk1bkoKaLSlDMCCbbZ4eHXIj7JFVr9R2i3/zjn
         ZsCsUfjy8CGX8tV+vI1gbD+FuKiJsOBBfJYxkhhqKnUGLeyJ/11iHt3KSFImMLcs6V9V
         tihE444iIk/hEVN2ZGYqkpwpPBaRy/jNI5RTkoukC5NvtQQSu1DSi04UPn10vvsxo16u
         fwap0vGL+L1F3WnsTjlG+glbNcjT0hFRq2jA0ajDy71efvvdJZ+4ox3JOZd6CsIth7hn
         OSyRrdJzMAxdopIwi6aOMDnjdpNk/6h3G+rUryWmfXtCTycmR2G2u5BIW2YioOSlcHi1
         Xg0g==
X-Received: by 10.49.12.102 with SMTP id x6mr59302786qeb.5.1387414227755; Wed,
 18 Dec 2013 16:50:27 -0800 (PST)
Received: by 10.96.124.101 with HTTP; Wed, 18 Dec 2013 16:49:57 -0800 (PST)
In-Reply-To: <xmqqhaa5ho7x.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239509>

On Thu, Dec 19, 2013 at 3:57 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Wed, Dec 18, 2013 at 3:44 PM, Antoine Pelisse <apelisse@gmail.com> wrote:
>>> FWIW, git-bisect points to 84b8b5d (that is $gmane/230349).
>>>
>>> On Wed, Dec 18, 2013 at 9:06 AM, Thomas Ferris Nicolaisen
>>> <tfnico@gmail.com> wrote:
>>>> This was discussed on the Git user list recently [1].
>>>>
>>>> #in a repo with no files
>>>>> git add -A
>>>> fatal: pathspec '.' did not match any files
>>>>
>>>> The same goes for git add . (and -u).
>>>>
>>>> Whereas I think some warning feedback is useful, we are curious
>>>> whether this is an intentional change or not.
>>
>> I was not aware of this case when I made the change. It's caused by
>> this change that removes pathspec.raw[i][0] check in builtin/add.c in
>> 84b8b5d .
>>
>> -               for (i = 0; pathspec.raw[i]; i++) {
>> -                       if (!seen[i] && pathspec.raw[i][0]
>> -                           && !file_exists(pathspec.raw[i])) {
>> +               for (i = 0; i < pathspec.nr; i++) {
>> +                       const char *path = pathspec.items[i].match;
>> +                       if (!seen[i] && !file_exists(path)) {
>
> Isn't that pathspec.raw[i][0] check merely an attempt to work around
> the combination of
>
>  (1) "the current directory" pathspec "." is sanitized down to an
>      empty string by the pathspec code; and
>
>  (2) even though file_exists() is willing to say "yes" to a non-file
>      (namely, a directory), it is not prepared to take an empty
>      string resulting from (1) to mean "the directory .".

Yeah, and it was added so intentionally in 07d7bed (add: don't
complain when adding empty project root - 2009-04-28). So this is a
regression.

>> Adding it back requires some thinking because "path" in the new code
>> could be something magic..
>
> Ehh, why?  Shouldn't "something magic" that did _not_ match
> (i.e. not in seen[]) diagnosed as such?
>
> I am wondering why we even need !file_exists(path) check there in
> the first place.  We run fill_directory() and then let
> prune_directory() report which pathspec did not have any match via
> the seen[] array.  We also match pathspec against the index to see
> if there are pathspec that does not match anything.  So at that
> point of the codeflow, we ought to be able to make sure that seen[]
> is the _only_ thing we need to consult to see if there are any
> pathspec elements that did not match.

See e96980e (builtin-add: simplify (and increase accuracy of) exclude
handling - 2007-06-12). It has something to do with directory check
originally, then we don't care about S_ISDIR() any more and turn it to
file_exists(). Maybe it's safe to remove it now. Need to check
fill_directory() again..

> Stepping back even further, I wonder if this "yes, I found a
> matching entity and know this is not an end-user typo" bit actually
> should be _in_ "struct pathspec".  Traditionally we implemented that
> bit as a separate seen[] array parallel to "const char **pathspec"
> array, but that was merely because we only had the list of strings.
> Now we express a pathspec as a list of "struct pathspec" elements,
> I think seen[] can and should become part of the pathspec.  Am I
> missing something?

Yes it probably better belongs to struct pathspec. Turning it into 1
flag would simplify seen[] memory management too.

>
>
>> and the new behavior makes sense, so I'm
>> inclined to keep it as is, unless people have other opinions.
>>
>>>>
>>>> [1] https://groups.google.com/d/topic/git-users/Qs4YSPhTsqE/discussion
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe git" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Duy

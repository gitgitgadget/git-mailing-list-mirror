From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 6/6] exclude: filter patterns by directory level
Date: Sun, 10 Mar 2013 18:14:25 +0700
Message-ID: <CACsJy8Bufcoe1ERMSx3uwUrQD88-kUPMHs5Oe_KMY7942eqMYg@mail.gmail.com>
References: <1362802190-7331-1-git-send-email-pclouds@gmail.com>
 <1362896070-17456-1-git-send-email-pclouds@gmail.com> <1362896070-17456-7-git-send-email-pclouds@gmail.com>
 <7vtxojd5u7.fsf@alter.siamese.dyndns.org> <7vmwubcyii.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 10 12:15:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEeE5-0004PH-8r
	for gcvg-git-2@plane.gmane.org; Sun, 10 Mar 2013 12:15:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576Ab3CJLO4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Mar 2013 07:14:56 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:37695 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751253Ab3CJLO4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Mar 2013 07:14:56 -0400
Received: by mail-ob0-f180.google.com with SMTP id ef5so2449361obb.25
        for <git@vger.kernel.org>; Sun, 10 Mar 2013 04:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=ow54MFL9YM61PTnylBJnIc+bjv321h2ttYhGkEjyPM0=;
        b=NJVdYIH7IHrnSDHRDD14qMesg2Mtew6a+OdCNnU54/VMipXaGtCG0yok+GnmQo3ncP
         mNt+MLazfYq+U7QO210qGXUzcTFIuQcazkqZ1uoMb06YKiOeUTEFDg63bOsNiIF8eRZq
         BrLQovZs3BKHqh7IQGnpSYXbAPaxEHLcz033xXQgWISAq8xrHzL98wqcKvPJY/xSYT/j
         CwGzcmv9Hs/adrTolrfur6oZ1nk3oUL1Jq6d/urRrJXm3zROjElfLgjn5KgHo89PubeY
         eGsEX18t1m1P1LCPZuNqHiNDhpCV1hGndTc8LTUchkc4bjOxkgXfNlS5JwxUPfsJe5cb
         uz8Q==
X-Received: by 10.60.171.230 with SMTP id ax6mr6075842oec.25.1362914095440;
 Sun, 10 Mar 2013 04:14:55 -0700 (PDT)
Received: by 10.76.27.200 with HTTP; Sun, 10 Mar 2013 04:14:25 -0700 (PDT)
In-Reply-To: <7vmwubcyii.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217799>

On Sun, Mar 10, 2013 at 5:58 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> write=
s:
>>
>>> A non-basename pattern that does not contain /**/ can't match anyth=
ing
>>> outside the attached directory. Record its directory level and avoi=
d
>>> matching unless the pathname is also at the same directory level.
>>
>> Without defining what a "directory level" is, the above is a bit
>> hard to grok, but I think you mean an entry "b/c/*.c" that appears
>> in "a/.gitignore" file will want to match a path that is directly
>> in "a/b/c" directory (and not in its subdirectories),
>> "a/b/x.c" at the two levels deep subdirectory or "a/b/c/d/x.c" that =
is
>> four levels deep will never match the pattern.
>>
>> The logic feels sound.
>
> Actually, I think you may be able to do a lot more with a simpler
> change.  If your top-level .gitignore has "a/b/c/*.c" in it, you
> certainly want to mark it not to be applied when you are looking at
> paths directly in directory a/b/ because they will never match, but
> you also know that nothing will match when you are inside a/b/d/,
> even though the pattern and the path you are checking are at the
> same levels.  Your dirlen approach will fail for that case, no?
>
> The idea behind prep_exclude() that organizes the exclode patterns
> into a stack structure and update the groups near the leaves by
> popping those for the old directory we were in and pushing those for
> the new directory we are going into is to give us a place to tweak
> the elements on the whole stack for optimization when we notice that
> we are looking at paths in different directories.  Instead of giving
> a "dirlen" member to each element, you could give a "do not look at
> me" flag to it, and when you notice that you were in a/b/c/ and now
> you are going to look at paths in a/b/d/, you can look at the group
> that was read from the .gitignore from the top-level, and mark
> entries that cannot be relevant (e.g. "a/b/c/*.c") as such.
>
> The mark does not have to be a boolean.  "a/b/*.c" when you are in
> "a/b/c/" can be marked as "This never matches, and I do not have to
> re-check until I pop one level".  When digging deeper to "a/b/c/d",
> you add one to that.  When switching to "a/b/e", you would first pop
> twice ("d" and then "c"), each time decrementing the "I do not have
> to re-check" counter by one, and then when pushing "e" down, you
> notice that you need to re-check, and mark it again as "no need to
> re-check for one pop".  So it is not like you have to re-scan all
> entries textually every time you switch directories. Most entries
> that are level-limited you would increment or decrement its counter
> and only the ones at the level boundary need to be re-checked.

A bit confused by "dirlen" (what is it?). I think what you're trying
to say is "mark whether a pattern is applicable for entries in this
directory in prep_exclude, update the marks as we push and pop
directories". It does not sound simpler (and it's actually more
powerful, as you said it could avoid checking "a/b/c/*.c" when
standing in a/b/d). I'll give it a try.
--=20
Duy

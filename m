From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v1 22/45] archive: convert to use parse_pathspec
Date: Sat, 16 Mar 2013 08:08:29 +0700
Message-ID: <CACsJy8DUb5j0of=cuQje5cRWLwyi-MiH-d-RsyBiPOjaD1Tntg@mail.gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
 <1363327620-29017-23-git-send-email-pclouds@gmail.com> <7vfvzwv96b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 16 02:09:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGfcv-0001kJ-3U
	for gcvg-git-2@plane.gmane.org; Sat, 16 Mar 2013 02:09:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138Ab3CPBJB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 21:09:01 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:34892 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932096Ab3CPBI7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Mar 2013 21:08:59 -0400
Received: by mail-ob0-f173.google.com with SMTP id dn14so3878923obc.18
        for <git@vger.kernel.org>; Fri, 15 Mar 2013 18:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=cBLoJwRvdUEsIUKNC/Vc4bDKgTq9uBaHmqjm1N9kt44=;
        b=ipv55/EH7D+sNxVsj+M0cd++mimAgFgZc3rulvtfgixcvEOSTgzSxlgZTfOi5Wp/W7
         Iiy0MO/yOE1n5d7TMUcf7ASXqMWdwBJ3NtfmrCoTo5rg5ZrAapU+YuW9zknOcrmdjSAL
         BdRhe5+wff7UOtMpW/2eBR5BIN8ozNUfoc3AQfqe86m6C5P2wOCpLmiYTiopabkAUNOv
         OQoQMuD44GUHM8hboc5gNY4RLYZXLiK3r9+aGZGRz3AfFNBaN5TGaVaJD6EJfoakOlR+
         umrgNyc36iRZ4hIZIj7YeQ1gaVANPvxCiRJ2Uet5HauZ/fChFFvVYKjFk1Fr/FH4Gu0U
         JrGQ==
X-Received: by 10.182.72.5 with SMTP id z5mr3906103obu.24.1363396139080; Fri,
 15 Mar 2013 18:08:59 -0700 (PDT)
Received: by 10.76.27.200 with HTTP; Fri, 15 Mar 2013 18:08:29 -0700 (PDT)
In-Reply-To: <7vfvzwv96b.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218268>

On Sat, Mar 16, 2013 at 12:56 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> @@ -232,11 +228,18 @@ static int path_exists(struct tree *tree, cons=
t char *path)
>>  static void parse_pathspec_arg(const char **pathspec,
>>               struct archiver_args *ar_args)
>>  {
>> -     ar_args->pathspec =3D pathspec =3D get_pathspec("", pathspec);
>> +     /*
>> +      * must be consistent with parse_pathspec in path_exists()
>> +      * Also if pathspec patterns are dependent, we're in big
>> +      * trouble as we test each one separately
>> +      */
>> +     parse_pathspec(&ar_args->pathspec, 0,
>> +                    PATHSPEC_PREFER_FULL,
>> +                    "", pathspec);
>>       if (pathspec) {
>>               while (*pathspec) {
>>                       if (!path_exists(ar_args->tree, *pathspec))
>> -                             die("path not found: %s", *pathspec);
>> +                             die(_("pathspec '%s' did not match any=
 files"), *pathspec);
>>                       pathspec++;
>>               }
>
> You do not use ar_args->pathspec even though you used parse_pathspec(=
)
> to grok it?  What's the point of this change?

parse_pathspec() here is needed because write_archive_entries needs it
later. tree_entry_interesting() has not supported "seen" feature like
match_pathspec_depth() to detect unused pathspecs. For simplicity,
just check each pathspec individually. We can revisit this when we add
"seen" feature to tree_entry_interesting.
--=20
Duy

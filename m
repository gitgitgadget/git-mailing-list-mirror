From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 01/24] dir.c: optionally compute sha-1 of a .gitignore file
Date: Mon, 16 Feb 2015 16:45:58 +0700
Message-ID: <CACsJy8AyAeNa0CoUA-jAYGN5S8yJ1wRzdZe==z-xbT-f2j0HaQ@mail.gmail.com>
References: <1423385748-19825-1-git-send-email-pclouds@gmail.com>
 <1423385748-19825-2-git-send-email-pclouds@gmail.com> <xmqqiof8ta6f.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 10:46:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNIGA-0005FC-HQ
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 10:46:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755077AbbBPJq3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Feb 2015 04:46:29 -0500
Received: from mail-ie0-f173.google.com ([209.85.223.173]:40050 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752377AbbBPJq3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Feb 2015 04:46:29 -0500
Received: by iebtr6 with SMTP id tr6so22176826ieb.7
        for <git@vger.kernel.org>; Mon, 16 Feb 2015 01:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=bSltNDQIIFEgm4YfcRk29uUbH63BYJ3nuo/oZNpEAuc=;
        b=rlQyRPZxXox5R/1FsYYsZacGlQ1hx51GSNqp2PA+vkto5kkmPQIiGHsqmhiFCPDExA
         FZNGIFQLr4qWwN+BaZSpKgKIhRCiqBnScblISLBqZDUwF3V/oivQiQhAc+2W9Fltae9n
         7qqpeekWG7n4tLOC6Xs2xmSfbpHCECuLaVs9uIQ24kX/edwkrbGBbomgQJ84KMWVS12e
         TsoXYMSQcZ1p2R3dKWKPzBydhU3WivZB1FpKa3ma189IB6/IjIRirA13B+X1MxH/P6b5
         5krLyvaa83/DEJ91RL80KyEB8Ca7LR/KcDdTYcLcmAP90T9g2T07HYleags3Fzg0a6tf
         iKAg==
X-Received: by 10.107.137.226 with SMTP id t95mr25668809ioi.10.1424079988391;
 Mon, 16 Feb 2015 01:46:28 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Mon, 16 Feb 2015 01:45:58 -0800 (PST)
In-Reply-To: <xmqqiof8ta6f.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263889>

On Thu, Feb 12, 2015 at 4:23 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> -int add_excludes_from_file_to_list(const char *fname,
>> -                                const char *base,
>> -                                int baselen,
>> -                                struct exclude_list *el,
>> -                                int check_index)
>> +/*
>> + * Given a file with name "fname", read it (either from disk, or fr=
om
>> + * the index if "check_index" is non-zero), parse it and store the
>> + * exclude rules in "el".
>> + *
>> + * If "ss" is not NULL, compute SHA-1 of the exclude file and fill
>> + * stat data from disk (only valid if add_excludes returns zero). I=
f
>> + * ss_valid is non-zero, "ss" must contain good value as input.
>> + */
>> +static int add_excludes(const char *fname, const char *base, int ba=
selen,
>> +                     struct exclude_list *el, int check_index,
>> +                     struct sha1_stat *sha1_stat)
>> ...
>> @@ -571,6 +588,21 @@ int add_excludes_from_file_to_list(const char *=
fname,
>>               }
>>               buf[size++] =3D '\n';
>>               close(fd);
>> +             if (sha1_stat) {
>> +                     int pos;
>> +                     if (sha1_stat->valid &&
>> +                         !match_stat_data(&sha1_stat->stat, &st))
>> +                             ; /* no content change, ss->sha1 still=
 good */
>> +                     else if (check_index &&
>> +                              (pos =3D cache_name_pos(fname, strlen=
(fname))) >=3D 0 &&
>> +                              !ce_stage(active_cache[pos]) &&
>> +                              ce_uptodate(active_cache[pos]))
>> +                             hashcpy(sha1_stat->sha1, active_cache[=
pos]->sha1);
>> +                     else
>> +                             hash_sha1_file(buf, size, "blob", sha1=
_stat->sha1);
>
> I do not think this would work well on DOS.
>
> This helper function originally is meant to work *only* on the
> checked out representation of the file and that is what is read by
> read_in_full(), and that is the reason why it handles the case where
> the contents of buf[] happens to be CRLF terminated in the function.
>
> If you want to detect the content changes across working tree, index
> and the tree objects by reusing hash_sha1_file(), however, you must
> not feed the checked out (aka "smudged") representation to it.
> You'd need to turn it into "cleaned" representation by doing the
> equivalent of calling index_path().  Some helpers in the callchain
> that originates from index_path() might directly be reusable for
> your purpose.

Urgh.. you're right this test would fail when some filters are
involved. I'm not sure if we want to check the cleaned version though.
What matters to exclude machinery is the checkout version. I think for
now we fall back to hashing .gitignore content. Perhaps later we could
make an exception for cr/lf conversion (and just that, not generic
filters, doing content conversion here sounds like a bad idea).
--=20
Duy

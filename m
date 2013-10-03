From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] add: add --bulk to index all objects into a pack file
Date: Thu, 3 Oct 2013 19:26:35 +0700
Message-ID: <CACsJy8AYAaXosV_T-JF8HvObVun_=q0UXPB8e8peHDxyvFG+RA@mail.gmail.com>
References: <1380772811-15415-1-git-send-email-pclouds@gmail.com> <xmqqsiwin9b2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 03 14:27:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VRhzt-0006LI-M2
	for gcvg-git-2@plane.gmane.org; Thu, 03 Oct 2013 14:27:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753882Ab3JCM1J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Oct 2013 08:27:09 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:54508 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753615Ab3JCM1H convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Oct 2013 08:27:07 -0400
Received: by mail-oa0-f54.google.com with SMTP id n5so2282494oag.27
        for <git@vger.kernel.org>; Thu, 03 Oct 2013 05:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=+gNfTIoU0eMCeHHs5oxn34jtBGFCddei1MMFOSVTZtc=;
        b=quCT973OEvHB9BEWPkGHRtaZDLNBJZSwQizLcwSktv9PA4i30P4qRgrYs2Jj9t7s4I
         flEH+2jFmcJJxd/hH4RIZVkQS84qMe1f94rwpb7bC1OqzP5jcWWKlLX0rFXwkXSIiJwJ
         TIIdZ3zYgxpM2pLxajwEKiTgzvzyL7Ndogm4rwY2bLzAp8nfBYzRd3ESFTh47lKFcE1c
         2oyYaCcd3kpZ8wMnLDwVeTdSQbkHRfi4Tf7dWOFrGcSspnWGjPWNoSZm+p8Qi024AmtG
         8eHJcK3yFuVoHqp/JEjTPAA2mmyiMiYjzxn5whAu1ys3FjCdgAqB+HmVO4I4VUhzHvS9
         JA/Q==
X-Received: by 10.60.95.229 with SMTP id dn5mr12222930oeb.26.1380803226094;
 Thu, 03 Oct 2013 05:27:06 -0700 (PDT)
Received: by 10.76.131.130 with HTTP; Thu, 3 Oct 2013 05:26:35 -0700 (PDT)
In-Reply-To: <xmqqsiwin9b2.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235683>

On Thu, Oct 3, 2013 at 1:43 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> The use case is
>>
>>     tar -xzf bigproject.tar.gz
>>     cd bigproject
>>     git init
>>     git add .
>>     # git grep or something
>
> Two obvious thoughts, and a half.
>
>  (1) This particular invocation of "git add" can easily detect that
>      it is run in a repository with no $GIT_INDEX_FILE yet, which is
>      the most typical case for a big initial import.  It could even
>      ask if the current branch is unborn if you wanted to make the
>      heuristic more specific to this use case.  Perhaps it would
>      make sense to automatically plug the bulk import machinery in
>      such a case without an option?

Yeah! I did not even think of that.

>  (2) Imagine performing a dry-run of update_files_in_cache() using a
>      different diff-files callback that is similar to the
>      update_callback() but that uses the lstat(2) data to see how
>      big an import this really is, instead of calling
>      add_file_to_index(), before actually registering the data to
>      the object database.  If you benchmark to see how expensive it
>      is, you may find that such a scheme might be a workable
>      auto-tuning mechanism to trigger this.  Even if it were
>      moderately expensive, when combined with the heuristics above
>      for (1), it might be a worthwhile thing to do only when it is
>      likely to be an initial import.

We do a lot of lstats nowadays for refreshing index so yeah it's
likely reasonably cheap, but I doubt people do mass update on existing
files often. Adding a large amount of new files (even when .git/index
exists) may be a better indication of an import and we already have
that information from fill_directory().

=46or the no .git/index case, packing with bulk-checkin probably
produces a reasonably good pack because they don't delta well anyway.
There are no previous versions to delta against. They can delta
against other files but I don't think we'll have good compression with
that. For the case where .git/index exists, we may intefere with "git
gc --auto". We create a less optimal pack, but it's a pack and may
delay gc time longer..

>  (3) Is it always a good idea to send everything to a packfile on a
>      large addition, or are you often better off importing the
>      initial fileset as loose objects?  If the latter, then the
>      option name "--bulk" may give users a wrong hint "if you are
>      doing a bulk-import, you are bettern off using this option".

Hard question. Fewer files are definitely a good thing, for example
when you "rm -rf" the whole thing :-) Disk usage is another. On
gdb-7.3.1, "du -sh" reports .git with loose objects takes 57M, while
the packed one takes 29M. Disk access is slightly faster on packed
=2Egit, at least for "git grep --cached": 0.71s vs 0.83s.

> This is a very logical extension to what was started at 568508e7
> (bulk-checkin: replace fast-import based implementation,
> 2011-10-28), and I like it.  I suspect "--bulk=3D<threashold>" might
> be a better alternative than setting the threshold unconditionally
> to zero, though.

The threshold may be better in form of a config setting because I
won't want to specify that every time. But does one really want to
keep some small files around in loose format? I don't see it because
my goal is to keep a clean .git, but maybe loose format has some
advantages..
--=20
Duy

From: Dongcan Jiang <dongcan.jiang@gmail.com>
Subject: Re: [PATCH/GSoC/RFC] fetch: git fetch --deepen
Date: Tue, 17 Mar 2015 00:08:06 +0800
Message-ID: <CABwkPcrCBAbGf6ToYTC5TWctvphbQsn3vsxETitgfZicLnijjw@mail.gmail.com>
References: <1426251846-1604-1-git-send-email-dongcan.jiang@gmail.com> <xmqqlhj0xhsl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 17:08:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXXZS-0000wC-Jf
	for gcvg-git-2@plane.gmane.org; Mon, 16 Mar 2015 17:08:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965905AbbCPQIc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Mar 2015 12:08:32 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34025 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965011AbbCPQI1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Mar 2015 12:08:27 -0400
Received: by pacwe9 with SMTP id we9so68808430pac.1
        for <git@vger.kernel.org>; Mon, 16 Mar 2015 09:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=oyLslebAF0PmyBPoRToBjLG0EjPUEZDE+DZbsR1bLYk=;
        b=Ub6Dsg/cLzIXUv80FjhltZydnW0bhYVECSxvXax+DyZ0gpjOrrjdw4d7VNdbRkUDvs
         W6eM7sB3d6Kx47OnPdRjZlH1jlMY9tYqxHAM8GID8+2Ko7litNeYvpfsObsrwnwbmON5
         cldiJuWJh1LzzMnbm9RM3w9iPrtDS08XyxqQtTwl1jOWAZIHLiCA2TBRPDctXKpmD2Y2
         KGOEQB1pX8rtMaLh2N4Kuku7P261lgBBwPTHNOQWpBIJCiMqJJG4mfqF6qeeW+c0446j
         eHD+fZRR174HHRhR47KmWxTqaFzirBM/MVy4GqxsBrjuE9STMoomxpsH8RoV/Xz8rMN3
         T6rw==
X-Received: by 10.70.89.195 with SMTP id bq3mr96894674pdb.138.1426522107141;
 Mon, 16 Mar 2015 09:08:27 -0700 (PDT)
Received: by 10.70.78.225 with HTTP; Mon, 16 Mar 2015 09:08:06 -0700 (PDT)
In-Reply-To: <xmqqlhj0xhsl.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265571>

Hi Junio,

Sorry for my late response.

> As this operation is not about moving _any_ refs, whether local
> branches or remote-tracking branches, any ref that used to point at
> commit B before you executed "fetch --deepen" would point at the
> same commit after the command finishes.

Thanks for clarifying the definition of "you". In this patch, it
actually would update the remote-tracking branches to the newest histor=
y.
I will keep working on it to figure out the reason.

It looks that it would be more efficient if the new history is not fetc=
hed,
as it transports less objects. Is this your main consideration on not
updating any refs?

>> -             if (starts_with(line, "deepen ")) {
>> +             if (starts_with(line, "depth ")) {
>>                       char *end;
>> -                     depth =3D strtol(line + 7, &end, 0);
>> -                     if (end =3D=3D line + 7 || depth <=3D 0)
>> -                             die("Invalid deepen: %s", line);
>> +                     depth =3D strtol(line + 6, &end, 0);
>> +                     if (end =3D=3D line + 6 || depth <=3D 0)
>> +                             die("Invalid depth: %s", line);
>>                       continue;
>>               }
>>               if (!starts_with(line, "want ") ||
>
> I do not quite understand this hunk.  What happens when this program
> is talking to an existing fetch-pack that requested "deepen"?

In this hunk, I actually just changed the one command name in upload-pa=
ck
service from "deepen" to "depth". I made this change because the name
"deepen" here is quite misleading, as it just means "depth". Of course,
I've changed the caller's sent pack from "deepen" to "depth" too (See b=
elow).

> @@ -317,7 +318,7 @@ static int find_common(struct fetch_pack_args *ar=
gs,
>         if (is_repository_shallow())
>                 write_shallow_commits(&req_buf, 1, NULL);
>         if (args->depth > 0)
> -               packet_buf_write(&req_buf, "deepen %d", args->depth);
> +               packet_buf_write(&req_buf, "depth %d", args->depth);
>         packet_buf_flush(&req_buf);
>         state_len =3D req_buf.len;

If the user wants "deepen", he should send a "depth_deepen" signal as w=
ell as
"depth N". When the upload-pack service in this patch receive "depth_de=
epen"
and "depth N", it collects N more commits ahead of the shallow commit a=
nd send
back to the caller.

Thanks,
Dongcan

2015-03-14 13:35 GMT+08:00 Junio C Hamano <gitster@pobox.com>:
> Dongcan Jiang <dongcan.jiang@gmail.com> writes:
>
>> This patch is just for discusstion. An option --deepen is added to
>> 'git fetch'. When it comes to '--deepen', git should fetch N more
>> commits ahead the local shallow commit, where N is indicated by
>> '--depth=3DN'. [1]
>>
>> e.g.
>>
>>>  (upstream)
>>>   ---o---o---o---A---B
>>>
>>>  (you)
>>>                  A---B
>>
>> After excuting "git fetch --depth=3D1 --deepen", (you) get one more
>> tip and it becomes
>>
>>>  (you)
>>>              o---A---B
>>
>> '--deepen' is designed to be a boolean option in this patch, which
>> is a little different from [1]. It's designed in this way, because
>> it can reuse '--depth' in the program, and just costs one more bit
>> in some data structure, such as fetch_pack_args,
>> git_transport_options.
>>
>> Of course, as a patch for discussion, it remains a long way to go
>> before being complete.
>>
>>       1) Documents should be completed.
>>       2) More test cases, expecially corner cases, should be added.
>>       3) No need to get remote refs when it comes to '--deepen' opti=
on.
>>       4) Validity on options combination should be checked.
>>       5) smart-http protocol remains to be supported. [2]
>>
>> Besides, I still have one question:
>> What does (you) exactly mean in [1]? The local branch or the local
>> remote ref?
>
> As this operation is not about moving _any_ refs, whether local
> branches or remote-tracking branches, any ref that used to point at
> commit B before you executed "fetch --deepen" would point at the
> same commit after the command finishes.
>
> The "you" does not explicitly depict any ref, because the picture is
> meant to illustrate _everything_ the repository at the receiving end
> of "fetch" has.  It used to have two commits, A and B (and the tree
> and blob objects necessary to complete these two commits).  After
> deepening the history by one commit, it then will have commit A^ and
> its trees and blobs.
>
>> diff --git a/upload-pack.c b/upload-pack.c
>> index b531a32..8004f2f 100644
>> --- a/upload-pack.c
>> +++ b/upload-pack.c
>> @@ -31,6 +31,7 @@ static const char upload_pack_usage[] =3D "git upl=
oad-pack [--strict] [--timeout=3D<
>>
>>  static unsigned long oldest_have;
>>
>> +static int depth_deepen;
>>  static int multi_ack;
>>  static int no_done;
>>  static int use_thin_pack, use_ofs_delta, use_include_tag;
>> @@ -563,11 +564,11 @@ static void receive_needs(void)
>>                       }
>>                       continue;
>>               }
>> -             if (starts_with(line, "deepen ")) {
>> +             if (starts_with(line, "depth ")) {
>>                       char *end;
>> -                     depth =3D strtol(line + 7, &end, 0);
>> -                     if (end =3D=3D line + 7 || depth <=3D 0)
>> -                             die("Invalid deepen: %s", line);
>> +                     depth =3D strtol(line + 6, &end, 0);
>> +                     if (end =3D=3D line + 6 || depth <=3D 0)
>> +                             die("Invalid depth: %s", line);
>>                       continue;
>>               }
>>               if (!starts_with(line, "want ") ||
>
> I do not quite understand this hunk.  What happens when this program
> is talking to an existing fetch-pack that requested "deepen"?
>
>> @@ -577,6 +578,8 @@ static void receive_needs(void)
>>
>>               features =3D line + 45;
>>
>> +             if (parse_feature_request(features, "depth_deepen"))
>> +                     depth_deepen =3D 1;
>>               if (parse_feature_request(features, "multi_ack_detaile=
d"))
>>                       multi_ack =3D 2;
>>               else if (parse_feature_request(features, "multi_ack"))
>> @@ -631,6 +634,10 @@ static void receive_needs(void)
>>                               struct object *object =3D shallows.obj=
ects[i].item;
>>                               object->flags |=3D NOT_SHALLOW;
>>                       }
>> +             else if (depth_deepen)
>> +                     backup =3D result =3D
>> +                             get_shallow_commits(&shallows, depth +=
 1,
>> +                                                 SHALLOW, NOT_SHALL=
OW);
>>               else
>>                       backup =3D result =3D
>>                               get_shallow_commits(&want_obj, depth,
>> --
>> 2.3.1.253.gb3fd89e



--=20
=E6=B1=9F=E4=B8=9C=E7=81=BF=EF=BC=88Dongcan Jiang=EF=BC=89
Team of Search Engine & Web Mining
School of Electronic Engineering & Computer Science
Peking University, Beijing, 100871, P.R.China

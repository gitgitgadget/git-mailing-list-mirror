From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/7] Fix ignoring of pathspecs with rev-list --objects
Date: Wed, 25 Aug 2010 17:50:39 -0600
Message-ID: <AANLkTimCv-fn-h21pM8L9NiGg3w7OXBJ-kfiC+HJLsTP@mail.gmail.com>
References: <1282704795-29661-1-git-send-email-newren@gmail.com>
	<1282704795-29661-3-git-send-email-newren@gmail.com>
	<AANLkTimguNHXSFyO1EvS+dHbHiXU-dXTNwkWfEsVUbVC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, gitster <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 26 01:50:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoPk6-0002LH-Fl
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 01:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783Ab0HYXum convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Aug 2010 19:50:42 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42988 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551Ab0HYXuk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Aug 2010 19:50:40 -0400
Received: by fxm13 with SMTP id 13so824980fxm.19
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 16:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=I13PCIQLJU+1zYfetIBOSG642W69+5DoUul5VauQB7M=;
        b=yDQQxF5yuKTSC17tXav4D37+32aOL3wEK/VI4fLcQrXIf1udMTupnV88gDOgzs5gc2
         7LYjTnArlnXF83Dgx1y0r/wZkbyK1Jz6CEmYKCjnCLyRBsBhQxitXf8NY4b7+zp9OKBL
         OiiR8fbksNgMa24acv/Yt6ELqzDkmuq9WTomM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wEfAcLAVD3pg7ln/9FA8+G1OcsOKbJKbBchTqpBGAt2DDMpEzB5QjR/j+7n/h2TtHZ
         4Zw2A+e1iSn8R2TlmZqZvtb/vuM7mHK+HQbB1p7wuOFCIDxNSsAtDZoH1UAPVy4/oU6l
         hIJNs+oFup74NACAqcm3uFO4keYjLV4e3WCYs=
Received: by 10.223.108.71 with SMTP id e7mr8554608fap.13.1282780239488; Wed,
 25 Aug 2010 16:50:39 -0700 (PDT)
Received: by 10.223.50.154 with HTTP; Wed, 25 Aug 2010 16:50:39 -0700 (PDT)
In-Reply-To: <AANLkTimguNHXSFyO1EvS+dHbHiXU-dXTNwkWfEsVUbVC@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154495>

On Wed, Aug 25, 2010 at 4:11 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.co=
m> wrote:
> On Wed, Aug 25, 2010 at 12:53 PM, Elijah Newren <newren@gmail.com> wr=
ote:
>> @@ -84,7 +85,24 @@ static void process_tree(struct rev_info *revs,
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0init_tree_desc(&desc, tree->buffer, tree-=
>size);
>>
>> - =C2=A0 =C2=A0 =C2=A0 while (tree_entry(&desc, &entry)) {
>> + =C2=A0 =C2=A0 =C2=A0 for (; desc.size; update_tree_entry(&desc)) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 entry =3D desc.en=
try;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!all_interest=
ing) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 char *full_path =3D path_name(path, name);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 int full_path_len =3D strlen(full_path);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 int showit =3D tree_entry_interesting(&desc,
>> full_path, full_path_len,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &revs->=
diffopt);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 free(full_path);
>
> I wonder if we can avoid xmalloc/free so many times here. If full_pat=
h
> is unchanged, how about moving it outside the loop?

Good point.

>> diff --git a/tree-diff.c b/tree-diff.c
>> index cd659c6..2fb670b 100644
>> --- a/tree-diff.c
>> +++ b/tree-diff.c
>> @@ -91,7 +91,7 @@ static int compare_tree_entry(struct tree_desc *t1=
, struct
>> tree_desc *t2, const
>> =C2=A0* =C2=A0- zero for no
>> =C2=A0* =C2=A0- negative for "no, and no subsequent entries will be =
either"
>> =C2=A0*/
>> -static int tree_entry_interesting(struct tree_desc *desc, const cha=
r *base,
>> int baselen, struct diff_options *opt)
>> +int tree_entry_interesting(struct tree_desc *desc, const char *base=
, int
>> baselen, struct diff_options *opt)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *path;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0const unsigned char *sha1;
>
> While at it, can you please also fix its comments? The comments say
> pathspec while what it uses is actually path prefix. Maybe something
> like this
>
> diff --git a/tree-diff.c b/tree-diff.c
> index 3c34c77..514dbca 100644
> --- a/tree-diff.c
> +++ b/tree-diff.c
> @@ -83,7 +83,7 @@ static int compare_tree_entry(struct tree_desc *t1,
> struct tree_desc *t2, const
> =C2=A0}
>
> =C2=A0/*
> - * Is a tree entry interesting given the pathspec we have?
> + * Is a tree entry interesting given the path prefix we have?

I believe the comment is parsed thus: "tree entry" =3D=3D combination o=
f
desc, base, and baselen.  "pathspec" =3D=3D paths and pathlens fields o=
f
opt (which do provide a pathspec).  So I believe the original was
correct, though I can see how it's confusing at first.

> =C2=A0*
> =C2=A0* Return:
> =C2=A0* =C2=A0- 2 for "yes, and all subsequent entries will be"
>
>
> This patch is good stuff. Please be informed I will steal this patch
> for my narrow use.

Thanks, but I just found a bug with it; I'm investigating.

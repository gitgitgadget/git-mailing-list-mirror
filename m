From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH RFC] parse_object: pass on the original sha1, not the
 replaced one
Date: Fri, 13 Aug 2010 19:02:40 +1000
Message-ID: <AANLkTinmJ0=VxFAaCXNjB2WAiPYHq3jXmRnzVoEiw_-f@mail.gmail.com>
References: <1280579802-8606-1-git-send-email-pclouds@gmail.com>
	<201008051341.08632.chriscool@tuxfamily.org>
	<AANLkTim9vMiEuBJJdCdGqjTOz8cs-nH+LyJF-rPGOTvS@mail.gmail.com>
	<201008130559.33640.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Aug 13 11:03:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjqAF-00015Q-5Z
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 11:02:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761378Ab0HMJCm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Aug 2010 05:02:42 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40662 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755902Ab0HMJCl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Aug 2010 05:02:41 -0400
Received: by wyb32 with SMTP id 32so2385121wyb.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 02:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=HGQ76cL0GMxlsi14OPn31Weoi1dyO21yZQyNSoFmTMs=;
        b=U/Ok1DeYGyVGGBtC59Te02PstZS9BVSRwQEntrHx+tHTBbUobRd1TH8lnoa/lL0fgQ
         WN0Sq4UtYrsKW+bQW1omgA8zIdT+1gjLYlrzLcrWC7CSqkgScjpFLA+i6NNCZ+21lFK3
         As+K7N0RwppBxEgKQ3Nc+1/LVlZW7BcB1Uixs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=E5EXuvxhPa/dTonm5AwX8zjjUb2a3ao/TDjD9AVVVMShyYDodTyzjYpcImw27BzxTy
         d6EIvPyew+3m2kjAFIbNB+gSEpi6ahHu8XiG2ahGI3bUTNMXd/PTrn391ODlL/CjMQc7
         Ui4i5otKwP/As2kBmw0FDppzUibKWKCnBA3ro=
Received: by 10.216.10.11 with SMTP id 11mr7794167weu.64.1281690160238; Fri,
 13 Aug 2010 02:02:40 -0700 (PDT)
Received: by 10.216.173.133 with HTTP; Fri, 13 Aug 2010 02:02:40 -0700 (PDT)
In-Reply-To: <201008130559.33640.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153466>

On Fri, Aug 13, 2010 at 1:59 PM, Christian Couder
<chriscool@tuxfamily.org> wrote:
> On Saturday 07 August 2010 06:03:05 Nguyen Thai Ngoc Duy wrote:
>> On Thu, Aug 5, 2010 at 9:41 PM, Christian Couder
>>
>> <chriscool@tuxfamily.org> wrote:
>> > It looks like parse_commit() is buggy regarding replaced objects. =
But I
>> > am not sure how it should be fixed.
>>
>> It could be fixed the same way you did with parse_object(): replace
>> read_sha1_file() with read_sha1_file_repl(). You would also need to
>> fix parse_tree() and parse_tag(). But..
>>
>> > Anyway if you use parse_object(), then you don't need parse_commit=
(). So
>> > if possible you should use parse_object() instead of both
>> > lookup_commit() and parse_commit().
>>
>> That's how those functions are used. For example, in
>> traverse_commit_list(), lookup_*() may be called and uninteresting
>> objects marked UNINTERESTING. Later on in process_{tree,blob,tag},
>> parse_* may be called if their content is interesting.
>>
>> To me, the fix above will leave a gap when object->sha1 is the
>> original sha1, until parse_*() is called. It just does not sound goo=
d.
>
> What do you think about adding a parse_commit_repl() function like th=
e patch
> below and then using it instead of parse_commit()?

How do you plan to use this new function? #define parse_commit(c)
parse_commit_repl(c) or use the new function explictly when needed?

You are going to need parse_tree_repl() too unless you declare
tree/blob replacement is not supported and make git-replace refuse
blob/tree replacement.

Another thing to address is, there will be a duration between
lookup_commit() and parse_commit_repl(), where object.sha1 is the
original one. If it is saved elsewhere, troubles are ahead.

> ------- >8 ---------------------------------------------------
>
> diff --git a/commit.c b/commit.c
> index 652c1ba..183a735 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -316,6 +316,50 @@ int parse_commit(struct commit *item)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> =C2=A0}
>
> +int parse_commit_repl(struct commit **commit)
> +{
> + =C2=A0 =C2=A0 =C2=A0 enum object_type type;
> + =C2=A0 =C2=A0 =C2=A0 void *buffer;
> + =C2=A0 =C2=A0 =C2=A0 unsigned long size;
> + =C2=A0 =C2=A0 =C2=A0 int ret;
> + =C2=A0 =C2=A0 =C2=A0 const unsigned char *repl;
> + =C2=A0 =C2=A0 =C2=A0 struct commit *item =3D *commit;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!item)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;
> + =C2=A0 =C2=A0 =C2=A0 if (item->object.parsed)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
> + =C2=A0 =C2=A0 =C2=A0 buffer =3D read_sha1_file_repl(item->object.sh=
a1, &type, &size, &repl);
> + =C2=A0 =C2=A0 =C2=A0 if (!buffer)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return error("Coul=
d not read %s",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0sha1_to_hex(item->object.sha1));
> +
> + =C2=A0 =C2=A0 =C2=A0 if (item->object.sha1 !=3D repl) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct commit *rep=
l_item =3D lookup_commit(repl);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!repl_item) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 free(buffer);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 return error("Bad replacement %s for commit %s",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sha1_to_hex(rep=
l),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sha1_to_hex(ite=
m->object.sha1));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }

You need to use lookup_object() instead here. lookup_commit() wil
create new object if "repl" is not found.
--=20
Duy

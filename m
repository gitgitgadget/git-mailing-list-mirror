From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/3] Fix sparse checkout not removing files from index
Date: Fri, 30 Jul 2010 18:24:59 +1000
Message-ID: <AANLkTi=3pX=k=Pf5SnWt8s=hbvwAXcZdmcqP_+kgCyE5@mail.gmail.com>
References: <1280135310-2347-1-git-send-email-pclouds@gmail.com>
	<20100730013534.GB2182@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 30 10:25:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oeku1-0003s2-RC
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 10:25:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755220Ab0G3IZG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Jul 2010 04:25:06 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49118 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755036Ab0G3IZB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jul 2010 04:25:01 -0400
Received: by wwj40 with SMTP id 40so1229888wwj.1
        for <git@vger.kernel.org>; Fri, 30 Jul 2010 01:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ElQ0DyobN1LR8XVayUxYdVtQnwZ+f9boyR3Lm+Kg4PY=;
        b=quwtr1y4VX8YU/XHIZJKQ/kw4aKxSL2fznUdBTQg31S50N6JHRjGTcQn6nwZcQ+UdH
         46/RctxvzbP9AlIhyEAbYjMm+rK8xL5/xDRJg3F74z+f30xoQedRdd+Uj0afBxakLrtA
         yEyVeRwRR5TyXaxKA7AUXJAh7HmkFsTTqBlB0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=t5oKX+GGGk1409IzzfeCoKVWfefDVz94Hnf8zv+vAzq6oKEeECUU+QYBGKd22yHylh
         Cc62MJcCOGdBEm/ImD5P4vALCIYi9WqvRe71NAWL46aZ+DhIMGbxlrQSIhwxhWTzZ5qR
         Z1MRTwT5Q7pIlcDHsWpP9Zf2GYyPLSrcwipew=
Received: by 10.227.37.220 with SMTP id y28mr1395116wbd.79.1280478299994; Fri, 
	30 Jul 2010 01:24:59 -0700 (PDT)
Received: by 10.216.173.199 with HTTP; Fri, 30 Jul 2010 01:24:59 -0700 (PDT)
In-Reply-To: <20100730013534.GB2182@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152223>

2010/7/30 Jonathan Nieder <jrnieder@gmail.com>:
>> +++ b/cache.h
>> @@ -179,8 +179,7 @@ struct cache_entry {
>> =C2=A0#define CE_UNHASHED =C2=A0(0x200000)
>> =C2=A0#define CE_CONFLICTED (0x800000)
>>
>> -/* Only remove in work directory, not index */
>> -#define CE_WT_REMOVE (0x400000)
>> +#define CE_WT_REMOVE (0x400000) /* remove in work directory */
>
> Before[1], CE_REMOVE was used by read-tree et al in core to represent
> something to be removed from the index file and work tree (e.g., when
> switching branches).
>
> In the new order, one uses CE_REMOVE|CE_WT_REMOVE for that, right?

=46or unpack_trees() only, yes. You made me grep for CE_REMOVE and foun=
d
that do_diff_cache() may turn CE_REMOVE on. The function is used by
blame and reset.

Hmm.. It's for removing staged entries. So it's probably fine.

>> +++ b/t/t1011-read-tree-sparse-checkout.sh
>> @@ -147,4 +147,11 @@ test_expect_success 'read-tree adds to worktree=
, dirty case' '
>> =C2=A0 =C2=A0 =C2=A0 grep -q dirty sub/added
>> =C2=A0'
>>
>> +test_expect_success 'read-tree --reset removes outside worktree' '
>> + =C2=A0 =C2=A0 echo init.t > .git/info/sparse-checkout &&
>> + =C2=A0 =C2=A0 git checkout -f top &&
>> + =C2=A0 =C2=A0 git reset --hard removed &&
>> + =C2=A0 =C2=A0 test -z "$(git ls-files sub/added)"
>> +'
>> +
>
> Using reset --hard to remove a file outside the sparse checkout.
> A sane, simple test; thanks. =C2=A0(Nitpick: I would have used
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0>empty &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git ls-files sub/added >output &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_cmp empty output
>
> even though that does not produce any more helpful output in this
> case.)

Thanks. That looks better.

>
>> +++ b/unpack-trees.c
>> @@ -53,6 +53,9 @@ static void add_entry(struct unpack_trees_options =
*o, struct cache_entry *ce,
>>
>> =C2=A0 =C2=A0 =C2=A0 clear |=3D CE_HASHED | CE_UNHASHED;
>>
>> + =C2=A0 =C2=A0 if (set & CE_REMOVE)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set |=3D CE_WT_REMOVE;
>> +
>
> A bridge between the old and new worlds.
>
> I would have added CE_WT_REMOVE to callers instead (they all pass
> constants more or less), but I suppose this way makes the patch
> shorter.

It'd better be done in one place. I don't expect anybody to set
CE_REMOVE without CE_WT_REMOVE any time soon. Adding it the the
callers, the new callers might miss it.

>> @@ -799,10 +796,15 @@ int unpack_trees(unsigned len, struct tree_des=
c *t, struct unpack_trees_options
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 /*
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0* Merge strategies may set CE_UPDATE|CE_REMOVE outside ch=
eckout
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0* area as a result of ce_skip_worktree() shortcuts in
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0* verify_absent() and verify_uptodate(). Clear them.
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0* verify_absent() and verify_uptodate().
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0* Make sure they don't modify worktree.
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0*/
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (ce_skip_worktree(ce))
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ce->ce_flags &=3D ~(CE_UPDATE | CE_REMO=
VE);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (ce_skip_worktree(ce)) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ce->ce_flags &=3D ~CE_UPDATE;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ce->ce_flags & CE_REMOVE)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ce->ce_flag=
s &=3D ~CE_WT_REMOVE;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 }
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 else
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 empty_worktree =3D 0;
>
> Ah, and at last we come to the fix. :)
>
> This is a little tricky: the CE_WT_REMOVE case (without CE_REMOVE)
> represents a narrowing of the checkout and should be preserved,
> while CE_WT_REMOVE|CE_REMOVE represents a removed index entry and
> should be changed to just CE_REMOVE.

Yeah. I did wonder if it's worth a comment to explain. I forget why I
did not add that comment now.
--=20
Duy

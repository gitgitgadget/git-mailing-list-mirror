From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Fix for a merge where a branch has an F->D transition
Date: Thu, 21 May 2009 00:09:57 +0200
Message-ID: <81b0412b0905201509o3db682dm9a667210a60b2d24@mail.gmail.com>
References: <81b0412b0905110242u3624f0eeyc0dc9b2b987bfa2b@mail.gmail.com>
	 <20090511192536.GA1485@blimp.localdomain>
	 <alpine.DEB.1.00.0905201228040.16461@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Anders Melchiorsen <mail@cup.kalibalik.dk>, git@vger.kernel.org,
	Samuel Tardieu <sam@rfc1149.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 21 00:10:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6tzD-0002Y4-Aq
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 00:10:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754345AbZETWJ7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 May 2009 18:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753650AbZETWJ6
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 18:09:58 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:59701 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753376AbZETWJ6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 May 2009 18:09:58 -0400
Received: by fxm2 with SMTP id 2so704312fxm.37
        for <git@vger.kernel.org>; Wed, 20 May 2009 15:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DG7ggA0LPX0EHuUHUXfSUXT0Y8NA+hpn7jAABXwgpto=;
        b=UrjGMSsr+ymcuOEDArKEl6nPDfpu4sbr9w/+atVgJulMCU97+wHAV+i1B8wcV3jwoq
         4+xRi/XNKAUG2yBLNIP/DgvqrzgLTUeCLHoBPxlD55nbssQB2QfGS4tSJFlsJranOcN3
         wTzTcIiKisvWwkh6WUJ1++HiFFv5AzGzsyCUI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wU43wmOj2hKHMl+0OX+hztIi/P4AhrKfym4jSG5ty7clrhBfR8+7mFRI9QjSxmmZQ+
         QsQTsDOBljKp5hYV7GOvrCt1w/n+vbhlxZaa5HI47XDAaLCHnQ4sK8+XtJkCyOULOjB9
         z1pJ/KhLa14wHefxsgVhepUX3Y5HQ5Ek5m8tE=
Received: by 10.204.112.11 with SMTP id u11mr1695414bkp.134.1242857398148; 
	Wed, 20 May 2009 15:09:58 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0905201228040.16461@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119637>

2009/5/20 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> On Mon, 11 May 2009, Alex Riesen wrote:
>
>> Some path names which transitioned from file to a directory were not
>> updated in the final part of the merge (loop around unmerged entries=
 in
>> merge_trees), because the branch in process_renames which filtered o=
ut
>> updates for the files with the same content ("merged same as existin=
g")
>> has left the rename entry in processed state. In this case, the
>> processing cannot be finished at the process_renames phase (because
>> the old file still blocks creation of directory where new files shou=
ld
>> appear), and must be postponed until the update_entry phase.
>
> I know that as a German, I am supposed to like long sentences and cro=
wded
> paragraphs. =C2=A0Maybe I am not that German after all.
>

Will be shortened.

>> diff --git a/merge-recursive.c b/merge-recursive.c
>> index a3721ef..3c5420b 100644
>> --- a/merge-recursive.c
>> +++ b/merge-recursive.c
>> @@ -980,14 +980,15 @@ static int process_renames(struct merge_option=
s *o,
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (mfi.clean &&
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sha_eq(mfi.sha, ren1-=
>pair->two->sha1) &&
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mfi.mode =3D=3D ren1->pai=
r->two->mode)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mfi.mode =3D=3D ren1->pai=
r->two->mode) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*=
 This messaged is part of
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*=
 t6022 test. If you change
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*=
 it update the test too.
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*=
/
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 output(=
o, 3, "Skipped %s (merged same as existing)", ren1_dst);
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ren1->dst_e=
ntry->processed =3D 0;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
>
> So basically, you say that a dst_entry has not been processed, when i=
t
> _has_ been? =C2=A0That cannot be correct...
>

My feeling exactly. I'm afraid I just zeroed the effect of the branch
which should avoid rewriting of files with known same content.
It's just that the code has grown a little confusing...
I'm still thinking about how to avoid unneeded rewrites of the files
with same content under same name.

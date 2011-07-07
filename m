From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 11/14] revert: Introduce a layer of indirection over pick_commits
Date: Thu, 7 Jul 2011 12:01:27 +0530
Message-ID: <CALkWK0mQS_8sNKP2T4QOCM_ahKTYvpRMnJz4Ltzq=zNsQTxkKQ@mail.gmail.com>
References: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
 <1309938868-2028-12-git-send-email-artagnon@gmail.com> <7vd3hnktuf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 07 08:31:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qei7t-0004IA-E8
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jul 2011 08:31:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754249Ab1GGGbs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jul 2011 02:31:48 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:64755 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371Ab1GGGbs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jul 2011 02:31:48 -0400
Received: by wwe5 with SMTP id 5so621162wwe.1
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 23:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=p0lU6AoGD3WDTFgiaZdqitRHNUmtXs2wsFU1czPehfU=;
        b=jpewYjrBBtaGuS0EPQnboZRcB0D916ooHHn1WLFYzf2Ln+CSziBB2p8wI2YJC/T9za
         Yo4othsXNT12BE0BrskgE+UHIP6gF6kPaeTWCA03K4RSUpfFthnTITQQfQu76rR6lxnC
         v/o84zJqSipmSmpAKqsYxbhaULEttrfAXI8+8=
Received: by 10.216.233.211 with SMTP id p61mr309398weq.107.1310020307062;
 Wed, 06 Jul 2011 23:31:47 -0700 (PDT)
Received: by 10.216.175.198 with HTTP; Wed, 6 Jul 2011 23:31:27 -0700 (PDT)
In-Reply-To: <7vd3hnktuf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176750>

Hi Junio,

Junio C Hamano writes:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>> diff --git a/builtin/revert.c b/builtin/revert.c
>> index 7d76f92..8cdcdb6 100644
>> --- a/builtin/revert.c
>> +++ b/builtin/revert.c
>> @@ -677,10 +677,8 @@ static int cleanup_sequencer_data(void)
>> =C2=A0 =C2=A0 =C2=A0 return 0;
>> =C2=A0}
>>
>> -static int pick_commits(struct replay_opts *opts)
>> +static int pick_commits(struct commit_list *todo_list, struct repla=
y_opts *opts)
>> =C2=A0{
>> - =C2=A0 =C2=A0 struct commit_list *todo_list =3D NULL;
>> - =C2=A0 =C2=A0 unsigned char sha1[20];
>> =C2=A0 =C2=A0 =C2=A0 struct commit_list *cur;
>> =C2=A0 =C2=A0 =C2=A0 int res;
>>
>> @@ -690,12 +688,6 @@ static int pick_commits(struct replay_opts *opt=
s)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 opts->record_origin || opts->edit))=
;
>> =C2=A0 =C2=A0 =C2=A0 read_and_refresh_cache(me, opts);
>>
>> - =C2=A0 =C2=A0 walk_revs_populate_todo(&todo_list, opts);
>> - =C2=A0 =C2=A0 create_seq_dir();
>> - =C2=A0 =C2=A0 if (!get_sha1("HEAD", sha1))
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 save_head(sha1_to_hex(sh=
a1));
>> - =C2=A0 =C2=A0 save_todo(todo_list, opts);
>> -
>> =C2=A0 =C2=A0 =C2=A0 for (cur =3D todo_list; cur; cur =3D cur->next)=
 {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 save_todo(cur, opts=
);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D do_pick_com=
mit(cur->item, opts);
>> @@ -710,6 +702,22 @@ static int pick_commits(struct replay_opts *opt=
s)
>> =C2=A0 =C2=A0 =C2=A0 return cleanup_sequencer_data();
>> =C2=A0}
>>
>> +static int process_continuation(struct replay_opts *opts)
>> +{
>> + =C2=A0 =C2=A0 struct commit_list *todo_list =3D NULL;
>> + =C2=A0 =C2=A0 unsigned char sha1[20];
>> +
>> + =C2=A0 =C2=A0 read_and_refresh_cache(me, opts);
>> +
>> + =C2=A0 =C2=A0 walk_revs_populate_todo(&todo_list, opts);
>> + =C2=A0 =C2=A0 create_seq_dir();
>> + =C2=A0 =C2=A0 if (!get_sha1("HEAD", sha1))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 persist_head(sha1_to_hex=
(sha1));
>> + =C2=A0 =C2=A0 persist_todo(todo_list, opts);
>
> Don't these two need forward declarations before their use?

Good catch.  I'm surprised the compiler didn't catch these.

-- Ram

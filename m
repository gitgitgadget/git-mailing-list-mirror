From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC PATCH] revert: Persist per-session opts
Date: Mon, 11 Jul 2011 11:42:44 +0530
Message-ID: <CALkWK0ndSWkPudM_sJnyUyh93t9JLk-t-YFQb7=WO2H_svnGdQ@mail.gmail.com>
References: <1310226118-10201-1-git-send-email-artagnon@gmail.com>
 <1310226118-10201-2-git-send-email-artagnon@gmail.com> <201107101002.06385.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Jul 11 08:13:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qg9jz-0005tr-OE
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 08:13:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757003Ab1GKGNH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jul 2011 02:13:07 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57958 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756568Ab1GKGNF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jul 2011 02:13:05 -0400
Received: by wyg8 with SMTP id 8so2348865wyg.19
        for <git@vger.kernel.org>; Sun, 10 Jul 2011 23:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=SKE6AJ1FgAfioSTEDDPaeWnYFIt6ZP3B5ST5FKVCYNE=;
        b=YJTSZf0rPsqxX7LH/Z/Gk8fqj6wubCMc60COPGPqTdjPCHrtYuxb/mbXGB3EDeZ6oK
         Y21gmjE7nqJ9qZnRj98l++Jdeinturz4RUAUI6yExuOZKf1SgJX/daIyB6smAv8zuqnG
         joKvNIAhocF2pHCQvZi/grWVrpA3e/my43Ty0=
Received: by 10.216.62.3 with SMTP id x3mr2634271wec.77.1310364784147; Sun, 10
 Jul 2011 23:13:04 -0700 (PDT)
Received: by 10.216.175.198 with HTTP; Sun, 10 Jul 2011 23:12:44 -0700 (PDT)
In-Reply-To: <201107101002.06385.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176833>

Hi Christian,

Christian Couder writes:
> On Saturday 09 July 2011 17:41:58 Ramkumar Ramachandra wrote:
>> Save the replay_opts struct in .git/sequencer/opts using a simple "k=
ey
>> =3D value" format. =C2=A0Parse it and populate the options structure=
 before
>> replaying.
>
> [...]
>
>> =C2=A0static void format_todo(struct strbuf *buf, struct commit_list=
 *todo_list,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 struct replay_opts *opts)
>> =C2=A0{
>> @@ -733,6 +759,102 @@ error:
>> =C2=A0 =C2=A0 =C2=A0 die(_("Malformed instruction sheet: %s"), git_p=
ath(SEQ_TODO_FILE));
>> =C2=A0}
>>
>> +static char *parse_opt_value(char *p, void *key, enum seq_opt_type =
type,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 parse_opt_cb *cb_function) {
>> + =C2=A0 =C2=A0 struct option opt;
>> + =C2=A0 =C2=A0 char *val, *cur, *end;
>> +
>> + =C2=A0 =C2=A0 if (!(val =3D strchr(p, '=3D')))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;
>> + =C2=A0 =C2=A0 if (!*(val + 1))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;
>> + =C2=A0 =C2=A0 if (!(end =3D strchr(p, '\n')))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;
>> + =C2=A0 =C2=A0 val +=3D 2;
>
> It looks like you rely on all lines ending with \n and having a space=
 after
> the '=3D'. It may be a little bit too fragile.

Right.  Thanks for the review -- will try to reuse bits of the
git-config parser.

-- Ram

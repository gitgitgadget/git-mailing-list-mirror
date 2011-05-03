From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/3] sparse checkout: do not eagerly decide the fate for
 whole directory
Date: Tue, 3 May 2011 11:43:35 +0700
Message-ID: <BANLkTimDO7yRyiBt7xS5Hy7-iT5SUDwJtA@mail.gmail.com>
References: <1304340464-14829-1-git-send-email-pclouds@gmail.com>
 <1304340464-14829-3-git-send-email-pclouds@gmail.com> <BANLkTikgNR1G5_TO3rmMZy3fN2PNF2Pqjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	skillzero@gmail.com
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 03 06:44:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QH7T5-0004uC-LM
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 06:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219Ab1ECEoJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2011 00:44:09 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34417 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751109Ab1ECEoH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2011 00:44:07 -0400
Received: by bwz15 with SMTP id 15so5217159bwz.19
        for <git@vger.kernel.org>; Mon, 02 May 2011 21:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=A2fMeMjjlb74RWxzD5h/iWeyPA2+NJF8v/LtGi84xPo=;
        b=YrnwBdcEN4ZIHKOD47HKzRHin3Mj97vIWnQNql1kL/9x/HIbPvMJX6cWSzBW5aUXLU
         utFJ0IPhBc5SnRZ9ljlvHtTBO40vrMKLER4MP5udX+mThHrOFg40QH3yeKf01Wcb7dvq
         umJukEvx9YTJyHyXg/HHSVOmtXJImywp2/sQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=aZ75XXvrjKxNd/BecCEtLFcRvB3y0qLhQHUvhNlJLOoSOf3qxNKyre1TtWhuuRFZ9f
         44BdArOtf0pUL26X1hbUP9n32rDxwnaFfZmX5ZJTW1KY2FF/T2Bhqe78NLzINGTQFUPj
         0K2BVoQXqEMQXJ9Bzb1IahaJAQStij5tKuIws=
Received: by 10.204.32.9 with SMTP id a9mr4129478bkd.182.1304397845351; Mon,
 02 May 2011 21:44:05 -0700 (PDT)
Received: by 10.204.53.13 with HTTP; Mon, 2 May 2011 21:43:35 -0700 (PDT)
In-Reply-To: <BANLkTikgNR1G5_TO3rmMZy3fN2PNF2Pqjg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172642>

2011/5/3 Thiago Farina <tfransosi@gmail.com>:
>> This generally works as long as there are no patterns to exclude par=
ts
>> of the directory. In case of sparse checkout code, the following pat=
terns
>>
>> =C2=A0t
>> =C2=A0!t/t0000-basic.sh
>>
>> will produce a worktree with full directory "t" even if t0000-basic.=
sh
>> is requested to stay out.
>> ...
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0prefix[prefix_len++] =3D '/';
>>
>> - =C2=A0 =C2=A0 =C2=A0 /* included, no clearing for any entries unde=
r this directory */
>> - =C2=A0 =C2=A0 =C2=A0 if (!ret) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (; cache !=3D=
 cache_end; cache++) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 struct cache_entry *ce =3D *cache;
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (strncmp(ce->name, prefix, prefix_len))
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return nr - (cach=
e_end - cache);
>> - =C2=A0 =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 =C2=A0 /* If undecided, use parent directory's decis=
ion in defval */
> What means "use parent directory's decision"? Could you make this
> comment more clearer?

Take the example patterns in commit message, we know that we match
directory "t" (pattern 1). When we check t/0001-init.sh, no patterns
match it. But because it's under "t", so we consider it matched. On
the other hand, t/t0000-basic.sh will match pattern 2 and override
parent directory's decision.

>> + =C2=A0 =C2=A0 =C2=A0 if (ret < 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D defval;
>>
>> - =C2=A0 =C2=A0 =C2=A0 /* excluded, clear all selected entries under=
 this directory. */
> Start with capital letter?

It's a line removal, what can I do about it?
--=20
Duy

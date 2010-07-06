From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCHv2 5/5] fast-import: Fix minor data-loss issue with 
	directories becoming symlinks
Date: Tue, 6 Jul 2010 13:48:50 -0600
Message-ID: <AANLkTimrD1LOZBb0YyzlrKgTc7bGWTxdf05cpwPR6WSw@mail.gmail.com>
References: <1278442295-23033-1-git-send-email-newren@gmail.com>
	<1278442295-23033-6-git-send-email-newren@gmail.com>
	<20100706193455.GA19476@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, agladysh@gmail.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jul 06 21:49:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWE92-0004kV-RU
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 21:49:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755828Ab0GFTsw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Jul 2010 15:48:52 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:65462 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754022Ab0GFTsv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jul 2010 15:48:51 -0400
Received: by vws5 with SMTP id 5so7895285vws.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 12:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=mID3AMzCZFGo1MCYyMYgZB4A44609rVobS0kmIVbr18=;
        b=D2B6pfK/IGMc1V+e9zzvBbDjL/vlAzsdORL3UytukmhYfWfz7kPEMASGCNSLrEKbwe
         IWc6KCBob9s04dYPiUixanpiPAzsn+6blkbFSISGDLT8vOC4Sveky1IoUCfzpfbJoK39
         4Twf7Fb7KAwjXYgNQ7g+752T9u7e+BY4SEJKM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=elDQW0MDQGI6p08/VSUYpN7TvUymaU/dJJFsHfCa/tEfkJnV5nBaFikbUDdGSFttoB
         DesyVL+Ut8Vy8XkvUwoKO05yNRyJYyWHNmoBeQb7nVDqk36HpNQUxPgo1LS8UDyOUGZE
         WfAcOW/PdI09vc0ZPUaV+9fii0/0mdFZWGaDA=
Received: by 10.220.62.206 with SMTP id y14mr2758813vch.111.1278445730178; 
	Tue, 06 Jul 2010 12:48:50 -0700 (PDT)
Received: by 10.220.83.138 with HTTP; Tue, 6 Jul 2010 12:48:50 -0700 (PDT)
In-Reply-To: <20100706193455.GA19476@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150405>

On Tue, Jul 6, 2010 at 1:34 PM, Shawn O. Pearce <spearce@spearce.org> w=
rote:
> newren@gmail.com wrote:
>> From: Elijah Newren <newren@gmail.com>
>>
>> When fast-export runs across a directory changing to a symlink, it w=
ill
>> output the changes in the form
>> =C2=A0 M 120000 :239821 dir-changing-to-symlink
>> =C2=A0 D dir-changing-to-symlink/filename1
>> When fast-import sees the first line, it deletes the directory named
>> dir-changing-to-symlink (and any files below it) and creates a symli=
nk in
>> its place. =C2=A0When fast-import came across the second line, it wa=
s previously
>> trying to remove the file and relevant leading directories in
>> tree_content_remove(), and as a side effect it would delete the syml=
ink
>> that was just created. =C2=A0This resulted in the symlink silently m=
issing from
>> the resulting repository.
>
> Ugh.
>
> I'm not against making the input parser more robust, but this is
> a violation of the stream format from fast-export. =C2=A0The stream i=
s
> incremental, a command like 'M' takes place immediately. =C2=A0It is
> wrong for a frontend to output 'M foo', then 'D foo/bar'.
>
> IMHO, if fast-export is doing what you say above, the bug lies in
> fast-export, and therefore the fix should too.

Okay, I'll fix up fast-export.  Do you want me to drop this
fast-import patch, or does it still make sense as an extra robustness
check?

Elijah

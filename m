From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH/RFC v3 6/8] Add case insensitivity support when using git ls-files
Date: Mon, 4 Oct 2010 18:48:46 +0200
Message-ID: <AANLkTimuJWHRjVNZu-zmUc0jDsK-5QLA+t87sXYnOMhR@mail.gmail.com>
References: <4CA847D5.4000903@workspacewhiz.com> <1286099806-25774-7-git-send-email-avarab@gmail.com>
 <201010041802.57398.robin.rosenberg@dewire.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Johannes Sixt <j6t@kdbg.org>, Brandon Casey <drafnel@gmail.com>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 18:49:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2oE0-0003H7-30
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 18:49:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756585Ab0JDQtK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 12:49:10 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:46737 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478Ab0JDQtJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 12:49:09 -0400
Received: by gxk9 with SMTP id 9so1696935gxk.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 09:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=VMZRpLzEen1WHTVaJgLkoTZkzfJ+mU+woe3Sb/KVUZQ=;
        b=hIucDfCxAoiGWM3FvqNPDu840x8fQ/jd4K62ASOYufKUC2Vy1J9AUV1KcvXyhRSxty
         a1n03/5bn68MXafNlGFXs0Ol7mQGsIP749Vz2tlsA9FiVx6p8Uz7EI+aWb7NzAg0CT2h
         Fu16WeMUTEmiN1UvYARWli+D5XA3v67kxnHco=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=Mm3dBx7y/tfQLzEKef1ne8aPR5dB+D4ehJGuBCdDMxtHyVwiQgDoJ3LlGHQgLdW6OT
         +ZSpPfT4fKjHz+wolrOGI/x1KYUTJR2dpAsLEnspz8nAV2CozL3g7dWQe2kZkMMNMwq7
         P+BY6fqir7FdFpkMjSjdg7L/EzkbsZ6nAm4ts=
Received: by 10.236.111.34 with SMTP id v22mr8579396yhg.5.1286210948233; Mon,
 04 Oct 2010 09:49:08 -0700 (PDT)
Received: by 10.150.147.6 with HTTP; Mon, 4 Oct 2010 09:48:46 -0700 (PDT)
In-Reply-To: <201010041802.57398.robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158064>

On Mon, Oct 4, 2010 at 6:02 PM, Robin Rosenberg
<robin.rosenberg@dewire.com> wrote:
> s=F6ndagen den 3 oktober 2010 11.56.44 skrev =A0=C6var Arnfj=F6r=F0 B=
jarmason:
>> From: Joshua Jensen <jjensen@workspacewhiz.com>
>>
>> When mydir/filea.txt is added, mydir/ is renamed to MyDir/, and
>> MyDir/fileb.txt is added, running git ls-files mydir only shows
>> mydir/filea.txt. Running git ls-files MyDir shows MyDir/fileb.txt.
>> Running git ls-files mYdIR shows nothing.
>>
>> With this patch running git ls-files for mydir, MyDir, and mYdIR sho=
ws
>> mydir/filea.txt and MyDir/fileb.txt.
>>
>> Wildcards are not handled case insensitively in this patch. Example:
>> MyDir/aBc/file.txt is added. git ls-files MyDir/a* works fine, but g=
it
>> ls-files mydir/a* does not.
>>
>> Signed-off-by: Joshua Jensen <jjensen@workspacewhiz.com>
>> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>> =A0dir.c | =A0 38 ++++++++++++++++++++++++++------------
>> =A01 files changed, 26 insertions(+), 12 deletions(-)
>>
>> diff --git a/dir.c b/dir.c
>> index cf8f65c..53aa4f3 100644
>> --- a/dir.c
>> +++ b/dir.c
>> @@ -107,16 +107,30 @@ static int match_one(const char *match, const =
char
>> *name, int namelen) if (!*match)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return MATCHED_RECURSIVELY;
>>
>> - =A0 =A0 for (;;) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 unsigned char c1 =3D *match;
>> - =A0 =A0 =A0 =A0 =A0 =A0 unsigned char c2 =3D *name;
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (c1 =3D=3D '\0' || is_glob_special(c1))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (c1 !=3D c2)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> - =A0 =A0 =A0 =A0 =A0 =A0 match++;
>> - =A0 =A0 =A0 =A0 =A0 =A0 name++;
>> - =A0 =A0 =A0 =A0 =A0 =A0 namelen--;
>> + =A0 =A0 if (ignore_case) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 for (;;) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned char c1 =3D tolow=
er(*match);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned char c2 =3D tolow=
er(*name);
>
> Is anyone thinking "unicode" around here?
>

You're not the first to think about the combination of core.ignorecase
and unicode, but unfortunately way too few people have.

slow_same_name() (and index_name_exists() by proxy) already does the
Wrong Thing (tm), so the problem is already rooted in the index. The
consensus on the msysGit mailing list last time this was brought up
[1] was simply to ignore the combination of unicode and
core.ignorecase, but I'm not sure I'm convinced myself that it's a
good idea. We might end up painting our selves further into a corner,
in the end making it nearly impossible to fix.

One complicating factor is that Windows' definition of what
character-pairs compare as identical depends on a table stored
somewhere in NTFS[2]. The time your drive was formatted decides what
that table looks like, and I haven't been able to retrieve it. This
might be going a little too far, as this table is likely to be very
rarely changed, but I think it's worth noting.

[1]: http://groups.google.com/group/msysgit/browse_thread/thread/675ad1=
6102f6233f/a25cd7bb8dfa2abb#a25cd7bb8dfa2abb
[2]: http://blogs.msdn.com/b/michkap/archive/2007/10/24/5641619.aspx

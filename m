From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [msysGit] [PATCH/RFC 07/11] run-command: support input-fd
Date: Fri, 27 Nov 2009 15:39:39 +0100
Message-ID: <40aa078e0911270639n1de36517w5fdf6ef38e931b19@mail.gmail.com>
References: <1259196260-3064-1-git-send-email-kusmabite@gmail.com>
	 <1259196260-3064-7-git-send-email-kusmabite@gmail.com>
	 <1259196260-3064-8-git-send-email-kusmabite@gmail.com>
	 <200911262253.59641.j6t@kdbg.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysgit@googlegroups.com, git@vger.kernel.org, dotzenlabs@gmail.com
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Nov 27 15:39:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NE1z8-0006tk-9n
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 15:39:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753136AbZK0Ojf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Nov 2009 09:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752993AbZK0Ojf
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 09:39:35 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:35843 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752658AbZK0Oje convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Nov 2009 09:39:34 -0500
Received: by ewy19 with SMTP id 19so1476985ewy.21
        for <git@vger.kernel.org>; Fri, 27 Nov 2009 06:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=haXLXzm/paVtOFXpvJKo4Ll0T4TDIMjjrzVW5qvo0rE=;
        b=gpsEMgYv7RFzUbUDREWSnPbKo0+46TqU8hcuyMEWEHt8YiT2hp9eaOojO7sNEPno8M
         QSRZEXqsei3ykdNszbFFzB41dC02mAMw8+UCy8oB0GFaflRFWCfuH8QE2RhyDUf7L8n8
         zzij0rXPdFUs9ANTsQHw3XJ3AkKDFRlbBhMEU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=jRh8RUt/8YZb4JuUDtU1NYDDhpGcGywnTGHUDTSCFqd5TB5ewEJU/LdoONMWZ1k0C5
         srVph4EM9hMEk3F/Ws5x+jrCmtF2QMPLyfexX5qHFQyd+weqvs96zP98MejDUp7Ci+5Z
         /lfm8cm3OaISQStmTmdPZhnYoFRi51UVn1eQ8=
Received: by 10.216.89.137 with SMTP id c9mr342037wef.228.1259332779718; Fri, 
	27 Nov 2009 06:39:39 -0800 (PST)
In-Reply-To: <200911262253.59641.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133898>

On Thu, Nov 26, 2009 at 10:53 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> On Donnerstag, 26. November 2009, Erik Faye-Lund wrote:
>> @@ -327,7 +327,10 @@ int start_async(struct async *async)
>> =A0{
>> =A0 =A0 =A0 int pipe_out[2];
>>
>> - =A0 =A0 if (pipe(pipe_out) < 0)
>> + =A0 =A0 if (async->out) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pipe_out[0] =3D dup(async->out);
>> + =A0 =A0 =A0 =A0 =A0 =A0 pipe_out[1] =3D dup(async->out);
>> + =A0 =A0 } else if (pipe(pipe_out) < 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return error("cannot create pipe: %s", s=
trerror(errno));
>> =A0 =A0 =A0 async->out =3D pipe_out[0];
>
> Hm. If async->out !=3D 0:
>
> =A0 =A0 =A0 =A0pipe_out[0] =3D dup(async->out);
> =A0 =A0 =A0 =A0async->out =3D pipe_out[0];
>
> This is confusing.

What do you find confusing about it? The idea is to use a provided
bi-directional fd instead of a pipe if async->out is non-zero. The
currently defined rules for async is that async->out must be zero
(since the structure should be zero-initialized).

> Moreover, you are assigning (a dup of) the same fd to the writable en=
d. This
> assumes a bi-directional channel. I don't yet know what I should thin=
k about
> this (haven't studied the later patches, yet).
>

Indeed it does. Do we want to extend it to support a set of
unidirectional channels instead?

> It would be great if you could add a few words to
> Documentation/technical/api-runcommand.txt.
>

Ah, yes. I know I should update the documentation and all, I'm just
usually really bad (*cough* lazy *cough*) at documenting stuff. But
I'll give it a go and if people hate what I write, they can suggest
changes.

--=20
Erik "kusma" Faye-Lund

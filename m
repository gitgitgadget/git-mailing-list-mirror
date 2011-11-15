From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v4 3/3] upload-archive: use start_command instead of fork
Date: Tue, 15 Nov 2011 18:44:38 +0100
Message-ID: <CABPQNSbu9bb5UG1ihi2vGX5ZkpvjfjaXrT8bhDGZHb=n9RbjSg@mail.gmail.com>
References: <1319472131-3968-1-git-send-email-kusmabite@gmail.com>
 <201111151122.48378.trast@student.ethz.ch> <20111115102807.GA18649@sigill.intra.peff.net>
 <201111151311.46832.trast@student.ethz.ch> <20111115173715.GA4478@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>,
	Franck Bui-Huu <vagabon.xyz@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, j6t@kdbg.org, rene.scharfe@lsrfire.ath.cx
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 15 18:45:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQN4b-00028P-Dw
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 18:45:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757041Ab1KORpV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Nov 2011 12:45:21 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:49990 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756980Ab1KORpU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Nov 2011 12:45:20 -0500
Received: by ggnb2 with SMTP id b2so7705956ggn.19
        for <git@vger.kernel.org>; Tue, 15 Nov 2011 09:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=JMAtJroCA1Hz4S50qXwD1s1xcXnoFBbFSGccKT2N8qE=;
        b=kpXkKJyRiKtVJ8Iie/YWhm85mdgMvau0Na4+f7ct26Uauo4fi4dKPGzz+wGu1qClPt
         BGtdkhh0uYdo2dApGG3NCHIjcdizK5TlDzP1nDdOCP3uCeZWuZXVK+B1zSJRrgQFxEMJ
         1caEflPVhG8q5zPlxe/ZKjzAIey7wJ2EBZVuc=
Received: by 10.68.72.104 with SMTP id c8mr61156240pbv.34.1321379119259; Tue,
 15 Nov 2011 09:45:19 -0800 (PST)
Received: by 10.68.71.135 with HTTP; Tue, 15 Nov 2011 09:44:38 -0800 (PST)
In-Reply-To: <20111115173715.GA4478@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185475>

On Tue, Nov 15, 2011 at 6:37 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Nov 15, 2011 at 01:11:46PM +0100, Thomas Rast wrote:
>
>> But after a closer look I think this patch just prodded it enough to
>> unearth long-existing undefined behaviour: prepare_argv() summarizes
>> to something like
>>
>> static void prepare_argv(const char **sent_argv, const char **argv)
>> {
>> =A0 =A0 =A0 char *p, buf[4096];
>>
>> =A0 =A0 =A0 for (p =3D buf;;) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 len =3D packet_read_line(0, p, (buf + si=
zeof buf) - p);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* ... p always points into buf ... */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 sent_argv[sent_argc++] =3D p;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 p +=3D len;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 *p++ =3D 0;
>> =A0 =A0 =A0 }
>> =A0 =A0 =A0 sent_argv[sent_argc] =3D NULL;
>> }
>>
>> The code appears to have looked like this ever since the addition of
>> that file back in 39345a2 (Add git-upload-archive, 2006-09-07). =A0S=
o
>> the elements of sent_argv have apparently always pointed into the
>> stack-allocated 'buf'.
>
> Oh, yikes. That is definitely the problem, but it does come from
> c09cd77e. The prepare_argv function used to be "run_upload_archive", =
and
> it would prepare argv on the stack, call into write_archive with it, =
and
> then return; nobody else cares about the value afterwards.
>
> Erik's patch converts it into a function that writes the new argv int=
o a
> parameter and returns, and the now-invalid stack-allocated memory is
> used by the calling function.
>

Outch. Thanks for spotting.

>> A quick band-aid would be to heap-allocate it instead:
>
> That works. =A0An even shorter band-aid is to mark it as "static".

Hmm, I seem to remember spotting it myself at some point and fixing it
by marking it as static. I guess I must have forgot to push it...

> I think the code would be more readable if it just used the new
> argv_array.
>

Oooh, nice. The whole argv_array slipped past me, I like it!

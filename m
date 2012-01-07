From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 1/5] run-command: optionally kill children on exit
Date: Sat, 7 Jan 2012 13:45:03 +0100
Message-ID: <CABPQNSb57LA6dYJvT7xF_vFfBFqKhCMbrQYp49_Ko1WmbUnYPw@mail.gmail.com>
References: <7vipkoih0e.fsf@alter.siamese.dyndns.org> <1325936567-3136-1-git-send-email-drizzd@aon.at>
 <1325936567-3136-2-git-send-email-drizzd@aon.at>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sat Jan 07 13:45:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjVeg-0000dJ-UY
	for gcvg-git-2@lo.gmane.org; Sat, 07 Jan 2012 13:45:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752180Ab2AGMpq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Jan 2012 07:45:46 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:55331 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987Ab2AGMpo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Jan 2012 07:45:44 -0500
Received: by pbdu13 with SMTP id u13so1369180pbd.19
        for <git@vger.kernel.org>; Sat, 07 Jan 2012 04:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=4W8ZkqvnVgQ0O50iB/44A+7fpJyw5pZd2vA2kfUyVbQ=;
        b=SWyAxFvzZSScyIGWHtxgJqlrTnH1dAiZ835ZCc8n79UPhVF/QLvgFSRLTB8gnwnH0k
         q8RSDaKy2GjyTGKhbh/wB8lkSFqYqCC0dw39yavA7e1a1G/Id/n1D+frngnKtnt26dzF
         6o1ImFB+G/vSFlRmL1nU1mhAEBXOGoKD0Rfns=
Received: by 10.68.191.100 with SMTP id gx4mr24117954pbc.26.1325940344262;
 Sat, 07 Jan 2012 04:45:44 -0800 (PST)
Received: by 10.68.8.7 with HTTP; Sat, 7 Jan 2012 04:45:03 -0800 (PST)
In-Reply-To: <1325936567-3136-2-git-send-email-drizzd@aon.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188076>

On Sat, Jan 7, 2012 at 12:42 PM, Clemens Buchacher <drizzd@aon.at> wrot=
e:
> +static void cleanup_children(int sig)
> +{
> + =A0 =A0 =A0 while (children_to_clean) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct child_to_clean *p =3D children_t=
o_clean;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 children_to_clean =3D p->next;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kill(p->pid, sig);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 free(p);
> + =A0 =A0 =A0 }
> +}
> +
> +static void cleanup_children_on_signal(int sig)
> +{
> + =A0 =A0 =A0 cleanup_children(sig);
> + =A0 =A0 =A0 sigchain_pop(sig);
> + =A0 =A0 =A0 raise(sig);
> +}
> +

Our Windows implementation of kill (mingw_kill in compat/mingw.c) only
supports SIGKILL, so propagating other signals to child-processes will
fail with EINVAL. That being said, Windows' support for signals is
severely limited, but I'm not entirely sure which ones can be
generated in this case.

> @@ -312,6 +375,7 @@ fail_pipe:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cmd->pid =3D -1;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0close(notify_pipe[0]);
> +
> =A0}
> =A0#else
> =A0{

This hunk is probably unintentional...

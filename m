From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v3 4/4] upload-archive: use start_command instead of fork
Date: Mon, 3 Oct 2011 20:48:20 +0200
Message-ID: <CABPQNSbN-sktYQUkLoywhCkc0_axgjY6Y9sN8ipeu6M+2VOVTA@mail.gmail.com>
References: <1317329963-6656-1-git-send-email-kusmabite@gmail.com>
 <1317329963-6656-5-git-send-email-kusmabite@gmail.com> <7vy5x1gbr6.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, peff@peff.net, j6t@kdbg.org,
	rene.scharfe@lsrfire.ath.cx
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 03 20:49:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAnZc-0001pI-DQ
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 20:49:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328Ab1JCStE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Oct 2011 14:49:04 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:34237 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087Ab1JCStB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Oct 2011 14:49:01 -0400
Received: by qadb15 with SMTP id b15so1809852qad.19
        for <git@vger.kernel.org>; Mon, 03 Oct 2011 11:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=NG20BSZu+2GfaRnIwJ9loFU2Trce8Mb8BMARteHlEFw=;
        b=xsrUPqIzfZfk7g/iNGQlq9wS8doKUx5vbTHLgTrSsNTprH+NupQ0tJPFGukFj7wx3E
         W0yQQcTtriSNq3DzMQ518GKF8RMrp7oA+ThkJfJ12CEmLnYojrVg72AuI4nrzvKPuLly
         8Qz5eHoNvdrm9vu6SIchuiia5N2RggTDuIxRs=
Received: by 10.68.14.105 with SMTP id o9mr3002151pbc.95.1317667740107; Mon,
 03 Oct 2011 11:49:00 -0700 (PDT)
Received: by 10.68.42.169 with HTTP; Mon, 3 Oct 2011 11:48:20 -0700 (PDT)
In-Reply-To: <7vy5x1gbr6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182686>

On Mon, Oct 3, 2011 at 8:39 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> Add an undocumented flag to git-archive that tells it that the
>> action originated from a remote, so features can be disabled.
>
>> diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
>> index 2d0b383..c57e8bd 100644
>> --- a/builtin/upload-archive.c
>> +++ b/builtin/upload-archive.c
>> @@ -6,6 +6,7 @@
>> =A0#include "archive.h"
>> =A0#include "pkt-line.h"
>> =A0#include "sideband.h"
>> +#include "run-command.h"
>>
>> =A0static const char upload_archive_usage[] =3D
>> =A0 =A0 =A0 "git upload-archive <repo>";
>> @@ -18,28 +19,17 @@ static const char lostchild[] =3D
>>
>> =A0#define MAX_ARGS (64)
>>
>> -static int run_upload_archive(int argc, const char **argv, const ch=
ar *prefix)
>> +static void prepare_argv(const char **sent_argv, const char **argv)
>> =A0{
>> - =A0 =A0 const char *sent_argv[MAX_ARGS];
>> =A0 =A0 =A0 const char *arg_cmd =3D "argument ";
>> =A0 =A0 =A0 char *p, buf[4096];
>> =A0 =A0 =A0 int sent_argc;
>> =A0 =A0 =A0 int len;
>>
>> + =A0 =A0 sent_argc =3D 2;
>> + =A0 =A0 sent_argv[0] =3D "archive";
>> + =A0 =A0 sent_argv[1] =3D "--remote-request";
>> =A0 =A0 =A0 for (p =3D buf;;) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* This will die if not enough free spac=
e in buf */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 len =3D packet_read_line(0, p, (buf + si=
zeof buf) - p);
>
> Hmm, forgetting the "Windows" for a while, does this client work agai=
nst
> the remote repositories that are running deployed versions of Git?
>

It should, the change is completely server-side. The first two entries
in sent_argv aren't sent over the network protocol, but the ones that
follow them are.

Or did I misunderstand your concern?

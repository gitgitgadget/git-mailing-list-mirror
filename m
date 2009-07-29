From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [BUG] Endless loop in git whatchanged --graph -m
Date: Wed, 29 Jul 2009 18:32:59 +0200
Message-ID: <20090729183259.2552912f@gmail.com>
References: <20090725014500.66680dc3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 29 18:39:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWCC2-0006bt-94
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 18:39:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755794AbZG2Qjo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Jul 2009 12:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755787AbZG2Qjn
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 12:39:43 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:62567 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755575AbZG2Qjm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2009 12:39:42 -0400
X-Greylist: delayed 397 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Jul 2009 12:39:41 EDT
Received: by ewy10 with SMTP id 10so102966ewy.37
        for <git@vger.kernel.org>; Wed, 29 Jul 2009 09:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=WZK2hccGUBsr20bJpDvyw6NXskIj/7wuCbbUAsxEykI=;
        b=FHM+9ZTiLgMjWgsCup2GSe/NPylnYjotp6Co1L64BoVWBIYlJFS4BZ9Wa8iXcEleVs
         NvHH6qOHjA3eAkWuEeFXczgQRBilfUYFZT3G8gVuCF88JHd5S3wV8XMDggvaXEsCAJal
         yT4Hf0UwWtuDW1WfZVU7EX1P1H2hYtgAlgoew=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=i7WgbT7HU6b6Ldt7453qTS1yX0N6y3VNAF6QrqJfpPd+l0lUPbY98ysPbe/0VpWEuD
         Dc7SeTfBT3/Ll6GqTjuwAX8z7YFXLfOdlwLeZv8r2d8X4wYYPQSGcpwJj/PV1TXXzel7
         mlOqUzOjZ4Jc3j3Ulp5XVBQMPTDWebOdmyQvo=
Received: by 10.210.58.13 with SMTP id g13mr11869631eba.99.1248885184285;
        Wed, 29 Jul 2009 09:33:04 -0700 (PDT)
Received: from localhost (87-205-225-111.adsl.inetia.pl [87.205.225.111])
        by mx.google.com with ESMTPS id 7sm271824eyb.2.2009.07.29.09.33.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Jul 2009 09:33:03 -0700 (PDT)
In-Reply-To: <20090725014500.66680dc3@gmail.com>
X-Mailer: Claws Mail 3.7.1 (GTK+ 2.14.7; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124367>

Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> wrote:

> Steps to reproduce:
>=20
> 	(Simple merge of two branches)
>=20
> 	$ mkdir a && cd a && git init
>=20
> 	$ echo file1 > file1
> 	$ git add file1 && git commit -m initial
>=20
> 	$ echo file1 >> file1
> 	$ git commit -a -m "commit on master"
>=20
> 	$ git checkout -b experimental HEAD^
> 	$ echo file2 > file2
> 	$ git add file2 && git commit -m "commit on experimental"
>=20
> 	$ git checkout master && git merge experimental=20
>=20
> 	$ git whatchanged --graph -m
> 	<endless loop here>
>=20
> Here is a simple patch, which solves this problem by removing constra=
int from
> git_show_commit(). I'm not sure if this is the best solution. Maybe s=
ome upper
> layer shouldn't call git_show_commit()?
>=20
> Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
> ---
>=20
> diff --git a/Documentation/technical/api-history-graph.txt b/Document=
ation/technical/api-history-graph.txt
> index d66e61b..32d961a 100644
> --- a/Documentation/technical/api-history-graph.txt
> +++ b/Documentation/technical/api-history-graph.txt
> @@ -36,11 +36,11 @@ The following utility functions are wrappers arou=
nd `graph_next_line()` and
>  They can all be called with a NULL graph argument, in which case no =
graph
>  output will be printed.
> =20
> -* `graph_show_commit()` calls `graph_next_line()` until it returns n=
on-zero.
> -  This prints all graph lines up to, and including, the line contain=
ing this
> -  commit.  Output is printed to stdout.  The last line printed does =
not contain
> -  a terminating newline.  This should not be called if the commit li=
ne has
> -  already been printed, or it will loop forever.
> +* `graph_show_commit()` calls `graph_next_line()` and
> +  `graph_is_commit_finished()` until one of them return non-zero.  T=
his prints
> +  all graph lines up to, and including, the line containing this com=
mit.
> +  Output is printed to stdout.  The last line printed does not conta=
in a
> +  terminating newline.
> =20
>  * `graph_show_oneline()` calls `graph_next_line()` and prints the re=
sult to
>    stdout.  The line printed does not contain a terminating newline.
> diff --git a/graph.c b/graph.c
> index e466770..049cdbc 100644
> --- a/graph.c
> +++ b/graph.c
> @@ -1198,7 +1198,7 @@ void graph_show_commit(struct git_graph *graph)
>         if (!graph)
>                 return;
> =20
> -       while (!shown_commit_line) {
> +       while (!shown_commit_line && !graph_is_commit_finished(graph)=
) {
>                 shown_commit_line =3D graph_next_line(graph, &msgbuf)=
;
>                 fwrite(msgbuf.buf, sizeof(char), msgbuf.len, stdout);
>                 if (!shown_commit_line)

Hi, has anyone looked at this?

Micha=C5=82 Kiedrowicz

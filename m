From: Junio C Hamano <gitster@pobox.com>
Subject: Re: something fishy with Git commit and log from file
Date: Wed, 06 Aug 2008 09:50:13 -0700
Message-ID: <7vy73aqe9m.fsf@gitster.siamese.dyndns.org>
References: <48997D2E.9030708@obry.net>
 <20080806104432.GG7121@bit.office.eurotux.com> <4899848C.6030800@obry.net>
 <7v3alirw6b.fsf@gitster.siamese.dyndns.org> <4899D119.1080403@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Luciano Rocha <luciano@eurotux.com>, git list <git@vger.kernel.org>
To: pascal@obry.net
X-From: git-owner@vger.kernel.org Wed Aug 06 18:51:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQmEU-0007SC-Sm
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 18:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755384AbYHFQuZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Aug 2008 12:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754314AbYHFQuW
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 12:50:22 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37142 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753869AbYHFQuW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Aug 2008 12:50:22 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id ACC044E1BB;
	Wed,  6 Aug 2008 12:50:19 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D3BD64E1B2; Wed,  6 Aug 2008 12:50:15 -0400 (EDT)
In-Reply-To: <4899D119.1080403@obry.net> (Pascal Obry's message of "Wed, 06
 Aug 2008 18:28:09 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C0EE3A92-63D7-11DD-A6C9-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91528>

Pascal Obry <pascal@obry.net> writes:

> Junio C Hamano a =C3=A9crit :
>> Pascal Obry <pascal@obry.net> writes:
>>
>>> So definitely a Git bug! Can be reproduced with:
>>>
>>>    $ mkdir repo && cd repo
>>>    $ git init
>>>    $ mkdir dir
>>>    $ cd dir
>>>    $ echo file > file
>>>    $ echo log > log
>>>    $ git add file
>>>    $ git commit --file=3Dlog
>>>    fatal: could not read log file 'log': No such file or directory
>>
>> Try it without cding down to "dir".
>
> Yes it works.

Perhaps something like this.  This must be another one of those
regressions introduced in C rewrite.

diff --git a/builtin-commit.c b/builtin-commit.c
index b783e6e..fcc9c59 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -469,7 +469,10 @@ static int prepare_to_commit(const char *index_fil=
e, const char *prefix)
 			die("could not read log from standard input");
 		hook_arg1 =3D "message";
 	} else if (logfile) {
-		if (strbuf_read_file(&sb, logfile, 0) < 0)
+		const char *lf =3D logfile;
+		if (prefix)
+			lf =3D prefix_filename(prefix, strlen(prefix), logfile);
+		if (strbuf_read_file(&sb, lf, 0) < 0)
 			die("could not read log file '%s': %s",
 			    logfile, strerror(errno));
 		hook_arg1 =3D "message";

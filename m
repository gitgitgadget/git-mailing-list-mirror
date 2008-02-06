From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git-daemon breakage in 1.5.4
Date: Wed, 06 Feb 2008 11:28:41 +0100
Message-ID: <47A98BD9.5040306@viscovery.net>
References: <BE051395-F4E1-428B-89B3-5D01BEA42C71@wincent.com> <7vr6fr9noj.fsf@gitster.siamese.dyndns.org> <C8E50E14-B50F-4385-A581-B69262E8E6A5@wincent.com> <47A98092.2070509@viscovery.net> <27E0A387-5A6B-4577-AAF4-ACE65A24E306@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	git mailing list <git@vger.kernel.org>,
	Scott R Parish <sRp@srparish.net>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 11:29:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMhWp-00050O-Jq
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 11:29:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbYBFK2s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Feb 2008 05:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbYBFK2s
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 05:28:48 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:29721 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243AbYBFK2r convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Feb 2008 05:28:47 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JMhVu-00007V-GF; Wed, 06 Feb 2008 11:28:23 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id A96526B7; Wed,  6 Feb 2008 11:28:41 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <27E0A387-5A6B-4577-AAF4-ACE65A24E306@wincent.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72793>

Wincent Colaiuta schrieb:
> El 6/2/2008, a las 10:40, Johannes Sixt escribi=F3:
>=20
>>> This fails with the "remote end hung up unexpectedly" error:
>>>
>>>  # /usr/local/bin/git-daemon --inetd --base-path=3D/blah -- /blah
>>
>> If you run this from the command line, you can't expect it to do any=
thing
>> useful: It communicates with the client via stdin and stdout.
>=20
> Strangely, it worked with 1.5.3.8. But I just tried to reproduce it a=
nd
> now I can't, so there must have been some error in my procedure. Doh.
> The bizarre thing is that in preparing these emails I tested it at le=
ast
> twice, which means I must have made the exact same mistake at least
> twice...
>=20
>> Which makes me think that you xinetd doesn't pass a PATH to git-daem=
on
>> that includes /usr/local/bin. Add this to your /etc/xinetd.d/git:
>>
>>    env =3D PATH=3D/bin:/usr/bin:/usr/local/bin
>>
>> (not tested).
>=20
> That works. Thanks.
>=20
> It's an acceptable workaround (the other is installing /usr instead o=
f
> /usr/local). Seeing as it worked in 1.5.3.8, does this qualify as
> breakage, or should we not worry about it?

Does this patch make a difference? (It does for me.)

diff --git a/daemon.c b/daemon.c
index 41a60af..c99285e 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1026,6 +1026,7 @@ int main(int argc, char **argv)
 	struct group *group;
 	gid_t gid =3D 0;
 	int i;
+	char *cmd_path =3D strdup(argv[0]), *slash;

 	/* Without this we cannot rely on waitpid() to tell
 	 * what happened to our children.
@@ -1184,6 +1185,13 @@ int main(int argc, char **argv)
 	if (strict_paths && (!ok_paths || !*ok_paths))
 		die("option --strict-paths requires a whitelist");

+	slash =3D strrchr(cmd_path, '/');
+	if (slash) {
+		*slash =3D 0;
+		setup_path(cmd_path);
+	}
+	free(cmd_path);
+
 	if (inetd_mode) {
 		struct sockaddr_storage ss;
 		struct sockaddr *peer =3D (struct sockaddr *)&ss;

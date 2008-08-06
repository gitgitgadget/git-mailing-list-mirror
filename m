From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] files given on the command line are relative to $cwd
Date: Wed, 06 Aug 2008 13:59:25 -0700
Message-ID: <7vd4kln9le.fsf@gitster.siamese.dyndns.org>
References: <48997D2E.9030708@obry.net>
 <20080806104432.GG7121@bit.office.eurotux.com> <4899848C.6030800@obry.net>
 <7v3alirw6b.fsf@gitster.siamese.dyndns.org> <4899D119.1080403@obry.net>
 <7vy73aqe9m.fsf@gitster.siamese.dyndns.org>
 <7vr692oufw.fsf@gitster.siamese.dyndns.org> <489A061B.7010508@free.fr>
 <7vtzdxnbgk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>,
	Luciano Rocha <luciano@eurotux.com>, pascal@obry.net,
	Pierre Habouzit <madcoder@debian.org>,
	Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Wed Aug 06 23:00:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQq7i-0000X5-FU
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 23:00:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756531AbYHFU7h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Aug 2008 16:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757173AbYHFU7h
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 16:59:37 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51693 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756266AbYHFU7g convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Aug 2008 16:59:36 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2537A4AAC5;
	Wed,  6 Aug 2008 16:59:35 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D25BF4AAB6; Wed,  6 Aug 2008 16:59:27 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9311ABA4-63FA-11DD-83D4-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91540>

Junio C Hamano <gitster@pobox.com> writes:

> Olivier Marin <dkr+ml.git@free.fr> writes:
>
>> Junio C Hamano a =C3=A9crit :
>>> =20
>>>  static int parse_and_validate_options(int argc, const char *argv[]=
,
>>> -				      const char * const usage[])
>>> +				      const char * const usage[],
>>> +				      const char *prefix)
>>>  {
>>>  	int f =3D 0;
>>> =20
>>>  	argc =3D parse_options(argc, argv, builtin_commit_options, usage,=
 0);
>>> +	logfile =3D parse_options_fix_filename(prefix, logfile);
>>
>> It breaks the "git commit -F -" case, no?
>
> Does it?  Ah, yeah, t7500 #15 does not go down to a subdirectory.

Ok, this squashed in on top of the previous one should cover the case.

Thanks for saving me in time from a major embarrassment.  I already tag=
ged
1.5.6.5 with the botched one but haven't pushed it out, so I can safely
rewind.

---

 parse-options.c   |    2 +-
 t/t7500-commit.sh |    8 ++++++++
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index d771bf4..12c8822 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -432,7 +432,7 @@ int parse_opt_approxidate_cb(const struct option *o=
pt, const char *arg,
  */
 extern const char *parse_options_fix_filename(const char *prefix, cons=
t char *file)
 {
-	if (!file || !prefix || is_absolute_path(file))
+	if (!file || !prefix || is_absolute_path(file) || !strcmp("-", file))
 		return file;
 	return prefix_filename(prefix, strlen(prefix), file);
 }
diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
index 2ab791b..823256a 100755
--- a/t/t7500-commit.sh
+++ b/t/t7500-commit.sh
@@ -159,4 +159,12 @@ test_expect_success 'commit message from file (2)'=
 '
 	commit_msg_is "Log in sub directory"
 '
=20
+test_expect_success 'commit message from stdin' '
+	(
+		cd subdir &&
+		echo "Log with foo word" | git commit --allow-empty -F -
+	) &&
+	commit_msg_is "Log with foo word"
+'
+
 test_done

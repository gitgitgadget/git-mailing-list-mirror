From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What is 'git BRANCH'?
Date: Tue, 29 Jul 2008 15:39:36 -0700
Message-ID: <7v63qob9hz.fsf@gitster.siamese.dyndns.org>
References: <g6o4vi$rap$1@ger.gmane.org>
 <7vej5cba6z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jurko =?utf-8?Q?Gospodneti=C4=87?= <jurko.gospodnetic@docte.hr>
X-From: git-owner@vger.kernel.org Wed Jul 30 00:40:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNxs8-000696-ND
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 00:40:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756727AbYG2Wjp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jul 2008 18:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754344AbYG2Wjp
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 18:39:45 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42099 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755992AbYG2Wjn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jul 2008 18:39:43 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6322044666;
	Tue, 29 Jul 2008 18:39:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A31AD44660; Tue, 29 Jul 2008 18:39:39 -0400 (EDT)
In-Reply-To: <7vej5cba6z.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 29 Jul 2008 15:24:36 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3C5E5460-5DBF-11DD-822A-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90697>

Junio C Hamano <gitster@pobox.com> writes:

> Jurko Gospodneti=C4=87 <jurko.gospodnetic@docte.hr> writes:
>
>>   Hi.
>>
>>   I typed in "git BRANCH" by accident and got the error message:
>> "fatal: cannot handle BRANCH internally".
>>
>>   What does that mean?
>>
>>   It is different from the usual "git: 'yada-yada' is not a
>> git-command. See 'git --help'." message you get when you type in an
>> incorrect command name.
>
> Just a guess; your git is installed on a case-challenged filesystem?

Yeah, that must be it.  This can happen on MacOS and Windows, I would
imagine.

-- >8 --
[PATCH] Fail on unknown command sensibly on case-challenged filesystems

The callchain on a case-challenged filesystem when the user runs "git
BRANCH" looks like this:

  - main(): git BRANCH
   - execv_dashed_external("BRANCH")
    - execvp("git-BRANCH")

     - main(): git-BRANCH
      - prefixcmp("git-BRANCH", "git-")
       - handle_internal_command()
         struct cmd_struct commands[] does not have "BRANCH"
         so it returns, instead of exiting.

When the "git wrapper" execs "git-BRANCH", if your filesystem knows
"branch" and "BRANCH" are different, execvp() would fail and we will se=
e
the familiar error message from the git.c::main().

However, if execvp() succeeds, we feed an unknown command name to
handle_internal_command() and it triggers a different error message.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git.c b/git.c
index 37b1d76..c99e769 100644
--- a/git.c
+++ b/git.c
@@ -448,7 +448,7 @@ int main(int argc, const char **argv)
 		cmd +=3D 4;
 		argv[0] =3D cmd;
 		handle_internal_command(argc, argv);
-		die("cannot handle %s internally", cmd);
+		help_unknown_cmd(cmd);
 	}
=20
 	/* Look for flags.. */

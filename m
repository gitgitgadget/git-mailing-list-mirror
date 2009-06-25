From: Junio C Hamano <gitster@pobox.com>
Subject: Re: names using git config
Date: Wed, 24 Jun 2009 22:11:04 -0700
Message-ID: <7veit8kidz.fsf@alter.siamese.dyndns.org>
References: <376636be0906240958l70c81b68g83340556f2bf4eca@mail.gmail.com>
	<vpqljnhv9w0.fsf@bauges.imag.fr>
	<376636be0906242146h1d4c3b1q8c2e9af26f124af4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Ryan <ryanphilips19@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 07:11:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJhEx-0002JH-Ow
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 07:11:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbZFYFLG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 01:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750879AbZFYFLE
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 01:11:04 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:53450 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788AbZFYFLD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 01:11:03 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090625051106.WNLL20430.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Thu, 25 Jun 2009 01:11:06 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 85B51c0024aMwMQ035B5fy; Thu, 25 Jun 2009 01:11:05 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=mK_AVkanAAAA:8 a=A1X0JdhQAAAA:8
 a=ez72-NhEb3RnDuAYZeAA:9 a=M4EtGvymtxyFKlqHMfCn6DnyxykA:4 a=MTTpUSoqY4oA:10
 a=9xyTavCNlvEA:10 a=Y6qChIQXU1wA:10
X-CM-Score: 0.00
In-Reply-To: <376636be0906242146h1d4c3b1q8c2e9af26f124af4@mail.gmail.com> (Ryan's message of "Thu\, 25 Jun 2009 10\:16\:56 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122180>

Ryan <ryanphilips19@googlemail.com> writes:

> Hi,
>   Thank you for your response.
>
> 1) git config user.name 'Matthieu M. Moy' Works
> 2) git config user.name 'Matthieu M.'  does not
>
> Name cannot end in a '.' <dot>. in git config user.name

That is correct, but I think we are a bit too strict in sanitizing names.
The code is ident.c::copy() whose intent was to sanitize useless runs of
commas we slurp from GECOS field, but the sanitization is done also for
anything specified by the end user.

This patch loosens it, but I think it goes too far, in that it does not
stop you from feeding total nonsense with GIT_AUTHOR_NAME environment and
user.name configuration.

 ident.c                |    5 ++---
 t/t1300-repo-config.sh |   12 ++++++++++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/ident.c b/ident.c
index 99f1c85..07ec81d 100644
--- a/ident.c
+++ b/ident.c
@@ -212,8 +212,7 @@ const char *fmt_ident(const char *name, const char *email,
 		pw = getpwuid(getuid());
 		if (!pw)
 			die("You don't exist. Go away!");
-		strlcpy(git_default_name, pw->pw_name,
-			sizeof(git_default_name));
+		copy(git_default_name, sizeof(git_default_name), 0, pw->pw_name);
 		name = git_default_name;
 	}
 
@@ -221,7 +220,7 @@ const char *fmt_ident(const char *name, const char *email,
 	if (!name_addr_only && date_str)
 		parse_date(date_str, date, sizeof(date));
 
-	i = copy(buffer, sizeof(buffer), 0, name);
+	i = add_raw(buffer, sizeof(buffer), 0, name);
 	i = add_raw(buffer, sizeof(buffer), i, " <");
 	i = copy(buffer, sizeof(buffer), i, email);
 	if (!name_addr_only) {
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 43ea283..c1a913e 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -758,4 +758,16 @@ test_expect_success 'check split_cmdline return' "
 	test_must_fail git merge master
 	"
 
+test_expect_success 'name ending in dot' '
+	foobar="Foo Bar."
+	git config user.name "$foobar" &&
+	git config user.email "foo.bar@example.com" &&
+	test "$(git config user.name)" = "$foobar" &&
+	(
+		unset GIT_AUTHOR_NAME
+		ident=$(git var GIT_AUTHOR_IDENT | sed -e "s/ *<.*//") &&
+		test "$ident" = "$foobar"
+	)
+'
+
 test_done

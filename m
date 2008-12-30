From: "Marcel M. Cary" <marcel@oak.homeunix.org>
Subject: [PATCH rfc v2] git-sh-setup: Fix scripts whose PWD is a symlink to a work-dir on OS X
Date: Tue, 30 Dec 2008 07:10:24 -0800
Message-ID: <1230649824-1893-1-git-send-email-marcel@oak.homeunix.org>
References: <CC0158BE-219B-4E09-9B3B-A2D1B66132AC@silverinsanity.com>
Cc: gitster@pobox.com, jnareb@gmail.com, ae@op5.se,
	j.sixt@viscovery.net, "Marcel M. Cary" <marcel@oak.homeunix.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 30 16:11:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHgG5-0005mE-FV
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 16:11:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752319AbYL3PK2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 10:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752311AbYL3PK2
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 10:10:28 -0500
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:35742 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752301AbYL3PK1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Dec 2008 10:10:27 -0500
Received: (qmail 96059 invoked from network); 30 Dec 2008 15:10:26 -0000
Received: from unknown (HELO ordinateur.home.org) (marcel@75.61.100.45 with plain)
  by smtp124.sbc.mail.sp1.yahoo.com with SMTP; 30 Dec 2008 15:10:26 -0000
X-YMail-OSG: vUgAzLAVM1nFYTgXvncxFgCaceWG.yggMZg1S2iVl5mEIs3mN2Qdn2.gCRYwajJU52hPnqG3Ji_bKnGkxDL3mKc5zzrkp79QFI0QOG3j4rmxl9dCq5__zhsqBdmB9w.AC3xKgQ7D6JN31KwXjBkQbUKhkXUXr8h22.Jij0ijyOU0I1ac8WPZqEL7Vg--
X-Yahoo-Newman-Property: ymail-3
Received: from polliwog.home.org ([192.168.0.18] helo=localhost.localdomain)
	by ordinateur.home.org with esmtp (Exim 4.63)
	(envelope-from <marcel@oak.homeunix.org>)
	id 1LHgEi-0006Cw-Jq; Tue, 30 Dec 2008 07:10:24 -0800
X-Mailer: git-send-email 1.6.0.3
In-Reply-To: <CC0158BE-219B-4E09-9B3B-A2D1B66132AC@silverinsanity.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104189>

On Mac OS X and possibly BSDs, /bin/pwd reads PWD from the environment
if available and shows the logical path by default rather than the
physical one.

Unset PWD before running /bin/pwd in both cd_to_toplevel and its
test.

Still use the external /bin/pwd because in my Bash on Linux,
the builtin pwd prints the same result whether or not PWD is set.
---

Brian Gernhardt wrote:
> I didn't pay attention to this at the time, but I just tried to build a
> new version of git and noticed this...
>
>> +        ..|../*|*/..|*/../*)
>> +            # Interpret $cdup relative to the physical, not logical,
>> cwd.
>> +            # Probably /bin/pwd is more portable than passing -P to
>> cd or pwd.
>> +            phys="$(/bin/pwd)/$cdup"
>> +            ;;
>
> This is a non-portable construct.  Notably, on OS X (and possibly some
> BSDs) /bin/pwd does not give the physical path, but $(/bin/pwd -P)
> does.

Ouch!

Junio C Hamano wrote:
> Having said that, I think it would probably be better to bite the
> bullet and start using "cd -P" soon after 1.6.1 goes final, and at the
> same time existing places that use "cd `pwd`" as a workaround if there
> are some.

Perhaps it's time to start using "cd -P" with the recent release of
1.6.1.  But maybe it's also worth finding a fix that doesn't rely on it
for any maintenance release of 1.6 that might happen?

Brian Gernhardt wrote:
> We may have to build this string ourselves with a --show-cd-absolute
> for portability.

Some options I considered:

(1) We could implement --show-cd-absolute in the short term, with the
expectation of removing it we switch to "cd -P".  Not sure it would
really work to try to remove a switch, even if it were undocumented, or
documented as deprecated.

(2) We could check the output of /bin/pwd for ".." and if they are still
present, add the "-P".  But I suppose there's no guarantee "-P" would
work, and I shy away from additional analysis of the path because I
don't want to miss an edge case.

(3) We could unset PWD before running /bin/pwd.  (Note that in my Bash,
the pwd *builtin* prints the same result whether or not I unset PWD
first.)  I suppose it's possible some /bin/pwd dies when PWD is unset or
something, but that seems unlikely.

From
http://developer.apple.com/DOCUMENTATION/Darwin/Reference/ManPages/man1/pwd.1.html
> The -L option does not work unless the PWD environment variable is
> exported by the shell.

I like option 3 best.  Any thoughts?


I sent the first rev of this patch to just Brian.  It didn't have
either of the unit test changes.  He said it fixed all but t2300.3,
where cd_to_toplevel doesn't actually "cd", so I made the same change
to the unit test itself.  Can someone with OS X try running the test
suite with v2 of this patch?  I don't have OS X readily available.

Marcel


 git-sh-setup.sh           |    2 +-
 t/t2300-cd-to-toplevel.sh |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index f07d96b..2142308 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -96,7 +96,7 @@ cd_to_toplevel () {
 		..|../*|*/..|*/../*)
 			# Interpret $cdup relative to the physical, not logical, cwd.
 			# Probably /bin/pwd is more portable than passing -P to cd or pwd.
-			phys="$(/bin/pwd)/$cdup"
+			phys="$(unset PWD; /bin/pwd)/$cdup"
 			;;
 		*)
 			# There's no "..", so no need to make things absolute.
diff --git a/t/t2300-cd-to-toplevel.sh b/t/t2300-cd-to-toplevel.sh
index beddb4e..e42cbfe 100755
--- a/t/t2300-cd-to-toplevel.sh
+++ b/t/t2300-cd-to-toplevel.sh
@@ -10,12 +10,12 @@ test_cd_to_toplevel () {
 			cd '"'$1'"' &&
 			. git-sh-setup &&
 			cd_to_toplevel &&
-			[ "$(/bin/pwd)" = "$TOPLEVEL" ]
+			[ "$(unset PWD; /bin/pwd)" = "$TOPLEVEL" ]
 		)
 	'
 }
 
-TOPLEVEL="$(/bin/pwd)/repo"
+TOPLEVEL="$(unset PWD; /bin/pwd)/repo"
 mkdir -p repo/sub/dir
 mv .git repo/
 SUBDIRECTORY_OK=1
-- 
1.6.0.3

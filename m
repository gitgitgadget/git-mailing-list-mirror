From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Re: "git stash list" shows HEAD reflog
Date: Sat, 13 Mar 2010 21:11:29 +0100
Message-ID: <4B9BF171.2000102@lsrfire.ath.cx>
References: <op.u9gl97fstuzx1w@cybershadow.mshome.net> <4B9BCD6E.4090902@lsrfire.ath.cx> <alpine.DEB.2.00.1003130939240.796@narbuckle.genericorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Vladimir Panteleev <vladimir@thecybershadow.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Dave Olszewski <cxreg@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 13 21:11:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqXgS-0006Zj-RX
	for gcvg-git-2@lo.gmane.org; Sat, 13 Mar 2010 21:11:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759032Ab0CMULf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Mar 2010 15:11:35 -0500
Received: from india601.server4you.de ([85.25.151.105]:34817 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758900Ab0CMULe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Mar 2010 15:11:34 -0500
Received: from [10.0.1.100] (p57B7E76C.dip.t-dialin.net [87.183.231.108])
	by india601.server4you.de (Postfix) with ESMTPSA id 16E892F8045;
	Sat, 13 Mar 2010 21:11:33 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
In-Reply-To: <alpine.DEB.2.00.1003130939240.796@narbuckle.genericorp.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142103>

Am 13.03.2010 18:41, schrieb Dave Olszewski:
> On Sat, 13 Mar 2010, Ren? Scharfe wrote:
> 
>> Am 12.03.2010 15:52, schrieb Vladimir Panteleev:
> 
>>> That doesn't explain why git displayed the HEAD reflog, though. That
>>> seems to happen thanks to the check (revs->def && !revs->pending.nr) in
>>> setup_revisions ("HEAD" is the default, as specified in the caller
>>> cmd_log_init). It looks like (ideally) git shouldn't rely on whether
>>> revs->pending is empty to decide whether to use the default, but rather
>>> if a ref was specified by the user or not.
>>
>> We could add some kind of check there, but with the patch applied I can't
>> trigger this second issue any more.  It would be nice to have a test
>> script
>> along with such a sanity check.  Any idea how to cause this error,
>> perhaps
>> with another type of invalid reflog file?
> 
> I actually noticed this last week.  You can reproduce it by doing "git
> reflog" on a branch which has been idle for longer than the expiration.
> Any 0-byte files in logs/refs/heads would give me this same behavior.
> 
>     Dave

Perhaps something like this?
---
 revision.c             |    4 ++++
 t/t1411-reflog-show.sh |   13 +++++++++++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/revision.c b/revision.c
index 29721ec..6991475 100644
--- a/revision.c
+++ b/revision.c
@@ -896,6 +896,7 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
 	struct object *object;
 	unsigned char sha1[20];
 	int local_flags;
+	int empty_after, empty_before = !revs->pending.nr;
 
 	dotdot = strstr(arg, "..");
 	if (dotdot) {
@@ -971,6 +972,9 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
 		verify_non_filename(revs->prefix, arg);
 	object = get_reference(revs, arg, sha1, flags ^ local_flags);
 	add_pending_object_with_mode(revs, object, arg, mode);
+	empty_after = !revs->pending.nr;
+	if (empty_before && empty_after)
+		die("bad revision '%s' (empty reflog?)", arg);
 	return 0;
 }
 
diff --git a/t/t1411-reflog-show.sh b/t/t1411-reflog-show.sh
index c18ed8e..3f48c2d 100755
--- a/t/t1411-reflog-show.sh
+++ b/t/t1411-reflog-show.sh
@@ -64,4 +64,17 @@ test_expect_success 'using --date= shows reflog date (oneline)' '
 	test_cmp expect actual
 '
 
+: >expected.out
+cat >expected.err <<'EOF'
+fatal: bad revision 'empty' (empty reflog?)
+EOF
+test_expect_success 'empty reflog file' '
+	git branch empty &&
+	: >.git/logs/refs/heads/empty &&
+
+	test_must_fail git log -g empty >actual.out 2>actual.err &&
+	test_cmp expected.out actual.out &&
+	test_cmp expected.err actual.err
+'
+
 test_done
-- 
1.7.0.2

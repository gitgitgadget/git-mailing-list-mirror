From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: v1.7.0-rc0 shows lots of "unable to find <sha1>" on git-stash
Date: Sat, 30 Jan 2010 21:44:08 +0100
Message-ID: <4B649A18.3050907@web.de>
References: <57518fd11001290712s2585e468o73b746b7ca27e1f1@mail.gmail.com> 	<7vzl3wiz59.fsf@alter.siamese.dyndns.org> <57518fd11001291646l5b0b581dm553689232b0910e8@mail.gmail.com> 	<4B642696.2070501@web.de> <57518fd11001300523xf7d931by254581c8494171af@mail.gmail.com> 	<4B643DEF.8010809@web.de> <57518fd11001300836v7f21a8a9qc09953d9091a4513@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 21:44:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbKB2-0003W3-BN
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 21:44:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752679Ab0A3UoO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 15:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752768Ab0A3UoO
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 15:44:14 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:50941 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752275Ab0A3UoN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 15:44:13 -0500
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id F2DA313CE35F2;
	Sat, 30 Jan 2010 21:44:11 +0100 (CET)
Received: from [80.128.90.168] (helo=[192.168.178.26])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NbKAt-00055S-00; Sat, 30 Jan 2010 21:44:11 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
In-Reply-To: <57518fd11001300836v7f21a8a9qc09953d9091a4513@mail.gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18MUGbe5jv+eYAU+EuAqwfILawv3piTgEuwZceA
	IUGC56WLIApEQW3RMMekDGxmMm2D1ts2n3Fg9g8sDlsgRUtrkO
	NGjMpNd29/XCRfJJvw0Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138501>

Am 30.01.2010 17:36, schrieb Jonathan del Strother:
> On 30 January 2010 14:10, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>> Am 30.01.2010 14:23, schrieb Jonathan del Strother:
>>> On 30 January 2010 12:31, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>>>> I assume you have one or more submodules, maybe even with untracked
>>>> or yet uncommitted modified files in your tree? If so, what does git
>>>> status say in the superproject and in the submodule(s)?
>>>
>>> Yep, I have 10 submodules.  However, they're all completely clean with
>>> no tracked or untracked changes shown in git status.  Anything else I
>>> can investigate?
>>
>> The change in behavior my patch introduced is that "git status" is
>> called inside each submodule. So i would expect getting the same
>> errors when using this command:
>>   git submodule foreach git status -s
>>
>> It should just show
>>   Entering '<submodule 1>'
>>   Entering '<submodule 2>'
>>   Entering '<submodule 3>'
>>   Entering '<submodule 4>'
>>   Entering '<submodule 5>'
>>   Entering '<submodule 6>'
>>   Entering '<submodule 7>'
>>   Entering '<submodule 8>'
>>   Entering '<submodule 9>'
>>   Entering '<submodule 10>'
>> when the submodules are not dirty. What do you get?
>>
> 
> Correct - I just get that output.

Hm, so nothing unusual there. I really wonder what is the problem here,
as calling "git status" inside the submodules works fine when issued via
"git submodule foreach", but not when done via run_command()!?

So i would like to ask some more questions:

- Under what operating system and on what filesystem is this happening?

- Is there anything unusual about your repo (e.g. using GIT_WORK_TREE
  or having the object database somewhere else that in .git in the
  superproject or any of the submodules)?

- You are just issuing a "git stash" to stash some changes in the
  superproject when that happens, right?

- The hashes that show up as "unable to find" are reachable via "git
  show" in the superproject, not in the submodules, right?

- Do these hashes have any relation to the contents you are stashing?

- The following patch should suppress (but not solve) this problem when
  applied to a version of git that contains
  4d34477f4c5dbebc55aa1362fd705440590a85f1 (git diff: Don't test
  submodule dirtiness with --ignore-submodules), e.g. current next.
  Could you please verify that?

---8<---
diff --git a/git-stash.sh b/git-stash.sh
index 3a0685f..e9b47b4 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -105,7 +105,7 @@ create_stash () {
                w_tree=$(GIT_INDEX_FILE="$TMP-index" git write-tree) ||
                die "Cannot save the current worktree state"

-               git diff-tree -p HEAD $w_tree > "$TMP-patch" &&
+               git diff-tree --ignore-submodules -p HEAD $w_tree > "$TMP-patch"
                test -s "$TMP-patch" ||
                die "No changes selected"

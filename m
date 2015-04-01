From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Trying to push into empty repo, get fatal: bad revision 'HEAD'
Date: Tue, 31 Mar 2015 18:36:03 -0700
Message-ID: <xmqq8uecocjg.fsf@gitster.dls.corp.google.com>
References: <CAHkN8V8cpZUmCi6=MUcsCOCBe6H_G6btr6WaV2vVrO1Nm_r4tg@mail.gmail.com>
	<xmqqego4ogxw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Samuel Williams <space.ship.traveller@gmail.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 01 03:36:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd7Zk-0001oP-F9
	for gcvg-git-2@plane.gmane.org; Wed, 01 Apr 2015 03:36:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752209AbbDABgI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 21:36:08 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50065 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751457AbbDABgG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 21:36:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DED6D463B7;
	Tue, 31 Mar 2015 21:36:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5nSVnDC76HRHmwPOlWksSNcAlE4=; b=Lfmn/C
	uBnmwjBgWIvkHnGwDxH4a98YCNvo9ES0M6zhiRSl172vvvikvFXH/WDQyIkRWLyD
	5fW9r3RXHEKJ1Np4gnMCOtEbADDgNPI+jgyxD5VkmzAg7AsfZOXOTeLii7NLZp8C
	4xCm2GvkSoIEC99Ne+/6CI2KFEKyTYrMN6NCc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rLYj6Y8RdeXVwpG02WnPS7DS3L/vTnZR
	N0sHLrkGU8q2TovtkvC7p/A2hkiEadVLm8CB1qMSGenDO5Rs2cZISFZblfs9cbxR
	mDBqb5cw7dN6509baFWXhFv94EKGE3GAN1NR9rf/S+t7lnxjEsnvFsKm+sv6GYKm
	OaJkf4swz2Q=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D55FF463B6;
	Tue, 31 Mar 2015 21:36:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 178E8463B3;
	Tue, 31 Mar 2015 21:36:05 -0400 (EDT)
In-Reply-To: <xmqqego4ogxw.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 31 Mar 2015 17:00:59 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 76709B1E-D80F-11E4-BBA5-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266588>

Junio C Hamano <gitster@pobox.com> writes:

> Samuel Williams <space.ship.traveller@gmail.com> writes:
>
>> I would expect if you push to an empty repo, it would update it
>> (because denyCurrentBranch = updateInstead).
>
> Good finding.
>
> I think the current implementation of updateInstead is set up to
> bootstrap from an empty repository but only supports incremental
> updates once the receiving repository and its working tree gets set
> up.  But I do not think it was a conscious design decison to forbid
> bootstrapping an empty repository, but was a mere gap in the
> implementation.  At least, I do not think of a reason why we should
> forbid it (and I am Cc'ing Dscho to confirm).
>
> Fixing it should not be too hard, but I am on a bus right now so...

A fix (or is it an enhancement) would probably look like this.

This is a tangent but I think we should unify the "do we already
have history behind HEAD, or is the current branch still unborn"
test done by various commands and tighten it.  As a quick and dirty
hack, I just mimicked what builtin/merge.c seems to do, but this
would tell a detached HEAD that points at a nonsense object name
(i.e. "abcde" not a full 40-hex) as "unborn", where we would be
better off stopping the operation instead of making the repository
breakage worse by doing further damage.

I originally suspected I'd need to fix the push_to_checkout()
codepath, too, but it turns out that the detection of unborn-ness
of the current branch is also outsourced to the push-to-checkout
hook, so I do not have to do anything special ;-)

 builtin/receive-pack.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index fc8ec9c..758b0b3 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -733,6 +733,13 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
 	return 0;
 }
 
+static int head_has_history(void)
+{
+	unsigned char sha1[20];
+
+	return !get_sha1("HEAD", sha1);
+}
+
 static const char *push_to_deploy(unsigned char *sha1,
 				  struct argv_array *env,
 				  const char *work_tree)
@@ -745,13 +752,15 @@ static const char *push_to_deploy(unsigned char *sha1,
 	};
 	const char *diff_index[] = {
 		"diff-index", "--quiet", "--cached", "--ignore-submodules",
-		"HEAD", "--", NULL
+		NULL, "--", NULL
 	};
 	const char *read_tree[] = {
 		"read-tree", "-u", "-m", NULL, NULL
 	};
 	struct child_process child = CHILD_PROCESS_INIT;
 
+	int empty = !head_has_history();
+
 	child.argv = update_refresh;
 	child.env = env->argv;
 	child.dir = work_tree;
@@ -772,6 +781,9 @@ static const char *push_to_deploy(unsigned char *sha1,
 	if (run_command(&child))
 		return "Working directory has unstaged changes";
 
+	/* diff-index with either HEAD or an empty tree */
+	diff_index[4] = empty ? EMPTY_TREE_SHA1_HEX : "HEAD";
+
 	child_process_init(&child);
 	child.argv = diff_index;
 	child.env = env->argv;

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/6] worktree.c: find_worktree() learns to identify worktrees by basename
Date: Thu, 02 Jun 2016 09:49:53 -0700
Message-ID: <xmqqfusvv8lq.fsf@gitster.mtv.corp.google.com>
References: <20160522104341.656-1-pclouds@gmail.com>
	<20160530104939.28407-1-pclouds@gmail.com>
	<20160530104939.28407-3-pclouds@gmail.com>
	<xmqqh9de5d6e.fsf@gitster.mtv.corp.google.com>
	<CACsJy8CmdTapWsst-PuwFNH8Uy3Vgow+fKWzQ+tGYPSc=aZsXg@mail.gmail.com>
	<xmqqr3cgycjl.fsf@gitster.mtv.corp.google.com>
	<CACsJy8B+j2im7XOV==tBtki=tOCN4k3ZHz6Jp4fq4qjqarb+ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Reto =?utf-8?Q?Habl=C3=BCtzel?= <rethab.ch@gmail.com>,
	Mike Rappazzo <rappazzo@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 18:50:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8VpB-0004In-A2
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 18:50:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161387AbcFBQt6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 12:49:58 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51940 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752431AbcFBQt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 12:49:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6EE0621934;
	Thu,  2 Jun 2016 12:49:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B2gw6RqCXF/fnnDWJ0FuUduISIU=; b=AtqlTG
	7liryUxpS4nhzd3gSftSxARvjsyKFSshNlgcDUVA7+LMdtIpg8jFWNwiu3a6PtLz
	wyolXmqW7LJifyzn8VquAWFvCXeJp3vltO1sGKZIiw+GAG4GlDdiMHicqYRG5J/3
	3S12Z7Zr0649cnm2bEU3Z7Jv2c5pkw/Jp8lYA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AxO8mk2nqJ5ewpEhfsh1paDeY2jui4Ke
	kN/tbsAz0XZeqSdvsSwsG9HNEdRU3jn6igAs8myDr5b5CHckwIktq3cxHpF1mGUA
	ARvuU6bSvqp2I8Qx1GSSZBPOpRF5TFvEXbYMGUEE/8/qTMWJ175lCJbCkqTwm1rH
	PuWrFI6/+pk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 660ED21933;
	Thu,  2 Jun 2016 12:49:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E013721932;
	Thu,  2 Jun 2016 12:49:54 -0400 (EDT)
In-Reply-To: <CACsJy8B+j2im7XOV==tBtki=tOCN4k3ZHz6Jp4fq4qjqarb+ew@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 2 Jun 2016 16:40:35 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 085B2F0C-28E2-11E6-9AB5-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296214>

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Jun 2, 2016 at 1:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> We would
>>> need to convert or match both '/' and '\' in "to/foo" case because of
>>> Windows, so it's not much easier than basename().
>>
>> I never said "easier to implement".  But can this codepath get
>> backslashed paths in the first place?  I somehow thought that
>> normalization would happen a lot before the control reaches here.
>>
>> You'll be calling into fspathcmp() anyway; shouldn't the function
>> know that '/' and '\' are equivalent on some platforms, or is it
>> legal to only call fspathcmp() on a single path component without
>> directory separator?
>
> We still need to calculate the length to compare, which could be
> problematic when utf-8 is involved, or some other encoding. 

Hmph.  I was unaware that fspathcmp() used here does more than
byte-for-byte processing, which would cause problems due to encoding
issues when you hand code the comparison.

+static struct worktree *find_worktree_by_basename(struct worktree **list,
+						  const char *base_name)
+{
+	struct worktree *found = NULL;
+	int nr_found = 0;
+
+	for (; *list && nr_found < 2; list++) {
+		char *path = xstrdup((*list)->path);
+		if (!fspathcmp(base_name, basename(path))) {
+			found = *list;
+			nr_found++;
+		}
+		free(path);
+	}
+	return nr_found == 1 ? found : NULL;
+}


> If we always split at '/' boundary though (e.g. "abc/def/ghi",
> "def/ghi" or "ghi" but never "ef/ghi") then it should be ok.

Does "basename()" used here know '/' and '\' can both be a directory
separator, or does worktree->path have a normalized representation
of the path, i.e. '/' is the only directory separator?

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] resolve_gitlink_ref_recursive(): verify format of symbolic refs
Date: Fri, 27 Jun 2014 10:59:24 -0700
Message-ID: <xmqq61jm2pz7.fsf@gitster.dls.corp.google.com>
References: <1403866877-15733-1-git-send-email-mhagger@alum.mit.edu>
	<xmqqa98y2q8k.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <jens.lehmann@web.de>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Jun 27 19:59:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0aR4-0006dL-2Y
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jun 2014 19:59:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbaF0R7i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 13:59:38 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58055 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750862AbaF0R7h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2014 13:59:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CFFF3228B3;
	Fri, 27 Jun 2014 13:59:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O242YgBCfwcnCWQA0/qTxfjpRyw=; b=fWs3Va
	a+J+UC6SHUK3BHvxiTP0vJ6dZH+l9GE+0RCfxgmcyBhg4kZ6ge3lux9lCv8kTSlr
	YxcvDf8YjQ8wyW/D6RWLoVe1lT6DPMvrCAZd1K8muo5bkoUBcFJJ8VpwXgwuTd0t
	bh4hD67y2RuskuxQlpuE8IqqV5A+j99kronsM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GnXd8CwyvHHg6soA7wFESlzvyZ6mJ/vD
	whozvXPkCA07J89tAqif4gISaMVO9PVF3FzoWROiAU7Ck06/lIesgpFwtBvHnWV7
	XwyqDec87tIISOzlaisXvxug1HNSVPCGm5kvVUDoXGWk/XxFTYaky1c3aPosg9h+
	9ye7T4aCb9Y=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C61D2228B2;
	Fri, 27 Jun 2014 13:59:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C6074228B0;
	Fri, 27 Jun 2014 13:59:17 -0400 (EDT)
In-Reply-To: <xmqqa98y2q8k.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 27 Jun 2014 10:53:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C1FEADE8-FE24-11E3-8AA6-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252566>

Junio C Hamano <gitster@pobox.com> writes:

> Michael Haggerty <mhagger@alum.mit.edu> writes:
>
>> When reading a symbolic ref via resolve_gitlink_ref_recursive(), check
>> that the reference name that is pointed at is formatted correctly,
>> using the same check as resolve_ref_unsafe() uses for non-gitlink
>> references.  This prevents bogosity like
>>
>>     ref: ../../other/file
>>
>> from causing problems.
>
> I do agree that a textual symref "ref: ../../x/y" that is stored in
> ".git/HEAD" or in ".git/refs/L" will step outside ".git/" and it is
> problematic.  But if ".git/refs/heads/a/b/LINK" has "ref: ../../x"
> in it, shouldn't we interpret it as referring to the ref at
> "refs/heads/x"?

Actually, the textual symrefs have been invented to replace symbolic
links used for .git/HEAD on symlink-incapable filesystems, and we do
even not let the filesystem follow symlinks.  The rule we have there
are like so:

		/* Follow "normalized" - ie "refs/.." symlinks by hand */
		if (S_ISLNK(st.st_mode)) {
			len = readlink(path, buffer, sizeof(buffer)-1);
			if (len < 0) {
				if (errno == ENOENT || errno == EINVAL)
					/* inconsistent with lstat; retry */
					goto stat_ref;
				else
					return NULL;
			}
			buffer[len] = 0;
			if (starts_with(buffer, "refs/") &&
					!check_refname_format(buffer, 0)) {
				strcpy(refname_buffer, buffer);
				refname = refname_buffer;
				if (flag)
					*flag |= REF_ISSYMREF;
				continue;
			}
		}

So we should do exactly the same check, I would think, no?

In a typical clone, the ".git/refs/remotes/origin/HEAD" textual
symref stores "ref: refs/remotes/origin/master" and it is neither
"ref: master" nor "ref: ./master", so it should be sensible to
insist on "must start with 'refs/' and its format valid."

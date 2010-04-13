From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Switch receive.denyCurrentBranch to "refuse"
Date: Tue, 13 Apr 2010 10:57:50 -0700
Message-ID: <7vtyrfutep.fsf@alter.siamese.dyndns.org>
References: <cover.1233275583u.git.johannes.schindelin@gmx.de>
 <alpine.DEB.1.00.0901300133070.3586@pacific.mpi-cbg.de>
 <alpine.DEB.2.00.0901291729540.22558@vellum.laroia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Asheesh Laroia <asheesh@asheesh.org>
X-From: git-owner@vger.kernel.org Tue Apr 13 19:58:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1kNJ-0005df-VC
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 19:58:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752838Ab0DMR6E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Apr 2010 13:58:04 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53200 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752038Ab0DMR6B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Apr 2010 13:58:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D874611F9;
	Tue, 13 Apr 2010 13:57:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GORRjnIVLl1GJe07bKNPlxMK3HY=; b=sL3l2t
	kYAELNWZSeSRRMNdfG4lcrSzfdwviS9Gp31j8hNV7eFBL09otCt/+XjnPj2h8IgP
	NTbAme8qjkDo0zugqEDFSFiwlYFBhTIvp2LlK/VomV+PXBt/wpkUxffAAX8cgjkv
	QvcGJaBpzWXQlT1h7n6xJUfUc3BCM4Poplp0U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OeZxhmo9pXthCUH5KtjShsMAhjuWK7/2
	4Qv7Ts10o29r6flmGEFA4ubTlF5kkL5BEnshlndXSgj3vkqJ08qdT2aG2u+++RDf
	OyM3oWRVcmtJY49oGT0if6nlaeRAjV5k4u+G0NUaUd7PnhWsfs9HEcxC9GCIM6/+
	AQxxl32FZEs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A656611F8;
	Tue, 13 Apr 2010 13:57:56 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B12AF11F6; Tue, 13 Apr
 2010 13:57:52 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.00.0901291729540.22558@vellum.laroia.net> (Asheesh
 Laroia's message of "Thu\, 29 Jan 2009 17\:32\:27 -0800 \(PST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 17121F6E-4726-11DF-AD53-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144825>

Asheesh Laroia <asheesh@asheesh.org> writes:

> On Fri, 30 Jan 2009, Johannes Schindelin wrote:
>
>> 	case DENY_REFUSE:
>> +		if (is_bare_repository() || !is_ref_checked_out(name))
>> 			break;
>> +		error("refusing to update checked out branch: %s\n"
>> +			"if you know what you are doing, you can allow it by "
>> +			"setting\n\n"
>> +			"\tgit config receive.denyCurrentBranch true\n", name);
>
> Being told how to do it right is even better than being told that
> you're doing it wrong. (-:

Of course you are correct, but there are two _right ways_ that are
completely different, depending on how the repository you are pushing
into is meant to be used:

 - If you are using it as a shared central repository, a distribution
   point, or a back-up location, you don't need a working tree, and
   as you say, the "checked out branch" condition will not trigger, if
   you made it a bare one.

 - People do wish a way to keep a repository with a checkout, and that is
   often the reason why this codepath is triggered.  They want a checkout
   in the repository (perhaps they are serving the files in them from a
   webserver).  For them, "pushing into it" is not the ultimate goal, but
   "having its working tree and keeping it up-to-date" is.  For that,
   pushing into a "reception branch" and merging that to the checkout from
   the post-update hook is probably the right way (Cf. [*1*] especially is
   "See also ...").

Also I do not think it would help users to suggest "bare repository"
even for the first class of users.

 - If the user knows what a "bare" repository is, the user would realize
   "Hmm, I am not allowed to push to the checked out branch?  Wait, this
   repository does not even need a working tree, so if I make it a bare
   one, I wouldn't have any checked out branch by definition and I
   wouldn't have this issue" without being told.

 - If the user does not know what a "bare" repository is, the user may not
   even realize that the target repository does not have to have a working
   tree.  In such a case, there won't be a mental "click" between "checked
   out" and "bare" anyway.  The added message to suggest "bare" will be
   another line of unintelligible gitspeak in the message to them.


[Reference]

*1* https://git.wiki.kernel.org/index.php/GitFaq#Why_won.27t_I_see_changes_in_the_remote_repo_after_.22git_push.22.3F

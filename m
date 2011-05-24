From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] combine-diff: respect textconv attributes
Date: Tue, 24 May 2011 09:20:53 -0700
Message-ID: <7vk4dg83yy.fsf@alter.siamese.dyndns.org>
References: <20110523201529.GA6281@sigill.intra.peff.net>
 <20110523203105.GE6298@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 24 18:21:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOuM5-0004DT-1Y
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 18:21:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757058Ab1EXQVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2011 12:21:07 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56651 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751936Ab1EXQVF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2011 12:21:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E3E505677;
	Tue, 24 May 2011 12:23:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DPcz4mcL4FCjwoQVNmf1xE0MPpk=; b=ArjMgp
	QpOOAAIACV698BZqbs20MFajjZcmnu47v7q/z+RjHWCMKXTWcDvuDmGle7rr5naK
	Hsl9ojDioo4k6VF2rooPfoe83NAC5Iqyek/+UB5QLRGo42ekVEMRz8TKMPxVJfxh
	2cPn14UJWohrAfN1IDZrjzWhk1K3+ohkqZn6M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GpeuhQGdnAp9jp+YXujhA4gFo8YnqCjc
	Oz6Zfci/Z2sKzGt1V9o+JFwnj6DPEpSzPm6CFb4bmtTTwjbqRsuXSkmDoez0ce0I
	IW3G+2mTQUdQtoSrn2YDZfKzTetIF8P4X63TWyeP21U6BCWduW8EZ+s7R9xFGD8p
	BjjJiE4aR1M=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9E5F15676;
	Tue, 24 May 2011 12:23:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3CB6F5675; Tue, 24 May 2011
 12:23:02 -0400 (EDT)
In-Reply-To: <20110523203105.GE6298@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 23 May 2011 16:31:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1C731986-8622-11E0-8061-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174325>

Jeff King <peff@peff.net> writes:

> This patch converts file contents according to textconv attributes. The
> implementation is slightly ugly; because the textconv code is tightly
> linked with the diff_filespec code, we temporarily create a
> diff_filespec during conversion.

After reading this patch again, I think this aversion to diff_filespec is
probably unjustified.  It is primarily a structure that records what path
has which blob by recording its object name and what mode, and also
in-core data when we make the contents available. There are small diff
specific data associated with it, but that could be separated out if you
really wanted to, perhaps like:

	struct diff_filespec {
        	struct filespec {
			... the generic and essential part ...
                } spec;
                /* diff specific part follows */
                const char *funcname_pattern_ident;
                int xfrm_flags;
                int rename_used;
                unsigned dirty_submodule :2;
                struct userdiff_driver *driver;
                int is_binary;
	};

and let most users use "struct filespec".

If anything else, we should be using the type in _more_ codepaths that are
not diff related but want to represent a path with its contents in the git
namespace (be it from working tree, index or a tree), not less, and in the
longer term weaken functions like fill_textconv() that take diff_filespec
to take filespec so that they can be made more reusable.

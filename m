From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Giving command line parameter to textconv command?
Date: Mon, 14 Dec 2009 21:56:28 -0800
Message-ID: <7vfx7c3hmb.fsf@alter.siamese.dyndns.org>
References: <20091215071735.6117@nanako3.lavabit.com>
 <7vvdg9ceud.fsf@alter.siamese.dyndns.org>
 <20091215121110.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Tue Dec 15 06:56:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKQOr-0007hw-Vz
	for gcvg-git-2@lo.gmane.org; Tue, 15 Dec 2009 06:56:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752176AbZLOF4k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2009 00:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752135AbZLOF4k
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Dec 2009 00:56:40 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46054 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037AbZLOF4j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2009 00:56:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 487C7A7737;
	Tue, 15 Dec 2009 00:56:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3PRo70NC1mPE1Q+tseKzay00qUQ=; b=De6BfL
	RjieVcAD857ftuea1J/0Jo1nIW4b7oK4pvLxWWxypZRHx343dFyzxbUGTsCk1AJn
	1gaeDQifQXV/mX0W9zVARlFI9C1xqdvXb0X/moSBqKV2X/xCT+8vGN9ghcJeg+ck
	/8KhEX+iTnOU5V8wJ9me0TKHxcUMQj2gNlTZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x0L3yZk0EcJuU4xXCQyjT4uXLHti58e2
	I3oitnNVqpCmXzhixwfjo3MPhNH+htWfSuk8GccSdH2EK2iQj/eMds0Sk6oDZF/R
	Vz5o/dbEk/guh9uzDiyDB8Nk2Tt5/qsDUjY0sU+2yKNaW7+kvyknZX+3Go5HQ/Xq
	zQsewJgzu9s=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 165DBA772E;
	Tue, 15 Dec 2009 00:56:34 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DA2C8A7720; Tue, 15 Dec 2009
 00:56:29 -0500 (EST)
In-Reply-To: <20091215121110.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Tue\, 15 Dec 2009 12\:11\:10 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 99840B2E-E93E-11DE-9E79-B34DBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135271>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> I experimented with other variables (eg. smudge and clean) and 
> they honor their command line arguments. If textconv is the only 
> setting that doesn't, the change may be easier to justify.

Yes, as you found out, convert.c::apply_filter() is aware of the command
line arguments.

Let's try to do a bit more work to make the coverage complete.  After
scanning "git grep -e start_async -e run_command" output, here is what I
came up with:

 - editor.c::launch_editor() that allows a custom editor named via
   GIT_EDITOR does seem to honor your command line arguments.

 - pager.c::setup_pager() is used for GIT_PAGER and it does honor your
   command line arguments.

 - ll-merge.c::ll_ext_merge() that is used to handle custom merge drivers
   lets the user specify command line via templating to replace %O %A %B
   and naturally it needs to be aware of the command line arguments.

 - diff.c::run_external_diff() that runs GIT_EXTERNAL_DIFF defines that
   the command has to take 7 parameters in a fixed order, and is not
   designed to permute its arguments like ll_ext_merge() does, but these
   days people don't use it directly (they use it indirectly via
   "difftool" wrapper), so it probably is not an issue.

 - merge-index.c::merge_entry() also defines a strict order and semantics
   to its parameters, but similar to GIT_EXTERNAL_DIFF, it is not
   something you would throw a ready-made program (like an editor or an
   pager) and expect it to work, so it wouldn't be an issue either.

Hooks do not even take arbitrary command line arguments, so we don't have
to worry about them.

So it does look like that textconv is the only odd-man out.

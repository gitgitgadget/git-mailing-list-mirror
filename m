From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFD] git update-index --remove frotz --add frotz expected
 behaviour?
Date: Thu, 24 Mar 2011 11:28:24 -0700
Message-ID: <7vy6448jav.fsf@alter.siamese.dyndns.org>
References: <4D8B7A6D.5050801@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakob Pfender <jpfender@elegosoft.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 19:28:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2pH2-0006If-8g
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 19:28:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933305Ab1CXS2i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2011 14:28:38 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54554 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933023Ab1CXS2i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2011 14:28:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CB8964800;
	Thu, 24 Mar 2011 14:30:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mZh9oyqVpgQPduU51z9q/PibpjE=; b=KANHaw
	HFhOb0cz6K3ICn6LLqXwQ0MklW2ajDtE16JHSYiROkB/Tw/5P0feviWM12dsQqzR
	tgINcypg9tHJAOwhJ/FpqXVVN/s4MmQCnrQywRGGSHlohFtyySiGUAE9ByDcwwPB
	0czWv3Er65mXD/wpqKvmm+hc/d2juUzLlq6tk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FezKPFbuPR9JO3tgqvukIpMFscFrDlUs
	UflDsvu8xjlkJAsI0r8kcI6RrcrVvv9Eh2wkb/Tm+ABtIGFqaVVqONfeoNcBhfn8
	Dy1A+3ObVNKWfLB0GKsMfI1/E3mKwRVnjkFEcTUjoLGtY7mM82txsm4yW4OumMqZ
	PCsCnsmx14k=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A965747FD;
	Thu, 24 Mar 2011 14:30:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C721A47FB; Thu, 24 Mar 2011
 14:30:08 -0400 (EDT)
In-Reply-To: <4D8B7A6D.5050801@elegosoft.com> (Jakob Pfender's message of
 "Thu, 24 Mar 2011 18:07:57 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C18CD05A-5644-11E0-84B8-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169936>

Jakob Pfender <jpfender@elegosoft.com> writes:

> I'm a bit stumped by update-index' behaviour when calling --remove and
> --add on the same file in that order:
>
> $ touch frotz
> $ git update-index --add frotz
> $ rm frotz
> $ git status -s
> AD frotz
> $ git update-index --remove frotz --add frotz

This falls into "if it hurts, don't do that" category.  The canonical
order of command line parameters is to have --options first and then
revisions and finally pathspecs.  update-index does not take any revs, so
you would be saying "git update-index --add --remove frotz".

For historical reasons, "update-index" never adds paths that are not
already in the index unless you tell it that it is Ok to do so with
"--add" option.  Also it does not remove without "--remove" even after you
removed the paths from your working tree.  The important point to note
here is that these two options only tell the command it is allowed to add
or remove the path from the index, and what happens solely depends on what
you have in the working tree.

If you do have Makefile and Rakefile already in the index, and if you only
have Makefile and Nakefile in the working tree,

    $ git update-index Nakefile

will error out because you didn't allow the command to add a new path to
the index by giving --add,

    $ git update-index Rakefile

will error out because you didn't allow the command to remove an existing
path from the index by giving --remove.  As an obvious consequence:

    $ git update-index --add --remove {M,N,R}akefile

will reflect the state of these three paths in the working tree to the
index.  It won't leave Rakefile in the index _only_ because you don't have
it in the working tree (and you allowed the command to remove it by giving
the --remove option); "--add" on the command line is _not_ an instruction
to "add" (implying that the command should error out because it cannot add
that which does not exist), it merely is a permission to the command.

And this is not going to change.

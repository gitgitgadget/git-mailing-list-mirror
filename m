From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug Report: Creating a hardlink to any of the file in git repo
 cause the source file  to show up in git commit message editor under "Changes
 not staged for commit" section.
Date: Mon, 18 Jul 2011 11:37:53 -0700
Message-ID: <7vwrffjuym.fsf@alter.siamese.dyndns.org>
References: <02a20a168c52beb42e57258bcc5c0551@mail.mxes.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Michael who\?\?" <git-scm@webhippo.net>
X-From: git-owner@vger.kernel.org Mon Jul 18 20:38:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qishf-0001Rh-HK
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 20:38:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263Ab1GRSh7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 14:37:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42969 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750945Ab1GRSh6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 14:37:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D3194258;
	Mon, 18 Jul 2011 14:37:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z6thrbBOVHAXEFvKupsIqWnGwP4=; b=AeJ/Lw
	np11NzIbocprd4FVaoGf3OOgmvW98E52Cah3EDTUf/SwhUlIMsa5tZ/N6NCXAf4s
	CiA53yq3mPkfcMiX8iJTpTfsimwqQLlQGLwOdjzfXA1FUJ9cTh6F70d7djngjStO
	zKvOs80yN9zeZQxuFdtbeZhD2CQK8W1Dl8XSk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FVlom82XHqMbx55UpwBNTwMvr4RpIZzU
	jg2t5M/QVM7WwkNIE6nsBxVyVbxhGB6PmxKD3Vn/FGq0tXbX5jr93Ji/JbUCbawc
	dwuC2+MAR+MgvJAOIoPYobkBc7SghnJhQKBq+TlI24PTLHN/nWzPW3UdPbmTGff+
	+lImHcWU+p4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 648E74257;
	Mon, 18 Jul 2011 14:37:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D96584256; Mon, 18 Jul 2011
 14:37:54 -0400 (EDT)
In-Reply-To: <02a20a168c52beb42e57258bcc5c0551@mail.mxes.net> (Michael's
 message of "Sun, 17 Jul 2011 20:42:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0D038B86-B16D-11E0-9442-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177396>

Michael <git-scm@webhippo.net> writes:

> echo "ln -vf FILE2 ../HARDLINK_TO_FILE2" >| .git/hooks/pre-commit
> echo "rm -vf ../HARDLINK_TO_FILE2" >> .git/hooks/pre-commit
> echo "ln -vf FILE3 ../HARDLINK_TO_FILE3" >> .git/hooks/pre-commit
> echo "rm -vf ../HARDLINK_TO_FILE3" >> .git/hooks/pre-commit

This does not have to do anything with hardlink. A simple "touch" should
do as long as FILE2/FILE3 are sufficiently old.

You are smudging cached stat information in your pre-commit hook (st_ctime
would be different), and that is shown as a difference between the working
tree and the index (note that nowhere in githooks documentation we say
pre-commit hook is allowed to muck with the working tree files). I think
we do refresh the cached stat information before running the pre-commit
hook so that the hook can check the list of working tree files that are
different from the index using diff-files, but the purpose of the said
hook is to validate, and not affect, the state of the working tree, and I
wouldn't be surprised if we do not update the cached stat information
after the hook returns control to us.

If you really want to munge the working tree inside pre-commit, I think
adding "git update-index --refresh" at the end of pre-commit hook would
make the phantom change go away.

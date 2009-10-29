From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 2/2] Provide a build time default-editor setting
Date: Thu, 29 Oct 2009 15:12:01 -0700
Message-ID: <7vfx916ea6.fsf@alter.siamese.dyndns.org>
References: <1256742357-sup-3798@ntdws12.chass.utoronto.ca>
 <4AE98175.504@viscovery.net> <7viqdy6ii1.fsf@alter.siamese.dyndns.org>
 <200910292157.37474.j.sixt@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	David Roundy <roundyd@physics.oregonstate.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ben Walton <bwalton@artsci.utoronto.ca>,
	GIT List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Oct 29 23:12:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3dEJ-00004y-Mo
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 23:12:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755056AbZJ2WMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 18:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753465AbZJ2WMP
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 18:12:15 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36293 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898AbZJ2WMO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 18:12:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C4F516CEC7;
	Thu, 29 Oct 2009 18:12:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ql0xVeXfggx9dMzu12Q5Fe3ftXk=; b=WFRJFQ
	e+LyjZxwiaG0vnN9JkTI8K9o4u3VLX1nonocjvAKGkXHCij8dJuOS/jc2l6ucpsb
	NHTZt6gZCLdyj/fRpwUq73jGqYcrSA1vSO+tRvJqWix4+UuoxiKdcF99NzK8W7D1
	82Sad+aBWWEpqm4ikIx0LxZVTHnhfbe0Ff5o4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NjATrzEzSwf6g0Adm0N1MlS1Agh5Pkid
	txBQpMDBg7SmIr7pX+u6IUpc7IDOs29sUnRL9yr6n9qVFXBOMUBiXxG0KuQPq8Ux
	AZak5/P48d4D2GVfuPx5HH6JzFZF6fImyC3dn8zJbTTk8AzrWWeV/xROMS4q/do/
	WzAZYVqqB3k=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D1446CEC6;
	Thu, 29 Oct 2009 18:12:12 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A263A6CEC5; Thu, 29 Oct
 2009 18:12:03 -0400 (EDT)
In-Reply-To: <200910292157.37474.j.sixt@viscovery.net> (Johannes Sixt's
 message of "Thu\, 29 Oct 2009 21\:57\:36 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1BB9CD8A-C4D8-11DE-8E1D-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131661>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Yeah, whatever, I didn't take the time to think it through. But this may be an 
> opportunity to give some life back to the zombie that git-var currently is, 
> that is, to make it the plumbing that does value discovery for variables like 
> GIT_AUTHOR_INDENT, GIT_COMMITTER_IDENT, GIT_EDITOR, and perhaps also 
> GIT_PAGER.

Hmm, wouldn't it make even more sense to "run" them for the calling
Porcelain script?

A shell script Porcelain can already ". git-sh-setup" and say

	git_editor this-file

when it needs to spawn the editor of choice.  Your new plumbing support
could make the definition of git_editor in git-sh-setup.sh into something
like:

    git_editor() {
    	git var --run GIT_EDITOR "$@"
    }
    git_pager() {
    	git var --run GIT_PAGER "$@"
    }

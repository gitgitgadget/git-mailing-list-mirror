From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/WIP PATCH] Use config value rebase.editor as editor when
 starting git rebase -i
Date: Tue, 11 Oct 2011 11:37:55 -0700
Message-ID: <7vipnvfk70.fsf@alter.siamese.dyndns.org>
References: <201110111956.08829.kumbayo84@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Oberndorfer <kumbayo84@arcor.de>
X-From: git-owner@vger.kernel.org Tue Oct 11 20:38:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDhDX-0005gi-6n
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 20:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755651Ab1JKSiA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Oct 2011 14:38:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33889 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755409Ab1JKSh6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2011 14:37:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 925F16415;
	Tue, 11 Oct 2011 14:37:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hkxsnoUkr8EIykzyd7r37Y+f9QY=; b=uiminM
	aRJ1tH79Cg7cSsyLSRXj+8pccXJn+s5ACyZ7+K2+o/zIWQ2+iu3T/+FtXVkHSjSO
	5Z02AntHQMolLwqToIxQejnD14WLoajBg7Bd7CXpeEx5DgCgkkF4b+xUyqMlj6cA
	ktXThooyT8PgQqGNovGJha29K1AD2/8V+SzXo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I0ha8+L7JY+NiXF5aa+SAdRdR9Zje55r
	9LrIp8jza3l9xFEQBqXB/GshxKOi7Ryl2/s5B6fPq1c8vYHjJXo79a899fPgjU7i
	Hem5NbhkQmx806OHV2hH6leqaHCiknnRxFXzBuVIozNPHfVSgrCIKOd3wN5vf8rM
	sEA/dTn1a7g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 889556413;
	Tue, 11 Oct 2011 14:37:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1BB9C6411; Tue, 11 Oct 2011
 14:37:57 -0400 (EDT)
In-Reply-To: <201110111956.08829.kumbayo84@arcor.de> (Peter Oberndorfer's
 message of "Tue, 11 Oct 2011 19:56:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 23739F2E-F438-11E0-B684-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183319>

Peter Oberndorfer <kumbayo84@arcor.de> writes:

> Using $GIT_EDITOR or core.editor config var for this is not possible
> since it is also used to start the commit message editor for reword action.

Your tool _could_ be smart about this issue and inspect the contents to
launch a real editor when it is fed a material not for sequencing, but
that feels hacky.

> * GIT_EDITOR env var is not honored anymore after this change.

Care to explain?  "git var" knows magic about a few variables like
GIT_EDITOR and GIT_PAGER.

	$ git config core.editor vim
	$ GIT_EDITOR=vi EDITOR=emacs git var GIT_EDITOR
        vi
	$ unset GIT_EDITOR; EDITOR=emacs git var GIT_EDITOR
        emacs

> * Should git_rebase_editor be in git-rebase--interactive.sh instead

Probably yes.

> * How should the config be called?

Given that in the longer term we would be using a unified sequencer
machinery for not just rebase-i but for am and cherry-pick, I would advise
against calling this anything "rebase".  How does "sequence.edit" sound?

You need to be prepared to adjust your code to deal with new kinds of
sequencing insns in the insn sheet and possibly a format change of the
insn sheet itself.

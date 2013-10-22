From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFE: support change-id generation natively
Date: Tue, 22 Oct 2013 12:50:31 -0700
Message-ID: <xmqqy55lrsoo.fsf@gitster.dls.corp.google.com>
References: <2127507934.9293293.1382367063640.JavaMail.root@openwide.fr>
	<201310212029.01589.thomas@koch.ro>
	<1382380858.25852.36711509.53CF173C@webmail.messagingengine.com>
	<201310211249.49568.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: james.moger@gitblit.com, Thomas Koch <thomas@koch.ro>,
	Jeremy Rosen <jeremy.rosen@openwide.fr>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Tue Oct 22 21:50:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYhyR-00049c-5P
	for gcvg-git-2@plane.gmane.org; Tue, 22 Oct 2013 21:50:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754387Ab3JVTuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Oct 2013 15:50:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54644 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754046Ab3JVTue (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Oct 2013 15:50:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 11DB64C902;
	Tue, 22 Oct 2013 19:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KZMlMg4WD0M28lmEvad8WHjS72A=; b=nL1/TL
	kpeYT0fh/mFJMxk+APguvGTKk+5a2bu4g8cU643QQYjSABCn3F5ZeKXnAs3m8yZV
	axYLrZo4QeDwcUStkCQdnp9G/Q5X2tLjfCYyMQfiQ7Jcr3t5GjrIsZpA3VwOczvI
	u2BiMdnNixnYkmhMnOEj3rpNKBeTpj9mHyHfI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wtYz221+VsebC+0N3e/Uj3clWCJPIO5V
	sllPUeX1tWog4oc4HINusDnVUAWvS20qR6CLD/HeieJUk58DtPvPZC4dmbSkzaSG
	j0RzDDT07hjl22B8mha3W7oR0SOv/cxbqtd0sPIGhuTZ74Yz5upRZKWK09iK7jga
	AWV9GB3b1jw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EC4D84C900;
	Tue, 22 Oct 2013 19:50:33 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4D3994C8FF;
	Tue, 22 Oct 2013 19:50:33 +0000 (UTC)
In-Reply-To: <201310211249.49568.mfick@codeaurora.org> (Martin Fick's message
	of "Mon, 21 Oct 2013 12:49:49 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3675CEB2-3B53-11E3-84D8-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236485>

Martin Fick <mfick@codeaurora.org> writes:

> As a Gerrit maintainer, I would suspect that we would 
> welcome a way to track "changes" natively in git.

I would suspect that we would not mind "git commit --change-id" (and
probably "git commit-tree --change-id") option that can be used to
tell the command to add a new Change-Id: trailer at the end, if and
only if there is none in the log message to be recorded (this needs
to happen after the user possibly edits).  We may even want to
introduce commit.changeId boolean configuration variable if we did
so.

"git commit --amend", "git rebase", etc. can be left oblivious to
the "Change-Id:" trailer, as the default mode of operation you guys
want is to leave the existing one as-is, unless the end user really
wants to change it, I think.

It would be just the matter of updating commit_tree_extended() in
commit.c to:

 - detect the need to add a new Change-Id: trailer;

 - call hash_sha1_file() on the commit object buffer (assuming that
   a commit object that you can actually "git cat-file commit" using
   the change Id does not have to exist anywhere for Gerrit to
   work---otherwise you would need to call write_sha1_file()
   instead) before adding Change-Id: trailer;

 - add Change-Id: trailer to the buffer; and then finally

 - let the existing write_sha1_file() to write it out.

I would think.  You might have a funny chicken-and-egg problem with
the signed commit, though.  I didn't think that part through.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-commit.txt: clarify -t requires editing message
Date: Thu, 29 Mar 2012 22:08:14 -0700
Message-ID: <7vehsaoev5.fsf@alter.siamese.dyndns.org>
References: <CAF_oF=xGHdbkYw-ytvcZvJnqZ_jdckUCBiuUDzkqGDk=66+yMQ@mail.gmail.com>
 <1333062296-27823-1-git-send-email-haircut@gmail.com>
 <7vboneq1vs.fsf@alter.siamese.dyndns.org> <4F75236C.4050703@gmail.com>
 <7vr4waoics.fsf@alter.siamese.dyndns.org> <4F753C3F.7010805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ivan Heffner <iheffner@gmail.com>
To: Adam Monsen <haircut@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 07:08:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDU4W-0002Sc-NB
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 07:08:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461Ab2C3FIU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 01:08:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44275 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750731Ab2C3FIS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 01:08:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FFAB6E75;
	Fri, 30 Mar 2012 01:08:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Krw3kxC+Xhbw/SNm5qqg5WD42HQ=; b=PuZJTs
	w+WnthyqDrIE3GdKETnBaObbn8/YlNmg1Q9gfmKvlRWqDrZB46ADRjiZ48O8VlnZ
	cpdsMflvxOF0nCGw9O8/odwmrNXmFppaXs3FnAqa2D6KMTd1bL6YySrSXKPPq7vb
	9NQXWblJhfD/aCmPhETJg8D+jPvWB1EqCps1E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UPDYsU3gfAULJVwwe+TRLJMBmweeWumS
	rxC6bJR9aaNXfnA70q0HbRJPhABkgxn85u+YYsh2JpvFRfSscskbelXiohUrDjIb
	OczV9FTp3ZW0fduq+X06x44q95OoP4dfVYj45QQmvoMUtc97MewOUSYPCOajIh3f
	3mmQdI6qdxg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 974426E74;
	Fri, 30 Mar 2012 01:08:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2FDDE6E73; Fri, 30 Mar 2012
 01:08:16 -0400 (EDT)
In-Reply-To: <4F753C3F.7010805@gmail.com> (Adam Monsen's message of "Thu, 29
 Mar 2012 21:53:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5B9BAECC-7A26-11E1-AE7A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194326>

Adam Monsen <haircut@gmail.com> writes:

> I *cannot* just save and quit my editor (unless I supply
> --allow-empty-message). That's the behavior I find confusing...

The root cause of the confusion is that the entire "--template" code piggy
backs on the non-templated case, where we would want to error out if the
user leaves the editor without explaining the commit. And an appropriate
diagnosis message for the "normal" case is "you gave me an empty message",
but "--template" code did not bother updating that to suit what it tries
to do better, e.g. "you did not edit the template I gave you".

The check to see if the message the user left matches that came from the
template was tacked into a wrong function message_is_empty(); it should be
made into its own helper function and called from the same caller where
it calls message_is_empty() only when template_file is not NULL.  Also its
honoring "--allow-empty" needs to be reconsidered.

In other words, I think that is something that needs fixing the broken
code to behave less confusingly, not documenting its wrong behaviour.

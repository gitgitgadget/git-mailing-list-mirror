From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] Teach git var about GIT_EDITOR
Date: Sat, 31 Oct 2009 21:29:43 -0700
Message-ID: <7vocnm3m14.fsf@alter.siamese.dyndns.org>
References: <20091030101634.GA1610@progeny.tock>
 <20091031012050.GA5160@progeny.tock> <20091031013934.GD5160@progeny.tock>
 <7vk4yccodl.fsf@alter.siamese.dyndns.org>
 <20091031022347.GA5569@progeny.tock>
 <7vws2cb8bp.fsf@alter.siamese.dyndns.org>
 <20091031040003.GA6022@progeny.tock> <20091031040436.GB6022@progeny.tock>
 <20091031045358.GA9565@progeny.tock> <20091031075627.GB635@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Walton <bwalton@artsci.utoronto.ca>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Roundy <roundyd@physics.oregonstate.edu>,
	GIT List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 01 05:30:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4S4r-00050N-Ja
	for gcvg-git-2@lo.gmane.org; Sun, 01 Nov 2009 05:30:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbZKAE3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2009 00:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbZKAE3y
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Nov 2009 00:29:54 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35479 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbZKAE3y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2009 00:29:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E4D76F19E;
	Sun,  1 Nov 2009 00:29:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=R5qgb07VHPEMnOtpx3sKGewZihI=; b=P+vYd7DsoCcjOVAPdHZGe64
	jaZbSS9YUEEb1QyVa5+SP5sAttgmREldudf+5TlC8KpIW8KBkRC20NXMnVt2cp8R
	ks0+WZPnYlUA7SCUXZZoZJiBuy8+AGP0Pv1WRkgs3LnKv9nUvsig4hA9UIW0ugWq
	4RNTvgKA6S8W2xMCxYkY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=EZpSATE8a2MVqHXjnrDlBymcVBir5auQGG76tcCq1/zBJAld6
	Ze9HcDQmvoWcyz2Qoak0ebXxcGzzNLpjMHZG1cf+iIkkUuEvAimocWJAh2ivWqG4
	MQeQ0XgDcnZ+XEIZ0wghnnBi8op+lLQ7w3eEW3QXgeRv5URvtWO2V0aMaE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EC91A6F19D;
	Sun,  1 Nov 2009 00:29:50 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D22696F19A; Sun,  1 Nov
 2009 00:29:44 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 320B5CF2-C69F-11DE-AE4E-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131865>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Expose the command used by launch_editor() for scripts to use.
> This should allow one to avoid searching for a proper editor
> separately in each command.

Ok, so the idea is...

 * git_editor(void) uses the logic to decide which editor to use that used
   to live in launch_editor().  The function returns NULL if there is no
   suitable editor; the caller is expected to issue an error message when
   appropriate.

 * launch_editor() uses git_editor() and gives the error message the same
   way as before when EDITOR is not set.

 * "git var GIT_EDITOR" gives the editor name, or an error message when
   there is no appropriate one.

 * "git var -l" gives GIT_EDITOR=name only if there is an appropriate
   editor.

The above all look sensible, but IIRC, the true "vi" fell back on "ex"
mode on dumb terminals and was usable as a line editor, so we should be
able to run it even on dumb terminals.  I do not know about vi-clones
though.

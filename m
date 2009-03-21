From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Respect core.autocrlf when preparing temporary files for
 external diff
Date: Sat, 21 Mar 2009 12:35:36 -0700
Message-ID: <7vocvuekjb.fsf@gitster.siamese.dyndns.org>
References: <cover.1237635609u.git.johannes.schindelin@gmx.de>
 <8cb424b16f21164ddc26d0be3f6f7727254b3506.1237635609u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sebastian Schuberth <sschuberth@gmail.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 21 20:37:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ll70N-0006fG-QH
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 20:37:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753107AbZCUTfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 15:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753034AbZCUTfo
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 15:35:44 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51409 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752914AbZCUTfn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 15:35:43 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 9F28B8D4C;
	Sat, 21 Mar 2009 15:35:41 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 08D958D4A; Sat,
 21 Mar 2009 15:35:37 -0400 (EDT)
In-Reply-To: <8cb424b16f21164ddc26d0be3f6f7727254b3506.1237635609u.git.johannes.schindelin@gmx.de> (Johannes Schindelin's message of "Sat, 21 Mar 2009 12:42:52 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 76A4AE6E-164F-11DE-95EC-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114053>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> When preparing temporary files for an external diff, the files should be
> handled as if they were worktree files.

I do not think so.  convert_to_working_tree() aka "smudge" means you would
be feeding crap like $Id$ expansion to the external diff, which we chose
not to do quite on purpose.

I think the right solution is to filter inside GIT_EXTERNAL_DIFF *if* the
diff tool you are dispatching into from the external diff script wants to
take smudged representation.  I know we don't have such a command right
now, but something like

	git filter --take-attr-for-path=$path --direction=out <clean >smudged
	git filter --take-attr-for-path=$path --direction=in >clean ><mudged

to invoke convert_to_working_tree() and convert_to_git() filters would be
sufficient.

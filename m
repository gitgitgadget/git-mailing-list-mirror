From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] remote: minor code cleanups in preparation for
 changing "show" output
Date: Thu, 19 Feb 2009 23:19:45 -0800
Message-ID: <7vbpsxh8xa.fsf@gitster.siamese.dyndns.org>
References: <1235020471-59982-1-git-send-email-jaysoffian@gmail.com>
 <1235020471-59982-2-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Marc Branchaud <marcnarc@xiplink.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 08:21:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaPhO-0002n1-JB
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 08:21:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323AbZBTHT6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 02:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752081AbZBTHT6
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 02:19:58 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63957 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412AbZBTHT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 02:19:57 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2AB269B078;
	Fri, 20 Feb 2009 02:19:55 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 460E99B077; Fri,
 20 Feb 2009 02:19:47 -0500 (EST)
In-Reply-To: <1235020471-59982-2-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Thu, 19 Feb 2009 00:14:28 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DF4DF710-FF1E-11DD-866B-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110806>

Jay Soffian <jaysoffian@gmail.com> writes:

> * Rename char *remote to remote_name to distinguish it clearly from the
>   struct remote pointer, also named remote.
>
> * There is no need to call sort_string_list() on branch_list, as its
>   items are added to it via string_list_insert() which maintains its
>   order.
>
> * Sort states->new and states->tracked so that we can use binary search
>   string_list_has_string() on them instead of less efficient linear
>   unsorted_string_list_has_string. This alters the output of "remote
>   show" slightly, so update the tests to match.
>
> * Simplify get_ref_states(); nothing is using the pointer to states that
>   is being copied into util.
>
> * Have get_remote_ref_states() populate states->tracked even when it is
>   not querying the remote so that this need not be done by the caller.

This does too many things in a single patch.

Ideally this would have been four patches for reviewability:

 - one "trivial and obviously correct bits" (s/remote/remote_name/ and
   removal of sort_string_list(&branch_list)) patch;

 - the change for states->{new,tracked}, should stand on its own; I think
   the reordering of the output should be described much better and
   defended independently.  "Earlier it was sorted by this order, which
   did not make sense for such and such reasons; this fixes the logic to
   sort the list by the name of the tracked branch, which makes it easier
   to read", or something like that.

 - change to the states->tracked population rule; and

 - get_ref_states() to lose the util bit.

It probably is Ok to squash the last two, though.

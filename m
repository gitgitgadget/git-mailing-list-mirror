From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add -p: skip conflicted paths
Date: Wed, 04 Apr 2012 14:31:56 -0700
Message-ID: <7v62df89pv.fsf@alter.siamese.dyndns.org>
References: <1332966017-6100-1-git-send-email-kusmabite@gmail.com>
 <7viphotng8.fsf@alter.siamese.dyndns.org>
 <7vaa30tmk9.fsf@alter.siamese.dyndns.org>
 <7v62dotltk.fsf@alter.siamese.dyndns.org>
 <20120329054558.GA27604@sigill.intra.peff.net>
 <CABPQNSY8gNPZTV77AjFbHn1HA9S=fw3NC+H8bCzZOPFyLg0nHQ@mail.gmail.com>
 <7v398mgfdu.fsf@alter.siamese.dyndns.org>
 <20120404094618.GA13870@sigill.intra.peff.net>
 <7v398jbjbo.fsf@alter.siamese.dyndns.org>
 <7vty0z8i66.fsf@alter.siamese.dyndns.org>
 <20120404202527.GA1363@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kusmabite@gmail.com, git@vger.kernel.org,
	matthieu.moy@grenoble-inp.fr, hellmuth@ira.uka.de
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 04 23:32:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFXoD-000109-DI
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 23:32:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753173Ab2DDVcA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 17:32:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37731 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752771Ab2DDVb7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 17:31:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 122C93A72;
	Wed,  4 Apr 2012 17:31:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wfdsJFsvkt0sNYHU+XpxvnJuBME=; b=Ie8j86
	LdV/mCh3wztR0KFxDZ9QDPzpzWJyi8+KpKb6/nAiSuZAlT33zCmRYIsCJuYAf5O2
	lNbwN1cUVCeHehM3TGFePrmZ5KphvoXxqrTu4s6F4V1ZEHCJhktG8qGuPjKBxUUX
	MCyDjbZGIpuhV4SiXcQHu7OHo/8IvcagBqcn0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GeNkeBq3XUSiKUNcsBrXV4j9a/HGZnKq
	HxTZ9YrTBm6dxotrDamaQwYb8f5VRzf7xrDDq+3gf6MZJ9/CWBQelDXTIS+lPYjk
	vhubNDsYw6hY17rAZ3UVoyVdiMxdCa6lFSye9qszaumJxdK/VSg7ANmz/sg/vrkX
	r88e76bQl/w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 099283A71;
	Wed,  4 Apr 2012 17:31:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 937293A70; Wed,  4 Apr 2012
 17:31:58 -0400 (EDT)
In-Reply-To: <20120404202527.GA1363@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 4 Apr 2012 16:25:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9BC4BD60-7E9D-11E1-8128-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194745>

Jeff King <peff@peff.net> writes:

> Yes, this is way better. I don't mind discarding the --raw entries that
> are not used; they cost nothing to generate on top of what we are
> already doing, so it is really just the cost of shuttling a few bytes
> across the pipe.
>
>> -	for (run_cmd_pipe(qw(git diff-files --numstat --summary --), @tracked)) {
>> +	for (run_cmd_pipe(qw(git diff-files --numstat --summary),
>> +			  ($note_unmerged ? ("--raw") : ()),
>> +			  "--", @tracked)) {
>
> Maybe it is not worth even having $note_unmerged, and just filling in
> the UNMERGED field unconditionally? I know other callers don't care
> about the information, but it's so cheap, and it just makes the function
> interface that much simpler.

Perhaps.  Care to do the honors of rolling the final version perhaps with
a test?

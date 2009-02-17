From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/8] config: Use parseopt.
Date: Mon, 16 Feb 2009 18:24:25 -0800
Message-ID: <7vbpt1by1y.fsf@gitster.siamese.dyndns.org>
References: <1234832094-15541-1-git-send-email-felipe.contreras@gmail.com>
 <1234832094-15541-2-git-send-email-felipe.contreras@gmail.com>
 <1234832094-15541-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 03:26:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZFf3-0004Ji-9Q
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 03:26:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715AbZBQCYc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 21:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751685AbZBQCYc
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 21:24:32 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49539 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592AbZBQCYb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 21:24:31 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 23BE02B4A1;
	Mon, 16 Feb 2009 21:24:31 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E37AC2B4A0; Mon,
 16 Feb 2009 21:24:26 -0500 (EST)
In-Reply-To: <1234832094-15541-3-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Tue, 17 Feb 2009 02:54:49 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1BB9BE28-FC9A-11DD-813E-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110295>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> +	if (HAS_MULTI_BITS(actions)) {
> +		error("only one action at a time.");
> +		usage_with_options(builtin_config_usage, builtin_config_options);

My initial reaction was:

	Can we easily say "--get and --getall are mutually incompatible"?

and knowing that it would take much more code, the second reaction was:

	Does the user know what we mean by "action"?

Since the answer to this is "Yes, the usage message comes from parseopt
and there is a clear categorization", I think the message is good enough.

What happens when the user says "config --get --get-colorbool user.name"?
Is it an error?  Is it diagnosed as an error?

It probably is easy to fix it by defining two bits of fake actions and do:

	if (get_color_slot)
        	actions |= ACTION_GET_COLOR;
	if (get_colorbool_slot)
        	actions |= ACTION_GET_COLORBOOL;

immediately before this HAS_MULTI_BITS check.

I know I suggested these to are type-like, but I realize that these two
are better categorized as actions tied to a specific type (color), as you
had in your earlier round.

> +	if (actions == 0)
> +		switch (argc) {
> +		case 1: actions |= ACTION_GET; break;
> +		case 2: actions |= ACTION_ADD; break;
> +		case 3: actions |= ACTION_REPLACE_ALL; break;

Straight assignment, not ORing-in please.  It wastes a few seconds from
the reader wondering what other bits in the variable "actions" are used
for things other than ACTION_* (the answer is none).

Similarly, later conditions:

> +	if (actions & ACTION_LIST) {

would read better if they used equality == checks.

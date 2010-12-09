From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] diffstat: Use new diffstat config values
Date: Wed, 08 Dec 2010 21:54:07 -0800
Message-ID: <7vwrnjh4ow.fsf@alter.siamese.dyndns.org>
References: <7vzksr280s.fsf@alter.siamese.dyndns.org>
 <1291776263-16320-1-git-send-email-matthew.ruffalo@case.edu>
 <1291776263-16320-2-git-send-email-matthew.ruffalo@case.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthew Ruffalo <matthew.ruffalo@case.edu>
To: mmr15@case.edu
X-From: git-owner@vger.kernel.org Thu Dec 09 06:54:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQZSg-0005YL-Hz
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 06:54:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751807Ab0LIFya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 00:54:30 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38625 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321Ab0LIFy3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 00:54:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 68F0823B9;
	Thu,  9 Dec 2010 00:54:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dmxxyI9lOvMs9MCSEi7tXHtS9Ys=; b=mNtg+G
	ZkbNfRj5MIvGjwf5WHX69fQ3TLf7fkvqi4zG0iExavdab4D1ovt93YYRj34nhmjv
	gk8L8ZCHOzRLoBZim8SDYbADRktu51tfKCvsKBUz+9Rovl0NirxIAS90+amnfBJv
	oMPuPQIUapTWbYdQ8QjwErJMGzj3GRh+2tel0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vvi1I0t+zrCSD5fIGMftZ/WSCKp73Kus
	vgKEMEKzdhr1PN89KR8LQoPOzHIWDbKBoAn2O2nFXNbvJCv9E8LP8m/p7WnLm478
	TA9bck+JsIvASIG/Wk50jGx2wTvsXg2dJKrIKa+u7MIqaL30nOmNd28lTDicNBZQ
	tXxzIochp0k=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3626C23B8;
	Thu,  9 Dec 2010 00:54:47 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 71E6B23B5; Thu,  9 Dec 2010
 00:54:40 -0500 (EST)
In-Reply-To: <1291776263-16320-2-git-send-email-matthew.ruffalo@case.edu>
 (mmr's message of "Tue\,  7 Dec 2010 21\:44\:22 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D41D8D7A-0358-11E0-907F-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163265>

mmr15@case.edu writes:

> This required removing the diffstat options from 'struct diff_options'
> and adding these values as static ints in diff.c. This preserves the
> style of "config options are static ints, command-line options are
> diff_options members". stat_opt now directly sets the global options.

It is not that I do not trust/believe it, but I am very unhappy with the
above "This required".

The diff callchain was designed to be a highly reusable library and has
been kept callable multiple times with different settings in a single
program by passing different "struct diff_options".  The above sounds like
a rather huge regression.

Aren't there any way to avoid this?  Why do these two options need to be
any different from other variables (e.g. a_prefix, context) that can be
set from the config and can be overridden by the command line options
while having a built-in fallback default values?

In general, the callflow of each git subcommand looks like this:

 (1) find $GIT_DIR;
 (2) read $GIT_DIR/config and friends;
 (3) parse command line options;
 (4) decide what the user asked us to do and do it.

I would imagine that the following should do what you want:

 * declare two static int variables, stat_name_width_default and
   stat_width_default, that are initialized to 80/50 at compile time;

 * add code to git_diff_ui_config() to update these two *_default
   variables in step (2) above;

 * add code to diff_setup() to initialize opt->stat_name_width and
   opt->stat_width from these two *_default variables;

 * add code to diff_opt_parse() to update opt->stat_name_width and
   opt->stat_width from the command line parameters.

Then follow cmd_diff() in diff.c to make sure the above is sufficient.
Observe that:

 - The first thing cmd_diff() does is to read the config;
 - then init_revisions() will call diff_setup();
 - then setup_revisions() will call into diff_opt_parse().

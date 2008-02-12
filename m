From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] config api: Add git_config_magic_int()
Date: Tue, 12 Feb 2008 13:41:35 -0800
Message-ID: <7vir0t3l9s.fsf@gitster.siamese.dyndns.org>
References: <47B15701.8040803@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Feb 12 22:43:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP2uP-0003QB-KN
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 22:43:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724AbYBLVmd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 16:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751723AbYBLVmd
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 16:42:33 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34310 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669AbYBLVmc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 16:42:32 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id DDBD5390B;
	Tue, 12 Feb 2008 16:42:28 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 19BFF38FF; Tue, 12 Feb 2008 16:41:42 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73697>

Andreas Ericsson <ae@op5.se> writes:

> +int git_config_magic_int(const char *name, const char *value,
> +			 const char *magic_value, int magic_setting)
> +{
> +	if (value && !strcasecmp(value, magic_value))
> +		return magic_setting;
> +
> +	return git_config_int(name, value);
> +}

I do not think this has much to do with any "magic".

An instruction "use 0 threads" when taken literally would mean
"do not use any CPU" which would not make much sense.  In that
sense, giving a magic meaning of "guess an appropriate value" to
0 may be a good idea.  A valid alternative would be to make 0
mean the same thing as 1, but that is much more boring ;-)

But if you did so, that means "var = 0" invokes the same magic
as "var = auto".  The magic lives in "0", and not in "auto".

I think the direction your patch leads us is good, but I think
it should allow an array of symbolic ways to spell values to be
useful, that is:

	struct config_symbolic_int {
        	const char *name;
                int value;
	};
        int git_config_symbolic_int(const char *var, const char *value,
				    struct config_symbolic_int *);

That way, you can have

	{ { "high", 9 }, { "default", 0 }, { "low", 1 } };

and say things like "zlevel = high|default|low".

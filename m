From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/11] revert: Introduce a struct to parse command-line
 options into
Date: Mon, 11 Apr 2011 14:41:44 -0700
Message-ID: <7vmxjwtqhz.fsf@alter.siamese.dyndns.org>
References: <1302448317-32387-1-git-send-email-artagnon@gmail.com>
 <1302448317-32387-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 23:42:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9Os3-0000d9-4T
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 23:42:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756028Ab1DKVmB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 17:42:01 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42710 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755928Ab1DKVmA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2011 17:42:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0EFF84C75;
	Mon, 11 Apr 2011 17:43:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=5JWq/Vg7DJDc64uJj4eRh0GFgEE=; b=LUAjHxERYLr9zogWVNh5
	39HmJTp9cqDqT57onQ7uD+a/7TAm55UmE7ONbnGkFTmjJ7wii9ZabMHjMtbyYCeV
	yq5cziyyDql93ft/Uv4GBt78CDKY5nRRsW2wR5hOme1eAig+AdZvqLVBC18vRVAV
	uYTQWlLKMcATDhztc/hDjfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=jX9xmmebCHsQyEXH/NjCyVkZAkCI26ih9lRbVwqZNY7YuR
	OLp2A6dRjN89UvA+S4d8MA6TePqWKvVFMrfMMRcT7SUiA3Zorh6aru0UwraobDEb
	R5ltIY+SdOO9l90lhGodpLjnHKsLNBwF+s5TL/L0da0pwZSqmUqZ5lugxn2Tk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AEA554C6E;
	Mon, 11 Apr 2011 17:43:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EC94B4C6C; Mon, 11 Apr 2011
 17:43:43 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C9DE4BA0-6484-11E0-B259-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171361>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>

Again, "In later steps, a new API that takes a single commit and replays
it in forward (cherry-pick) or backward (revert) direction will be
introduced, and will take this structure as a parameter to tell it what to
do" is missing from the above description.

More importantly, the primary purpose of these variables is _not_ "to
parse command line options into".  It is to actively affect what happens
in the code, and "parse command line" is merely a way to assign the
initial values to them.  So I'd rather see this patch described perhaps
like this:

    cherry-pick/revert: introduce "struct replay_options"

    The current code uses a set of file-scope static variables to instruct
    the cherry-pick/revert machinery how to replay the changes, and
    initialises them by parsing the command line arguments. In later steps
    in this series, we would like to introduce an API function that calls
    into this machinery directly and have a way to tell it what to do.

    Introduce a structure to group these variables, so that the API can
    take them as a single "replay_options" parameter.

I strongly prefer to see this patch also update the callchain to pass a
pointer to the options struct as parameter.  I can guess without reading
the rest the series that at some later step you would do that, but I think
it makes more sense to do the conversion at this step, as you will be
touching lines that use the global variables in this patch anyway, like
this:

-	return action == REVERT ? revert_usage : cherry_pick_usage;
+	return cmd_opts.action == REVERT ? revert_usage : cherry_pick_usage;

which should eventually become something like:

	return opts->usage_message;

at the very last step when this codepath is _fully_ libified (I don't know
if the final result of your series still is a "choose only from these two
canned messages" API, or gives the ability to the caller to specify the
usage message---I am just showing how it should look like at the end of a
full libification).  So it would make sense to see:

	return opts->action == REVERT ? revert_usage : cherry_pick_usage;

in this patch.

> @@ -268,17 +278,17 @@ static struct tree *empty_tree(void)
>  static int error_dirty_index()

It is probably a remnant of the earlier patches in this series, but this
should start with:

	static int error_dirty_index(void)

Of course, you will actually be passing the options structure, so it would
become:

	static int error_dirty_index(struct replay_options *opts)
        {
        	...
                if (opts->action == REVERT)
                	...
	}

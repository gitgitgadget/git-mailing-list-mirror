From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 02/19] parse-options-cb: implement parse_opt_pass_argv_array()
Date: Wed, 10 Jun 2015 01:03:54 -0700
Message-ID: <xmqqy4jst2fp.fsf@gitster.dls.corp.google.com>
References: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
	<1433314143-4478-3-git-send-email-pyokagan@gmail.com>
	<xmqqr3pkwjz6.fsf@gitster.dls.corp.google.com>
	<CACRoPnRVjNseXPOxKe4_3rnKXmAYeA80iCHY3o8euWA=EUX6hA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 10:04:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2azU-000153-Td
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 10:04:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754173AbbFJIEA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 04:04:00 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:35622 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753000AbbFJID5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 04:03:57 -0400
Received: by iesa3 with SMTP id a3so29391559ies.2
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 01:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=18ObjM/ZGGROhH8EgLC/6iHG2n83vP5rO21zM5fIj4M=;
        b=RFy5KrXEvdbupQmdVdNI7HZ4SBsMrG7+yPYPChQctr9zYREJzK4Ldd1Xvn1fBaGWp5
         gA584ekAqMY/gc+1px268Edyc12zADD7gpO1R6zAzWtw+rtZIbwaXdF9UzUk6rI1zXo/
         NKhvOOR1NRSrTR69xaCSUGY6z3AN8dGiEX7ao0vqIqXHHZrA1x+BbUi6WzLFxVviB69A
         I7L5Ec4quzuqM0LwfARFwjvOLr69f/N5mn0hWBrbSEbLFmM0hSWoYbYuNmMMXkWqP2Wo
         Ko+lcDy/hCvtzHJhPZpg2fr7HYYrjVhlUQFK6l4/dD2nhVa65BnKZcbwX04y7b34DGLQ
         nZeg==
X-Received: by 10.107.12.202 with SMTP id 71mr2609131iom.73.1433923436229;
        Wed, 10 Jun 2015 01:03:56 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b116:bf29:c748:758b])
        by mx.google.com with ESMTPSA id bc2sm2670448igb.7.2015.06.10.01.03.55
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Jun 2015 01:03:55 -0700 (PDT)
In-Reply-To: <CACRoPnRVjNseXPOxKe4_3rnKXmAYeA80iCHY3o8euWA=EUX6hA@mail.gmail.com>
	(Paul Tan's message of "Wed, 10 Jun 2015 15:11:01 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271272>

Paul Tan <pyokagan@gmail.com> writes:

> I don't see how it feels iffy.

That is largely a taste thing.  And a good taste matters.

What is iffy is to use strbuf as an external interface between the
implementation of the parse_opt_pass() API function and its users.

I would expect that no users of the parse_opt_pass() would ever take
advantage of the fact that the value they are using is implemented
as a strbuf, allowing them to use the family of functions in the
strbuf API to further manipulate it.  All users you added wants to
use a plain vanilla string, and only because you used strbuf as the
interface element, they have to say "var.buf" to get to the value
they want to use.

> The purpose of using strbufs (and
> argv_arrays) is to avoid error-prone manual memory management.

It is a good idea to use strbuf as an implementation detail of
parse_opt_pass() function.  After all, safer, easier and efficient
manipulation of strings is why we added the strbuf API to the system
in the first place.

But it is a different matter to expose that as an API element when
the recipient is not going to benefit.

In other words, callers of the API designed with a better taste
would look more like this:

	static const char *opt_diffstat;

	static struct option pull_options[] = {
        	...
                { OPTION_CALLBACK, 'n', NULL, &opt_diffstat, NULL,
		  N_("do not show a diffstat at the end of the merge"),
		  PARSE_OPT_NOARG | PARSE_OPT_NONEG, parse_opt_pass
        	},
		...
	};

	static int run_merge(void)
        {
        	...
                if (opt_diffstat)
                	argv_array_push(&args, opt_diffstat);
		...
	}

That way, they do not have to define strbuf variables and
dereference the value as opt_diffstat.buf.

And the implementation of the API element is not all that different
from what you wrote:

	int parse_opt_pass(const struct options *opt, const char *arg, int unset)
	{
		struct strbuf sb = STRBUF_INIT;
		char **value = opt->value;

		if (*value)
                	free(*value);
		if (opt->long_name) {
                	strbuf_addf(&sb, "--%s%s",
                        	    unset ? "no-" : "",
                                    opt->long_name);
			...
                }
                ...
                *value = strbuf_detach(&sb, NULL);
		return 0;
	}

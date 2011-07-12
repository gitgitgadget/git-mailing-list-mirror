From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 08/17] revert: Separate cmdline parsing from functional
 code
Date: Tue, 12 Jul 2011 13:20:46 -0500
Message-ID: <20110712182046.GD14120@elie>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-9-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 12 20:21:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QghZs-0006eT-B5
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 20:21:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754720Ab1GLSUz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 14:20:55 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:58905 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754458Ab1GLSUz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 14:20:55 -0400
Received: by ywe9 with SMTP id 9so2050796ywe.19
        for <git@vger.kernel.org>; Tue, 12 Jul 2011 11:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=a0bWm5Cs5XHXMOnJoSr2Ti8AJGFkEXQVpLtAE4GWdD8=;
        b=Ujnkku5lyzSk8ldf9CLD6XwMdRGa0YXwx5EVz9dbI7cj0MqXb6OmK8TRuLzK81no1+
         aa/jJ+HtqPCP708fr0H7DqOhF3Cp+Vvs1k8NONroD9/MNOlznpx8cZu8TzzndgMGhvQz
         tHuGjw0KHvVpueKsl4E8Z6YL21aP6Nc1pqLhM=
Received: by 10.91.200.22 with SMTP id c22mr417716agq.87.1310494854283;
        Tue, 12 Jul 2011 11:20:54 -0700 (PDT)
Received: from elie (adsl-69-209-70-6.dsl.chcgil.sbcglobal.net [69.209.70.6])
        by mx.google.com with ESMTPS id p50sm5763356yhj.42.2011.07.12.11.20.52
        (version=SSLv3 cipher=OTHER);
        Tue, 12 Jul 2011 11:20:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1310396048-24925-9-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176962>

Hi,

Ramkumar Ramachandra wrote:

> Currently, revert_or_cherry_pick does too many things including
> argument parsing and setting up to pick the commits; this doesn't make
> a good API.

On the contrary, generally speaking single-call APIs are often very
pleasant to work with.  Consider the difference between

	struct compressor c;
	memset(&c, 0, sizeof(c));
	init_compressor(&c);
	set_compressor_opts(c, COMPRESSOR_OPT_FAST);
	set_compressor_input("foo.c");
	set_compressor_output("foo.c.compressed");
	while (compressor_pump() != COMPRESSOR_DONE)
		; /* just looping */
	fini_compressor(&c);

and

	compress_file("foo.c.compressed", "foo.c", COMPRESSOR_OPT_FAST);

The latter is more pleasant, right?

So this is probably not about the function doing too many things but
something else.

By the way, the API still has the problem described in [1]: it could
not be used from another translation unit, since one of the parameters
(the "me" variable) is passed through a global instead of on the stack
or in registers.

If the goal is a pleasant API, a good way to explain it is sometimes

	Currently you have to do:

		...

	After this change, you can write:

		...

	Isn't that nice?

[1] http://thread.gmane.org/gmane.comp.version-control.git/176647/focus=176668

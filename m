From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix Solaris Workshop Compiler issues
Date: Wed, 14 Nov 2007 16:30:08 -0800
Message-ID: <7v3av89wq7.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0711142125460.17530@bianca.dialin.t-online.de>
	<20071114204732.GE3973@steel.home>
	<7vprycfrk6.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0711150011020.4135@bianca.dialin.t-online.de>
	<20071114232809.GH3973@steel.home>
	<20071115001756.GA25021@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Guido Ostkamp <git@ostkamp.fastmail.fm>, git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 15 01:30:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsScw-0001IB-8u
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 01:30:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754517AbXKOAaW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Nov 2007 19:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756613AbXKOAaW
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 19:30:22 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:58910 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754247AbXKOAaV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Nov 2007 19:30:21 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 2683C2F9;
	Wed, 14 Nov 2007 19:30:42 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 8349495DA5;
	Wed, 14 Nov 2007 19:30:37 -0500 (EST)
In-Reply-To: <20071115001756.GA25021@atjola.homenet> (=?utf-8?Q?Bj=C3=B6rn?=
 Steinbrink's
	message of "Thu, 15 Nov 2007 01:17:56 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65031>

Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de> writes:

> No, just tried with cc: Sun C 5.7 Patch 117837-06 2005/10/05
>
> It's the "struct hack", ie. the incomplete array at the end of
> delta_index. Still looking for a fix/workaround.

Do you mean the "FLEX_ARRAY" thing?

You can ask for FLEX_ARRAY from the command line of your "make"
process.

There is this thing in git-compat-util.h

        #ifndef FLEX_ARRAY
        #if defined(__GNUC__) && (__GNUC__ < 3)
        #define FLEX_ARRAY 0
        #else
        #define FLEX_ARRAY /* empty */
        #endif
        #endif

The sources are written this way:

	struct foo {
        	... other members ...
                char last_member_that_is_flexible[FLEX_ARRAY];
	};

=46or older gcc, because we know about its lack of support, the
above turns into:

	struct foo {
        	... other members ...
                char last_member_that_is_flexible[0];
        }

But for recent enough compilers that grok the "flexible array
members", the above expands to:

	struct foo {
        	... other members ...
                char last_member_that_is_flexible[];
        }

Maybe your compiler needs -DFLEX_ARRAY=3D0 in CFLAGS?

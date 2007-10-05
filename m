From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [AGGREGATED PATCH] Fix in-place editing functions in convert.c
Date: Fri, 5 Oct 2007 09:43:19 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710050933330.23684@woody.linux-foundation.org>
References: <20071005082026.GE19879@artemis.corp> <20071005085522.32EFF1E16E@madism.org>
 <alpine.LFD.0.999.0710050819540.23684@woody.linux-foundation.org>
 <20071005162139.GC31413@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Bernt Hansen <bernt@alumni.uwaterloo.ca>
To: Sam Ravnborg <sam@ravnborg.org>
X-From: git-owner@vger.kernel.org Fri Oct 05 18:45:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdqIN-0005LX-KM
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 18:45:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757449AbXJEQot (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 12:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757015AbXJEQos
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 12:44:48 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:50231 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755242AbXJEQos (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Oct 2007 12:44:48 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l95GhKgu022911
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 5 Oct 2007 09:43:24 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l95GhJ2B008911;
	Fri, 5 Oct 2007 09:43:20 -0700
In-Reply-To: <20071005162139.GC31413@uranus.ravnborg.org>
X-Spam-Status: No, hits=-3.045 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,SARE_MILLIONSOF,TW_VN
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.46__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60111>



On Fri, 5 Oct 2007, Sam Ravnborg wrote:
> 
> Took a short look at strbuf.h after seeing the above code.
> And I was suprised to see that all strbuf users were exposed to
> the strbuf structure.

Well, they *have* to. We want people to declare their strbufs as automatic 
or static structures, and using a opaque struct pointer is *not* an option 
(like "FILE" is doing in stdio.h).

> Following patch would at least make sure noone fiddle with strbuf internals.

No, following patch is fundamentally broken - it's not even a good 
starting point. It's bad, bad, bad.

It's also broken in another way: we want it to be really easy to use 
strbuf's as normal C strings.

Yes, many (totally idiotic and broken) interfaces think it's so important 
to "protect" their internal data structures that you have a 
"string_to_c()" helper function for that. That may be "good abstraction", 
but it's totally idiotic, because it results in horrible source code!

Tell me which is more readable:

	printf("Hello %s\n", sb->buf);

or

	printf("Hello %s\n", strbuf_to_c(sb));

and I claim that anybody who claims that the latter is "more readable" is 
full of shit, and has an agenda to push, so it's "more agenda-friendly" 
rather than readable!

So having "sb->buf" and "sb->len" be visible to users is a *good* thing. 
Otherwise you end up having to create millions of idiotic small helper 
functions, rather than just use the standard ones.

			Linus

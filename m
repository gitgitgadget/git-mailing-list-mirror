From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH v2 0/3] Documentation: refactor config variable
 descriptions
Date: Fri, 22 Oct 2010 11:53:07 -0400
Message-ID: <20101022155307.GB5554@sigill.intra.peff.net>
References: <cover.1287690696.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Oct 22 17:52:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9Juw-0007J1-95
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 17:52:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756295Ab0JVPwY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 11:52:24 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:45673 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755380Ab0JVPwY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 11:52:24 -0400
Received: (qmail 19465 invoked by uid 111); 22 Oct 2010 15:52:23 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 22 Oct 2010 15:52:23 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Oct 2010 11:53:07 -0400
Content-Disposition: inline
In-Reply-To: <cover.1287690696.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159705>

On Fri, Oct 22, 2010 at 07:02:28AM +0200, Thomas Rast wrote:

> This resurrects (finally) the earlier attempt at
> 
>   http://mid.gmane.org/cover.1280169048.git.trast@student.ethz.ch
> 
> It tries the inverse approach: teaching the script how to find config
> variable blocks in each manpage, and then linking them from the main
> list.  (Obviously just inserting them into the main list could also
> work.)
> 
> In other words, it attempts to push out the "original" documentation
> of each variable from the main list to the individual manpage, which
> is exactly opposite from v1.

Thanks for working on this.

I think this approach is much saner for writers and readers of the
source files, and I think the output is much better (in particular, the
giant list having "see X" pointers instead of the actual description
blocks).

Your 2/3 doesn't seem to have made it through to the list, but I pulled
from your repository and looked at it. I have two comments on the
approach:

  1. It looks like you're more or less just parsing "::" list keys from
     all of the manpages. This seems somewhat fragile, as there could be
     other non-config lists. Can we at least restrict it to
     CONFIGURATION sections? It would be nice if we could put in some
     kind of semantic markup, but I'm not sure how painful that would be
     with asciidoc (we could always resort to comments in the source,
     but that would probably get unreadable quickly).

  2. You recursively follow includes via include::. This means that the
     make rule is not accurate. E.g., try:

       rm cmds-mainporcelain.txt config-vars.txt
       make config-vars.txt

     which should fail, as we actually depend on cmds-mainporcelain.txt.
     Doing it accurately and automatically would mean making .depend
     files for make.

     But I wonder if the recursive lookup is really required. Some of
     the includes with config files can just go away (e.g.,
     merge-config.txt is included only by config-vars-src.txt and
     git-merge.txt; it can just be merged straight into git-merge.txt
     once this system exists). Others, like pretty-formats.txt, should,
     IMHO, get their own user-visible page. Right now with your script
     you get[1]:

       format.pretty::
               The default pretty format for log/show/whatchanged command,
               See linkgit:git-log[1], linkgit:git-show[1],
               linkgit:git-whatchanged[1].

     but I would rather see[2]:

       format.pretty::
               See linkgit:gitpretty[7].

     [1]: I assume the single line of block description is an error in
          your script.

     [2]: Actually, as I mentioned a long time ago, I think it would be
          nicer to have a table like:

             format.attach         linkgit:git-format-patch[1]
             format.cc             linkgit:git-format-patch[1]
             format.headers        linkgit:git-format-patch[1]
             format.pretty         linkgit:gitpretty[7]

> I'm afraid 1/3 (semantically unchanged from the equivalent patch in
> v1) will again not make it through, so I again pushed this out:
> 
>   git://repo.or.cz/git/trast.git t/doc-config-extraction-v2

Yeah, I saw neither 1/3 nor 2/3 on the list.

-Peff

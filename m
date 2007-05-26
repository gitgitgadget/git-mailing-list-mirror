From: Jeff King <peff@peff.net>
Subject: Re: Bug: git-rebase goofs up \n in commit messages
Date: Fri, 25 May 2007 20:40:28 -0400
Message-ID: <20070526004028.GA8940@sigill.intra.peff.net>
References: <465750FE.9000406@iii.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: herbert@gondor.apana.org.au, git@vger.kernel.org
To: Szekeres Istvan <szekeres@iii.hu>
X-From: git-owner@vger.kernel.org Sat May 26 02:40:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrkKq-0000ig-LA
	for gcvg-git@gmane.org; Sat, 26 May 2007 02:40:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbXEZAke (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 20:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752639AbXEZAke
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 20:40:34 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1983 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750957AbXEZAke (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 20:40:34 -0400
Received: (qmail 22150 invoked from network); 26 May 2007 00:40:39 -0000
Received: from sigill.intra.peff.net (10.0.0.7)
  by peff.net with (DHE-RSA-AES256-SHA encrypted) SMTP; 26 May 2007 00:40:39 -0000
Received: (qmail 19523 invoked by uid 1000); 26 May 2007 00:40:28 -0000
Content-Disposition: inline
In-Reply-To: <465750FE.9000406@iii.hu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48436>

On Fri, May 25, 2007 at 11:11:26PM +0200, Szekeres Istvan wrote:

> while playing with git I found the following bug: if a commit message
> contains "\n" (as a string, not as a character), git-rebase changes this
> string into a literal newline character.

Hmm. The culprit seems to be git-am.sh, line 313:

  SUBJECT="$(sed -n '/^Subject/ s/Subject: //p' "$dotest/info")"

and even more exciting, it seems to be a bash vs dash thing. Try this:

$ cat >content-with-escapes <<'EOF'
foo \n bar
EOF

$ bash
bash$ test=$(cat content-with-escapes)
bash$ echo $test
foo \n bar

$ dash
dash$ test=$(cat content-with-escapes)
dash$ echo $test
foo
 bar


Hmm. It even happens with this:

bash$ export test=$(echo foo \\n bar)
bash$ dash
dash$ echo $test
foo
 bar

I'm not sure what the best workaround is.  I am cc'ing Herbert Xu to see
if he has any helpful comments.

-Peff

From: Jeff King <peff@peff.net>
Subject: [BUG-ish] diff compaction heuristic false positive
Date: Fri, 10 Jun 2016 03:50:43 -0400
Message-ID: <20160610075043.GA13411@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 09:50:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBHDP-0002ZH-Dk
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 09:50:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbcFJHur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 03:50:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:52311 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751339AbcFJHur (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 03:50:47 -0400
Received: (qmail 28976 invoked by uid 102); 10 Jun 2016 07:50:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Jun 2016 03:50:46 -0400
Received: (qmail 31413 invoked by uid 107); 10 Jun 2016 07:50:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Jun 2016 03:50:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Jun 2016 03:50:43 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296947>

I found a false positive with the new compaction heuristic in v2.9:

-- >8 --

# start with a simple file
cat >file.rb <<\EOF
def foo
  do_foo_stuff()

  common_ending()
end
EOF

git add file.rb
git commit -m base

# and then add another function with a similar ending
cat >>file.rb <<\EOF

def bar
  do_bar_stuff()

  common_ending()
end
EOF

-- 8< --

I get this rather unfortunate diff:

    $ git diff
    diff --git a/file.rb b/file.rb
    index bd9d1cb..67fbeba 100644
    --- a/file.rb
    +++ b/file.rb
    @@ -1,5 +1,11 @@
     def foo
       do_foo_stuff()
     
    +  common_ending()
    +end
    +
    +def bar
    +  do_bar_stuff()
    +
       common_ending()
     end

but without the compaction heuristic (or with an older git), I get:

    $ git -c diff.compactionHeuristic=false diff
    diff --git a/file.rb b/file.rb
    index bd9d1cb..67fbeba 100644
    --- a/file.rb
    +++ b/file.rb
    @@ -3,3 +3,9 @@ def foo
     
       common_ending()
     end
    +
    +def bar
    +  do_bar_stuff()
    +
    +  common_ending()
    +end

:( The problem is that the common bits are separated from the
interesting bits by a blank line. This is simplified from a real-world
example, but I think you could come up with the same example in C, like:

  if (foo) {
        do_foo();

        something_else();
  }

-Peff

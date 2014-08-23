From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] teach fast-export an --anonymize option
Date: Sat, 23 Aug 2014 02:19:32 -0400
Message-ID: <20140823061932.GB18256@peff.net>
References: <20140821070130.GA15930@peff.net>
 <xmqqiollqzel.fsf@gitster.dls.corp.google.com>
 <20140821224910.GB21105@peff.net>
 <20140821232100.GA27849@peff.net>
 <9E69746EFF0048FF84631A9794206566@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Duy Nguyen <pclouds@gmail.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sat Aug 23 08:19:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XL4ft-0001YT-Go
	for gcvg-git-2@plane.gmane.org; Sat, 23 Aug 2014 08:19:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752263AbaHWGTf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2014 02:19:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:57281 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752210AbaHWGTe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2014 02:19:34 -0400
Received: (qmail 16361 invoked by uid 102); 23 Aug 2014 06:19:34 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 23 Aug 2014 01:19:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 23 Aug 2014 02:19:32 -0400
Content-Disposition: inline
In-Reply-To: <9E69746EFF0048FF84631A9794206566@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255736>

On Fri, Aug 22, 2014 at 07:39:59PM +0100, Philip Oakley wrote:

> Just a bit of bikeshedding for future improvements..
> 
> The .gitignore is another potential user problem area that may benefit form
> not being anonymised when problems strike.

Thanks, I had meant to mention some implications for .gitmodules here,
but forgot about .gitignore (and .gitattributes!).

For any git-specific files like this, we have two challenges:

  1. We've munged their filenames (so .gitignore is probably path123
     now).

  2. We'll have munged their contents. So even if we left the file as
     .gitignore, it will have junk in it.

Fixing (1) is pretty easy. I structured all of the anonymizing functions
to take the old values, even though most of them just throw it away
entirely (which is a good way to be sure you're not leaking anything!).
But we could pass through a few specific ones.

However, that doesn't help us if the contents are still munged (in fact
it's worse, because git will be annoyed that your .gitmodules file
contains unparseable crap). So how do we munge those files?

It depends on the individual file, I think, and what the user wants to
protect.

For .gitignore and .gitattributes, we can translate the pathnames
contained in the file. But that doesn't work in the general case,
because the file could have wildcards or other non-literal syntax.

For .gitmodules, I think it's all-or-nothing. Either the user is OK
sharing the URLs of their submodules or not (we could munge _just_ the
URLs, but it's not like the result would be remotely functional).

So while we might be able to get some things working on the .gitignore
side, I kind of think the simplest way forward is just adding finer
granularity for the user. Let them say "my filenames are OK to share
because they're part of the problem, but just make sure you hide my
commit messages and file contents".

And then if you're not munging filenames, we would turn off .gitignore
and .gitattributes munging. The implementation is not too hard.
export_blob does not have the path of the blob, but we generate the list
of blobs to export from a diff, so we can feed the path that way.  That
technically misses a case where you have a blob at path "X", we
anonymize it, and then you later move it to ".gitignore", which would
not be anonymized. But that is unlikely enough that it is probably not
worth worrying about.

> For example, there's a current
> problem on the git-users list
> https://groups.google.com/forum/#!topic/git-users/JJFIEsI5HRQ about "git
> clean vs git status re .gitignore", which would then also beg questions
> about retaining file extensions/suffixes (.txt, .o, .c, etc).

Yeah, I think retaining extensions would be a reasonable option (and you
would probably use it with an option to retain .gitattributes or
.gitignore whole if you were confident that those files did not have
anything private and just used extension wildcards).

> One thought is that the user should be able to, as an option, select the
> number of initial characters retained from filenames, and similarly, the
> option to retain the file extension, and possibly directory names, such that
> the full .gitignore still works in most cases, and the sort order works (as
> far as it goes on number of characters).

Yeah, those all seem reasonable.

> All things for future improvers to consider.

Agreed. I wanted to go through your list not because I want to implement
any of those things right now, but because I wanted to make sure that
there was nothing in my approach that would preclude us from building
those things later. And I don't think there is (and I'd be happy if
somebody else felt like building them on top, now or later).

-Peff

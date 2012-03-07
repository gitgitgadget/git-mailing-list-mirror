From: Andreas Stricker <astricker@futurelab.ch>
Subject: Re: git-svn show-externals and svn version
Date: Wed, 07 Mar 2012 10:39:40 +0100
Organization: FutureLAB
Message-ID: <4F572CDC.6060303@futurelab.ch>
References: <E59CCE45-6F92-4748-9B6E-2A562647904B@nikolaus-demmel.de> <994D6101-DD43-4CD9-BB96-34807E3087C4@nikolaus-demmel.de> <5B8386D7-3C01-4A58-A7AB-9AA43BB45572@nikolaus-demmel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Nikolaus Demmel <nikolaus@nikolaus-demmel.de>
X-From: git-owner@vger.kernel.org Wed Mar 07 10:48:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5DTp-0000Kj-N5
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 10:48:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752832Ab2CGJsQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Mar 2012 04:48:16 -0500
Received: from host-179.futurelab.ch ([62.2.169.179]:46585 "EHLO
	primus.futurelab.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752441Ab2CGJsP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2012 04:48:15 -0500
X-Greylist: delayed 511 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Mar 2012 04:48:14 EST
Received: from astricker.futurelab.ch (primus [127.0.0.1])
	(authenticated bits=0)
	by primus.futurelab.ch (8.13.8/8.13.8/fL-3.7) with ESMTP id q279deQD003088;
	Wed, 7 Mar 2012 10:39:40 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <5B8386D7-3C01-4A58-A7AB-9AA43BB45572@nikolaus-demmel.de>
X-Enigmail-Version: 1.3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192433>

Nikolaus Demmel <nikolaus@nikolaus-demmel.de> wrote:
> I feel a bit like I am talking to myself, but I see from the high
> traffic on this list that people are busy doing great things :-). I will
> write anyway in case someone interested in git-svn listens.

Um I'm always a bit behind in reading this list. A long time ago my
colleague and I implemented a parser for the new svn:externals format
as a proof of concept[1]. I never took the time to finish it.

> So I've investigated the matter a bit further. Turns out in the
> subversion SWIG language bindings there is an API function that parses
> svn:externals definitions for you.

This looks like a sane approach. I ended with a bunch of complicated
parsing code [2].

> How could this be used in git-svn show-externals? As layed out before, I
> believe that the current output for the svn1.5 syntax is inherently
> broken and we should not worry about backwards compatibility for
> that.

I second that. The output for the new syntax is just plain broken and
can't be used in a sane way. I know that because I tried...

> To maintain backwards compatibility with the output for the old
> format and to give a canonical, easy to parse, output for any external
> definition, I suggest sticking to the current format, just inserting the
> parsed definition at the appropriate place with relative URLs completely
> resolved to absolute ones.

This is exactly what my proof of concept does. The output format keeps
the same as for pre subversion 1.5 format.

> The pre-svn1.5 syntax for external definitions was:
> 
> LOCAL-PATH [-r REVISION] ABSOLUTE-URL
> 
> The output for show-externals was thus (note that there is no parsing of
> the external definition going on yet):
> 
> DIRECTORY-PREFIX/LOCAL-PATH [-rREVISION] ABSOLUTE-URL

Wasn't there also a line commented with a hash "#" before that? Like:
# DIRECTORY-PREFIX

> The DIRECTORY-PREFIX was added because show-externals shows the external
> definitions for all subdirectories recursively. With this prefix, every
> line can be processed on its own. I suggest extending this output to:
> 
> DIRECTORY-PREFIX/LOCAL-PATH [-rREVISION] ABSOLUTE-URL[@PEG-REV]
> 
> Again, as mentioned above, show-externals should parse the definitions
> and resolve relative URLs. Any lines that the svn API call cannot parse
> should be completely ommited (e.g. commented lines and empty lines).

A sane approach. What about a warning about lines skipped?

> As I understand it show-externals is intended primarily for scripts for
> further processing. With this extension existing scripts for the old
> syntax should keep working also long as they don't feature
> peg-revisions. With relative URLs resolved and a standard ordering old
> and new syntax cannot be distinguished in terms of show-externals output
> (except when there are peg-revsion are there).

True. So external tools like git-svn-clone-externals will still work
with this. I verified this with my proof of concept.

Regards, Andy

[1] https://github.com/AndyStricker/git
[2]
https://github.com/AndyStricker/git/commit/9981b3b8313fb831247a16a04d5040bd6a8660b1

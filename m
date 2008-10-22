From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: don't escape tilde ('~') for http(s) URLs
Date: Wed, 22 Oct 2008 01:16:53 -0700
Message-ID: <20081022081653.GC14966@untitled>
References: <20081018213919.GC3107@atjola.homenet> <20081018224728.GD3107@atjola.homenet> <20081021211131.GA21606@yp-box.dyndns.org> <7vtzb5wr6v.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	git@vger.kernel.org, jsogo@debian.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 22 10:18:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsYuw-0000Lk-96
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 10:18:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546AbYJVIQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 04:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbYJVIQ4
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 04:16:56 -0400
Received: from hand.yhbt.net ([66.150.188.102]:42898 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751201AbYJVIQy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 04:16:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 970562DC01A;
	Wed, 22 Oct 2008 01:16:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vtzb5wr6v.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98839>

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> >> strace revealed that git-svn url-encodes ~ while svn does not do that.
> >>
> >> For svn we have:
> >> write(5, "<S:update-report send-all=\"true\" xmlns:S=\"svn:\">
> >> <S:src-path>https://sucs.org/~welshbyte/svn/backuptool/trunk</S:src-path>...
> >>
> >> While git-svn shows:
> >> write(7, "<S:update-report send-all=\"true\" xmlns:S=\"svn:\">
> >> <S:src-path>https://sucs.org/%7Ewelshbyte/svn/backuptool/trunk</S:src-path>...
> 
> This looks like an XML based request sequence to me (and svn is talking
> WebDAV here, right?); it makes me wonder what exact quoting rules are used
> there.  I would expect $path in <S:src-path>$path</S:src-path> to quote
> a letters in it e.g. '<' as "&lt;" --- which is quite different from what
> the s/// substitutions in the patch seem to be doing.

I agree.  I haven't checked if the SVN libraries do proper XML escaping
for us (but the problem hasn't shown up yet :).  I was already
completely disappointed that git-svn had to do its own escaping when
transmitting data using the SVN libraries (and dependent on the protocol
being used, too!).

> > diff --git a/git-svn.perl b/git-svn.perl
> > index ef6d773..a97049a 100755
> > --- a/git-svn.perl
> > +++ b/git-svn.perl
> > @@ -852,7 +852,7 @@ sub escape_uri_only {
> > -		s/([^\w.%+-]|%(?![a-fA-F0-9]{2}))/sprintf("%%%02X",ord($1))/eg;
> > +		s/([^~\w.%+-]|%(?![a-fA-F0-9]{2}))/sprintf("%%%02X",ord($1))/eg;
> 
> Admittedly I do not know git-svn (nor Perl svn bindings it uses), and I
> suspect that some of the XML-level escaping is done in the libsvn side,
> but it would be nice if somebody can at least verify that the code after
> the patch works with repositories with funny characters in pathnames
> (perhaps list all the printables including "<&>?*!@.+-%^").  Even nicer
> would be a log message that says "the resulting code covers all cases
> because it follows _that_ spec to escape _all_ problematic letters",
> pointing at some in svn (or libsvn-perl) resource.

Help with looking at what SVN does and writing testcases would
definitely be appreciated on this matter.  Or perhaps this can be done
at GitTogether :)

> The patch may make a path with '~' work, but it (neither in the patch text
> nor in the commit log message) does not have much to give readers enough
> confidence that the code after the patch is the _final_ one, as opposed to
> being just a band-aid for a single symptom that happened to have been
> discovered this time.

This is definitely a band-aid fix until I or somebody else takes the
time to figure out:

 1. exactly which characters need to be escaped
 2. for which protocols those characters need to be escaped
 3. which part(s) of the URI they need to be escaped for
    (repository root vs SVN path)
 4. which versions of SVN needs more (or less) escaping rules

(I vote for somebody else, especially for #4 :)

-- 
Eric Wong

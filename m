From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 4/6] Add QuotedString class to handle C-style
	quoting rules
Date: Wed, 10 Dec 2008 15:41:30 -0800
Message-ID: <20081210234130.GB32487@spearce.org>
References: <1228946751-12708-1-git-send-email-spearce@spearce.org> <1228946751-12708-4-git-send-email-spearce@spearce.org> <1228946751-12708-5-git-send-email-spearce@spearce.org> <200812110022.03719.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 00:42:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAYhf-000531-DU
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 00:42:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755244AbYLJXlb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 18:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755115AbYLJXlb
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 18:41:31 -0500
Received: from george.spearce.org ([209.20.77.23]:43232 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754702AbYLJXla (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 18:41:30 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 1DC1138200; Wed, 10 Dec 2008 23:41:30 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200812110022.03719.robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102743>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> onsdag 10 december 2008 23:05:49 skrev Shawn O. Pearce:
> > Git patch files can contain file names which are quoted using the
> > C language quoting rules.  In order to correctly create or parse
> 
> Should we maybe call this Git-style since we really do not care
> about C (which version btw?).

Yea, I think you are right.  I'll change the name.
 
> Making two interfaces is better. We may share the implementation initially,
> but parsing file names in Git patches and parsing C strings are different
> operations.

Well, if we ever supported other C-style string names we could just
swap the implementation reference.  I'll try to make it clearer
this format, although like a C-style string, is really meant for
Git path names within patches.
 
> > +	public void testQuote_OctalAll() {
> > +		assertQuote("\1", "\\001");
> > +		assertQuote("~", "\\176");
> > +		assertQuote("\u00ff", "\\303\\277"); // \u00ff in UTF-8
> > +	}
>
> What do we do with non-UTF8 names? I think we should
> follow the logic we use when parsing commits and paths
> in other places.

Then we're totally f'd.

Git has no specific encoding on file names.  If we get a standard
Java Unicode string and get asked to quote it characters with
code points above 127 need to be escaped as an octal escape code
according to the Git style.  Further the Git style only permits
octal escapes that result in a value <= 255, aka an unsigned char.

The name needs to be encoded into an 8-bit encoding, and UTF-8 is
the only encoding that will represent every valid Unicode character.
Elsewhere we sort of take the attitude that when writing data *out*
we produce UTF-8, even if we read in ISO-whatever.  Here I'm doing
the same thing.

> > +	public void testDequote_UnknownEscapeQ() {
> > +		assertDequote("\\q", "\\q");
> > +	}
>
> Would Git generate this style in a name? 

No, but a mangled patch might have it.  Rather than throw an
exception I try to parse the string as faithfully as I can, so we
can continue on and mine the stream for more information.  We may
be able to work around the breakage (there's a lot of redundant
data about path names in the git patch format).

As far as I can tell C Git handles this style of escape the same way:

  $ cat F
  diff --git "a/\q" "b/\q"
  --- "a/\q"
  +++ "b/\q"
  $ git apply --stat F
   "\\q\"" |    0
   1 files changed, 0 insertions(+), 0 deletions(-)

Actually, I think there's a bug, its reading the closing quote as
part of the file name.  But anyway, my point is that C git handles
an unknown escape sequence as though it were a literal.
 
> > +			quote['\b'] = 'b';
> \e = esc

Oddly enough, C Git doesn't output \e.  It uses \033.  It doesn't
recognize \e either, so we can't produce it even if we wanted to
honor it on input.  I can add it to our input table (but keep it
out of our output table), but then we'd treat \e as \033 while C
Git would treat \e as a literal.  Bad.

So no, I won't add \e here.

> > +			return decode(Constants.CHARSET, r, 0, rPtr);
> 
> Importing methods really obscures things. Please qualify with class name
> of RawparseUtils here instead. 

Hmmph.  I wonder how you'll feel then about the patch parser code.
I import 4 methods from RawParseUtils because they are so commonly
invoked that I got tired of reading RawParseUtils.foo.

There's only two calls here so I changed it to be qualified.

-- 
Shawn.

From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] replace: add --graft option
Date: Mon, 19 May 2014 07:19:40 -0400
Message-ID: <20140519111940.GB17492@sigill.intra.peff.net>
References: <20140518182939.5260.91202.chriscool@tuxfamily.org>
 <5379D1EF.8040203@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon May 19 13:19:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmLbf-0003GB-6P
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 13:19:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753083AbaESLTn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 07:19:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:54945 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752085AbaESLTm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 07:19:42 -0400
Received: (qmail 5910 invoked by uid 102); 19 May 2014 11:19:43 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 19 May 2014 06:19:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 May 2014 07:19:40 -0400
Content-Disposition: inline
In-Reply-To: <5379D1EF.8040203@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249575>

On Mon, May 19, 2014 at 11:42:07AM +0200, Michael Haggerty wrote:

> On 05/18/2014 08:29 PM, Christian Couder wrote:
> > The usage string for this option is:
> > 
> > git replace [-f] --graft <commit> [<parent>...]
> > 
> > First we create a new commit that is the same as <commit>
> > except that its parents are [<parents>...]
> > 
> > Then we create a replace ref that replace <commit> with
> > the commit we just created.
> > 
> > With this new option, it should be straightforward to
> > convert grafts to replace refs, with something like:
> > 
> > cat .git/info/grafts | while read line
> > do git replace --graft $line; done
> 
> I love the functionality; I think it's a great step towards making
> grafts obsolete.

Me too.

> I haven't worked with Git's object reading/writing code much, but it
> surprised me that you are editing the commit object basically as a
> string, using hard-coded length constants and stuff.  It seems
> error-prone, and we already have a commit parser.

I think we have at least two commit parsers already. :)

The one in commit.c:parse_commit_buffer tries hard to be fast and only
get out enough information for a traversal (so parents, commit
timestamp, and tree pointer).

The ones in pretty.c that back format_commit_message
(parse_commit_header, parse_commit_message) are a bit more flexible, as
they record the offsets and lengths of certain key lines. But "parents"
is not one of those lines (we rely on the already-parsed copy in the
"struct commit" for parents and tree information).

It might make sense to just teach parse_commit_header to be a little
more thorough; it has to read past those lines anyway to find the author
and committer lines, so it would not be much more expensive to note
them.  And then of course the code needs to be pulled out of the
pretty-printer and made generally accessible.

While I do like the thought of having a decent reusable commit parser,
this particular case is really about trying to tweak one header, without
touching anything else. IOW, it is basically:

  sed '/^parent /d; /^tree /a\
  parent ...\
  parent ...
  '

That's more or less what Christian's function is doing, though it
assumes things like that the parents come immediately after the tree,
and that they are all in a group. Those are all true for objects created
by git, but I think we can be a little flexible.

It turns out I wrote a proof-of-concept of this in March when we had the
original discussion, but forgot to ever send it to the list. My parsing
function looked like:

	/*
	 * Rewrite the commit object found in "buf", removing any existing
	 * parents and adding lines for any parents in the NULL-terminated
	 * array "parents" (whose strings should be 40-char hex sha1s).
	 *
	 * The output is written to the strbuf "out".
	 */
	static void rewrite_parents(struct strbuf *out, const char *buf, const char **parents)
	{
		int added = 0;
	
		while (buf && *buf) {
			const char *eol = strchrnul(buf, '\n');
			const char *next = *eol ? eol + 1 : eol;
	
			if (eol == buf + 1)
				break;
	
			if (!starts_with(buf, "parent "))
				strbuf_add(out, buf, next - buf);
	
			/*
			 * We always put our parent lines right after the tree line,
			 * which matches how git creates commit objects.
			 */
			if (starts_with(buf, "tree ")) {
				const char **p;
	
				if (added++)
					die("commit has two tree lines?");
				for (p = parents; *p; p++)
					strbuf_addf(out, "parent %s\n", *p);
			}
	
			buf = next;
		}
	
		if (!added)
			die("commit has no tree line?");
	
		strbuf_addstr(out, buf);
	}

Rather than a splice, I did it as I copied into the strbuf, and I
treated each line independently (dropping parent lines, no matter where,
and then finding the tree line as the "proper" place to add new parent
lines).

-Peff

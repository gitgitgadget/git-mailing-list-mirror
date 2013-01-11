From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: [PATCH] cvsimport: rewrite to use cvsps 3.x to fix major bugs
Date: Fri, 11 Jan 2013 13:58:18 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20130111185818.GA30398@thyrsus.com>
References: <1357875152-19899-1-git-send-email-gitster@pobox.com>
 <7va9sfd6lk.fsf@alter.siamese.dyndns.org>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 19:58:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtjoY-00076M-Ki
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 19:58:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755376Ab3AKS6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2013 13:58:31 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:41619
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753679Ab3AKS6a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 13:58:30 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 101B94047B; Fri, 11 Jan 2013 13:58:18 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7va9sfd6lk.fsf@alter.siamese.dyndns.org>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213234>

Junio C Hamano <gitster@pobox.com>:
> I think the prevalent style in this script is to write "print"
> without parentheses:
> 
> 	print STDERR "msg\n";

That can be easily fixed.

> This looks lazy and unsafe quoting.  Is there anything that makes
> sure repository path does not contain a single quote?

No. But...wait, checking...the Perl code didn't have the analogous
check, so there's no increased vulnerability here.  I'll put it on the
to-do list for after I ship parsecvs.

> > +    def command(self):
> > +        "Emit the command implied by all previous options."
> > +        return "(cvs2git --username=git-cvsimport --quiet --quiet --blobfile={0} --dumpfile={1} {2} {3} && cat {0} {1} && rm {0} {1})".format(tempfile.mkstemp()[1], tempfile.mkstemp()[1], self.opts, self.modulepath)
> 
> Could we do something better with this overlong source line?

Yes.  The correct fix is to simplify cvs2git's rather baroque command-line 
interface.  Michael Haggerty has accepted that patch.  Soon that line will
look like this:

     return "cvs2git --quiet --quiet {0} {1}".format(self.opts, self.modulepath)

Older versions of cvs2git will terminate cleanly with an error message 
when called this way.

> > +        elif opt == '-o':
> > +            sys.stderr.write("git cvsimport: -o is no longer supported.\n")
> > +            sys.exit(1)
> 
> Isn't this a regression?

It would be if the -o behavior were consistent and decently
documented.  When I tested this option with the Perl version I got no
result.  Possibly my usage was incorrect; if anyone can be found who
actually understands how it's supposed to work in detail and will tell
me, I can probably support it.

> > +        elif opt in ('-m', '-M'):
> > +            sys.stderr.write("git cvsimport: -m and -M are no longer supported: use reposurgeon instead.\n")
> > +            sys.exit(1)
> 
> I wonder if it is better to ignore these options with a warning but
> still let the command continue; cvsps-3.x was supposed to get merges
> right without the help of these ad-hoc options, no?

Sorry, I don't know where you got that idea. I don't think the general merge
detection that would need is possible even in principle.

> Otherwise it looks like a regression to me.

There are two reasons -m and -M aren't supported.

One is implementation-level.  The wrapper script no longer deals with
individual files or changesets or branches; it relies on the
conversion engine to do all that.  (As it should - the old design was
a mess with lots of stuff being done at the wrong level.)  But the
conversion engines don't implement -m or -M, and aren't ever going to
(see next paragraph).

The other is a design-level problem - these options were a bad idea to
begin with.  In earlier list mail I said

    An example of the batchiness mistake close to home is the -m and -M
    options in the old version of cvsimport.  It takes human judgment
    looking at the whole commit DAG in gitspace to decide what merge
    points would best express the (as you say, sometimes ambiguous) CVS
    history - what's needed is a scalpel and sutures in a surgeon's hand,
    not a regexp hammer.

One specific problem with the regexp hammer is false-positive matches
leading to unintended merges.

That's why I won't implement these in cvsps or parsecvs. Instead I've
just added DAG visualization via graphviz in reposurgeon, so a human
can quickly see candidate merges in the visualization and do them by
hand.  This is better and safer.

> Having the code to die when it sees options the rewritten version
> does not yet support before it calls the fallback makes the fallback
> much less effective, no?

Only to the extent that -o/-m/-M are really important, which I doubt.
But that might be fixable, and I'll put it on the to-do list.

> Not very impressed (yet).  The advertised "fix major bugs" sounds
> more like "trade major bugs with different ones with a couple of
> feature removals" at this point.

If you think that, you have failed to understand just how broken and
dangerous the old combination is.  None of the details you've called
out are "major" by any stretch of the imagination compared to it
silently botching the translation of repositories.

Also bear in mind that leaving the old Perl code in place is not going
to be a viable option for more than a few months out.  As cvsps-3.x
propagates to the distros what you have is going to stop even its
current pretense of working.

Finally...my own purposes are fulfilled by having CVS exporters that can
do a decent job of front-ending for reposurgeon. Rewriting git's
wrapper script was extra work that I took on only because I wanted to
be friendly to the git project, *but*... 

...there is a limit to the amount of what I consider pointless
hoop-jumping that friendliness will buy you, and the 2.x fallback eas
already pushing that limit.  Tread a little more gently, Junio; I've
put in a lot of hard, boring work on git-cvsimport over the last two
weeks when I would rather have been doing other things, and my
patience for being nit-picked without appreciation or reward has a
correspondingly low limit.  We'll both be happier if you don't reach
it.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>

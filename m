From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH v2 08/16] remote-helpers: Support custom transport
	options
Date: Tue, 13 Oct 2009 11:45:31 -0700
Message-ID: <20091013184531.GB9261@spearce.org>
References: <1255400715-10508-1-git-send-email-spearce@spearce.org> <1255400715-10508-9-git-send-email-spearce@spearce.org> <alpine.LNX.2.00.0910122357230.32515@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Oct 13 20:55:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxmWn-00065q-1V
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 20:55:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760952AbZJMSqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 14:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760087AbZJMSqJ
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 14:46:09 -0400
Received: from george.spearce.org ([209.20.77.23]:35494 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760951AbZJMSqI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 14:46:08 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 4F338381FE; Tue, 13 Oct 2009 18:45:31 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0910122357230.32515@iabervon.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130183>

Daniel Barkalow <barkalow@iabervon.org> wrote:
> > diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
> > +'option' <name>::
> > +	This helper supports the option <name> under fetch-multiple.
> > +
> 
> I'm a bit surprised that the options only apply in a fetch-multiple 
> section, rather than getting set at the beginning and applying to 
> everything for that run. At least, I think an "option" command should be 
> useable outside of a fetch-multiple (or possible future grouping 
> construct) and have global scope.

In hindsight, I agree with you.

I'll respin the series so the set_option method in the transport
forwards the options immediately to the helper and lets the helper
decide whether it accepts or rejects the option string.  This will
clean up the capabilities interface since we no longer need to dump
the list of options we support in the helper, and as you point out,
it will make a lot more sense to just set the options for this
transport instance.
 
> >  REF LIST ATTRIBUTES
> >  -------------------
> >  
> > @@ -76,10 +80,26 @@ None are defined yet, but the caller must accept any which are supplied.
> >  
> >  FETCH OPTIONS
> >  -------------
> > +To enable an option the helper must list it in 'capabilities'.
> >  
> >  'option verbose'::
> >  	Print more verbose activity messages to stderr.
> 
> I think you mis-split the above part; your previoud patch declared this 
> option without declaring any way to use it. Might be worth allowing 
> multiple "verboses" and "quiet" or "option verbosity quiet"/"option 
> verbosity verbose verbose".

Hmmph.  "option verbosity verbose verbose" is a bit verbose, don't
you think?  :-)

I think we should just forward the verbosity setting from the
frontend: "option verbosity [0-n]" where n is the number of
times -v appeared on the command line/how verbose the user wants.
 
> > +'option uploadpack' <command>::
> > +	The program to use on the remote side to generate a pack.
> 
> I sort of feel like the helper ought to read this one out of the config 
> file itself if it wants it.

Eh, true, but you can also set this on the command line.  An open
question I still have for myself is how to set this in HTTP
transports.

The reason why I care is Gerrit Code Review has overloaded the
'git-receive-pack' executable and taught it more command line flags:

  $ ssh r git receive-pack -h
  git receive-pack PROJECT.git [--cc EMAIL ...] [--help (-h)] [--reviewer (--re) EMAIL ...]

   PROJECT.git             : project name
   --cc EMAIL              : CC user on change(s)
   --help (-h)             : display this help text
   --reviewer (--re) EMAIL : request reviewer for change(s)

Which is typically invoked as:

  git push --receive-pack "git-receive-pack --reviewer spearce@spearce.org" URL REFSPEC

Folks actually have scripts which make this invocation for them, so
they can insert in the proper reviewer and/or cc arguments.  Since
the arguments vary its hard to set this up in the configuration file.

Over SSH this is fine, we obtain the arguments off the SSH command
line string and its no big deal.  Over git:// this would fail as
git-daemon can't parse the line anymore.  Over HTTP this also is not
going to work since the service can't receive arbitrary arguements.

My primary motivator for doing smart HTTP now is folks who are
stuck behind firewalls that permit only HTTP through their local
proxy servers are unable to communicate with a Gerrit Code Review
instance over SSH on port 29418.  That --reviewer flag above is a
very useful feature of Gerrit that I somehow have to support for
the HTTP transport too.

I started down the road of currying this data into the backend by
at least exposing the option to the helper.  How the helper reads
and uses it is up to the helper.

But given that the value can come in from the command line or from
the configuration file, I think this should be handled by fetch
or push porcelain and fed through the helper protocol, and not be
something that the helper reads from the config directly.

> In general, it would be good to have 
> transport.c and remote.c out of the business of knowing this sort of 
> protocol-specific (albiet specific now to two protocols) information. (Of 
> course, the native protocol's transport methods are in transport.c, so 
> that's there, but I'd like to move that to a transport-native.c someday.)

Agreed, but I have no solution for you due to the --receive-pack
and --upload-pack arguments supported by the command line git push
and git fetch/pull porcelain.

But I have been trying to extend the helper interface in a way
that would allow us to eject the native transport code entirely
into a helper.  We may never bother, there are some advantages to
being in the push/fetch client process, but I also didn't want to
get stuck in a corner.

I think with my series we do almost everything we need to support
native git:// in an external helper process rather than builtin.
We honor the pack lock file system used by fetch to maintain safe
concurrent mutations.  We use push_refs API and signal back the
complete information from the remote side.  We permit arbitrary
message strings per ref to be returned by the helper.  Etc.
 
> > +'option followtags'::
> > +	Aggressively fetch annotated tags if possible.
> 
> I assume this means to fetch tags which annotate objects we have or are 
> fetching? (As opposed to fetching any annotated tag we could possibly 
> fetch, even if we don't otherwise care about the tag or the thing it 
> tags.) It's obvious in the context of git's config options, but I'd like 
> this document to avoid assuming that context, and the option could apply 
> more generally.

Yes.  I'll extend the documentation further in the next iteration.
 
> > +'option thin'::
> > +	Transfer the data as a thin pack if possible.
> 
> Does anyone still use non-default thinness? 

Its a command line option on the porcelain.  Until we remove
the command line flag I think we should still try to honor it
in implementations that understand that notion.

-- 
Shawn.

From: Nicolas Pitre <nico@cam.org>
Subject: Re: Continue git clone after interruption
Date: Wed, 19 Aug 2009 13:21:19 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908191122020.6044@xanadu.home>
References: <1250509342.2885.13.camel@cf-48>
 <alpine.DEB.1.00.0908171430010.4991@intel-tinevez-2-302>
 <vpqskfphe2k.fsf@bauges.imag.fr> <1250578735.2885.40.camel@cf-48>
 <alpine.LFD.2.00.0908181246470.6044@xanadu.home>
 <m3fxbpneqe.fsf@localhost.localdomain>
 <alpine.LFD.2.00.0908181537360.6044@xanadu.home>
 <alpine.DEB.1.00.0908190022090.8306@pacific.mpi-cbg.de>
 <alpine.LFD.2.00.0908181936130.6044@xanadu.home>
 <alpine.DEB.1.00.0908190921360.5594@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_FKh2ahOE7kV9UbqhABf4PA)"
Cc: Jakub Narebski <jnareb@gmail.com>,
	Tomasz Kontusz <roverorna@gmail.com>, git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 19 19:21:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mdoqt-0002vG-W6
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 19:21:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbZHSRV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 13:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbZHSRV0
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 13:21:26 -0400
Received: from relais.videotron.ca ([24.201.245.36]:50844 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbZHSRVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 13:21:25 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KOM0025KW7JIDI0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 19 Aug 2009 13:21:21 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.DEB.1.00.0908190921360.5594@intel-tinevez-2-302>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126565>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_FKh2ahOE7kV9UbqhABf4PA)
Content-type: TEXT/PLAIN; charset=VISCII
Content-transfer-encoding: 8BIT

On Wed, 19 Aug 2009, Johannes Schindelin wrote:

> Hi,
> 
> On Tue, 18 Aug 2009, Nicolas Pitre wrote:
> 
> > On Wed, 19 Aug 2009, Johannes Schindelin wrote:
> > 
> > > But seriously, I miss a very important idea in this discussion: we 
> > > control the Git source code.  So we _can_ add a upload_pack feature 
> > > that a client can ask for after the first failed attempt.
> > 
> > Indeed.  So what do you think about my proposal?  It was included in my 
> > first reply to this thread.
> 
> Did you not talk about an extension of the archive protocol?  That's not 
> what I meant.  The archive protocol can be disabled for completely 
> different reasons than to prevent restartable clones.

And those reasons are?

> But you brought up an important point: shallow repositories.
> 
> Now, the problem, of course, is that if you cannot even get a single ref 
> (shallow'ed to depth 0 -- which reminds me: I think I promised to fix 
> that, but I did not do that yet) due to intermittent network failures, you 
> are borked, as you said.

Exact.

> But here comes an idea: together with Nguy­n's sparse series, it is 
> conceivable that we support a shallow & narrow clone via the upload-pack 
> protocol (also making mithro happy).  The problem with narrow clones was 
> not the pack generation side, that is done by a rev-list that can be 
> limited to certain paths.  The problem was that we end up with missing 
> tree objects.  However, if we can make a sparse checkout, we can avoid 
> the problem.

Sure, if you can salvage as much as you can from a partial pack and 
create a shallow and narrow clone out of it then it should be possible 
to do some restartable clone.  I still think this might be much less 
complex to achieve through git-archive, especially if some files i.e. 
objects are large enough to expose themselves to network outage.  It is 
like the same issue as being able to fetch at least one revision but to 
a lesser degree.  You might be able to get that first revision through 
multiple attempts by gathering missing objects on each attempt.  But if 
you encounter an object large enough you then might be unlucky enough 
not to be able to transfer it all before the next network failure.

With a simple extension to git-archive, any object content could be 
resumed many times from any offset.  Then, deepening the history should 
make use of deltas through the pack protocol which should hopefully 
consist of much smaller transfers and therefore less prone to network 
outage.

That could be sketched like this, supposing user runs
"git clone git://foo.bar/baz":

1) "git ini baz" etc. as usual.

2) "git ls-remote git://foo.bar/baz HEAD" and store the result in
   .git/CLONE_HEAD so not to be confused by the remote HEAD possibly 
   changing before we're done.

3) "git archive --remote=git://foo.bar/baz CLONE_HEAD" and store the 
   result locally. Keep track of how many files are received, and how 
   many bytes for the currently received file.

4) if network connection is broken, loop back to (3) adding
   --skip=${nr_files_received},${nr_bytes_in_curr_file_received} to
   the git-archive argument list.  REmote server simply skips over 
   specified number of files and bytes into the next file.

5) Get content from remote commit object for CLONE_HEAD somehow. (?)

6) "git add . && git write-tree" and make sure the top tree SHA1 matches 
   the one in the commit from (5).

7) "git hash-object -w -t commit" with data obtained in (5), and make 
   sure it matches SHA1 from CLONE_HEAD.

8) Update local HEAD with CLONE_HEAD and set it up as a shallow clone.
   Delete .git/CLONE_HEAD.

9) Run "git fetch" with the --depth parameter to get more revisions.

Notes:

- This mode of operation should probably be optional, like by using 
  --safe or --restartable with 'git clone'.  And since this mode of 
  operation is really meant for people with slow and unreliable network 
  connections, they're unlikely to wish for the whole history to be 
  fetched.  Hence this mode could simply be triggered by the --depth 
  parameter to 'git clone' which would provide a clear depth value to 
  use in (9).

- If the transfer is interrupted locally with ^C then it should be 
  possible to resume it by noticing the presence of .git/CLONE_HEAD
  up front.  DEtermining how many files to skip when resuming with 
  git-archive can be done with $((`git ls-files -o | wc -l` - 1)) and
  $(git ls-files -o | tail -1 | wc -c).

- That probably would be a good idea to have a tgz format to 'git 
  archive' which might be simpler to deal with than the zip format.

- Step (3) could be optimized in many ways, like by directly using 
  hash-object and update-index, or by using a filter to pipe the result 
  directly into fast-import.

- So to say that the above should be pretty easy to implement even 
  with a shell script.  A builtin version could then be made if this 
  proves to actually be useful.  And the server remains stateless with 
  no additional caching needed which would go against any attempt 
  at making a busy server like git.kernel.org share as much of the 
  object store between plenty of mostly identical repositoryes.

> Note: this is not well thought-through, but just a brainstorm-like answer 
> to your ideas.

And so is the above.


Nicolas

--Boundary_(ID_FKh2ahOE7kV9UbqhABf4PA)--

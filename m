From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: cvsps, parsecvs, svn2git and the CVS exporter mess
Date: Sat, 5 Jan 2013 10:11:07 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20130105151106.GA1938@thyrsus.com>
References: <20121222173649.04C5B44119@snark.thyrsus.com>
 <50E5A5CF.2070009@alum.mit.edu>
 <20130103205301.GD26201@thyrsus.com>
 <1E7F9F86-F040-42E4-98C4-152B8CCE47CE@quendi.de>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Yann Dirson <ydirson@free.fr>, Heiko Voigt <hvoigt@hvoigt.net>,
	Antoine Pelisse <apelisse@gmail.com>,
	Bart Massey <bart@cs.pdx.edu>,
	Keith Packard <keithp@keithp.com>,
	David Mansfield <david@cobite.com>, git@vger.kernel.org
To: Max Horn <postbox@quendi.de>
X-From: git-owner@vger.kernel.org Sat Jan 05 16:11:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrVPI-0001TI-Q2
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 16:11:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755750Ab3AEPLN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 10:11:13 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:53759
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755574Ab3AEPLM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 10:11:12 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 567554044B; Sat,  5 Jan 2013 10:11:07 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1E7F9F86-F040-42E4-98C4-152B8CCE47CE@quendi.de>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212698>

Max Horn <postbox@quendi.de>:
> Hm, you snipped this part of Michael's mail:
> 
> >> However, if that is a
> >> problem, it is possible to configure cvs2git to write the blobs inline
> >> with the rest of the dumpfile (this mode is supported because "hg
> >> fast-import" doesn't support detached blobs).
> 
> I would call "hg fast-import" a main potential customer, given that there "cvs2hg" is another part of the cvs2svn suite. So I can't quite see how you can come to your conclusion above...

Perhaps I was unclear.  I consider the interface design error to
be not in the fact that all the blobs are written first or detached,
but rather that the implementation detail of the two separate journal
files is ever exposed.

I understand why the storage of intermediate results was done this
way, in order to decrease the tool's working set during the run, but
finishing by automatically concatenating the results and streaming
them to stdout would surely have been the right thing here.
 
The downstream cost of letting the journalling implementation be
exposed, instead, can be seen in this snippet from the new git-cvsimport
I've been working on:

    def command(self):
        "Emit the command implied by all previous options."
        return "(cvs2git --username=git-cvsimport --quiet --quiet --blobfile={0} --dumpfile={1} {2} {3} && cat {0} {1} && rm {0} {1})".format(tempfile.mkstemp()[1], tempfile.mkstemp()[1], self.opts, self.modulepath)

According to the documentation, every caller of csv2git must go
through analogous contortions!  This is not the Unix way; if Unix
design principles had been minimally applied, that second line would
just read like this:

     return "cvs2git --username=git-cvsimport --quiet --quiet"

If Unix design principles had been thoroughly applied, the "--quiet
--quiet" part would be unnecessary too - well-behaved Unix commands
*default* to being completely quiet unless either (a) they have an
exceptional condition to report, or (b) their expected running time is
so long that tasteful silence would leave users in doubt that they're
working.

(And yes, I do think violating these principles is a lapse of taste when
git tools do it, too.)

Michael Haggerty wants me to trust that cvs2git's analysis stage has
been fixed, but I must say that is a more difficult leap of faith when
two of the most visible things about it are still (a) a conspicuous
instance of interface misdesign, and (b) documentation that is careless and
incomplete.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>

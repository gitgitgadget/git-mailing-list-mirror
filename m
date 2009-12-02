From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [RFC PATCH 0/8] Git remote helpers to implement smart
 transports.
Date: Wed, 2 Dec 2009 21:52:33 +0200
Message-ID: <20091202195233.GA11301@Knoppix>
References: <1259675838-14692-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <fabb9a1e0912010812t4de8027dj1faf828051d1adc2@mail.gmail.com>
 <20091201165245.GF21299@spearce.org>
 <20091201171908.GA15436@Knoppix>
 <20091201193009.GM21299@spearce.org>
 <7vskbuwhmy.fsf@alter.siamese.dyndns.org>
 <20091202055632.GD31244@Knoppix>
 <7vy6llnar5.fsf@alter.siamese.dyndns.org>
 <20091202160446.GA32667@Knoppix>
 <alpine.DEB.1.00.0912021832480.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 02 20:52:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFvFm-0005kE-Nw
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 20:52:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753834AbZLBTwf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 14:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753823AbZLBTwe
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 14:52:34 -0500
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:54599 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753627AbZLBTwe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 14:52:34 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id 5881218D2E6;
	Wed,  2 Dec 2009 21:52:39 +0200 (EET)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A017235465D; Wed, 02 Dec 2009 21:52:39 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id C779C158A6C;
	Wed,  2 Dec 2009 21:52:33 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0912021832480.4985@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134390>

On Wed, Dec 02, 2009 at 06:39:19PM +0100, Johannes Schindelin wrote:
> 
> This is definitely a good direction, and it would be even better if the 
> absence of the remote helper was also handled gracefully.  Just think 
> about a (as of now fictious) git-remote-http.rpm relying on git-core.rpm 
> and libcurl.rpm.  If you do not want to access http:// URLs, you can 
> install just git-core.  Once you encounter an http:// URL you need to 
> access, you install git-remote-http.  Keeping git-core.  (I like to call 
> this setup "modular".)

There are some rather unfortunate details relating to this.

Main git executable currently has no good way to discover what went wrong
with remote helper execution that fails before reaching capabilities
exchange.

It would be ideal if executions failing due to ENOENT would be reported
as remote helper not existing, other exec errors reported as failed execution,
fatal signals as remote helper crashing and other exits rely on remote helper
reporting the problem.

Unfortunately, this can't be done without breaking remote helper interface,
either by requiring initial response from helper or requiring helpers not
to explicitly fail due to bad parameters before reaching capabilities exchange,
since one can't know if execution was successuful without seeing at least
one incoming line.

IIRC, current versions print some rather funky error if you try to use
nonexistent helper: 'remote-foo is not git command' or some such.

> Of course, I never understood why the backend should know the 
> implementation detail that it is based on cURL, so it would be even more 
> modular (at least by my definition) if there was no hard-coded mapping 
> (Sverre -- Cc'ed -- seemed to like URLs of the form "svn::http://..." and 
> "cvs::pserver..." to trigger looking for a remote helper explicitely).  I 
> find the compiled-in mapping rather limiting.

That syntax is rather nice for handling foregin VCSes that may have URL forms
that overlap with native ones. But it sure isn't nice for those remote helpers
that implement git native transports (remote-curl is already a precedent on
doing that). 

The API is already general enough to do both: Git native transports (currently
dumb only without lots of effort, which this patchset is about) and foregin 
VCS bridges.

-Ilari

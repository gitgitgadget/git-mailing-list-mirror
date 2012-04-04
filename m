From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] add -p: skip conflicted paths
Date: Wed, 4 Apr 2012 16:25:27 -0400
Message-ID: <20120404202527.GA1363@sigill.intra.peff.net>
References: <1332966017-6100-1-git-send-email-kusmabite@gmail.com>
 <7viphotng8.fsf@alter.siamese.dyndns.org>
 <7vaa30tmk9.fsf@alter.siamese.dyndns.org>
 <7v62dotltk.fsf@alter.siamese.dyndns.org>
 <20120329054558.GA27604@sigill.intra.peff.net>
 <CABPQNSY8gNPZTV77AjFbHn1HA9S=fw3NC+H8bCzZOPFyLg0nHQ@mail.gmail.com>
 <7v398mgfdu.fsf@alter.siamese.dyndns.org>
 <20120404094618.GA13870@sigill.intra.peff.net>
 <7v398jbjbo.fsf@alter.siamese.dyndns.org>
 <7vty0z8i66.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: kusmabite@gmail.com, git@vger.kernel.org,
	matthieu.moy@grenoble-inp.fr, hellmuth@ira.uka.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 04 22:25:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFWlq-0008SE-Ms
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 22:25:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752414Ab2DDUZa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 16:25:30 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46209
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751823Ab2DDUZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 16:25:29 -0400
Received: (qmail 13661 invoked by uid 107); 4 Apr 2012 20:25:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 04 Apr 2012 16:25:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Apr 2012 16:25:27 -0400
Content-Disposition: inline
In-Reply-To: <7vty0z8i66.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194736>

On Wed, Apr 04, 2012 at 11:29:21AM -0700, Junio C Hamano wrote:

> >> So combining the two patches, we have
> >> something like:
> >
> > Hrm.  I kind of liked the idea of doing this with a single plumbing call
> > to diff-files (the entries that come from --raw will be mostly discarded
> > except for the ones that are marked with "U"), though.
> 
> That is, something like this on top of your patch.

Ugh, I totally misread your original message and missed the fact that we
_could_ see what we wanted by adding "--raw". Sorry to be dense.

Yes, this is way better. I don't mind discarding the --raw entries that
are not used; they cost nothing to generate on top of what we are
already doing, so it is really just the cost of shuttling a few bytes
across the pipe.

> -	for (run_cmd_pipe(qw(git diff-files --numstat --summary --), @tracked)) {
> +	for (run_cmd_pipe(qw(git diff-files --numstat --summary),
> +			  ($note_unmerged ? ("--raw") : ()),
> +			  "--", @tracked)) {

Maybe it is not worth even having $note_unmerged, and just filling in
the UNMERGED field unconditionally? I know other callers don't care
about the information, but it's so cheap, and it just makes the function
interface that much simpler.

-Peff

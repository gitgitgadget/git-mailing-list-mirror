From: bdowning@lavos.net (Brian Downing)
Subject: Re: Preferring shallower deltas on repack
Date: Mon, 9 Jul 2007 13:53:53 -0500
Message-ID: <20070709185353.GL4087@lavos.net>
References: <20070709044326.GH4087@lavos.net> <7v1wfixhvk.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.999.0707090954550.26459@xanadu.home> <7vir8tv8dr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 09 20:54:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7yNW-0000f6-83
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 20:54:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757712AbXGISyI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 14:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758142AbXGISyH
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 14:54:07 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:9930 "EHLO
	asav00.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757712AbXGISyF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 14:54:05 -0400
Received: from 74-134-246-243.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.246.243])
  by asav00.insightbb.com with ESMTP; 09 Jul 2007 14:54:03 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AnA9AJwhkkZKhvbzR2dsb2JhbACBSoVdiAMBAT8B
Received: by mail.lavos.net (Postfix, from userid 1000)
	id 1B4D8309F31; Mon,  9 Jul 2007 13:53:54 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <7vir8tv8dr.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52011>

On Mon, Jul 09, 2007 at 09:39:44AM -0700, Junio C Hamano wrote:
> > OK here it is.  And results on the GIT repo and another patalogical test 
> > repo I keep around are actually really nice!  Not only the pack itself 
> > is a bit smaller, but the delta depth distribution as shown by 
> > git-verify-pack -v is much nicer with the bulk of deltas in the low 
> > depth end of the spectrum and no more peak at the max depth level.
> 
> Looks obviously correct.  Brian, it would be very interesting to
> see what Nico's patch does to your dataset.

Nico's patch makes the overall statistics look better, but the
version.lisp-expr file still goes 593 levels deep, as opposed to about
65 with my patch.  (That's better than 980 with stock Git, though.)

Pack statistics from my shoddy analysis tool (I'll post it a bit later):

"sizes" are all object sizes in the pack.  For deltas this is just the
delta size.  "path sizes" is the size of the /path/ to each object in
the file; this is the size of the base and each patch in the chain to
the object.  This is approximately how much data you have to read to
get to an object.  "depths" should be obvious.

SBCL, stock git:
      all sizes: count 46829 total 30256118 min 0 max 1012295 mean 646.10 median 45 std_dev 9555.48
 all path sizes: count 46829 total 1551200401 min 0 max 1012295 mean 33124.78 median 11661 std_dev 55310.88
         depths: count 46829 total 4693372 min 0 max 980 mean 100.22 median 12 std_dev 188.21

SBCL, my patch:
      all sizes: count 46829 total 30251762 min 0 max 1012295 mean 646.00 median 45 std_dev 9555.48
 all path sizes: count 46829 total 1529629918 min 0 max 1012295 mean 32664.16 median 11213 std_dev 54930.06
         depths: count 46829 total 2883121 min 0 max 787 mean 61.57 median 11 std_dev 127.64

SBCL, Nico's patch:
      all sizes: count 46829 total 30253345 min 0 max 1012295 mean 646.04 median 45 std_dev 9555.49
 all path sizes: count 46829 total 1518730701 min 0 max 1012295 mean 32431.41 median 10819 std_dev 54751.35
         depths: count 46829 total 3694511 min 0 max 699 mean 78.89 median 12 std_dev 141.53

I'm vaguely working on an alternate weighting mechanism based on path
sizes, but so far all I've been able to do is generate some really
strange packs.  :)

-bcd

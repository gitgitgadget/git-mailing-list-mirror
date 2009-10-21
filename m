From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 7/6 (v4)] support for commit grafts, slight change to general mechanism
Date: Wed, 21 Oct 2009 15:44:07 +0200
Message-ID: <200910211544.08776.trast@student.ethz.ch>
References: <op.uzv4dyuotdk399@sirnot.private> <4ADCCCA9.4000802@gmail.com> <200910211115.25017.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sam Vilain <sam@vilain.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Nick Edelen <sirnot@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 15:52:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0bUp-0003HX-Lx
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 15:45:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753427AbZJUNot (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 09:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753419AbZJUNot
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 09:44:49 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:53786 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753330AbZJUNot (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 09:44:49 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.176.0; Wed, 21 Oct
 2009 15:44:52 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Wed, 21 Oct
 2009 15:44:42 +0200
User-Agent: KMail/1.12.2 (Linux/2.6.27.29-0.1-default; KDE/4.3.1; x86_64; ; )
In-Reply-To: <200910211115.25017.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130916>

Thomas Rast wrote:
> Nick Edelen wrote:
> > Adds support for graft commits in rev-cache (w/ test), and slightly alters
> > graft mechanism.  Before, parse_commit() checked the graft list on every
> > commit.  Now register_commit_graft() preemptively loads graft commits into
> > memory, and sets a new 'graft' flag in the object.  This allows awareness of
> > the commits' medical history without searching a (normally private) array upon
> > each commit.
> 
> I felt adventurous and merged the topic into my local build, but I get
> "error: duplicate graft data ..." in repositories with only a single
> line in .git/info/grafts, which bisects to this commit (1c0a666 in
> today's pu).

Here's the complaint in squashable form if you want to keep it as a
testcase:

diff --git i/t/t6001-rev-list-graft.sh w/t/t6001-rev-list-graft.sh
index b2131cd..49ba37b 100755
--- i/t/t6001-rev-list-graft.sh
+++ w/t/t6001-rev-list-graft.sh
@@ -110,4 +110,18 @@ do
 	"
 
 done
+
+duplicate_error="error: duplicate graft"
+
+test_expect_success 'duplicates: no false positives' '
+	echo $B0 $A2 > .git/info/grafts &&
+	! git rev-list -1 HEAD 2>&1 | grep -q "$duplicate_error"
+'
+
+test_expect_success 'duplicates: no false negatives' '
+	echo $B0 $A2 > .git/info/grafts &&
+	echo $B0 $A1 >> .git/info/grafts &&
+	git rev-list -1 HEAD 2>&1 | grep "$duplicate_error"
+'
+
 test_done


-- 
Thomas Rast
trast@{inf,student}.ethz.ch

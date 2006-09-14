From: Nathaniel Smith <njs@pobox.com>
Subject: Re: cvs import
Date: Wed, 13 Sep 2006 17:32:42 -0700
Message-ID: <20060914003242.GA19228@frances.vorpus.org>
References: <45084400.1090906@bluegap.ch>
	<20060913225200.GA10186@frances.vorpus.org>
	<1158190921.29313.175.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: dev@cvs2svn.tigris.org, monotone-devel@nongnu.org,
	Git Mailing List <git@vger.kernel.org>
X-From: monotone-devel-bounces+gcvmd-monotone-devel=m.gmane.org@nongnu.org Thu Sep 14 02:32:56 2006
Return-path: <monotone-devel-bounces+gcvmd-monotone-devel=m.gmane.org@nongnu.org>
Envelope-to: gcvmd-monotone-devel@m.gmane.org
Received: from lists.gnu.org ([199.232.76.165])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNf9u-0005k4-Jm
	for gcvmd-monotone-devel@m.gmane.org; Thu, 14 Sep 2006 02:32:51 +0200
Received: from localhost ([127.0.0.1] helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43)
	id 1GNf9t-0008IE-OP
	for gcvmd-monotone-devel@m.gmane.org; Wed, 13 Sep 2006 20:32:49 -0400
Received: from mailman by lists.gnu.org with tmda-scanned (Exim 4.43)
	id 1GNf9q-0008HV-LJ
	for monotone-devel@nongnu.org; Wed, 13 Sep 2006 20:32:46 -0400
Received: from exim by lists.gnu.org with spam-scanned (Exim 4.43)
	id 1GNf9p-0008F7-98
	for monotone-devel@nongnu.org; Wed, 13 Sep 2006 20:32:45 -0400
Received: from [199.232.76.173] (helo=monty-python.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43) id 1GNf9p-0008Ew-1e
	for monotone-devel@nongnu.org; Wed, 13 Sep 2006 20:32:45 -0400
Received: from [208.210.124.79] (helo=rune.pobox.com)
	by monty-python.gnu.org with esmtp (Exim 4.52) id 1GNfBe-0000zr-BU
	for monotone-devel@nongnu.org; Wed, 13 Sep 2006 20:34:38 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 208B28058E;
	Wed, 13 Sep 2006 20:33:06 -0400 (EDT)
Received: from frances.frop.org (adsl-66-159-194-130.dslextreme.com
	[66.159.194.130]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 794318020C;
	Wed, 13 Sep 2006 20:33:02 -0400 (EDT)
Received: from njs by frances.frop.org with local (Exim 4.63)
	(envelope-from <njs@pobox.com>)
	id 1GNf9m-0005Yf-TH; Wed, 13 Sep 2006 17:32:42 -0700
To: Keith Packard <keithp@keithp.com>
Mail-Followup-To: Keith Packard <keithp@keithp.com>,
	dev@cvs2svn.tigris.org, monotone-devel@nongnu.org,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1158190921.29313.175.camel@neko.keithp.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-BeenThere: monotone-devel@nongnu.org
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: developer discussion for monotone <monotone-devel.nongnu.org>
List-Unsubscribe: <http://lists.nongnu.org/mailman/listinfo/monotone-devel>,
	<mailto:monotone-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/pipermail/monotone-devel>
List-Post: <mailto:monotone-devel@nongnu.org>
List-Help: <mailto:monotone-devel-request@nongnu.org?subject=help>
List-Subscribe: <http://lists.nongnu.org/mailman/listinfo/monotone-devel>,
	<mailto:monotone-devel-request@nongnu.org?subject=subscribe>
Sender: monotone-devel-bounces+gcvmd-monotone-devel=m.gmane.org@nongnu.org
Errors-To: monotone-devel-bounces+gcvmd-monotone-devel=m.gmane.org@nongnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26966>

On Wed, Sep 13, 2006 at 04:42:01PM -0700, Keith Packard wrote:
> However, this means that parsecvs must hold the entire tree state in
> memory, which turned out to be its downfall with large repositories.
> Worked great for all of X.org, not so good with Mozilla.

Does anyone know how big Mozilla (or other humonguous repos, like KDE)
are, in terms of number of files?

A few numbers for repositories I had lying around:
  Linux kernel -- ~21,000
  gcc -- ~42,000
  NetBSD "src" repo -- ~100,000
  uClinux distro -- ~110,000

These don't seem very indimidating... even if it takes an entire
kilobyte per CVS revision to store the information about it that we
need to make decisions about how to move the frontier... that's only
110 megabytes for the largest of these repos.  The frontier sweeping
algorithm only _needs_ to have available the current frontier, and the
current frontier+1.  Storing information on every version of every
file in memory might be worse; but since the algorithm accesses this
data in a linear way, it'd be easy enough to stick those in a
lookaside table on disk if really necessary, like a bdb or sqlite file
or something.

(Again, in practice storing all the metadata for the entire 180k
revisions of the 100k files in the netbsd repo was possible on a
desktop.  Monotone's cvs_import does try somewhat to be frugal about
memory, though, interning strings and suchlike.)

-- Nathaniel

-- 
When the flush of a new-born sun fell first on Eden's green and gold,
Our father Adam sat under the Tree and scratched with a stick in the mould;
And the first rude sketch that the world had seen was joy to his mighty heart,
Till the Devil whispered behind the leaves, "It's pretty, but is it Art?"
  -- The Conundrum of the Workshops, Rudyard Kipling

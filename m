From: Ian Kumlien <pomac@vapor.com>
Subject: Re: [PATCH 2/2] index-pack: reduce memory usage when the pack has
 large blobs
Date: Sun, 26 Feb 2012 14:28:34 +0100
Message-ID: <20120226132834.GK9526@pomac.netswarm.net>
References: <1330086201-13916-1-git-send-email-pclouds@gmail.com>
 <1330086201-13916-2-git-send-email-pclouds@gmail.com>
 <20120224161613.GH9526@pomac.netswarm.net>
 <CACsJy8C-8dvXpNTU=JpdupSpS8OuqqTpGvDs6s1ASeKdk9d5Dg@mail.gmail.com>
 <20120225224533.GJ9526@pomac.netswarm.net>
 <CACsJy8Cncs8RYiSB0N20vy9zu2NRTTHpfw3rSfmW64i-4_wxSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 26 14:29:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1eAE-00015i-9v
	for gcvg-git-2@plane.gmane.org; Sun, 26 Feb 2012 14:29:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409Ab2BZN2r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Feb 2012 08:28:47 -0500
Received: from mail.vapor.com ([83.220.149.2]:49743 "EHLO nitrogen.vapor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751150Ab2BZN2q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2012 08:28:46 -0500
Received: from twilight.demius.net (c-387a71d5.013-195-6c756e10.cust.bredbandsbolaget.se [213.113.122.56])
	by nitrogen.vapor.com (Postfix) with ESMTPSA id E21F440CA49;
	Sun, 26 Feb 2012 14:28:35 +0100 (CET)
Received: by twilight.demius.net (Postfix, from userid 1000)
	id 13FDB8E6B54; Sun, 26 Feb 2012 14:28:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CACsJy8Cncs8RYiSB0N20vy9zu2NRTTHpfw3rSfmW64i-4_wxSw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191560>

On Sun, Feb 26, 2012 at 11:10:14AM +0700, Nguyen Thai Ngoc Duy wrote:
> On Sun, Feb 26, 2012 at 5:45 AM, Ian Kumlien <pomac@vapor.com> wrote:
> > Actually, i added a backtrace and used addr2line to confirm my
> > suspicion... which is:
> > builtin/index-pack.c:414
> >
> > ie get_data_from_pack...
> 
> That function should only be called when objects are deltified, which
> should _not_ happen for large blobs. What is its caller?

Full backtrace:

for x in 0x536031 0x451b0e 0x452212 0x4523f5 0x452711 0x452799 0x452bbb
0x454344 0x4170d1 0x41726c ; do addr2line $x -e ../git/git ; done
git/wrapper.c:41
git/builtin/index-pack.c:414
git/builtin/index-pack.c:588
git/builtin/index-pack.c:625
git/builtin/index-pack.c:679
git/builtin/index-pack.c:694
git/builtin/index-pack.c:805
git/builtin/index-pack.c:1246
git/git.c:308
git/git.c:467

Which means:
xmalloc
get_data_from_pack
get_base_data -- line just after: if (!delta_nr) {
resolve_delta
find_unresolved_deltas_1
find_unresolved_deltas
parse_pack_objects
cmd_index_pack
[skipping the git.c part]

Btw, i'm running these tests on a 64 bit laptop - since i'm not at work
;) (had to manually limit xmalloc but it triggers at the same point)

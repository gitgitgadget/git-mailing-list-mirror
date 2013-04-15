From: Jeff King <peff@peff.net>
Subject: Re: Fwd: Re: git send-pack: protocol error: bad band #50
Date: Sun, 14 Apr 2013 21:04:27 -0400
Message-ID: <20130415010427.GB6477@sigill.intra.peff.net>
References: <51674966.8010403@netcabo.pt>
 <51693B73.3030007@netcabo.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Konstantin Khomoutov <flatworm@users.sourceforge.net>
To: =?utf-8?B?Sm/Do28=?= Joyce <joao.joyce@netcabo.pt>
X-From: git-owner@vger.kernel.org Mon Apr 15 03:04:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URXqX-00035P-0c
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 03:04:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753928Ab3DOBEd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Apr 2013 21:04:33 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45847 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752366Ab3DOBEc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 21:04:32 -0400
Received: (qmail 18748 invoked by uid 107); 15 Apr 2013 01:06:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 14 Apr 2013 21:06:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 14 Apr 2013 21:04:27 -0400
Content-Disposition: inline
In-Reply-To: <51693B73.3030007@netcabo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221172>

On Sat, Apr 13, 2013 at 12:03:15PM +0100, Jo=C3=A3o Joyce wrote:

> I have tried to remove and recreate my git folder and remove some
> files to get more logs. Here they are:

Your output looks quite odd.

> packet:         push< 0000000000000000000000000000000000000000 capabi=
lities^{}\0 report-status delete-refs side-band-64k quiet ofs-delta
> packet:         push< 0000

So this is the server advertising its refs. It doesn't have any, so it
just gives a blank capabilities string, followed by a flush. OK.

> packet:         push> 0000000000000000000000000000000000000000 17c420=
b8bd99856aee6da9c1743f6df0ec18a9ca refs/heads/master\0report-status sid=
e-band-64k
> packet:         push> 0000

And we want to push up one ref, so we send it, along its old and new
sha1s, its name, and our own capabilities list. And then we flush. OK.

> packet:         push< 20b8bd99856aee6da9c1743f6df0ec18a9cac28267338c1=
98573ad59e89d0acc445a62b3d127
> acf853d0a30287d9455dbe1707edeb16cc3e9b22

Now what the heck is this? We should be sending the packfile next,
and the server should send us back the ref status. It would look
something like:

packet:         push< 0000000000000000000000000000000000000000 capabili=
ties^{}\0 report-status delete-refs side-band-64k quiet ofs-delta
packet:         push< 0000
packet:         push> 0000000000000000000000000000000000000000 662bbff2=
308c7e72f417d3419f4984222faf7ef8 refs/heads/master\0 report-status side=
-band-64k
packet:         push> 0000
packet:         push< \1000eunpack ok0019ok refs/heads/master0000
packet:         push< 0000
packet:         push< unpack ok
packet:         push< ok refs/heads/master
packet:         push< 0000

What is generating that output on the server? Do you have any hooks on
the server repository that might generate output (we _should_ be
channeling their output over the sideband, but we might have missed a
case). What transport are you using (git-over-ssh, git-over-http, etc)?

-Peff

From: Shawn Pearce <spearce@spearce.org>
Subject: Re: GSoC resumable clone
Date: Fri, 11 Mar 2011 07:17:31 -0800
Message-ID: <AANLkTinrgqLhZK=fQ_+gUanT-zy9Mcbw-y3o7nYV9A-m@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>, git <git@vger.kernel.org>,
	Pranav Ravichandran <prp.1111@gmail.com>
To: Alexander Miseler <alexander@miseler.de>
X-From: git-owner@vger.kernel.org Fri Mar 11 16:18:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Py46I-0006yQ-Ts
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 16:17:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754093Ab1CKPRx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2011 10:17:53 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:39223 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113Ab1CKPRw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2011 10:17:52 -0500
Received: by vxi39 with SMTP id 39so2616139vxi.19
        for <git@vger.kernel.org>; Fri, 11 Mar 2011 07:17:52 -0800 (PST)
Received: by 10.52.169.97 with SMTP id ad1mr10270610vdc.106.1299856671304;
 Fri, 11 Mar 2011 07:17:51 -0800 (PST)
Received: by 10.52.162.33 with HTTP; Fri, 11 Mar 2011 07:17:31 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168906>

On Fri, Mar 11, 2011 at 06:10, Alexander Miseler <alexander@miseler.de> wrote:
> On 11.03.2011 14:48, Nguyen Thai Ngoc Duy wrote:
>>> On Fri, Mar 11, 2011 at 01:18:45PM +0100, Alexander Miseler wrote:
>>>>
>>>> Resumable clone
>>
>> A simpler way to restartable clone is to facilitate bundles (Nicolas'
>> idea). Some glue is needed to teach git-fetch/git-daemon to use the
>> bundles, and git-push to automatically create bundles periodically (or
>> a new command that can be run from cron). I think this way fit in GSoC
>> scope better.

I think the cached bundle idea is horrifically stupid in the face of
the subsequent cached pack idea. JGit already implements cached packs,
and it works very well. The feature just needs to be back-ported to
builtin/pack-objects.c, along with some minor edits to my RFC patch to
git-repack.sh to be able to construct the cached pack.

Unlike a cached bundle, the cached pack doesn't eat up useless disk
space on the server. Its still the only copy of the object content,
which keeps server disk usage (and buffer cache usage) lower.

A protocol extension in the fetch-pack/upload-pack protocol is
required to allow pack-objects to delimit the early thin-pack from the
later cached pack, as well as supply the cached-pack's identity. A
client who breaks the connection after the leading thin-pack has been
received could restart by downloading the cached pack from a specific
starting byte.

Without waiting for pack v4, cached packs can shave a full minute of
server CPU time during a clone of the linux-2.6 kernel. That's nothing
to laugh at, its a full CPU minute. These days a full CPU minute is a
lot of computational work. It also is pretty backwards compatible with
the current network protocol, even ancient Git clients can still use
the cached pack during an initial clone, saving a lot of server
resources.

With cached packs, organizations like Gentoo wouldn't need to
implement bizarre hacks in their upload-pack binary to prevent clones
over git:// from their servers.

Its also well within GSoC size scope. I think the hard part is
understanding enough of how the revision walker works inside of
pack-objects in order to construct the leading thin-pack.

>> [1] The idea of my work above was mentioned elsewhere, history is cut
>> down by path. Each file/dir's history a very long chain of deltas. We
>> can stream deltas (in parallel if needed) over the wire, resuming
>> where the chain stops last time.
>
> This may all be aiming to short. IMHO the best solution would be some
> generic way for the client to specify exactly what it wants to get and to
> get just that. This would lay the groundwork for:
> - lazy clones
> - sparse clones
> - resumable cloning
> - resumable fetching

Junio and I would like see narrow checkout code re-implemented to
support obtaining only a subset of the paths from the remote.

Once that is implemented, a client on a really bad network connection
could do a resumable clone by grabbing a shallow clone of depth 1
along no paths, partition the root tree up, then extend its paths
grabbing subdirectories until the root commit is fully expanded. Then
it can walk back increasing its depth until it runs into the cached
pack... where it can then do byte range requests.

This won't be pretty. And given that the leading thin-pack for a
cached pack can be less than 2% of the entire data transfer, may not
be necessary for a resumable clone. IMHO if you cannot get 2% of the
data transfer before your connection breaks, maybe you should ask for
the data on DVD via post, because your network sucks.

-- 
Shawn.

From: Mike Hommey <mh@glandium.org>
Subject: Re: Why repository grows after "git gc"? / Purpose of *.keep files?
Date: Mon, 12 May 2008 23:03:04 +0200
Organization: glandium.org
Message-ID: <20080512210304.GA17352@glandium.org>
References: <20080512122900.GA13050@mithlond.arda.local> <20080512155243.GA3592@mithlond.arda.local> <alpine.DEB.1.00.0805121810501.30431@racer> <20080512184334.GB5160@mithlond.arda.local> <alpine.LFD.1.10.0805121453250.23581@xanadu.home> <20080512190946.GC5160@mithlond.arda.local> <alpine.LFD.1.10.0805121527550.23581@xanadu.home> <20080512202414.GA8620@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Mon May 12 23:04:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvfBs-00014H-Hi
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 23:04:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754758AbYELVDW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 17:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755461AbYELVDW
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 17:03:22 -0400
Received: from vuizook.err.no ([194.24.252.247]:52929 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753703AbYELVDV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 17:03:21 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JvfAr-0005Ng-Rw; Mon, 12 May 2008 23:03:16 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JvfAm-0005jo-SS; Mon, 12 May 2008 23:03:04 +0200
Content-Disposition: inline
In-Reply-To: <20080512202414.GA8620@mithlond.arda.local>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81949>

On Mon, May 12, 2008 at 11:24:14PM +0300, Teemu Likonen wrote:
> But I have experienced the same earlier with some other post-1.5.5
> version so I believe you can reproduce this yourself. After cloning
> Linus's linux-2.6 repo its .git directory weights 209MB. After single
> "git pull" and "git gc" it was 298MB in my test.

I noticed that a while ago: when repacking multiple packs when one has a
.keep file, the resulting additional pack contains too many blobs and
trees, contrary to when only packing loose objects:

$ git init
$ echo a > a; git add a; git commit -m a
$ git gc
Counting objects: 3, done.
Writing objects: 100% (3/3), done.
Total 3 (delta 0), reused 0 (delta 0)
$ git verify-pack -v .git/objects/pack/pack-b87e61e2dc18ff37624d7f996f1270f923411530.pack
4bba7c0583de30efff4097299f89b199ab4a6dff commit 160 116 12
78981922613b2afb6025042ff6bd878ac1994e85 blob   2 11 167
aaff74984cccd156a469afa7d9ab10e4777beb24 tree   29 39 128
.git/objects/pack/pack-b87e61e2dc18ff37624d7f996f1270f923411530.pack: ok

$ touch .git/objects/pack/pack-b87e61e2dc18ff37624d7f996f1270f923411530.keep
$ echo b > b; git add b; git commit -m b
$ git gc
Counting objects: 3, done.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), done.
Total 3 (delta 0), reused 0 (delta 0)
$ git verify-pack -v
.git/objects/pack/pack-aa817046e43f278d67c6b85962676246f57bb855.pack
3683f870be446c7cc05ffaef9fa06415276e1828 tree   58 65 158
61780798228d17af2d34fce4cfbdf35556832472 blob   2 11 223
647aed0360e964adc5cedb12e0719fb8bfc05867 commit 208 146 12
.git/objects/pack/pack-aa817046e43f278d67c6b85962676246f57bb855.pack: ok

$ git gc
Counting objects: 4, done.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (4/4), done.
Total 4 (delta 0), reused 4 (delta 0)
$ git verify-pack -v
.git/objects/pack/pack-5f692a665e062dedad7b4baf692517adec37899d.pack
3683f870be446c7cc05ffaef9fa06415276e1828 tree   58 65 158
61780798228d17af2d34fce4cfbdf35556832472 blob   2 11 234
647aed0360e964adc5cedb12e0719fb8bfc05867 commit 208 146 12
78981922613b2afb6025042ff6bd878ac1994e85 blob   2 11 223
.git/objects/pack/pack-5f692a665e062dedad7b4baf692517adec37899d.pack: ok

Mike

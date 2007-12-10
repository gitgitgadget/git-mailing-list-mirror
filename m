From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 2/2] pack-objects: fix threaded load balancing
Date: Mon, 10 Dec 2007 13:21:54 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0712101308150.555@xanadu.home>
References: <alpine.LFD.0.99999.0712080000120.555@xanadu.home>
 <9e4733910712092030j5cf7dfdcrb3a003fbce391422@mail.gmail.com>
 <9e4733910712092123r6987c3edua74a15890ae45a3d@mail.gmail.com>
 <9e4733910712092159s24cf5a7cx4610f797f61b1de5@mail.gmail.com>
 <9e4733910712092206o40e0c748s3796b95f637bf2b3@mail.gmail.com>
 <alpine.LFD.0.99999.0712101104320.555@xanadu.home>
 <9e4733910712100906g6794e326qf18da4be146f3667@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 10 19:22:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1nGk-00021z-7D
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 19:22:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753316AbXLJSV4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 13:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753022AbXLJSV4
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 13:21:56 -0500
Received: from relais.videotron.ca ([24.201.245.36]:17805 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752815AbXLJSVz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 13:21:55 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSU001WMJ0H99M0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 10 Dec 2007 13:21:53 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <9e4733910712100906g6794e326qf18da4be146f3667@mail.gmail.com>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67743>

On Mon, 10 Dec 2007, Jon Smirl wrote:

> On 12/10/07, Nicolas Pitre <nico@cam.org> wrote:
> 
> > The hash in the code above has to do with the file names the
> > corresponding objects are coming from.
> 
> So can we change this loop to exit after a max of window_size * 10 or
> something like that iterations? Without capping it the threads become
> way unbalanced in the end. In the gcc case one thread is continuing
> 30+ minutes past the others exiting.

Indeed, some more tweaking are needed.

The object path distribution goes like this for the gcc repo:

105557  gcc
42537   gcc/ChangeLog
25210   gcc/config
20690   gcc/testsuite
13434   gcc/testsuite/ChangeLog
12363   libstdc++-v3
9346    gcc/cp
8757    libstdc++-v3/include
8186    gcc/version.c
7867    gcc/cp/ChangeLog
7737    libstdc++-v3/include/bits
7653    libjava
6577    gcc/testsuite/gcc.dg
5942    libjava/ChangeLog
5351    gcc/config/i386
5260    gcc/testsuite/g++.dg
4451    gcc/f
4330    libstdc++-v3/ChangeLog
4321    libstdc++-v3/include/bits/c++config
4316    gcc/doc
[...]

So... the top entries are most certainly going to create load balancing 
issues if their path hash clustering isn't broken.


Nicolas

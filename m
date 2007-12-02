From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/3] Call builtin functions directly, was Re: [PATCH]
 transport.c: call dash-less form of receive-pack and upload-pack on remote
Date: Sun, 2 Dec 2007 02:52:52 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712020146240.27959@racer.site>
References: <20071127150229.GA14859@laptop> <20071127160423.GA22807@laptop>
 <Pine.LNX.4.64.0711271617350.27959@racer.site> <20071128000731.GD9174@efreet.light.src>
 <7v8x4jb295.fsf@gitster.siamese.dyndns.org>
 <fcaeb9bf0711280036p33583824ge59af93bbe3f0a78@mail.gmail.com>
 <7vfxyq2c9b.fsf@gitster.siamese.dyndns.org>
 <fcaeb9bf0711281917p56cc4228m6c401286439e2a34@mail.gmail.com>
 <alpine.LFD.0.99999.0711290905510.9605@xanadu.home> <7vd4tsvfvk.fsf@gitster.siamese.dyndns.org>
 <DB613F3E-85CC-4AF0-928C-4F4E4C8E9FB8@orakel.ntnu.no>
 <Pine.LNX.4.64.0711301207020.27959@racer.site> <7vlk8f9m52.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0712010959180.27959@racer.site> <7vzlwu43i4.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0712012300440.27959@racer.site> <Pine.LNX.4.64.0712012314190.27959@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Eyvind Bernhardsen <eyvind-git-list@orakel.ntnu.no>,
	Nicolas Pitre <nico@cam.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 02 03:53:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iyexc-0007DC-UO
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 03:53:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753724AbXLBCxO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2007 21:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753671AbXLBCxN
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Dec 2007 21:53:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:36997 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753591AbXLBCxN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2007 21:53:13 -0500
Received: (qmail invoked by alias); 02 Dec 2007 02:53:10 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp038) with SMTP; 02 Dec 2007 03:53:10 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/pPlJibZXpEsqjUBQqrTfnsKJ0rcCB2Mue8v6qJ4
	tJHChMLlVzHIDx
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0712012314190.27959@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66748>

Hi,

On Sat, 1 Dec 2007, Johannes Schindelin wrote:

> On Sat, 1 Dec 2007, Johannes Schindelin wrote:
> 
> > Will investigate right now,
> 
> The problem is that "git <command>" will call execv_git_cmd() for 
> non-builtins, which in turn will execute "git <command>", ... ad 
> infinitum.

Okay, I bit the apple and tried to move the builtins into the library, and 
rename handle_internal_command into execv_git_builtin(), moving it into 
exec-cmd.c.

Big mistake.

Why?  Because there is at least one caller, git-bundle, which relies on 
execv_git_cmd() _not_ reusing all those "nice" one-shot static variables, 
like for example the object hashmap and the objects themselves.

Now, it seems that we can get away for the moment with just introducing an 
object release mechanism and calling that in execv_git_builtin() before 
calling a builtin function, because the existing callers do not rely on 
more than a cleanup of the objects.

But it is hairy, since it is such an essential part of git.  And since I 
was utterly tired while preparing this patch series.  So I suggest maybe 
putting this into pu, but no further for the moment.  I will use the 
patched git in the next days, though, to catch breakages (hopefully).

Ciao,
Dscho

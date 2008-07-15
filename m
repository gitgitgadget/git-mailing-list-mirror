From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 15 Jul 2008 11:22:22 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807151117450.3487@eeepc-johanness>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>  <7vk5ggipuw.fsf@gitster.siamese.dyndns.org>  <7vej6l3lp7.fsf@gitster.siamese.dyndns.org>  <7vod5kd3im.fsf@gitster.siamese.dyndns.org>  <7v3amv1e8n.fsf@gitster.siamese.dyndns.org> 
 <7vprpwhp7t.fsf@gitster.siamese.dyndns.org>  <7vlk0ffhw3.fsf@gitster.siamese.dyndns.org>  <7vtzf1w0rj.fsf@gitster.siamese.dyndns.org>  <7vabgqsc37.fsf@gitster.siamese.dyndns.org>  <7vtzetjbif.fsf@gitster.siamese.dyndns.org>
 <7f9d599f0807142038w62ccb69fv42d6dcf3dd4f2afd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Geoffrey Irving <irving@naml.us>
X-From: git-owner@vger.kernel.org Tue Jul 15 11:22:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIgkG-0007oG-Tu
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 11:22:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754659AbYGOJVz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 05:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754609AbYGOJVy
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 05:21:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:57252 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754547AbYGOJVy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 05:21:54 -0400
Received: (qmail invoked by alias); 15 Jul 2008 09:21:51 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp030) with SMTP; 15 Jul 2008 11:21:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19i2a4UGilimYvC5dsuW21U80EvLwu1Ggb8wrNN8L
	XZaNNcIVSyHBgG
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7f9d599f0807142038w62ccb69fv42d6dcf3dd4f2afd@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88545>

Hi,

On Mon, 14 Jul 2008, Geoffrey Irving wrote:

> The problem (beyond the basic problem of me not having tried running the 
> tests) is that the current caching code isn't taking into account the 
> changing values of diff_options.  t6007 computes a patch-id for a commit 
> with one value of options.paths, and then tries to compute a _different_ 
> patch-id for the same commit using a different value of options.paths.
> 
> Here are a few different ways of fixing this:
> 
> 1. Modify commit_patch_id in patch-ids.c to compute a sha1 of the 
>    diff_options structure and xor it with the commit sha1 to get a truly 
>    unique hash of the input.  This means the optimization can be safely 
>    applied for all patch-id computations regardless of the diff_options.  
>    I can add a diff_options_sha1 function in diff.[ch] to compute the 
>    checksum.
> 
> 2. Restrict commit_patch_id in patch-ids.c to apply the optimization 
>    only if options.nr_paths is zero, and perhaps a few other conditions.  
>    This is rather fragile, since it would mean that the cache would 
>    break if someone decided to change the default diff options.

Funnily, (2) contradicts (1).  The patch id is _different_ when you have 
nr_paths > 0.  At least in the general case.

So what you propose in (1) will not work, unless you also hash the path 
names (in the correct order, otherwise you'll end up with two hashes).

OTOH I would be really surprised if you needed --cherry-pick with paths 
and/or diff options more than once for the same commits.  So the caching 
does not make sense to begin with (especially since we do not have a 
proper way of gc'ing it, right?).

So I'd suggest saving diff_opts before the command line parsing, and 
disable the cache when it is different _and/or_ (||) nr_paths.

Ciao,
Dscho

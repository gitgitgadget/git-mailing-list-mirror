From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Handle deltified object correctly in git-*-pull family.
Date: Wed, 1 Jun 2005 17:58:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506011738080.1876@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org>
 <Pine.LNX.4.62.0505301644430.5330@localhost.localdomain>
 <7vacmapo18.fsf@assigned-by-dhcp.cox.net> <7vu0kilc21.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0506011032570.7439@localhost.localdomain>
 <7vpsv6kqx0.fsf@assigned-by-dhcp.cox.net> <7v1x7lk8fl.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>,
	"Daniel Barkalow <barkalow@iabervon.org> Git Mailing List" 
	<git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 02 02:54:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dddy9-0007eB-5v
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 02:53:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbVFBA4t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Jun 2005 20:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbVFBA4t
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jun 2005 20:56:49 -0400
Received: from fire.osdl.org ([65.172.181.4]:33473 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261302AbVFBA4m (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Jun 2005 20:56:42 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j520uTjA018677
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 1 Jun 2005 17:56:29 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j520uS8w030688;
	Wed, 1 Jun 2005 17:56:28 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1x7lk8fl.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 1 Jun 2005, Junio C Hamano wrote:
> 
> *** Linus, I have a hook in sha1_file.c to let me figure out the
> *** size of the SHA1 file without fully expanding it.  This
> *** patch does not use it, but you already know where I am
> *** heading, so please leave it there ;-). 

Argh. This is just adding conceptual complexity without any real 
advantage.

Why not just split out the current "unpack_sha1_file()" into two stages: 
"unpack_sha1_header()" and the rest.

Then you can just decide to call "unpack_sha1_header()" when you want the 
header information.

Hmm. I just committed something like that. If you want to just see the 
type of an object, you can map the object in memory, and just do

	z_stream stream;
	char buffer[100];

	if (unpack_sha1_header(&stream, map, mapsize, buffer, sizeof(buffer) < 0)
		return NULL;
	if (sscanf(buffer, %10s %lu", type, size) != 0)
		return NULL;
	.. there you have it ..

which is a lot simpler than worrying about callbacks etc.

		Linus

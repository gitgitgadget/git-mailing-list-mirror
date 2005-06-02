From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Handle deltified object correctly in git-*-pull family.
Date: Thu, 2 Jun 2005 10:03:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506020959250.1876@ppc970.osdl.org>
References: <7vy89ums2l.fsf@assigned-by-dhcp.cox.net> <7vis0xkjn4.fsf@assigned-by-dhcp.cox.net>
 <7v4qcg906f.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 02 18:59:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ddt1p-0004ne-72
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 18:58:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVFBRBk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 13:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbVFBRBk
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 13:01:40 -0400
Received: from fire.osdl.org ([65.172.181.4]:63683 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261202AbVFBRBb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2005 13:01:31 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j52H1PjA026144
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 2 Jun 2005 10:01:26 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j52H1OMg004235;
	Thu, 2 Jun 2005 10:01:25 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4qcg906f.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 2 Jun 2005, Junio C Hamano wrote:
> 
> *** Linus, this uses the new helper you wrote.  The interface is
> *** much more pleasant to use.

Can you update it for the fact that I split things up even more?

In particular, see commit 5180cacc202bb20b15981469487eb8d6b0509997: "Split 
up unpack_sha1_file() some more".

You should be able to unpack a delta with just something like this:

	int ret;
	z_stream stream;
	char hdr[100], type[10];
	unsigned long size;

	ret = unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr));
	if (ret < Z_OK)
		return NULL;
	if (parse_sha1_header(hdr, type, &size) < 0)
		return NULL;
	if (strcmp("delta", type))
		return NULL;
	buffer = unpack_sha1_rest(&stream, hdr, size);
	if (!buffer)
		return NULL;
	.. we now have the delta of size "size" in "buffer" ..

ie it now has proper helper functions for every single stage in unpacking
an object.

		Linus

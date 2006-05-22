From: Jim Meyering <jim@meyering.net>
Subject: avoid atoi, when possible; int overflow -> heap corruption
Date: Mon, 22 May 2006 08:57:19 +0200
Message-ID: <871wumim28.fsf_-_@rho.meyering.net>
References: <87mzdcjqey.fsf@rho.meyering.net>
	<7v3bf3jl15.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 22 08:57:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fi4ML-00085K-Na
	for gcvg-git@gmane.org; Mon, 22 May 2006 08:57:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520AbWEVG5W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 02:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932525AbWEVG5W
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 02:57:22 -0400
Received: from mx.meyering.net ([82.230.74.64]:22224 "EHLO mx.meyering.net")
	by vger.kernel.org with ESMTP id S932520AbWEVG5V (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 May 2006 02:57:21 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id C24698135; Mon, 22 May 2006 08:57:19 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3bf3jl15.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 21 May 2006 11:21:58 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20484>

This is another one of those `would be nice' sort of changes.
Probably not worth much at this early stage in development, but
eventually worth changing.

There are about 20 uses of atoi, and most calls can return
a usable result in spite of an invalid input -- just because
atoi returns the same thing for "99" as "99-and-any-suffix".
It would be better not to ignore invalid inputs.

-------------------
Also, integer overflow in object.c can cause trouble.
When the xrealloc byte count exceeds 2^32 (for a 32-bit int),
xrealloc will happily return a buffer of the requested (small) size,
but the following memset will scribble zeroes far beyond the end
of that new buffer.

static int nr_objs;
int obj_allocs;
...
void created_object(const unsigned char *sha1, struct object *obj)
{
...
	if (obj_allocs - 1 <= nr_objs * 2) {
		int i, count = obj_allocs;
		obj_allocs = (obj_allocs < 32 ? 32 : 2 * obj_allocs);
		objs = xrealloc(objs, obj_allocs * sizeof(struct object *));
		memset(objs + count, 0, (obj_allocs - count)
				* sizeof(struct object *));

But this may be only theoretical, because the problem doesn't strike
until there are over 250M objects (assuming 32-bit int and 8-byte pointers).

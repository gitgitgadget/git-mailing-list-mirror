From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [BAD PATCH 0/9] v4-aware tree walker API
Date: Fri, 11 Oct 2013 19:22:59 +0700
Message-ID: <20131011122259.GA7776@lanh>
References: <1381329976-32082-1-git-send-email-pclouds@gmail.com>
 <alpine.LFD.2.03.1310091137310.3023@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Oct 11 14:19:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUbgd-0003q5-TK
	for gcvg-git-2@plane.gmane.org; Fri, 11 Oct 2013 14:19:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509Ab3JKMTP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Oct 2013 08:19:15 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:52934 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225Ab3JKMTO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Oct 2013 08:19:14 -0400
Received: by mail-pd0-f177.google.com with SMTP id y10so4185414pdj.22
        for <git@vger.kernel.org>; Fri, 11 Oct 2013 05:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=2KsL6T3KmWWClA/9bfO2BBmop8uo+w9tOcAoLnTXUjY=;
        b=tLrhfRnEE85wruJGLACOxYEi1OzQ10WMCWge22RKK9bQrJznVjud1TS3c2fFqZ3X3U
         t8TTX7+pnJlAcopojM8z8hmGJfGzdxsGU1jCA5mVPa+ZWCmlespxlSHcU2kSh8kuJH4p
         OTOkaGUscCMlEQsZYD86F4OpN1uzEaKmOkbKZg0DZ7EgTzrdUm8HnJENAezMBVUUeTif
         74M0Jb6ghHkfF++Jr3D5/9S6yOFfZytuj4YbIFbLwjvI49UsMJGZlQw9KLA/669/qTSP
         nRshR60a+T30cJGJ92pOiOHpYrPPdP4gW2FRBcStp84vd2c2BlS/wjl9F3w4DR1duBk5
         488A==
X-Received: by 10.68.108.3 with SMTP id hg3mr19553129pbb.91.1381493954079;
        Fri, 11 Oct 2013 05:19:14 -0700 (PDT)
Received: from lanh ([115.73.225.239])
        by mx.google.com with ESMTPSA id os4sm59563819pbb.25.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Oct 2013 05:19:12 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 11 Oct 2013 19:22:59 +0700
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.03.1310091137310.3023@syhkavp.arg>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235898>

On Wed, Oct 09, 2013 at 12:51:26PM -0400, Nicolas Pitre wrote:
> Now let's mitigate the deep delta chaining effect in the tree encoding:
> 
> $ rm .git/objects/pack/pack-foo.*
> $ ../../git/test-packv4 --min-tree-copy=50 orig/pack-*.pack .git/objects/pack/pack-foo.pack
> Scanning objects: 100% (162785/162785), done.
> Writing objects: 100% (162785/162785), done.
> $ time git rev-list --objects --all > /dev/null
> 
> real    0m9.451s
> user    0m9.393s
> sys     0m0.036s
> 
> Using --min-tree-copy=50 produces a pack which is still smaller than 
> pack v2 but any tree copy sequence must refer to a minimum of 50 
> entries.  This significantly reduces the CPU usage in decode_entries() 
> by reducing the needless chaining effect I mentioned here:
> 
> http://article.gmane.org/gmane.comp.version-control.git/234975

Yeah I was frustrated and did not think about trying --min-tree-copy.

> So, there are 2 conclusions here:
> 
> 1: The current tree delta euristic is inefficient for pack v4.
> 
> 2- Something must be very wrong in your latest patches as they make it
>    close to 3 times more expensive than without them.

For one I know that get_tree_offset_cache() is called a lot more with
the new API. I do rev-list on v1.8.4. With compatibility layer on,
it's 211m calls (*). With new API it's 655m calls. The new API is
basically do decode_entries() on every tree_entry() call. Perhaps I
screwed up something in decode_entries() itself..

(*) for 15m tree entries, 211m are a lot of calls, which might
translate to a lot of copy sequences..

> > Maybe we could make an exception and allow the tree walker to pass
> > pv4_tree_cache* directly to decode_entries so it does not need to do
> > the first lookup every time..
> > 
> > Suggestions?
> 
> I'll try to have a look at your patches in more details soon.

Shameful fixup (though it does not seem to impact the timing)

diff --git a/packv4-parse.c b/packv4-parse.c
index 6f6152c..9d7589e 100644
--- a/packv4-parse.c
+++ b/packv4-parse.c
@@ -825,8 +825,8 @@ static struct object **get_packed_objs(struct pv4_tree_desc *desc)
 	if (!desc->p || !desc->sha1_index)
 		return NULL;
 	if (desc->p->version >= 4 && !desc->p->objs)
-		desc->p->objs =
-			xmalloc(sizeof(struct object *) * desc->p->num_objects);
+		desc->p->objs = xcalloc(desc->p->num_objects,
+					sizeof(struct object *));
 	return desc->p->objs;
 }
 

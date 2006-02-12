From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Optimization for git-rev-list --objects
Date: Sat, 11 Feb 2006 18:19:09 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602111803350.3691@g5.osdl.org>
References: <87slqpg11q.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 12 03:19:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F86pY-00051N-Ui
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 03:19:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbWBLCTM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Feb 2006 21:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbWBLCTM
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Feb 2006 21:19:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50625 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750935AbWBLCTL (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Feb 2006 21:19:11 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1C2J9DZ031514
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 11 Feb 2006 18:19:10 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1C2J9un021567;
	Sat, 11 Feb 2006 18:19:09 -0800
To: Alexandre Julliard <julliard@winehq.org>
In-Reply-To: <87slqpg11q.fsf@wine.dyndns.org>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15970>



On Sat, 11 Feb 2006, Alexandre Julliard wrote:
> 
> When building a large list of objects, most of the time is spent in
> created_object() inserting the objects in the sorted list. This patch
> splits the list in 256 sublists to reduce the impact of the O(n^2)
> list insertion.
> 
> On the WineHQ repository (220,000 objects), the patch reduces the time
> needed for a 'git-rev-list --objects HEAD' from 2 minutes to 20 seconds.

Goodie. However, I wonder if we care about the sorting at _all_.

The sorting really only helps "find_object()", and the thing is, we could 
certainly do that other ways too. Keeping a sorted list is kind of 
senseless, when the data is so amenable to be kept in a tree.

We could add left/right pointers to each object, and just keep them in a 
tree. We probably don't even need any fancy balancing, since hashing means 
that we could just keep the first object we ever allocate as the root, and 
things should normally be pretty damn balanced.

Then we could do:

	static struct object *root = NULL;

	static struct object **lookup_object_position(unsigned char *sha1)
	{
		struct object **p = &root;

		for (;;) {
			struct object *object = *p;
			int sign;

			if (!object)
				break;
			sign = memcmp(sha1, object->sha1, 20)
			if (!sign)
				break;
			p = &object->left;
			if (sign < 0)
				continue;
			p = &object->right;
		}
		return p;
	}

and now we _trivially_ have:

	struct object *lookup_object(unsigned char *sha1)
	{
		return *lookup_object_position(unsigned char *sha1);
	}

	void created_object(struct object **pos, unsigned char *sha1, struct object *n)
	{
		memcpy(n->sha1, sha1, 20);
		*pos = n;
	}

and the "lookup_or_create()" functions would become

	struct tag *lookup_tag(unsigned char *sha1)
	{
		struct object **p = lookup_object_position(sha1);
		struct object *object;

		object = *p;
		if (!object) {
			struct tag *ret = xmalloc(sizeof(struct tag));
			memset(ret, 0, sizeof(struct tag));
			created_object(p, sha1, &ret->object);
			ret->object.type = tag_type;
			return ret;
		}
		if (!object->type)
			obj->type = tag_type;

		if (object->type != tag_type) {
			error("Object %s is a %s, not a tag",
				sha1_to_hex(sha1), obj->type);
			return NULL;
		}
		return (struct tag *)obj;
	}

etc etc.

Hmm? That would be a lot faster than what we have now, I suspect, and none 
of the ops are expensive.

Anybody want to try this approach?

		Linus

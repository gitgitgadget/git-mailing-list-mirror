From: Junio C Hamano <junkio@cox.net>
Subject: Re: [1/4] Report info from trees
Date: Mon, 18 Apr 2005 22:19:18 -0700
Message-ID: <7vsm1nqr6x.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.21.0504182148330.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 07:16:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNl5B-0004K4-G0
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 07:15:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbVDSFT1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 01:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbVDSFT1
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 01:19:27 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:18308 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261321AbVDSFTU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2005 01:19:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050419051917.TKUT2123.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 19 Apr 2005 01:19:17 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0504182148330.30848-100000@iabervon.org> (Daniel
 Barkalow's message of "Mon, 18 Apr 2005 21:51:55 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "DB" == Daniel Barkalow <barkalow@iabervon.org> writes:

DB> This patch adds actual information to struct tree, making it possible to
DB> tell what sorts of things the referenced objects are. This is needed for
DB> http-pull, and Junio wanted something of the sort.

Thanks for keeping me in the loop, but...

DB> --- 1172a9b8f45b2fd640985595cc5258db3b027828/tree.h  (mode:100644 sha1:14ebbacded09d5e058c7f94652dcb9e12bc31cae)
DB> +++ 7e5a0d93117ecadfb15de3a6bebdb1aa94234fde/tree.h  (mode:100644 sha1:985500e2a9130fe8c33134ca121838af9320c465)
DB> @@ -5,9 +5,20 @@
 
DB>  extern const char *tree_type;
 
DB> +struct tree_entry_list {
DB> +	struct tree_entry_list *next;
DB> +	unsigned directory : 1;
DB> +	unsigned executable : 1;
DB> +	union {
DB> +		struct tree *tree;
DB> +		struct blob *blob;
DB> +	} item;
DB> +};
DB> +
DB>  struct tree {
DB>  	struct object object;
DB>  	unsigned has_full_path : 1;
DB> +	struct tree_entry_list *entries;
DB>  };
 
... what about names?  When somebody other than connectivity
checker walks a tree, it would be more likely than not that 
it wants to know what each entry is called, wound't it?

I can get the type of the object, either tree or blob, from
tree->object.type, so I do not think the single-bit are needed.

Instead, how about something simpler like this?

    struct tree {
        struct object object; /* the tree node itself as an object */
        unsigned child_nr;
        unsigned child_alloc;
        struct {
            struct object *object;
            char *name;
        } **child;
    };

The tree->child[n].object would point at the same object as one
of the object_list elements in tree->object.refs chain (i.e. you
do not need to read the same object twice).  Before the tree is
parsed, tree->child would be NULL.  You do not need child_alloc
if the intended use of this API is only parsing existing object
tree.  Otherwise keep that and realloc tree->child as needed.




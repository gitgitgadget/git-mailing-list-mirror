From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 2/3] Teach read_tree_recursive() how to traverse into
 submodules
Date: Sun, 18 Jan 2009 17:13:36 +0100
Message-ID: <49735530.4090901@lsrfire.ath.cx>
References: <1232275999-14852-1-git-send-email-hjemli@gmail.com> <1232275999-14852-2-git-send-email-hjemli@gmail.com> <1232275999-14852-3-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 18 17:15:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOaIl-00026B-Bv
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 17:15:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757602AbZARQNn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Jan 2009 11:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757430AbZARQNn
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 11:13:43 -0500
Received: from india601.server4you.de ([85.25.151.105]:41265 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757246AbZARQNn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 11:13:43 -0500
Received: from [10.0.1.101] (p57B7E094.dip.t-dialin.net [87.183.224.148])
	by india601.server4you.de (Postfix) with ESMTPSA id D8AD32F8046;
	Sun, 18 Jan 2009 17:13:40 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <1232275999-14852-3-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106235>

Lars Hjemli schrieb:
> The traversal of submodules is only triggered if the current submodul=
e
> HEAD commit object is accessible. To this end, read_tree_recursive()
> will try to insert the submodule odb as an alternate odb but the lack
> of such an odb is not treated as an error since it is then assumed th=
at
> the user is not interested in the submodule content. However, if the
> submodule odb is found it is treated as an error if the HEAD commit
> object is missing.

Callers of read_tree_recursive() specify a tree to traverse.
Unconditionally using the HEAD of submodules feels a bit restrictive,
but I don't use submodules, so I have no idea what I'm actually talking
about here. :)

>  int read_tree_recursive(struct tree *tree,
>  			const char *base, int baselen,
>  			int stage, const char **match,
> @@ -132,6 +188,30 @@ int read_tree_recursive(struct tree *tree,
>  				return -1;
>  			continue;
>  		}
> +		if (S_ISGITLINK(entry.mode) && get_traverse_gitlinks()) {
> +			int retval;
> +			char *newbase;
> +			struct tree *subtree;
> +			unsigned int pathlen =3D tree_entry_len(entry.path, entry.sha1);
> +
> +			newbase =3D xmalloc(baselen + 1 + pathlen);
> +			memcpy(newbase, base, baselen);
> +			memcpy(newbase + baselen, entry.path, pathlen);
> +			newbase[baselen + pathlen] =3D 0;
> +			if (!traverse_gitlink(newbase, entry.sha1, &subtree)) {
> +				free(newbase);
> +				continue;
> +			}
> +			newbase[baselen + pathlen] =3D '/';
> +			retval =3D read_tree_recursive(subtree,
> +						     newbase,
> +						     baselen + pathlen + 1,
> +						     stage, match, fn, context);
> +			free(newbase);
> +			if (retval)
> +				return -1;
> +			continue;
> +		}
>  	}
>  	return 0;
>  }

You don't need to call get_traverse_gitlinks() in the if statement abov=
e
if you make all read_tree_recursive() callback functions return 0 for
gitlinks that they don't want to follow and READ_TREE_RECURSIVE for
those they do.  It's cleaner without the static variable and its
accessors and more flexible, too: the callbacks might decide to travers=
e
only certain submodules.

Ren=E9

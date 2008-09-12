From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 1/6] submodule.*: Introduce simple C interface for
	submodule lookup by path
Date: Fri, 12 Sep 2008 23:58:14 +0200
Message-ID: <20080912215814.GG10544@machine.or.cz>
References: <20080912210817.31628.69014.stgit@localhost> <20080912210857.31628.7605.stgit@localhost> <7vsks5njmg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 23:59:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeGg1-0000kM-PJ
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 23:59:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756985AbYILV6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 17:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756960AbYILV6S
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 17:58:18 -0400
Received: from w241.dkm.cz ([62.24.88.241]:57623 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756744AbYILV6R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 17:58:17 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 80DF2393A2DF; Fri, 12 Sep 2008 23:58:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vsks5njmg.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95775>

On Fri, Sep 12, 2008 at 02:23:51PM -0700, Junio C Hamano wrote:
> Petr Baudis <pasky@suse.cz> writes:
> 
> > +static int gitmodules_worker(const char *key, const char *value, void *info_)
> 
> Won't you ever have different kind of work in the future?
> find_submodule_by_path(), perhaps?

Good point.

> > +{
> > +	struct gitmodules_info *info = info_;
> > +	const char *subkey;
> > +
> > +	if (prefixcmp(key, "submodule."))
> > +		return 0;
> > +
> > +	subkey = strrchr(key, '.');
> > +	if (!subkey)
> > +		return 0;
> 
> This cannot happen; you made sure the thing begins with "submodule."
> already.
> 
> > +	if (strcmp(subkey, ".path"))
> > +		return 0;
> 
> This will miss a misconfigured "submodule.path" (two level).
> 
> I can understand if this part were:
> 
> 	subkey = strrchr(key, '.');
>         if (!subkey || subkey == key + strlen("submodule.") - 1)
>         	return 0;

This looks strange, but I think I see what do you mean. I will use

if (strcmp(subkey, ".path") || subkey == key + strlen("submodule.") - 1)

> > +	if (strcmp(value, info->path))
> > +		return 0;
> 
> This will segfault on a misconfigured:
> 
> 	[submodule "xyzzy"]
>         	path

Thanks.

> > +	/* Found the key to change. */
> > +	if (info->key) {
> > +		error("multiple submodules live at path `%s'", info->path);
> 
> Why is this "error()", not "warning()"?

Matter of taste, I suppose. I have changed this to warning(), though it
is dubious configuration at best.

> > +		/* The last one is supposed to win. */
> > +		free(info->key);
> > +	}
> > +	info->key = xstrdup(key);
> > +	return 0;
> 
> Have to wonder if it makes easier for the users if this function kept only
> "xyzzy" out of "submodule.xyzzy.path", not the whole thing.  Cannot judge
> without actual callers.

They follow up in the next patches. ;-)  They use the submodule name
only to access the configuration again, so this format is the most
convenient for them.

> > +}
> > +
> > +char *submodule_by_path(const char *path)
> > +{
> > +	struct gitmodules_info info = { path, NULL };
> > +
> > +	config_exclusive_filename = ".gitmodules";
> > +	if (git_config(gitmodules_worker, &info))
> > +		die("cannot process .gitmodules");
> > +	if (!info.key)
> > +		die("the submodule of `%s' not found in .gitmodules", path);
> > +	config_exclusive_filename = NULL;
> > +
> > +	return info.key;
> > +}
> > diff --git a/submodule.h b/submodule.h
> > new file mode 100644
> > index 0000000..bc74fa0
> > --- /dev/null
> > +++ b/submodule.h
> > @@ -0,0 +1,8 @@
> > +#ifndef SUBMODULE_H
> > +#define SUBMODULE_H
> > +
> > +/* Find submodule living at given path in .gitmodules and return the key
> > + * of its path config variable (dynamically allocated). */
> 
> Style?

Would you seriously find it prettier with the newline?

$ git grep '^[^/]*[a-z][^/]*\*/$' *.c | wc -l
37

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates

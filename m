From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/6] Add infrastructure to write revisions in
 fast-export format
Date: Fri, 4 Jun 2010 14:02:22 -0500
Message-ID: <20100604190222.GB21295@progeny.tock>
References: <1275658871-1473-1-git-send-email-artagnon@gmail.com>
 <1275658871-1473-6-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 04 21:03:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKcAq-0006C8-2a
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 21:03:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523Ab0FDTC2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jun 2010 15:02:28 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:59446 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837Ab0FDTC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jun 2010 15:02:27 -0400
Received: by wwb28 with SMTP id 28so1111636wwb.19
        for <git@vger.kernel.org>; Fri, 04 Jun 2010 12:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Woybwp4upj75ZBOZEu0IxE7NvHll3vMOhtAlrDHhSG0=;
        b=CS+gF+KhoLRjLrTPOocY9iZ/A11/dEDE0Aj147H5KfXh19wgdWKn6d9NJNh5eMhnVh
         vy2MFnE+fkTlVsW87qFPIEk8nPxG02KTKPgzRACB4AQwhTPaG9WLPqHZB8Y30s8u03dk
         8D+1HUW2GIo08A2Zzm9u2w8v5CFShllDLcUZo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=NRUQ+qnBxG4NPiG/9eYYsr9g406Zwf8I8nE4w6Qi6eVrMq9bqoBjm9hAoq5Zu/OtaE
         mZZ+VpUfZMaqK4V+xMtzy1KJNk2Vm3ErQs7tbFEcx1Hd2pr30GYJtG65OP3a0D/ZOz4p
         6JqrHv6qzBsHdrC0QvXbLX3lYOTS8ykKXmZvI=
Received: by 10.227.127.137 with SMTP id g9mr10875411wbs.58.1275678145471;
        Fri, 04 Jun 2010 12:02:25 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id y31sm12166866wby.22.2010.06.04.12.02.22
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 04 Jun 2010 12:02:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1275658871-1473-6-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148435>

Hi Ram,

Thanks for the style cleanup.

Ramkumar Ramachandra wrote:

> --- /dev/null
> +++ b/vcs-svn/repo_tree.c
[...]
> +static struct repo_dir *repo_clone_dir(struct repo_dir *orig_dir, uint32_t padding)
> +{
> +	uint32_t orig_o, new_o, dirent_o;
> +	orig_o = dir_offset(orig_dir);
> +	if (orig_o < num_dirs_saved) {
> +		new_o = dir_with_dirents_alloc(orig_dir->size + padding);
> +		orig_dir = dir_pointer(orig_o);
> +		dirent_o = dir_pointer(new_o)->first_offset;
> +	} else {
> +		if (padding == 0)
> +			return orig_dir;
> +		new_o = orig_o;
> +		dirent_o = dirent_alloc(orig_dir->size + padding);
> +	}
> +	memcpy(dirent_pointer(dirent_o), repo_first_dirent(orig_dir),
> +		   orig_dir->size * sizeof(struct repo_dirent));
> +	dir_pointer(new_o)->size = orig_dir->size + padding;
> +	dir_pointer(new_o)->first_offset = dirent_o;
> +	return dir_pointer(new_o);
> +}

This function expands a list of directory entries, copying it if
already committed as part of a previous revision.

The big downside is that as David mentioned it does not scale well with
the size of the directory and number of expansions.  But a patch is in
the pipeline to fix that.  I do not think it should hold the series up.

> +
> +static struct repo_dirent *repo_read_dirent(uint32_t revision, uint32_t *path)
> +{
> +	uint32_t name = 0;
> +	struct repo_dir *dir = NULL;
> +	struct repo_dirent *dirent = NULL;
> +	dir = repo_commit_root_dir(commit_pointer(revision));
> +	while (~(name = *path++)) {
> +		dirent = repo_dirent_by_name(dir, name);
> +		if (dirent == NULL) {
> +			return NULL;
> +		} else if (repo_dirent_is_dir(dirent)) {
> +			dir = repo_dir_from_dirent(dirent);
> +		} else {
> +			break;
> +		}

Style: would probably be clearer to write:

	while (~(name = *path++)) {
		dirent = repo_dirent_by_name(dir, name);
		if (!dirent || !repo_dirent_is_dir(dirent))
			break;
		dir = repo_dir_from_dirent(dirent);
	}

i.e., fewer unnecessary braces, and dealing with the exceptional cases
separately from the normal case.

As before, I wonder about the error cases.  Might it make sense to
report the error if someone tries to copy a nonexistent directory
from a previous revision?

> +static void
> +repo_write_dirent(uint32_t *path, uint32_t mode, uint32_t content_offset,
> +                  uint32_t del)

Function is too long for my taste (I realize this is a matter of
taste).  The innermost blocks would make sense as functions in their
own right.

[...]
> +static void repo_diff_r(uint32_t depth, uint32_t *path, struct repo_dir *dir1,
> +			struct repo_dir *dir2)
[...]
> +	while (de1 < max_de1 && de2 < max_de2) {
> +		if (de1->name_offset < de2->name_offset) {
> +			path[depth] = (de1++)->name_offset;
> +			fast_export_delete(depth + 1, path);
> +		} else if (de1->name_offset > de2->name_offset) {
> +			path[depth] = de2->name_offset;
> +			repo_git_add(depth + 1, path, de2++);
> +		} else {
> +			path[depth] = de1->name_offset;
> +			if (de1->mode != de2->mode ||
> +				de1->content_offset != de2->content_offset) {
> +				if (repo_dirent_is_dir(de1) && repo_dirent_is_dir(de2)) {

My 80-column terminal is suffering.  Why not use the common

	while (...) {
		if (exceptional case) {
			....
			continue;
		} else if (exceptional case) {
			...
			continue;
		}
		path[depth] = de1->name_offset;
		if (easy case) {
			...
			continue;
		}
		usual case
	}

pattern?

> +#define REPO_MAX_PATH_LEN 4096
> +#define REPO_MAX_PATH_DEPTH 1000

These limits are not checked; is the caller supposed to check them
itself?  Does svn obey them?

Jonathan

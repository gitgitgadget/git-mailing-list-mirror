From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] count-objects: report garbage files in
 .git/objects/pack directory too
Date: Thu, 07 Feb 2013 10:12:58 -0800
Message-ID: <7vzjzg802d.fsf@alter.siamese.dyndns.org>
References: <1359982145-10792-1-git-send-email-pclouds@gmail.com>
 <1359982145-10792-2-git-send-email-pclouds@gmail.com>
 <7v1ucw2bd4.fsf@alter.siamese.dyndns.org>
 <20130207073751.GA20672@duynguyen-vnpc.dek-tpc.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 07 19:13:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3VyR-0005yg-Hz
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 19:13:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758810Ab3BGSNE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 13:13:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43949 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757017Ab3BGSNB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 13:13:01 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27A97C39B;
	Thu,  7 Feb 2013 13:13:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HtDTYaCy4K3WRXZxDT27uL8zLcQ=; b=MF6xpw
	OlCqN15j2x9PVcZgXnvtPsn1G9PCmFhVtSZxf+jT2Qy+1pi89li3D68FhrWWWrqB
	ndoDAY8dSLZGiRn0q9qoVg6uaBymQIqnAlPWrqvDzmLNXtiSbA5i53oiiZ2ncFne
	gg3i/VbJGJUYy5e2/gdw9KvI0nLkzRA1I2/nA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K7S/c7+xKjTPMCQuuXSDxQa898/lMyVF
	NEQyXnsQ9/j5idPQ8IGBTXL5BlkEh/MMFpBlh/kfF4GWBxvCELBO+301rBZfcZOk
	bAJE0h10pjWm/00dFhAhkRJ1RWMN89w7MW3QwezfIHY58w/vhXVrKH1ns8AWKR7v
	1AYuPbYeS9w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B8D1C39A;
	Thu,  7 Feb 2013 13:13:01 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 26ECAC38D; Thu,  7 Feb 2013
 13:13:00 -0500 (EST)
In-Reply-To: <20130207073751.GA20672@duynguyen-vnpc.dek-tpc.internal> (Duy
 Nguyen's message of "Thu, 7 Feb 2013 14:37:52 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 018B132C-7152-11E2-BAA2-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215705>

Duy Nguyen <pclouds@gmail.com> writes:

> I thought about that, but we may need to do extra stat() for loose
> garbage as well. As it is now, garbage is complained loudly, which
> gives me enough motivation to clean up, even without looking at how
> much disk space it uses.

I wouldn't call a single line "garbage: 4" exactly *loud*.  I also
think that this is not about *motivating* you, but about giving
more information to the users to help them assess the health of
their repository themselves.

By the way, I wonder if we also want to notice .git/objects/garbage
or .git/objects/ga/rbage if we are to do this?

> -- 8< --
> Subject: count-objects: report garbage pack directory too
>
> prepare_packed_git_one() is modified to allow count-objects to hook a
> report function to so we don't need to duplicate the pack searching
> logic in count-objects.c. When report_pack_garbage is NULL, the
> overhead is insignificant.
>
> diff --git a/Documentation/git-count-objects.txt b/Documentation/git-count-objects.txt
> index e816823..1611d7c 100644
> --- a/Documentation/git-count-objects.txt
> +++ b/Documentation/git-count-objects.txt
> @@ -33,8 +33,8 @@ size-pack: disk space consumed by the packs, in KiB
>  prune-packable: the number of loose objects that are also present in
>  the packs. These objects could be pruned using `git prune-packed`.
>  +
> -garbage: the number of files in loose object database that are not
> -valid loose objects
> +garbage: the number of files in object database that are not valid
> +loose objects nor valid packs
>  
>  GIT
>  ---
> diff --git a/builtin/count-objects.c b/builtin/count-objects.c
> index 9afaa88..7fdd508 100644
> --- a/builtin/count-objects.c
> +++ b/builtin/count-objects.c
> @@ -9,6 +9,8 @@
>  #include "builtin.h"
>  #include "parse-options.h"
>  
> +static unsigned long garbage;
> +
>  static void count_objects(DIR *d, char *path, int len, int verbose,
>  			  unsigned long *loose,
>  			  off_t *loose_size,
> @@ -65,6 +67,16 @@ static void count_objects(DIR *d, char *path, int len, int verbose,
>  	}
>  }
>  
> +extern void (*report_pack_garbage)(const char *path, int len, const char *name);
> +static void real_report_pack_garbage(const char *path, int len, const char *name)
> +{
> +	if (len)
> +		error("garbage found: %.*s/%s", len, path, name);
> +	else
> +		error("garbage found: %s", path);
> +	garbage++;
> +}
> +
>  static char const * const count_objects_usage[] = {
>  	N_("git count-objects [-v]"),
>  	NULL
> @@ -76,7 +88,7 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
>  	const char *objdir = get_object_directory();
>  	int len = strlen(objdir);
>  	char *path = xmalloc(len + 50);
> -	unsigned long loose = 0, packed = 0, packed_loose = 0, garbage = 0;
> +	unsigned long loose = 0, packed = 0, packed_loose = 0;
>  	off_t loose_size = 0;
>  	struct option opts[] = {
>  		OPT__VERBOSE(&verbose, N_("be verbose")),
> @@ -87,6 +99,8 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
>  	/* we do not take arguments other than flags for now */
>  	if (argc)
>  		usage_with_options(count_objects_usage, opts);
> +	if (verbose)
> +		report_pack_garbage = real_report_pack_garbage;
>  	memcpy(path, objdir, len);
>  	if (len && objdir[len-1] != '/')
>  		path[len++] = '/';
> diff --git a/sha1_file.c b/sha1_file.c
> index 40b2329..5b70e55 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -21,6 +21,7 @@
>  #include "sha1-lookup.h"
>  #include "bulk-checkin.h"
>  #include "streaming.h"
> +#include "dir.h"
>  
>  #ifndef O_NOATIME
>  #if defined(__linux__) && (defined(__i386__) || defined(__PPC__))
> @@ -1000,15 +1001,19 @@ void install_packed_git(struct packed_git *pack)
>  	packed_git = pack;
>  }
>  
> +void (*report_pack_garbage)(const char *path, int len, const char *name);
> +
>  static void prepare_packed_git_one(char *objdir, int local)
>  {
>  	/* Ensure that this buffer is large enough so that we can
>  	   append "/pack/" without clobbering the stack even if
>  	   strlen(objdir) were PATH_MAX.  */
>  	char path[PATH_MAX + 1 + 4 + 1 + 1];
> -	int len;
> +	int i, len;
>  	DIR *dir;
>  	struct dirent *de;
> +	struct packed_git *p;
> +	struct string_list garbage = STRING_LIST_INIT_DUP;
>  
>  	sprintf(path, "%s/pack", objdir);
>  	len = strlen(path);
> @@ -1024,14 +1029,33 @@ static void prepare_packed_git_one(char *objdir, int local)
>  		int namelen = strlen(de->d_name);
>  		struct packed_git *p;
>  
> -		if (!has_extension(de->d_name, ".idx"))
> +		if (len + namelen + 1 > sizeof(path)) {
> +			if (report_pack_garbage)
> +				report_pack_garbage(path, len - 1, de->d_name);
>  			continue;
> +		}
>  
> -		if (len + namelen + 1 > sizeof(path))
> +		strcpy(path + len, de->d_name);
> +
> +		if (!has_extension(de->d_name, ".idx")) {
> +			if (!report_pack_garbage)
> +				continue;
> +			if (is_dot_or_dotdot(de->d_name))
> +				continue;
> +			if (!has_extension(de->d_name, ".pack")) {
> +				report_pack_garbage(path, 0, NULL);
> +				continue;
> +			}

Didn't I already say the logic should be inverted to whitelist the
known ones?  Saying "Anything that is not '.pack' is bad" here is a
direct opposite, I think.  

Add "A '.keep' file is OK" to this codeflow and see how it goes.

> +			/*
> +			 * we can't decide right know if this .pack is
> +			 * garbage. Delay until we identify all good
> +			 * packs.
> +			 */
> +			string_list_append(&garbage, path);
>  			continue;
> +		}
>  
>  		/* Don't reopen a pack we already have. */
> -		strcpy(path + len, de->d_name);
>  		for (p = packed_git; p; p = p->next) {
>  			if (!memcmp(path, p->pack_name, len + namelen - 4))
>  				break;
> @@ -1047,6 +1071,25 @@ static void prepare_packed_git_one(char *objdir, int local)
>  		install_packed_git(p);
>  	}
>  	closedir(dir);
> +
> +	if (!report_pack_garbage)
> +		return;
> +
> +	sort_string_list(&garbage);
> +	for (p = packed_git; p; p = p->next) {
> +		struct string_list_item *item;
> +		if (!p->pack_local)
> +			continue;
> +		item = string_list_lookup(&garbage, p->pack_name);
> +		if (item)
> +			item->util = &garbage; /* anything but NULL */
> +	}
> +	for (i = 0; i < garbage.nr; i++) {
> +		struct string_list_item *item = garbage.items + i;
> +		if (!item->util)
> +			report_pack_garbage(item->string, 0, NULL);
> +	}
> +	string_list_clear(&garbage, 0);
>  }
>  
>  static int sort_pack(const void *a_, const void *b_)
> -- 8< --

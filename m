From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 42/44] refs.c: pass a skip list to name_conflict_fn
Date: Thu, 22 May 2014 12:27:17 -0700
Message-ID: <20140522192717.GU12314@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
 <1400174999-26786-43-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu May 22 21:27:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnYeD-0007jP-5l
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 21:27:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752742AbaEVT1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 15:27:21 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:60319 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348AbaEVT1U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 15:27:20 -0400
Received: by mail-pa0-f41.google.com with SMTP id lj1so2937302pab.28
        for <git@vger.kernel.org>; Thu, 22 May 2014 12:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=SzwVqAt251a47sToJO6iGpMfAYDFYpRQkQs5oj+t2LE=;
        b=VBiedkjCc5mgnuLopR/PcdYLBJe0VWTqV04Nkr38Idx491vKe28nb8v9UsPy+CZITI
         egPRWsDJGmuo3Be890mbfxx/oUwxfoFE3gssPORKVgDcOe0+qfkrIGKcQD0DObe/cc9u
         qSoXCme/nolc+g4c/Jb8Z3ZVFWXHFu/YDbqA5jnHAo/VQeTvEyjGTTBPbGiJQSYjdZXg
         P8emhnQ2ptirezt9FI0zE9w3hjz2fqc0W/SCw1PLy2GWsuB6DdiS+V3Krqbh2qoNZS9r
         AR3tVNqbemfS0z5tmAaxZ+mpnhkoa0BKtwgJbeEbtK9HqvvtwMJv0CrODBs53KM5JZLD
         p2fQ==
X-Received: by 10.66.146.199 with SMTP id te7mr71082284pab.106.1400786840381;
        Thu, 22 May 2014 12:27:20 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id rw4sm2926175pab.47.2014.05.22.12.27.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 22 May 2014 12:27:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400174999-26786-43-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249938>

Ronnie Sahlberg wrote:

> --- a/refs.c
> +++ b/refs.c
> @@ -798,11 +798,19 @@ struct name_conflict_cb {
>  	const char *refname;
>  	const char *oldrefname;
>  	const char *conflicting_refname;
> +	const char **skip;
> +	int skipnum;

Would a struct string_list make sense here?  (See
Documentation/technical/api-string-list.txt.)

[...]
>  };
>  
>  static int name_conflict_fn(struct ref_entry *entry, void *cb_data)
>  {
>  	struct name_conflict_cb *data = (struct name_conflict_cb *)cb_data;
> +	int i;
> +	for(i = 0; i < data->skipnum; i++) {

(style nit) missing space after 'for'.

> +		if (!strcmp(entry->name, data->skip[i])) {
> +			return 0;
> +		}

Style: git tends to avoid braces around a single-line if/for/etc body.

[...]
> @@ -817,15 +825,21 @@ static int name_conflict_fn(struct ref_entry *entry, void *cb_data)
>   * conflicting with the name of an existing reference in dir.  If
>   * oldrefname is non-NULL, ignore potential conflicts with oldrefname
>   * (e.g., because oldrefname is scheduled for deletion in the same
> - * operation).
> + * operation). skip contains a list of refs we want to skip checking for
> + * conflicts with. Refs may be skipped due to us knowing that it will
> + * be deleted later during a transaction that deletes one reference and then
> + * creates a new conflicting reference. For example a rename from m to m/m.

This example of "Refs may be skipped due to" seems overly complicated.
Isn't the idea just that skip contains a list of refs scheduled for
deletion in this transaction, since they shouldn't be treated as
conflicts at all (for example when renamining m to m/m)?

I wonder if there's some way to make use of the result of the naive
refname_available check to decide what to do when creating a ref.

E.g.: if a refname would be available except there's a ref being
deleted in the way, we could do one of the following:

 a. delete all relevant loose refs and perform the transaction in
    packed-refs, or

 b. order operations to avoid the D/F conflict, even with loose refs
    (the hardest case is if the ref being deleted uses a directory
    and we want to create a file with the same name.  But that's
    still doable if we're willing to rmdir when needed as part of
    the loop to commit changes)

The packed-refs trick (a) seems much simpler, but either should work.

This could be done e.g. by checking is_refname_available with an empty
list first before doing the real thing with a list of exclusions.

[...]
> @@ -2592,6 +2609,9 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
>  	int log = !lstat(git_path("logs/%s", oldrefname), &loginfo);
>  	const char *symref = NULL;
>  
> +	if (!strcmp(oldrefname, newrefname))
> +		return 0;

What is the intended result if I try to rename a nonexistent ref or an
existent symref to its own name?

Sorry to be so fussy about this part.  It's not that I think that this
change is trying to do something bad --- in fact, it's more the
opposite, that I'm excited to see git learning to have a better
understanding and handling of refname D/F conflicts.

That would allow:

 * "git fetch --prune" working as a single transaction even if
   the repository being fetched from removed a refs/heads/topic
   branch and created refs/heads/topic/1 and refs/heads/topic/2

 * "git fast-import" and "git fetch --mirror" learning the same trick

 * fewer code paths having to be touched to be able to (optionally)
   let git actually tolerate D/F conflicts, for people who want to
   have 'topic', 'topic/1', and 'topic/2' branches at the same time.
   This could be turned on by default for remote-tracking refs.  It
   would be especially nice for people on Windows and Mac OS where
   there can be D/F conflicts that people on Linux didn't notice due
   to case-sensitivity.

   Longer term, through a configuration that starts turned off by
   default and has the default flipped as more people have upgraded
   git, this could make D/F conflicts in refnames stop being an error
   altogether.

So it's kind of exciting to see, even though it's fussy to get it
right.

Thanks,
Jonathan

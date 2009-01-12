From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: [RFC/PATCH 1/3] tree.c: add support for traversal of submodules
Date: Mon, 12 Jan 2009 10:04:29 +0100
Message-ID: <8c5c35580901120104u418d8d73mad4ab7d71fe8c3f8@mail.gmail.com>
References: <1231717555-10559-1-git-send-email-hjemli@gmail.com>
	 <1231717555-10559-2-git-send-email-hjemli@gmail.com>
	 <7vr639kyf0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 10:06:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMIkA-0006C6-1i
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 10:05:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751950AbZALJEd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 04:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751710AbZALJEc
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 04:04:32 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:5547 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352AbZALJEa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 04:04:30 -0500
Received: by wa-out-1112.google.com with SMTP id v27so5540083wah.21
        for <git@vger.kernel.org>; Mon, 12 Jan 2009 01:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FpwY7L3J8gIeupjT+MhbGLRfPlOLEpU8LbgKrpyF9GY=;
        b=GtSnBVcJNMAT2/dfF4LxxsXyPt7Jf9trhSiAcUNGXynYVQUJLFqgaw48F7JcIAlFD5
         By5FHbdoSIGeCey58ceUvtbnvVnZzkQc/uD/E4v7iR2kZiumIMm53lseVWx0zOjdMYxD
         tBGyaXWiD9fH5eQGBaQGEq6V44FdRIq0AY1uc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bSbjMjDN+eUtmVSp+Y1z5ohcesRrubjMxUV33+M3OAp2ix64JG7+uGGpAKUkKvsEes
         /T4GrHJ1ghSIaZLa+52Fw5hrbNwBxKT8okvfpp+VVZfa29jYUpL/SVxIvqPSmw1ICwYW
         clm9JBCZU7/21f0IMxBqYz7ZDOZdQoxfWIlH8=
Received: by 10.114.81.1 with SMTP id e1mr18904642wab.212.1231751069986; Mon, 
	12 Jan 2009 01:04:29 -0800 (PST)
In-Reply-To: <7vr639kyf0.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105307>

On Mon, Jan 12, 2009 at 04:15, Junio C Hamano <gitster@pobox.com> wrote:
> Lars Hjemli <hjemli@gmail.com> writes:
>
>> If the commit referenced by a gitlink is available in the (possibly
>> alternate) object database, read_tree_recursive() is now able to descend
>> into the tree of the linked commit if the flag 'traverse_gitlinks' is
>> turned on.
>>
>> Signed-off-by: Lars Hjemli <hjemli@gmail.com>
>> ---
>>  tree.c |   20 +++++++++++++++++---
>>  tree.h |    1 +
>>  2 files changed, 18 insertions(+), 3 deletions(-)
>>
>> diff --git a/tree.c b/tree.c
>> index 03e782a..1468e10 100644
>> --- a/tree.c
>> +++ b/tree.c
>> @@ -7,6 +7,7 @@
>>  #include "tree-walk.h"
>>
>>  const char *tree_type = "tree";
>> +int traverse_gitlinks = 0;
>
> I think we tend to put these global settings that will affect everybody in
> environment.c.  You do not have to initialize variable to zero; BSS will
> take care of it.

Ok, I'll add a proper interface in environment.c for this setting.


> When the user explicitly asks you to traverse into submodules and the
> necessary commit is not available in a submodule, the code goes on without
> complaining.  I am not saying it is bad, but I wonder if we would want to
> distinguish these three cases:
>
>  (1) the submodule is initialized and the necessary commit is there.
>
>  (2) the submodule is initialized, but the necessary commit is missing.
>
>  (3) the submodule is not even initialized (aka "the user is not
>     interested in it"); there is only an empty directory.
>
> I think it is perfectly fine not to say anything for (3) but I am unsure
> about the second case.

Do we want to impose the porcelainish rules of git-submodule
(.gitmodules, .git/config) in read_tree_recursive()?

If so, I guess a new submodule.h might provide something like this
(disclaimer: coded in gmail):

	struct submodule {
		int interesting:1;
		char *name;
		char *url;
		char **objectdirs;
		char **paths;
	}

	typedef int (*submodule_cb)(struct submodule *submodule, void *data);

	int load_submodule_config();
	struct submodule *get_submodule_from_path(char *path);
	int add_submodule_objectdb(struct submodule *item);
	int for_each_submodule(submodule_cb cb, void *data);



Then, in read_tree_recursive(), we could check submodule->interesting
to decide if we should follow the gitlink. Also, for bare
repositories, we'd need to support something like
'submodule.<name>.objectdir' in the config file (and .gitmodules must
obviously be read from the objectdb).

If we don't want to impose these rules, the current patch should be
minimally sufficient (the user has to edit
.git/objects/info/alternates by hand and missing submodule commits are
treated as if the submodule is not interesting).

-- 
larsh

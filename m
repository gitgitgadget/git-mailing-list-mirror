From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC] rebase -p: do not redo the merge, but cherry-pick
 first-parent changes
Date: Tue, 22 May 2012 18:38:21 -0500
Message-ID: <20120522233821.GA31667@burratino>
References: <4FBAA33D.1080703@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Stephen Haberman <stephen@exigencecorp.com>,
	Andrew Wong <andrew.kw.w@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed May 23 01:38:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWyf3-0006A5-4l
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 01:38:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932722Ab2EVXic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 19:38:32 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:50451 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753944Ab2EVXib (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 19:38:31 -0400
Received: by yenm10 with SMTP id m10so5982182yen.19
        for <git@vger.kernel.org>; Tue, 22 May 2012 16:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=+1etCFubrFvIVZbLD2W7eiQtxqSV89rtaAkuoBY7LlQ=;
        b=sIha9bfBiUKlVaSsFbV5wHcldTi1/QrI9Tw4xVoBi9w8/ivqLUsh3n/CHYJBH9UAbh
         J2t8lD+kKl9NB8dVkynaEROAKAmtk1KqIRXAauns9my1a9cZHvmh2RqYd+jc/blfoXKO
         ZHGenk8GWjWD8fGvndal/lEzQjKlhkezSW6cHJcMKfUKH3RJ9xB0yIjA0ti4RgeSWnNp
         rAEl7C5nsO1JTOJz2AsQTG624d6vVnaQP7rXU7BWrZCS1t/oZ4BS9O28rB7j08L5Vsq5
         r+HT5v0LcJbe8FruGN2TAyWD1FgbZhQZlKuVNMbr5PL4UHwWYdZxzWcTUCNyC3bXKIcR
         drZw==
Received: by 10.42.68.71 with SMTP id w7mr16313463ici.26.1337729910915;
        Tue, 22 May 2012 16:38:30 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id f8sm3919913ign.0.2012.05.22.16.38.29
        (version=SSLv3 cipher=OTHER);
        Tue, 22 May 2012 16:38:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4FBAA33D.1080703@kdbg.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198266>

Johannes Sixt wrote:

> - The 'git merge' invocation passed the commit message of the old merge
>   commit, but it still obeyed the merge.log option. If it was set, the log
>   ended up twice in the commit message.

Likewise for the "Conflicts:" paragraph, which should also be pretty
simple to fix directly.  I don't think that points directly to a
fundamental flaw in the current implementation, but it does make it
seem like no one has been using "rebase -p" for anything nontrivial. :)

[...]
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -312,12 +312,14 @@ pick_one_preserving_merges () {
>  			msg_content="$(commit_message $sha1)"
>  			# No point in merging the first parent, that's HEAD
>  			new_parents=${new_parents# $first_parent}
> -			if ! do_with_author output \
> -				git merge --no-ff ${strategy:+-s $strategy} -m \
> -					"$msg_content" $new_parents
> +			printf "%s\n" $new_parents >"$GIT_DIR"/MERGE_HEAD
> +			printf "%s\n" "$msg_content" >"$GIT_DIR"/MERGE_MSG
> +			if output git cherry-pick -m 1 -n "$sha1"
>  			then
> +				do_with_author output git commit --no-verify -F "$GIT_DIR"/MERGE_MSG ||
> +					die_with_patch $sha1 "Could not replay merge $sha1"
> +			else
> -				printf "%s\n" "$msg_content" > "$GIT_DIR"/MERGE_MSG
> -				die_with_patch $sha1 "Error redoing merge $sha1"
> +				die_with_patch $sha1 "Could not pick merge $sha1"
>  			fi

Cute.  The approach looks very sensible to me.

Thanks,
Jonathan

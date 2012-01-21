From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] git-p4: Search for parent commit on branch
 creation
Date: Fri, 20 Jan 2012 20:55:08 -0800
Message-ID: <7v7h0ld58z.fsf@alter.siamese.dyndns.org>
References: <1327105292-30092-1-git-send-email-vitor.hda@gmail.com>
 <1327105292-30092-3-git-send-email-vitor.hda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pete Wyckoff <pw@padd.com>,
	Luke Diamand <luke@diamand.org>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 21 05:55:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RoSyx-00013w-TJ
	for gcvg-git-2@lo.gmane.org; Sat, 21 Jan 2012 05:55:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756831Ab2AUEzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jan 2012 23:55:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40363 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756561Ab2AUEzK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2012 23:55:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D9D6B66A3;
	Fri, 20 Jan 2012 23:55:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=uKbFz5RyKocovHVW9cbXmsQ7K5M=; b=RNnaFPeSpDa3TidEYdoR
	yxOAU0m+KjvxY08NNXkUVvsgdYvHsxlDpL3oK1fhJqWQdppS6c37AkM6dblWP7cS
	dqRwnEl203v5EUBLsy3Ggdjp4uibcKcCCxVtPGjx46c6TXF4nXI/F1CCXXH/cQtm
	XDfDJEye56pUgrtDYzeP1TE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=JZR+socW97oZLn+59Yii+Av9+jEU7udVsxrrO1Av3Vktj9
	sfi6jcFTHgee4o5M1OhhuYf9+LuqJNTPT7aUGzVtbrp1rz1dchMsZB6x2M7k3hPT
	Z2Oc/Ahn4rKSy1VVfdQ+gc8sAFUkUr9UH5lQVSBDLfkfHoYBJ4CWkLs+VS/q8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D0A6F66A2;
	Fri, 20 Jan 2012 23:55:09 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 63B8F66A1; Fri, 20 Jan 2012
 23:55:09 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 18242B44-43EC-11E1-9DE3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188918>

Vitor Antunes <vitor.hda@gmail.com> writes:

> A fast-import "checkpoint" call is required for each comparison because
> diff-tree is only able to work with blobs on disk. But most of these
> commits will not be part of the final imported tree, making fast-import
> fail. To avoid this, the temporary branches are tracked and then removed
> at the end of the import process.
>
> Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
> ---

It might make sense to squash 1/3 with this patch; the definition alone
without any actual user would not be very useful and won't help hunting
for breakages, if exists, in the future.

> @@ -2012,7 +2014,27 @@ class P4Sync(Command, P4UserMap):
>                              parent = self.initialParents[branch]
>                              del self.initialParents[branch]
>  
> -                        self.commit(description, filesForCommit, branch, [branchPrefix], parent)
> +                        parentFound = False
> +                        if len(parent) > 0:
> +                            tempBranch = os.path.join(self.tempBranchLocation, "%d" % (change))
> +                            if self.verbose:
> +                                print "Creating temporary branch: " + tempBranch
> +                            self.commit(description, filesForCommit, tempBranch, [branchPrefix])
> +                            self.tempBranches.append(tempBranch)
> +                            self.checkpoint()
> +                            for blob in read_pipe_lines("git rev-list --reverse --no-merges %s" % parent):
> +                                blob = blob.strip()
> +                                if len( read_pipe("git diff-tree %s %s" % (blob, tempBranch)) ) == 0:
> +                                    parentFound = True
> +                                    if self.verbose:
> +                                        print "Found parent of %s in commit %s" % (branch, blob)

... also this looks excessively deeply nested, which is a sign that it
might be a good idea to refactor this part into a separate helper function
or something.

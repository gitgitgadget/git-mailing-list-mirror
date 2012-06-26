From: Junio C Hamano <gitster@pobox.com>
Subject: Re: MERGE_RR droppings
Date: Tue, 26 Jun 2012 11:04:53 -0700
Message-ID: <7v395ic5kq.fsf@alter.siamese.dyndns.org>
References: <CABURp0omkVoLrz29GeOjjoZOpN238Rm6Nu5aOKQyVxFVnPihsw@mail.gmail.com>
 <CABURp0os2no40BW0P-biG_fXyi7MHRcLLYWmCbLTdBv1o1OXcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, davvid@gmail.com
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 26 20:05:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sja8Z-00088m-AH
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 20:05:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757972Ab2FZSFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jun 2012 14:05:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64921 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755755Ab2FZSFG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2012 14:05:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 671F99E22;
	Tue, 26 Jun 2012 14:05:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d52GV1wtF0OAS1UJuBsgtUrTFK0=; b=rsEs87
	XnEO32/K1AGDoocfKNm5Ta1SbEcx2nVQ3dAMpI4p61sAaQILSOmVxZrki6JzZm6B
	ydYGoGXQm1NgFIJT7p3HvHP7Qb26cVQF35GyOgTZnp2eEJSvTBQLs4KAR8s3p0I6
	YZX634lMg8V7oqih+fmM01P1ZT/lO8H3j+h00=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xHpHHouFLLpAJPHktNEEaSOkQaU7tuc3
	7hHR4vHAoy0baF3jPfKIPy18K3wcAY7XKB5/wKlExFhL7CXHMOsVJW6UP2gDPFAj
	gjJJLoLcf5S4EDZlOzQ6KorWMMUUCEZhhqkjuBMC3KgLO3jFMH60FmvQpzUY8+Kn
	S4WvyhEiVj0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C6C69E21;
	Tue, 26 Jun 2012 14:05:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 46F159E1D; Tue, 26 Jun 2012
 14:05:01 -0400 (EDT)
In-Reply-To: <CABURp0os2no40BW0P-biG_fXyi7MHRcLLYWmCbLTdBv1o1OXcg@mail.gmail.com> (Phil
 Hord's message of "Mon, 18 Jun 2012 18:41:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 72C2396C-BFB9-11E1-81BC-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200663>

Phil Hord <phil.hord@gmail.com> writes:

> git mergetool decides to use rerere-remaining based on the existence
> of the .git/MERGE_RR file:
>
>     if test -e "$GIT_DIR/MERGE_RR"
>     then
>         files=$(git rerere remaining)
>     else
>         files=$(git ls-files -u | sed -e 's/^[^ ]*      //' | sort -u)
>     fi
>
> But when I disabled rerere, I still had MERGE_RR files left over in my
> .git directory.   This causes git-mergetool to do the wrong thing.
>
> I do not know if the correct fix for this is to check rerere.enabled instead.

I do not think basing the decision to use "ls-files -u" output upon
the use of "rerere" is a good thing for this script to do in the
first place.  Doesn't it close the door to future enhancements and
third-party mechanisms that do better job than rerere to help the
users auto-resolve conflicted merges?  They certainly do not have to
use GIT_DIR/MERGE_RR nor GIT_DIR/rr-cache, and "rerere remaining"
would not know which paths they handled already.

After all, the user may have resolved the conflicts in his editor
but hasn't recorded the resolution to the index yet when he runs
mergetool, and the tool should handle such a path exactly like how
it currently handles the paths resolved by rerere in the working
tree.  But the above code will include such paths in the $files list
and throw them at the mergetool backends when rerere is not in use.

This part of the code probably should be _inspecting_ the files and
the index to find out what still needs to be fed to the mergetools
itself.  Asking "rerere remaining" about things that it may not have
done (either the user edited the paths in the editor, or some
third-party mechanism resolved the conflicts already) does not make
much sense, methinks.

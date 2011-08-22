From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/1] git-clone: fix relative path problem in the
 alternates
Date: Mon, 22 Aug 2011 13:38:41 -0700
Message-ID: <7vzkj1uqpa.fsf@alter.siamese.dyndns.org>
References: <1314003957-9455-1-git-send-email-jason77.wang@gmail.com>
 <7v7h65w9d7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Hui Wang <jason77.wang@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 22 22:38:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvbGl-0000C5-Ry
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 22:38:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752014Ab1HVUir (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 16:38:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63628 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751233Ab1HVUiq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 16:38:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 840FB4E6F;
	Mon, 22 Aug 2011 16:38:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LntXHfV9q+klMt6NUa7pdcExjlw=; b=g9aq5l
	i8HH9eVuy4uLyrv0OOO3+Y+f6mwAjH6GZVYo69ZnhEIrO8ELUVPf9KwE11SGfsqq
	jtIu0st+eZLHMdZbcw3s+diQpYZUkTMOy1tUt4yBNqe6DJO/GhNNokZiXHIJ0auP
	YvbVp5Ur1rSLl68CZrqBgf+PmApQmojrMwOVw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LiQOQy8i5vw1/Kwgjg0AMl8h60SGfEVR
	7Nzx3f+JbJ7CrCAW9AS1lKKM44seHr+89TXHMdR/vlQ2TM2YvDOWYe23H8eS50m9
	8EMZ7uIJUOQHlt8Wle5aqpKVuQI9cu4pC0RQW/RY+ukg6LWqLdY3Fh+0ajzouWm6
	mgcRay9/H9Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 797F34E6E;
	Mon, 22 Aug 2011 16:38:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DDCCF4E6C; Mon, 22 Aug 2011
 16:38:42 -0400 (EDT)
In-Reply-To: <7v7h65w9d7.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 22 Aug 2011 12:10:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B9A0AB60-CCFE-11E0-B25A-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179889>

Junio C Hamano <gitster@pobox.com> writes:

>> 3. current existing add_to_alternates_file() will unconditionally append
>> "/objects" at each new added line, that need us to parse and  remove
>> "/objects" from each line read out from source alternates, this is a little
>> bit complicated.
>
> Clone with --reference is the only other caller of that function; I would
> say it is perfectly fine to make it the caller's responsibility to append
> "/objects" if that makes the resulting code easier to maintain.

I would further suggest moving add_to_alternates_file() from sha1_file.c
to builtin/clone.c and make it file-scope static function, and change the
way it should be used.

 - The caller should first obtain a lock file to info/alternates. If it
   truncates first or opens the file for appending is up to the caller.

 - When adding an alternate (either from --reference or your new
   codepath), the caller should give the lockfile instance it obtained
   earlier, and a path to the object store it wants to borrow objects from
   (not the repository, i.e. the caller should add "/objects" at the end
   if needed before calling the function), to add_to_alternates_file()
   function;

 - The function should just write the path to the locked info/alternates
   file, and link it to alt_odb list. Do not commit the alternates file,
   to allow multiple calls to the function be made without opening and
   closing the file number of times.

 - The caller should commit the updated alternates file once it is done.

While at it, we may probably want to update the command option handling so
that you can give more than one --reference= parameters.

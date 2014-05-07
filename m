From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] ignorecase: Fix git mv on insensitive filesystems
Date: Wed, 07 May 2014 10:46:35 -0700
Message-ID: <xmqqha51bhxg.fsf@gitster.dls.corp.google.com>
References: <xmqqoazaelmi.fsf@gitster.dls.corp.google.com>
	<1399417144-24864-1-git-send-email-dturner@twopensource.com>
	<1399417144-24864-2-git-send-email-dturner@twopensource.com>
	<5369CFDE.2070207@viscovery.net> <1399480977.11843.62.camel@stross>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed May 07 19:46:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi5vY-0006IC-PI
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 19:46:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515AbaEGRql (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 13:46:41 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57193 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750892AbaEGRqk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 13:46:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E9B8A14A31;
	Wed,  7 May 2014 13:46:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QtAYPl2YPz/CrLvmv/cHG+N2lAA=; b=VObWT5
	AabP8jo9EqLlz+Iuc/A6v5ua82XTKnSRZdW5LIlqNu1V0KzKHOHysNcS2NdtleZc
	y2vwyBs3iz1lXztPt2XrGFt6I4TIG9pqc8LMhC7XNYtH9xlR9+GrQu0tBc9gW7/5
	iFpVZwnryQ2g9NgapkYJQebsLbofoBo5kC0hE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aFLWJUZ4g7RnhePJbp8QbzkfFWT536+w
	DUehU/VUy+efgRIOTpCXObkG4W6KJOTp0b8IveOf9rwHEWP+YJ5jySxSftaFPY1m
	gFPpfZPZ5odfOSxrdw0iriRcfDhId7SbyCK40zQzq+dBPTOqlBNhMjTKYfqmFIN4
	rxNQTm4CGRQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E0AB614A30;
	Wed,  7 May 2014 13:46:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 58B9714A2D;
	Wed,  7 May 2014 13:46:37 -0400 (EDT)
In-Reply-To: <1399480977.11843.62.camel@stross> (David Turner's message of
	"Wed, 07 May 2014 09:42:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 89AADB52-D60F-11E3-ABA4-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248336>

David Turner <dturner@twopensource.com> writes:

> On Wed, 2014-05-07 at 08:17 +0200, Johannes Sixt wrote:
>> >  		} else if (cache_name_pos(src, length) < 0)
>> >  			bad = _("not under version control");
>> > -		else if (lstat(dst, &st) == 0) {
>> > +		else if (lstat(dst, &dst_st) == 0 &&
>> > +			 (src_st.st_ino != dst_st.st_ino ||
>> > +			  (src_st.st_ino == 0 && strcasecmp(src, dst)))) {
>> 
>> Don't do that. st_ino is zero on Windows only because we do not spend time
>> to fill in the field. Don't use it as an indicator for a case-insensitive
>> file system; zero may be a valid inode number on other systems.
>
> I don't think it is a problem if zero is a valid inode.  The only thing
> that happens when there is a zero inode, is that we have to compare
> filenames.  The inode check is just an optimization to avoid doing a
> bunch of strcasecmp on systems that don't have to.

Am I correct to rephrase you that the code assumes that any
filesystem that cannot give unique inum to different files will use
0 as the placeholder inum, so if src/dst share the same non-zero
inum, it is guaranteed that is not a placeholder and we know they
are different files without comparing the two paths?

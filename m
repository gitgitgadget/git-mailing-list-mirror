From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v3 01/13] Move index v2 specific functions to their
 own file
Date: Thu, 09 Aug 2012 17:13:16 -0700
Message-ID: <7v7gt7mwo3.fsf@alter.siamese.dyndns.org>
References: <1344424681-31469-1-git-send-email-t.gummerer@gmail.com>
 <1344424681-31469-2-git-send-email-t.gummerer@gmail.com>
 <7vtxwbn2qe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	pclouds@gmail.com, robin.rosenberg@dewire.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 02:13:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Szcqz-0007eo-B0
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 02:13:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760029Ab2HJANU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Aug 2012 20:13:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64724 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755412Ab2HJANT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2012 20:13:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF0148E0F;
	Thu,  9 Aug 2012 20:13:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ua9cpG52MZ4rhclZDjoWhgHk6cc=; b=dRad86
	mQxVMMzbVawVXJ3s60FGiKz+47ORdtA4CjZxYKXNEUr8I/+XMu9PB9iWXCNSs1sm
	//65K4+JMU2w+pm7WvROjd95AQbHdjr01LmhSnC83aixH7VoeNgxsgJ2zYrrL+i5
	RuqTUnjKt0FI2hbZgf5MfW5fnu+GTp2lUT7/A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rC3auBgq7zHP3S0yjf2Vv3YJNcM4LG/B
	SGsu6JlZDC13k5IwaHjClwbRLcm7GN+lfTo5HEjvgUznbzAcyhzY0X10wMWoehwT
	xs3BxPNgeb6n3+BqtGGADvwY2uEyu/fgllessrzP3AjVKWlfJ8bBpq4OjPQRu7hJ
	dApu3hWX51M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ACDED8E0E;
	Thu,  9 Aug 2012 20:13:18 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 344D18E0D; Thu,  9 Aug 2012
 20:13:18 -0400 (EDT)
In-Reply-To: <7vtxwbn2qe.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 09 Aug 2012 15:02:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2FBCD7D2-E280-11E1-815D-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203192>

Junio C Hamano <gitster@pobox.com> writes:

> If you found that an entry you read halfway has an inconsistent crc,
> and if you suspect that is because somebody else was writing to the
> same index, it is a _sure_ sign that you are not alone, and all the
> entries you read so far to the core, even if they weren't touched by
> that sombody else when you read them, may be stale, and worse yet,
> what you are going to read may be inconsistent with what you've read
> and have in-core (e.g. you may have read "f" before somebody else
> that is racing with you have turned it into a directory, and your
> next read may find "f/d" in the index without crc error).
>
> One sane way to avoid reading such an inconsistent state may be to
> redo this whole function, starting from the part that calls mmap().
> IOW,
>
> 	do {
> 		fd = open()
> 		mmap = xmmap(fd);
> 		close(fd);
>                 verify_various_fields(mmap);
>                 status = istate->ops->read_index(istate, mmap, mmap_size));
> 	} while (status == READ_AGAIN);
>
> I do not think the "pass fd around so that we can redo the mapping
> deep inside the callchain" is either a good idea or necessary.

By the way, you can only detect such inconsistency when you are
lucky enough that you catch the other person in the middle of
writing.

If the index you are looking at holds a large tree with very many
paths, it is possible that there are two large directories, and
after you read all entries from one, the other process starts
modifying the paths in that directory, without you ever finding it
out.  If the goal of the topic is to make the index work better in
projects with large trees, it may be wise to think about locking the
whole thing, so that you do not have to rely on the per-entry crc
and you being lucky to detect such a race.  The per-entry crc, as
far as I understand, may have been introduced primarily to detect
on-disk data corruption; it is not a suitable mechanism to detect
conflicting accesses.

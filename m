From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Use git_open_noatime when accessing pack data
Date: Fri, 05 Nov 2010 10:26:21 -0700
Message-ID: <7vr5ezu1fm.fsf@alter.siamese.dyndns.org>
References: <1288652061-19614-1-git-send-email-spearce@spearce.org>
 <1288652061-19614-2-git-send-email-spearce@spearce.org>
 <7v8w1axrnp.fsf@alter.siamese.dyndns.org> <20101103174148.GB13377@burratino>
 <7vvd4ew687.fsf@alter.siamese.dyndns.org> <20101104050437.GB15018@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 05 18:27:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEQ43-00063h-Hb
	for gcvg-git-2@lo.gmane.org; Fri, 05 Nov 2010 18:27:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754630Ab0KER0p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Nov 2010 13:26:45 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43426 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754623Ab0KER0l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Nov 2010 13:26:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 32FFA21D8;
	Fri,  5 Nov 2010 13:26:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UmasJvQaRDvqVGInhVevpou00QE=; b=W/PZXS
	YnlNo0AcTTKvuZ6fIVd5TUyp1eQY7g/p7Ioqv2GEI4qgW7dBQlcqOv+0ZyOlexEu
	J8VflNJIJK5IkxZxQdXeVly5qtdPItXDLDNyxXtZ/LIz0OjH8MtaPR6sl14/6JOY
	YSPRTj59D3LV1isz06tBD9EEGA4NTuLFUGMvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c1+S6UkQQ6/W6Rk6H668pzDAHn0A5ezW
	Z9+nHlZV2vY1+wt1LaKAe9F+Jo+A0B7IOb3ry7mYwiJzCjbD5pklVKMEyGxEXxhd
	tAFJHsBEythOsEOBDX9XuwK2mudM0+oABuYvPaUKQtsnJDTWr4Rt6+lcYb4ojtzW
	VjT0MZLeQ7A=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 01F2521D3;
	Fri,  5 Nov 2010 13:26:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CEE7C21D1; Fri,  5 Nov 2010
 13:26:25 -0400 (EDT)
In-Reply-To: <20101104050437.GB15018@burratino> (Jonathan Nieder's message of
 "Thu\, 4 Nov 2010 00\:04\:37 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D3A890C2-E901-11DF-964C-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160820>

Jonathan Nieder <jrnieder@gmail.com> writes:

> I guess I should put it another way.  What if anything does readonly
> have to do with O_NOATIME?  Why shouldn't we always use O_NOATIME?
> Why should the operating system provide atime at all?

Well, I think what you are getting at is that the proposed API in Shawn's
patch and my suggestion is upside down, and it should be layered more like
this (from lower to higher layers) from the interface's point of view:

 - git_open_wpf(): an API to get a file descriptor to a file, while
   protecting open fds to a packfile from getting reclaimed;

 - git_open(): a thin wrapper of the previous, for callers that do not
   need any "with-pack-file" aspect of it;

 - git_open_noatime(): a thin wrapper of the previous, for callers that do
   not want to incur inode metainformation traffic to the filesystem.
 
even though the bulk of implementation, including the logic to handle
no-atime, probably needs to happen in the lowermost layer.

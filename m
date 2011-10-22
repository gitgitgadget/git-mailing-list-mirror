From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/22] Refactor to accept NUL in commit messages
Date: Sat, 22 Oct 2011 15:47:12 -0700
Message-ID: <7vobx863v3.fsf@alter.siamese.dyndns.org>
References: <1319277881-4128-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= 
	<avarab@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 23 00:47:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHkLf-0006M0-ST
	for gcvg-git-2@lo.gmane.org; Sun, 23 Oct 2011 00:47:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924Ab1JVWrP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Oct 2011 18:47:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56875 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751597Ab1JVWrP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Oct 2011 18:47:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F03595D46;
	Sat, 22 Oct 2011 18:47:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rgWqrQUN5MuXqiOWxuK5vXiqw9A=; b=TRgITD
	B9FAeAfpSG3dibxhPtnzWayOaB+lvFsI+MIRYif3TRA5r+iqMUgBD+CXNuHPTHsk
	bwSstm6LpdwFxDWnx60p4EAiPsAOSW8IZdsvKsONaRDDWVkjIrJJILxrvoMkUFD6
	QEWTvP0D1ZQmW9nHHDpP57ZngN7bqctWdqXqo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wjn6PLD66RR5fGGluCzCmuz9ytQGkD09
	Ri6Keu4741SgC9JONZTlmuv5W/fvgj4PtC/ObV4jjpY7I5/5qj6+BVJYvrgBmLac
	1t93K1h888OgiEkES4kEU/Ft7h630mcZa1iVIzf4uICLQnXWSPBkjeuEE/2rKTld
	9XGsZ0LAKUs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E64D15D45;
	Sat, 22 Oct 2011 18:47:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7A74E5D44; Sat, 22 Oct 2011
 18:47:13 -0400 (EDT)
In-Reply-To: <1319277881-4128-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 22 Oct
 2011 21:04:19 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C8B2B45A-FCFF-11E0-8ADE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184123>

I do not think we want to go this route.

There are two possible approaches to attack this.

 - If we want to show everything after a potential and rare NUL in the log
   message most of the time, then "struct commit" should just store
   <ptr,len> pair. This grows "struct commit" with one extra ulong.

 - If we want to give us a way to notice and show these "funnily, this
   commit log message has a NUL in it" case as an exception in only
   selected codepaths, then "struct commit" should just gain "flags"
   4-byte int field between "indegree" and "date", and
   parse_commit_buffer() should set one bit in the flags when the log
   message has NUL in it. And teach only these selected codepaths to find
   the length from the object name with sha1_object_info() as needed. This
   grows "struct commit" with one 4-byte int, with runtime overhead only
   where it matters.

The approach taken by the patch wastes two malloc() blocks with their own
allocation overhead, and unused "alloc" field in the strbuf that does not
have to be there.

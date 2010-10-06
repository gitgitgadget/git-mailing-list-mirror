From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/7] lockfile: introduce alloc_lock_file() to avoid
 valgrind noise
Date: Wed, 06 Oct 2010 14:45:22 -0700
Message-ID: <7vhbgzyozx.fsf@alter.siamese.dyndns.org>
References: <wes62zknmki.fsf@kanis.fr>
 <7v1va760ip.fsf@alter.siamese.dyndns.org> <20100810032647.GA2386@burratino>
 <20101002082752.GA29638@burratino> <20101002083216.GC29638@burratino>
 <7vocb7yte4.fsf@alter.siamese.dyndns.org> <20101006202130.GB2118@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Pierre Habouzit <madcoder@debian.org>,
	David Barr <david.barr@cordelta.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 06 23:45:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3bo2-00027X-2v
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 23:45:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933209Ab0JFVpi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 17:45:38 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35678 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932904Ab0JFVpi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 17:45:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E7447DC086;
	Wed,  6 Oct 2010 17:45:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rz7h66e6CSi3o1vlhTvEAykf548=; b=TS1TYa
	dLoKpsWE2cKbrLXXc9PvD9uQRp/IQKPRDJby4P0Sh7ZYNSnzkufDWy73gK0iYg/z
	3HtAiap2QOlY6w0YDYt+c4W0m/FB5YFbzKD3BRrsn8PxsBgi2R/uw9+GhZGcbod6
	FtdvXfs0VX8wSsTBQPLai2G6OkevIMdMNX/dI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hiYTSRIyZXvI+nnLHCv2ztTCRosXFDUB
	xU9ZqN3wFQt8BIIE4EvFAmgynlkmazTpdjWMQxtxMdxvUm5yarNmtX3PfnRFviQn
	0sQ8pvhdYdGpQtwck/xR0upakSFY3PuYbpKzYUKCtWhETWKxntM2v2DWADV8gehm
	mC+c3iKYYHE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A4990DC084;
	Wed,  6 Oct 2010 17:45:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9D95CDC083; Wed,  6 Oct
 2010 17:45:24 -0400 (EDT)
In-Reply-To: <20101006202130.GB2118@burratino> (Jonathan Nieder's message of
 "Wed\, 6 Oct 2010 15\:21\:30 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0A3B605A-D193-11DF-9834-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158309>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>
>> Hmm, I am getting
>> 
>>     cc1: warnings being treated as errors
>>     lockfile.c:189: error: 'optimize' attribute directive ignored
>>     make: *** [lockfile.o] Error 1
>> 
>> from this patch with gcc (Debian 4.3.2-1.1) 4.3.2
>
> Unfortunate.  With gcc 4.5 it works, but that isn't too useful.
>
>> Aren't "struct lock_file" instances supposed to be reachable from the
>> linked list, i.e. lock_file_list?  Why does valgrind consider that
>> elements on that list are leaked in the first place?
>
> At exit, we walk the lock file list and clear it in the process.
> Which suggests a cleaner workaround (thanks!):
>
>  static void remove_lock_file(void)
>  {
> 	pid_t me = getpid();
> +	struct lock_file *p = lock_file_list;
>
> -	while (lock_file_list) {
> -		if (lock_file_list->owner == me &&
> -		    lock_file_list->filename[0]) {
> -			if (lock_file_list->fd >= 0)
> -				close(lock_file_list->fd);
> -			unlink_or_warn(lock_file_list->filename);
> -		}
> -		lock_file_list = lock_file_list->next;
> +	while (p) {
> +		if (p->owner == me &&
> +		    p->filename[0]) {
> +			if (p->fd >= 0)
> +				close(p->fd);
> +			unlink_or_warn(p->filename);
> +		}
> +		p = lock_file_list->next;
> 	}

Heh, shouldn't the last one assign from p->next?

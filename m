From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-email.perl - Fix 550 EHLO argument does not
 match calling host
Date: Sat, 13 Mar 2010 14:32:42 -0800
Message-ID: <7vfx433l9x.fsf@alter.siamese.dyndns.org>
References: <4B97C157.4020806@gmail.com>
 <20100311081213.GA13575@sigill.intra.peff.net>
 <20100311083148.GA13786@sigill.intra.peff.net>
 <7vaaueziv8.fsf@alter.siamese.dyndns.org> <4B9A74CA.4080507@gmail.com>
 <7vy6hxnnfx.fsf@alter.siamese.dyndns.org> <87bpesi0om.fsf_-_@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Sat Mar 13 23:32:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqZt8-00010x-E0
	for gcvg-git-2@lo.gmane.org; Sat, 13 Mar 2010 23:32:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759370Ab0CMWct (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Mar 2010 17:32:49 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39162 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759356Ab0CMWcs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Mar 2010 17:32:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 190A9A15F4;
	Sat, 13 Mar 2010 17:32:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=mrInBdFbHqb3goeEs4V0DBP1EQE=; b=EKN3pQBBS936Zx9voiw1LrR
	EuXTkDkAl2rQZ90grdMKz4ODjY6LFyweJRel70eOklmvnN7b5NBwRE6qBbfgcYcC
	cs5qsMn+NGuzFNI9/1nj/bJHPyWmZQqvbvTsOPGd8hcqYOmtXnNuMHQRBfZl0ZrS
	9GX95eGoIxdZ1SQ+SUN0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=kolL7jT0dx+ilSP/qS3ZZhan1K/9RbxC/kGTWaRb2f14oxRik
	qrylTczqhyE5vM5Q8wP1zBCcn1VOFZTcC/yaKbgNNmUDjJF2xNmGL3SeesaTa9DX
	R9ihBogGLL4MzZcgtpP1geH24yw4UGXm6Iu07QxyxUwEU/WGdOoX5XlGqM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EC811A15F3;
	Sat, 13 Mar 2010 17:32:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 42A53A15EF; Sat, 13 Mar
 2010 17:32:43 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 58B097E6-2EF0-11DF-9F23-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142118>

Jari Aalto <jari.aalto@cante.net> writes:

> Add new function maildomain() which returns FQDN for use in
> send_message(). The value is passed to Net::SMTP HELO/EHLO handshake.
>
> The default value in Net::SMTP may not get through:
>
>   Net::SMTP=GLOB(0x267ec28)>>> EHLO localhost.localdomain
>   Net::SMTP=GLOB(0x267ec28)<<< 550 EHLO argument does not match calling host
>
> whereas using the FQDN, the result is:
>
>   Net::SMTP=GLOB(0x15b8e80)>>> EHLO host.example.com
>   Net::SMTP=GLOB(0x15b8e80)<<< 250-host.example.com Hello host.example.com [192.168.1.7]

I think you identified a good issue to tackle.  But is it really the
optimal solution?

 - Is it the best we can do to always make an empty connection only to
   check if the we have hosts locally known as mailhost or localhost
   listens to SMTP port?  And calling this function again and again, even
   after sending one message to the same $smtp_server successfully ($smtp
   in the global scope is already set in that case)?

 - You are trying to improve the chance that $smtp_server likes the name
   your side identifies as; what does it have to do with your local
   "mailhost" or "localhost" listening to the SMTP port?  These local MTA
   may be configured for local-only delivery after all.

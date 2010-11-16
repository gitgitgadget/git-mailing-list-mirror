From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/10] add: do not rely on dtype being NULL behavior
Date: Tue, 16 Nov 2010 10:58:17 -0800
Message-ID: <7v39r1hz92.fsf@alter.siamese.dyndns.org>
References: <1289817410-32470-1-git-send-email-pclouds@gmail.com>
 <1289817410-32470-2-git-send-email-pclouds@gmail.com>
 <20101115121415.GB14729@burratino>
 <AANLkTikkArsu=NLJWQcP61uf3yrQmdxRQtB+3AmC9tHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 16 19:58:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIQk5-0004rK-6m
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 19:58:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757099Ab0KPS6d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Nov 2010 13:58:33 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49629 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757041Ab0KPS6c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Nov 2010 13:58:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7A26928AF;
	Tue, 16 Nov 2010 13:58:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0qILXr4QHjedpLfcKjuobiq4xxg=; b=PU3RhH
	zLyE+nEf6zMr2IZ96iwdFE9lmNG9cVoDaqTYeNfaYGeX3UN81q2IEO9blW6Ul8SH
	6bwmyxV9t/c5/UMx88U5l2lZRhchhBSLAOBbRaAetsUNMoPkPFapYQO2cf5mVS+d
	1i0awZNd8aazf7HcfXUTETWeo0ZcTKVRaMsLc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LcTaALd+Q3PDl3sV7KotcOoCXWklwFf/
	JMv0Ki/Polnu2znHStFZjc9+9EXWNss8J40/vC5+1eK631Nkh8xaWXeI+O+lretD
	ZBMapFWBr14HBlNvdUknJJ9gf1BGtan9OIojqWTTg6We3fU6st9S7Vmh1ssn0RSS
	Lb2je6U2g/I=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2DA8428AD;
	Tue, 16 Nov 2010 13:58:35 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AD10928AA; Tue, 16 Nov 2010
 13:58:28 -0500 (EST)
In-Reply-To: <AANLkTikkArsu=NLJWQcP61uf3yrQmdxRQtB+3AmC9tHQ@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Tue\, 16 Nov 2010 09\:18\:04 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 83778468-F1B3-11DF-A8A2-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161575>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> Hmm.. get_index_dtype() would return DT_DIR if the submodule exists in
> index. If it does not it must be a directory in worktree, right?
> Call flow: excluded_from_list() -> get_dtype() -> get_index_dtype()

By the way, your c84de70 (excluded_1(): support exclude files in index,
2009-08-20) looks broken.  What happens when the exclude pattern wants a
directory but specifies it with a wildcard?

The safest and sanest first step is to just change DT_UNKNOWN (which
clearly is a wrong thing to pass) to NULL to keep the current behaviour,
but it probably makes more sense to do the second step at the same time to
pass a pointer to an int that holds DT_UNKNOWN to avoid triggering that
broken codepath.
